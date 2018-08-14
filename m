Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3839CC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEFEA2172B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEFEA2172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388187AbeHNUN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:13:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51646 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733240AbeHNUN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:13:28 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F404DCD8;
        Tue, 14 Aug 2018 17:25:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Laight <david.laight@aculab.com>,
        Jean Delvare <jdelvare@suse.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com,
        jgross@suse.com, kstewart@linuxfoundation.org,
        boris.ostrovsky@oracle.com, astrachan@google.com, mka@chromium.org,
        arnd@arndb.de, tstellar@redhat.com, sedat.dilek@gmail.com,
        David.Laight@aculab.com
Subject: [PATCH 4.18 04/79] x86/irqflags: Provide a declaration for native_save_fl
Date:   Tue, 14 Aug 2018 19:16:23 +0200
Message-Id: <20180814171336.964554855@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171336.799314117@linuxfoundation.org>
References: <20180814171336.799314117@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nick Desaulniers <ndesaulniers@google.com>

commit 208cbb32558907f68b3b2a081ca2337ac3744794 upstream.

It was reported that the commit d0a8d9378d16 is causing users of gcc < 4.9
to observe -Werror=missing-prototypes errors.

Indeed, it seems that:
extern inline unsigned long native_save_fl(void) { return 0; }

compiled with -Werror=missing-prototypes produces this warning in gcc <
4.9, but not gcc >= 4.9.

Fixes: d0a8d9378d16 ("x86/paravirt: Make native_save_fl() extern inline").
Reported-by: David Laight <david.laight@aculab.com>
Reported-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: hpa@zytor.com
Cc: jgross@suse.com
Cc: kstewart@linuxfoundation.org
Cc: gregkh@linuxfoundation.org
Cc: boris.ostrovsky@oracle.com
Cc: astrachan@google.com
Cc: mka@chromium.org
Cc: arnd@arndb.de
Cc: tstellar@redhat.com
Cc: sedat.dilek@gmail.com
Cc: David.Laight@aculab.com
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180803170550.164688-1-ndesaulniers@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/irqflags.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -13,6 +13,8 @@
  * Interrupt control:
  */
 
+/* Declaration required for gcc < 4.9 to prevent -Werror=missing-prototypes */
+extern inline unsigned long native_save_fl(void);
 extern inline unsigned long native_save_fl(void)
 {
 	unsigned long flags;


