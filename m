Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B069ECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B5520693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="JXLzSQV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B5520693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbeGRCTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 22:19:15 -0400
Received: from imap.thunk.org ([74.207.234.97]:54446 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730614AbeGRCTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/6kW4C0AuE1PrIVo8C3EcpCflI1vVjKQKVIBShAGxC0=; b=JXLzSQV2OIijEzrDdTnZKshaMn
        wdRzEy++A2t3tr6TYe6cZd6JLUo8yAQ34U61Mjhe6EySGvemc+D5nN6lmVHQT98C8gtICVLPHEXF/
        Khenbizd88EQvjXAHJIK9f/xdb/+Q55tWfgbCiBm8ZJC3tZc45HOE4gNdg/PjD7wexVQ=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1ffbVQ-0000lp-Mh; Wed, 18 Jul 2018 01:43:52 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8E3DB7A63F0; Tue, 17 Jul 2018 21:43:50 -0400 (EDT)
From:   Theodore Ts'o <tytso@mit.edu>
To:     linux-crypto@vger.kernel.org,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>
Cc:     labbott@redhat.com, Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] random: add a config option to trust the CPU's hwrng
Date:   Tue, 17 Jul 2018 21:43:44 -0400
Message-Id: <20180718014344.1309-1-tytso@mit.edu>
X-Mailer: git-send-email 2.18.0.rc0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This gives the user building their own kernel (or a Linux
distribution) the option of deciding whether or not to trust the CPU's
hardware random number generator (e.g., RDRAND for x86 CPU's) as being
correctly implemented and not having a back door introduced (perhaps
courtesy of a Nation State's law enforcement or intelligence
agencies).

This will prevent getrandom(2) from blocking, if there is a
willingness to trust the CPU manufacturer.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---

 I'm not sure Linux distro's will thank us for this.  The problem is
 trusting the CPU manfuacturer can be an emotional / political issue.

 For example, assume that China has decided that as a result of the
 "death sentence" that the US government threatened to impose on ZTE
 after they were caught introducing privacy violating malware on US
 comsumers, that they needed to be self-sufficient in their technology
 sector, and so they decided the needed to produce their own CPU.

 Even if I were convinced that Intel hadn't backdoored RDRAND (or an
 NSA agent backdoored RDRAND for them) such that the NSA had a NOBUS
 (nobody but us) capability to crack RDRAND generated numbers, if we
 made a change to unconditionally trust RDRAND, then I didn't want the
 upstream kernel developers to have to answer the question, "why are
 you willing to trust Intel, but you aren't willing to trust a company
 owned and controlled by a PLA general?"  (Or a company owned and
 controlled by one of Putin's Oligarchs, if that makes you feel
 better.)

 With this patch, we don't put ourselves in this position --- but we
 do put the Linux distro's in this position intead.  The upside is it
 gives the choice to each person building their own Linux kernel to
 decide whether trusting RDRAND is worth it to avoid hangs due to
 userspace trying to get cryptographic-grade entropy early in the boot
 process.  (Note: I trust RDRAND more than I do Jitter Entropy.)

 drivers/char/Kconfig  | 14 ++++++++++++++
 drivers/char/random.c | 11 ++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 212f447938ae..fe2930c4ecf0 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -554,3 +554,17 @@ config ADI
 
 endmenu
 
+config RANDOM_TRUST_CPU
+       bool "Trust the CPU manufacturer to initialize Linux's CRNG"
+       depends on (X86 || X86_64 || X86_32 || S390 || PPC)
+       default n
+       help
+	Assume that CPU manufacurer (e.g., Intel or AMD for RDSEED or
+	RDRAND, IBM for the S390 and Power PC architectures) is trustworthy
+	for the purposes of initializing Linux's CRNG.  Since this is not
+	something that can be indepedently audited, this amounts to trusting
+	that CPU manufacturer (perhaps with the insistance or requirement
+	of a Nation State's intelligence or law enforcement agencies)
+	has not installed a hidden back door to compromise the CPU's
+	random number generation facilities.
+
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 34ddfd57419b..f4013b8a711b 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -782,6 +782,7 @@ static void invalidate_batched_entropy(void);
 static void crng_initialize(struct crng_state *crng)
 {
 	int		i;
+	int		arch_init = 1;
 	unsigned long	rv;
 
 	memcpy(&crng->state[0], "expand 32-byte k", 16);
@@ -792,10 +793,18 @@ static void crng_initialize(struct crng_state *crng)
 		_get_random_bytes(&crng->state[4], sizeof(__u32) * 12);
 	for (i = 4; i < 16; i++) {
 		if (!arch_get_random_seed_long(&rv) &&
-		    !arch_get_random_long(&rv))
+		    !arch_get_random_long(&rv)) {
 			rv = random_get_entropy();
+			arch_init = 0;
+		}
 		crng->state[i] ^= rv;
 	}
+#ifdef CONFIG_RANDOM_TRUST_CPU
+	if (arch_init) {
+		crng_init = 2;
+		pr_notice("random: crng done (trusting CPU's manufacturer)\n");
+	}
+#endif
 	crng->init_time = jiffies - CRNG_RESEED_INTERVAL - 1;
 }
 
-- 
2.18.0.rc0

