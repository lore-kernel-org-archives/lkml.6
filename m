Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A35ECDE47
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 23:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F3120834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 23:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="OYLVgtoo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F3120834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbeJ0IDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 04:03:14 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43276 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbeJ0IDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 04:03:13 -0400
Received: by mail-ed1-f67.google.com with SMTP id y20-v6so2650115eds.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 16:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JEBobtHg1qgbOc630FYStYv8aN4/HB7o15k1W7ldVoc=;
        b=OYLVgtooq7ObuotGpIxgk8rxockKE76sRnIUI5hhbNEPQr5sYwOuDQ6Z8jJ1Y8Wukq
         LlOfv5pwxHVPPX8UWCN9yb417DGJ1PuPKzpY5wN8mTRM1jnj3Mnzuhx20ppRJ1jsUvQs
         H8Mez81Q0oVN6ipJU9vEY3h/PnfEABbRlQtNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JEBobtHg1qgbOc630FYStYv8aN4/HB7o15k1W7ldVoc=;
        b=o20v1cGERCHTfVZ4riliiSRD2yrmtLTlj7B0IVOoQhoN1GbgYZgQ/UgZO7EW3qzRiq
         mSRmQCl/iVvlwlXpOpPWqHk50Ks6X9PXm8TRiMFLxc1c9UEyTEjhZBO18LBYVI+P//f5
         o6lDCBipd1hH6bZKKO2ry0XXHIvfQwc+kVAzYJgbxm/eYSuSZXqQDK8lCpYNjV0M0Ksv
         YRDIjL0JSx888jHl3a1bnxVLTe2wSeQkybmT9yWvagPm3Vy5FNbicRU/BnrV+7t5om48
         yctoHvlIkQC/F+yx8IOrKmW7HWLBR0SvWPFVZgNUiV930tdcdds8sYPxNLvAFZAZG+0M
         fLJw==
X-Gm-Message-State: AGRZ1gLpVA/3ir29L3h5KKOguqI6fngeR8SwRXQUMP6v4526ELuH/a9r
        LVoOR2PfOVVSgj8ynlR5Hg41Uw==
X-Google-Smtp-Source: AJdET5en4qW4GcEmqKcIU6ys6vzhrxNJTPyQnLSiny8uDtCWsXC+TwfPcq7Q5NH36j9AAG+hsSQXMw==
X-Received: by 2002:a17:906:2111:: with SMTP id 17-v6mr3604087ejt.206.1540596252659;
        Fri, 26 Oct 2018 16:24:12 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id o13-v6sm3986746edc.95.2018.10.26.16.24.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Oct 2018 16:24:11 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-nfs@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-hwmon@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 0/7] runtime format string checking
Date:   Sat, 27 Oct 2018 01:24:02 +0200
Message-Id: <20181026232409.16100-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20171108223020.24487-1-linux@rasmusvillemoes.dk>
References: <20171108223020.24487-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resurrection of something I sent out about a year ago. In
the relatively few places where we use a non-literal as format string,
we can annotate the source with a fmtcheck() call that will (a) at
build time, allow the compiler to check the variadic arguments against
the template, and (b) at runtime, check that the format specifiers
present in the actual format string match those in the template (and
if not, WARN and use the template to ensure runtime type safety).

Finding places to annotate is just

  make -j8 KCFLAGS='-Wformat-nonliteral'

So far, in about half the places I looked, one might as well get
completely rid of the non-literal format string. Patches 5,6,7 are
some examples of where one might add fmtcheck() calls. I don't think
we can get to a state where we can unconditionally add
-Wformat-nonliteral to the build, but I think there's a lot of
low-hanging fruit.

This is on top of Miguel's compiler attributes series [1], which I
hope will land in mainline soon.

[1] https://github.com/ojeda/linux.git tags/compiler-attributes-for-linus-4.20-rc1

Rasmus Villemoes (7):
  compiler_attributes.h: add __attribute__((format_arg)) shorthand
  lib/vsprintf.c: add fmtcheck utility
  kernel.h: implement fmtmatch() wrapper around fmtcheck()
  lib/test_printf.c: add a few fmtcheck() test cases
  kernel/kthread.c: do runtime check of format string in
    kthread_create_on_cpu()
  nfs: use fmtcheck() in root_nfs_data
  drivers: hwmon: add runtime format string checking

 drivers/hwmon/hwmon.c               |  3 +-
 fs/nfs/nfsroot.c                    |  2 +-
 include/linux/compiler_attributes.h | 13 ++++++
 include/linux/kernel.h              | 25 +++++++++++
 kernel/kthread.c                    |  4 +-
 lib/Kconfig.debug                   |  9 ++++
 lib/test_printf.c                   | 43 +++++++++++++++++++
 lib/vsprintf.c                      | 65 +++++++++++++++++++++++++++++
 8 files changed, 160 insertions(+), 4 deletions(-)

-- 
2.19.1.6.gbde171bbf5

