Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A156ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93A120693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bpa2Za71"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E93A120693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbeGQVjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:39:08 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40089 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729684AbeGQVjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:39:08 -0400
Received: by mail-pl0-f66.google.com with SMTP id s17-v6so987949plp.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=K9cAIOlM8vIlyl8eoQBDMoSI2ADkVWD6UnwaStMBIB4=;
        b=Bpa2Za71Qv8ojEQX1vf12LTZgTp78FWZZF2W7AX/LmTcrhN4ltnhrQhW5fmKWbR9kv
         kPotImjhg9iB2t2Lss2GI/SdTmsbTbUTmL2ug7d6Hq8N2/NUnf3xIWFVf1AoGm74BddR
         13zCW+Pk+MxYcTJYOy2PsRyPdZWMnFWove1kMQd9dejBu/y+TFKBe5prs/LNodsNCjSg
         ihk/K2AVopy7ilrUdfeQopFxqLZO/Qz7V1RWvrUGlMqbzoxPTQ7WRvsJdyDub9nzZ+EX
         NDhhYhaIQvEQtb6RfbSho/A0U2ydT7eJhTTJt6my1hNpwwd8W6CJ37nE8cuKpt3bEkrR
         fsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K9cAIOlM8vIlyl8eoQBDMoSI2ADkVWD6UnwaStMBIB4=;
        b=COL1EoLHve0uCUgTLc1Ntx+j3a761JFRIeXYaTb5RCJF7oLQVqJfVK1QP4SeV46mM3
         Cp0mTpbK+91w7hSOVMkMSJh8FTVZLZmsqfSVJqCakaGMuMAoXquoSRVyD4ZYiuMMyC0/
         uFfxgzOyoesuci3p+cnIZ82euut91ZPP21HHeFArJtMwDI0vduguut0aKLBqnGXk6+Zz
         oZfrWEv+dA+YPhv6d1mLRG12dD8Anf8amc5s61QSEVKWT6IlWluXMuEp72n/faqoUZ2u
         IDXciraxOh0FH5Q1k1cjwjfV48d9+a1Sqk5f1eV8jlwAQQUpBBb2cJ6KqjHsuQPSpRHc
         KW2A==
X-Gm-Message-State: AOUpUlFx37n4W/rkzDElf8Tf/xh+n0ygn2wCqCUewYU0gk3tLoiPZFNa
        Oi/ibUsohK30N3g0COfW94ARHjPt
X-Google-Smtp-Source: AAOMgpdrJVyHSnDoRT08j65gBAz5b0lxo2iWRlPv10VL+f9fn2aVz3n7K/fvyAgAYcwWJHUvJWWU3A==
X-Received: by 2002:a17:902:7b97:: with SMTP id w23-v6mr3175153pll.66.1531861480795;
        Tue, 17 Jul 2018 14:04:40 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m86-v6sm3361487pfi.47.2018.07.17.14.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:04:40 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 00/32 v3] staging: gasket: sundry fixes and fixups
Date:   Tue, 17 Jul 2018 13:56:40 -0700
Message-Id: <20180717205712.29495-1-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Various fixes mainly from the chromium review of the gasket and apex
drivers.  More to come.

Todd Poynor (32):
  staging: gasket: remove X86 Kconfig restriction
  staging: gasket: fix typo in apex_enter_reset
  staging: gasket: fix typo in gasket_core.h comments
  staging: gasket: whitespace fix in gasket_page_table_init
  staging: gasket: remove driver registration on class creation failure
  staging: gasket: hold mutex on gasket driver unregistration
  staging: gasket: Return EBUSY on mapping create when already in use
  staging: gasket: Remove stale pointers on error allocating attr array
  staging: gasket: convert gasket_mmap_has_permissions to bool return
  staging: gasket: fix gasket_wait_with_reschedule timeout return code
  staging: gasket: gasket_wait_with_reschedule use msleep
  staging: gasket: gasket_wait_with_reschedule simplify logic
  staging: gasket: gasket_wait_with_reschedule use 32 bits of retry
    count
  staging: gasket: bail out of reset sequence on device callback error
  staging: gasket: drop gasket_cdev_get_info, use container_of
  staging: gasket: always allow root open for write
  staging: gasket: annotate ioctl arg with __user
  staging: gasket: gasket_enable_dev remove unnecessary variable
  staging: gasket: remove code for no physical device
  staging: gasket: fix class create bug handling
  staging: gasket: remove unnecessary code in coherent allocator
  staging: gasket: don't treat no device reset callback as an error
  staging: gasket: gasket_mmap return error instead of valid BAR index
  staging: gasket: apex_clock_gating simplify logic, reduce indentation
  staging: gasket: apex_ioctl_check_permissions use bool return type
  staging: gasket: gasket page table functions use bool return type
  staging: gasket: remove else clause after return in if clause
  staging: gasket: fix comment syntax in apex.h
  staging: gasket: remove unnecessary parens in page table code
  staging: gasket: gasket_mmap use PAGE_MASK
  staging: gasket: remove extra parens in gasket_write_mappable_regions
  staging: gasket: fix multi-line comment syntax in gasket_core.h

