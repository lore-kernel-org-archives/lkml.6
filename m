Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FA4C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4713F208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ol5JKUF8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4713F208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeH1Bk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 21:40:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40864 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeH1Bk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 21:40:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id z25-v6so190566pgu.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 14:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=r8t6EW6n+jyjT8ZaGNQ5aTfLWWu/+xiiBp/7EvTHWXs=;
        b=Ol5JKUF8Q8h9xQyYmyINCSKqNr7sYOxmAY9CHskvsLBP0c4rMn7YLSxldhO8hevre/
         1Z4sAj7EBK/10yEE/DWn4t1y9G3nAdVks7FVNPaWx0blyddPht8pEmCDGi9imkWgupmV
         JfxeeVEesAas9IGCPOry7JMU3eBCr/TPnZnIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=r8t6EW6n+jyjT8ZaGNQ5aTfLWWu/+xiiBp/7EvTHWXs=;
        b=Le4OudKhMzvh4LmdiVfHlE0GxJRD0WJFSBYkoGNfLM88/LwFk0gGbyqAJLsyfcwup9
         9qVWR/atQ9CWA1tGYIjySpx3/B8qamh8dOnQ7aiVOsDkEKIv+4TckJxDh/AO/3bb9ZKJ
         rlk+N4wozYR08blCP3aVP0XcddW374tvSZfX/m9Odf4K0atDPYpKYiJSZ2jFI8bACPZ7
         sfv6Pe5NvrLTNdLrmxsJjoo698t/L/Ib8djHel+NOi9s3N5XlKhs7lwj1o89AlERK7DJ
         v5/wNHvymzTtylbnmAk3tVmWj7EBIpXx/BS6DfcyDxIQAa1YvoQmzEbNJXx3uesM/IaO
         nHoA==
X-Gm-Message-State: APzg51Awq7Lk9UHN81p1Umhl3yJEVYe8GtpwPmzS6W4Wo8+rnE6s6g0W
        17+q9fgw2FisATPXWt/tfkppWA==
X-Google-Smtp-Source: ANB0VdZyeu+RWJAeMjbF5o58QdXvTz08xeDdv5MMxdJ81MO860O3ixUSiV72G/RxtJlRzkIG4lco7w==
X-Received: by 2002:a65:594b:: with SMTP id g11-v6mr13797300pgu.260.1535406717156;
        Mon, 27 Aug 2018 14:51:57 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id u25-v6sm180258pfk.177.2018.08.27.14.51.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 14:51:56 -0700 (PDT)
Date:   Mon, 27 Aug 2018 14:51:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>, Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thymo van Beers <thymovanbeers@gmail.com>,
        Joe Perches <joe@perches.com>, linux-doc@vger.kernel.org
Subject: [PATCH] random: Make CPU trust a boot parameter
Message-ID: <20180827215154.GA44225@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of forcing a distro or other system builder to choose
at build time whether the CPU is trusted for CRNG seeding via
CONFIG_RANDOM_TRUST_CPU, provide a boot-time parameter for end users to
control the choice. The CONFIG will set the default state instead.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
 drivers/char/Kconfig                            |  4 ++--
 drivers/char/random.c                           | 11 ++++++++---
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9871e649ffef..64a3bf54b974 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3523,6 +3523,12 @@
 	ramdisk_size=	[RAM] Sizes of RAM disks in kilobytes
 			See Documentation/blockdev/ramdisk.txt.
 
+	random.trust_cpu={on,off}
+			[KNL] Enable or disable trusting the use of the
+			CPU's random number generator (if available) to
+			fully seed the kernel's CRNG. Default is controlled
+			by CONFIG_RANDOM_TRUST_CPU.
+
 	ras=option[,option,...]	[KNL] RAS-specific options
 
 		cec_disable	[X86]
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index ce277ee0a28a..40728491f37b 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -566,5 +566,5 @@ config RANDOM_TRUST_CPU
 	that CPU manufacturer (perhaps with the insistence or mandate
 	of a Nation State's intelligence or law enforcement agencies)
 	has not installed a hidden back door to compromise the CPU's
-	random number generation facilities.
-
+	random number generation facilities. This can also be configured
+	at boot with "random.trust_cpu=on/off".
diff --git a/drivers/char/random.c b/drivers/char/random.c
index bf5f99fc36f1..c75b6cdf0053 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -779,6 +779,13 @@ static struct crng_state **crng_node_pool __read_mostly;
 
 static void invalidate_batched_entropy(void);
 
+static bool trust_cpu __ro_after_init = IS_ENABLED(CONFIG_RANDOM_TRUST_CPU);
+static int __init parse_trust_cpu(char *arg)
+{
+	return kstrtobool(arg, &trust_cpu);
+}
+early_param("random.trust_cpu", parse_trust_cpu);
+
 static void crng_initialize(struct crng_state *crng)
 {
 	int		i;
@@ -799,12 +806,10 @@ static void crng_initialize(struct crng_state *crng)
 		}
 		crng->state[i] ^= rv;
 	}
-#ifdef CONFIG_RANDOM_TRUST_CPU
-	if (arch_init) {
+	if (trust_cpu && arch_init) {
 		crng_init = 2;
 		pr_notice("random: crng done (trusting CPU's manufacturer)\n");
 	}
-#endif
 	crng->init_time = jiffies - CRNG_RESEED_INTERVAL - 1;
 }
 
-- 
2.17.1


-- 
Kees Cook
Pixel Security
