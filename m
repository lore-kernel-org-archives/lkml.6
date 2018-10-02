Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623E1C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 00:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270BC206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 00:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GAcR6tP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 270BC206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbeJBHfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:35:42 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40633 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbeJBHfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:35:41 -0400
Received: by mail-it1-f195.google.com with SMTP id i191-v6so1054776iti.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 17:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bDWn21iauCiQfJ3Cfx0b4/V/Z6uec1GQQMOYX0nkvvY=;
        b=GAcR6tP9URv886m1xLxqEkbz7YdEIPtmlOXupq5g2EXLl32Y9kAajKKDmJnKpSlbBV
         rLEBx20E5RrgQhPahPVvIDZNhfmaScUj9mX/sjntvnTzTNHuAHznGA7psqHqUnYdsXf9
         7S4K20h9JonYDs+o+8wdIfvtkRVU8XCaqZInk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bDWn21iauCiQfJ3Cfx0b4/V/Z6uec1GQQMOYX0nkvvY=;
        b=SVTI7ocNJaRPiU9vPiyLCiKSrWPJmPyk583VZbHCs9FU+55ek8wtuRfC7xT55bADzJ
         b4NWk8oTz0uIXAyJFpBIJBQNf0oM8EoCiIpFhfNLEmItAEWU58C6GtjmJVzytCD1CAEd
         veIbd84H8ey1pWciyhspBRsPN4VjXvZJS5ZQMpo9vchg0gy3RFJt0zmy6yqKI/dYbYiQ
         2vb2TaEGzZngrnewlvHxy6VZvhGcwdOjlDcwIi/aDzfVtB4IS2/vjI5Mv/1x5iDtvo2X
         4iky52Jo8BoqYPa73lIelDLBsUS11P77z01kW1Y0cPd1LECCojG35Z/00rKF/UmK/txZ
         o8yA==
X-Gm-Message-State: ABuFfoiWzNEUFwnMSVZnwEw65tHb1YPVrOLpIJ9JPCnZX15ASwG6b2m9
        EhKmMt5coo6moZUvu/jQ2o2X9g==
X-Google-Smtp-Source: ACcGV61AqGxKtv9I9HjmCYv04cw6b4KEf5MttqybCinUm3ePWLIaBa+yoUlDm4hJymYZNebTGzkDIg==
X-Received: by 2002:a63:9712:: with SMTP id n18-v6mr12323822pge.69.1538441712326;
        Mon, 01 Oct 2018 17:55:12 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id c79-v6sm12054717pfb.147.2018.10.01.17.55.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 17:55:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH security-next v4 02/32] vmlinux.lds.h: Avoid copy/paste of security_init section
Date:   Mon,  1 Oct 2018 17:54:35 -0700
Message-Id: <20181002005505.6112-3-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181002005505.6112-1-keescook@chromium.org>
References: <20181002005505.6112-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid copy/paste by defining SECURITY_INIT in terms of SECURITY_INITCALL.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: James Morris <james.morris@microsoft.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
---
 include/asm-generic/vmlinux.lds.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 7b75ff6e2fce..934a45395547 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -473,13 +473,6 @@
 #define RODATA          RO_DATA_SECTION(4096)
 #define RO_DATA(align)  RO_DATA_SECTION(align)
 
-#define SECURITY_INIT							\
-	.security_initcall.init : AT(ADDR(.security_initcall.init) - LOAD_OFFSET) { \
-		__security_initcall_start = .;				\
-		KEEP(*(.security_initcall.init))			\
-		__security_initcall_end = .;				\
-	}
-
 /*
  * .text section. Map to function alignment to avoid address changes
  * during second ld run in second ld pass when generating System.map
@@ -798,6 +791,12 @@
 		KEEP(*(.security_initcall.init))			\
 		__security_initcall_end = .;
 
+/* Older linker script style for security init. */
+#define SECURITY_INIT							\
+	.security_initcall.init : AT(ADDR(.security_initcall.init) - LOAD_OFFSET) { \
+		SECURITY_INITCALL					\
+	}
+
 #ifdef CONFIG_BLK_DEV_INITRD
 #define INIT_RAM_FS							\
 	. = ALIGN(4);							\
-- 
2.17.1