Changes from v2:
  staging: gasket: Return EBUSY on mapping create when already in use
     Update commit text for clarity: why EBUSY is better than EINVAL here.
  staging: gasket: gasket_wait_with_reschedule use msleep
     Update commit text for clarity: why msleep is better than
     schedule_timeout here.
  staging: gasket: gasket_wait_with_reschedule return when condition hit
     Renamed: staging: gasket: gasket_wait_with_reschedule simplify logic
     Update commit text for clarity: improved description of change.
     Remove extraneous condition check and a return statement now impossible
     to reach.
  staging: gasket: always allow root open for write
     Add change that accidentally went into the below patch in v2.
     Normalize file mode bitwise ANDs to zero or one values.
     Dropped Reviewed-by from Dmitry Torokhov since this has changed.
  staging: gasket: annotate ioctl arg with __user
     Remove stray change from v2, now moved into the above patch in v3.
  staging: gasket: remove else clause after return in if clause
     Don't break line that doesn't need it after indentation reduced.
  staging: gasket: gasket_mmap use PAGE_MASK
     Update commit text for clarity: why ~PAGE_MASK is better than
     PAGE_SIZE - 1 here.
  staging: gasket: apex_clock_gating simplify logic, reduce indentation
     Unbreak line that no longer needs a break after re-indent.
     
Unchanged from v2:
  staging: gasket: remove X86 Kconfig restriction
  staging: gasket: fix typo in apex_enter_reset
  staging: gasket: fix typo in gasket_core.h comments
  staging: gasket: whitespace fix in gasket_page_table_init
  staging: gasket: remove driver registration on class creation failure
  staging: gasket: hold mutex on gasket driver unregistration
  staging: gasket: Remove stale pointers on error allocating attr array
  staging: gasket: convert gasket_mmap_has_permissions to bool return
  staging: gasket: fix gasket_wait_with_reschedule timeout return code
  staging: gasket: gasket_wait_with_reschedule use 32 bits of retry
    count
  staging: gasket: bail out of reset sequence on device callback error
  staging: gasket: drop gasket_cdev_get_info, use container_of
  staging: gasket: gasket_enable_dev remove unnecessary variable
  staging: gasket: remove code for no physical device
  staging: gasket: fix class create bug handling
  staging: gasket: remove unnecessary code in coherent allocator
  staging: gasket: don't treat no device reset callback as an error
  staging: gasket: gasket_mmap return error instead of valid BAR index
  staging: gasket: apex_ioctl_check_permissions use bool return type
  staging: gasket: gasket page table functions use bool return type
  staging: gasket: fix comment syntax in apex.h
  staging: gasket: remove unnecessary parens in page table code
  staging: gasket: remove extra parens in gasket_write_mappable_regions
  staging: gasket: fix multi-line comment syntax in gasket_core.h

 drivers/staging/gasket/Kconfig             |   2 +-
 drivers/staging/gasket/apex.h              |   7 +-
 drivers/staging/gasket/apex_driver.c       |  77 ++++++--------
 drivers/staging/gasket/gasket_core.c       | 115 ++++++++-------------
 drivers/staging/gasket/gasket_core.h       |  11 +-
 drivers/staging/gasket/gasket_ioctl.c      |  95 +++++++++--------
 drivers/staging/gasket/gasket_ioctl.h      |   4 +-
 drivers/staging/gasket/gasket_page_table.c |  66 ++++++------
 drivers/staging/gasket/gasket_page_table.h |   8 +-
 drivers/staging/gasket/gasket_sysfs.c      |   4 +-
 10 files changed, 177 insertions(+), 212 deletions(-)

-- 
2.18.0.203.gfac676dfb9-goog

