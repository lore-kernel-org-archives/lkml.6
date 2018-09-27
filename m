Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23556C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC31216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sryG2n3C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC31216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeI1Cxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:53:53 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37251 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeI1Cxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:53:52 -0400
Received: by mail-qt1-f194.google.com with SMTP id n6-v6so4312352qtl.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 13:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XeIyob3e+k3Lc5ztFb3Djiyfr8ggM4MacXhRFEsvkkA=;
        b=sryG2n3CWA31tKWbRXfdvI77Q8UY63bmgwq1TyDGDz48alGDJlQAGkkcc5wK6GkG6X
         Uok0FFrmxXjZSj4pQkJsllMvxae2QUuTsWgmt0GCGkVwnc4Oc8u6lVSHhsrf+P78qr/l
         C88GmeNYUBCbqY+F2xTG/Sn4A5i0erXOhsFrrYcBlS5qTTmGZik5dvn6sE6mo3p7BHaa
         d1G5dFpBX8xFvc06fK+IRiF4yMy9NE2ckdLjFbfzodqwPaQZUGnlVNECficDQ2JxwxqJ
         E7Ot7z1/jj575hgazluBAQEVIsbGBWW6cJtfMLlB+cv4CkzsmM0+Bf9e8PIAkHmgbIV9
         nylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XeIyob3e+k3Lc5ztFb3Djiyfr8ggM4MacXhRFEsvkkA=;
        b=V9Z3TEY9o38MOlwIOaAlF7hfM9nlX0iNgJieNF6XHkP4exZXSxXPrdNYsmqTT0/ErY
         2EGHACFnOnOMgUd1nMFomc8dyRICaiqQu1aShGitwULC3DApbKcjnHeaUOW0U/X6+vrG
         8fSlDsx0U8Wezb18o/Z9Lis7BVHlbg67P7qoKy9O4fJkGtRFhAx2EGhUB6zwTY9a0d0n
         nN8g5e8k7YMzVI/gvXjnkaPwq0c3CEoI+FozE1ETbRZCMlgzBb7o33yLObHm7kfx9D83
         g4610rJzGoZnvrXYLrQcfTicqC5VbHyjxEBRKtEU9A+icmRC0t4RcGhYSSj9u/WGcvUB
         rzCg==
X-Gm-Message-State: ABuFfogZfHPtqK92iocA0CwDBC0uMM6kadOabfns199lti1dfk7zfjyB
        bjOH1MmU9b6vUl9t6z/Ftg==
X-Google-Smtp-Source: ACcGV62L0+UteccsE7SbJnFxDdExoCe4Zr/+WCHhLJABKg6ROTRBTbK7wQhclByNg74G7SJiE+zW+A==
X-Received: by 2002:a0c:9691:: with SMTP id a17-v6mr9534621qvd.30.1538080427373;
        Thu, 27 Sep 2018 13:33:47 -0700 (PDT)
Received: from centos7.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v187-v6sm1649374qka.73.2018.09.27.13.33.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 13:33:46 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] Add a kernel parameter to change the padding size for KASLR
Date:   Thu, 27 Sep 2018 16:31:43 -0400
Message-Id: <20180927203146.12201-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series are adding an kernel parameter to change
the padding size used for KASLR. It is useful for memory hotplug
capable system. User can adjust the padding size to use it.

It is better if the padding size is calculated automatically,
however, ACPI SRAT is not available at the KASLR initialization
time. So, I add a message for user to tell the suitable padding
size. User can set it on next reboot.

This patch series don't change the current default padding size.

Change log from v3:
 - Add a warning message if the padding size for KASLR is not enough.
   And it says the suitable padding size to user.

Change log from v2:
 - Simplify the description. As Baoquan said, this is similar SGI UV issue,
   but a little different. Remove SGI UV description.

Masayoshi Mizuma (3):
  x86/mm: Add an option to change the padding used for the physical
    memory mapping
  ACPI / NUMA: Add warning message if the padding size for KASLR is not
    enough
  docs: kernel-parameters.txt: document rand_mem_physical_padding
    parameter

 Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
 arch/x86/include/asm/setup.h                    |  2 ++
 arch/x86/mm/kaslr.c                             | 17 ++++++++++++++++-
 drivers/acpi/numa.c                             | 14 ++++++++++++++
 4 files changed, 39 insertions(+), 1 deletion(-)

-- 
2.18.0

