Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B76C28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F6720865
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HS5S/O5x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F6720865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbeJLGXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 02:23:49 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33109 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbeJLGXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 02:23:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id 78-v6so2761053pfq.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 15:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=UYXAYqGfk3BgRwHcASkqOPryY2jQvc48F6CyQunh6FE=;
        b=HS5S/O5xzFkgGIXrpdtrZ+Z6lBy6wY/ZnuMIfNQTu30OVdQphSeaLzMmIyvu4Qzj1b
         nka7bpL/xc6dI4aMkbeSczVZvXqxLCKoREIUUdZH44him4sng7zSqAcmpJgvFZrouRVz
         q4JWlaNqNIUcJJWa5UQHxppBNGko+QVJgpoGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=UYXAYqGfk3BgRwHcASkqOPryY2jQvc48F6CyQunh6FE=;
        b=Yo5UPDPMleWce/wrTR8yfgX2mXAspxY8zB1tT92kOUPJgwZidku70jkQABXFGWwPyE
         TqhG+ccz4YXj+BD4awMKySO8rvgi0EKTlS2FjJZT/zhTGrapJQqEBrgE9YFIyfMRCKpC
         Jm5cZOJdrK6R0ECrplfTqUzEOeTgrW7ObOWjdZwAkl7xyUqKPnLZMZDG+VPjFPROVuD/
         maKJcxiDhXvSNKowglLb+8imiAh7t2vapSNl0/xXUF7+o415Cbcom6Vi8uymqZEf8njG
         RODA2BAvm7SCEpvl5L07kpvfDKwF2Sb8X7UzgcF2KzIQSyIL4f9ZK94+7fiNNvR3oTAD
         vBew==
X-Gm-Message-State: ABuFfohOLXGF+2N2Ol7j1Sn2DHaA9YnvkI20s3jungkKSg/09T/BiTb3
        zhAFOq/Qs0b5Ht/3hiFexeKBiw==
X-Google-Smtp-Source: ACcGV617Mo19Q4ey+bBEGsYpQ6ytttHyz7r8lJUfYGzL3/56PanVfzmzglNFOTKwaynTCRK9w7KPig==
X-Received: by 2002:a62:c80d:: with SMTP id z13-v6mr3405934pff.176.1539298463713;
        Thu, 11 Oct 2018 15:54:23 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id v5-v6sm55988837pfd.64.2018.10.11.15.54.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 15:54:22 -0700 (PDT)
Date:   Thu, 11 Oct 2018 15:54:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org, Laura Abbott <labbott@redhat.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Tobin C. Harding" <me@tobin.cc>, Arnd Bergmann <arnd@arndb.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] random: Move rand_initialize() earlier
Message-ID: <20181011225421.GA21093@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now rand_initialize() is run as an early_initcall(), but it only
depends on timekeeping_init() (for mixing ktime_get_real() into the
pools). However, the call to boot_init_stack_canary() for stack canary
initialization runs earlier, which triggers a warning at boot:

random: get_random_bytes called from start_kernel+0x357/0x548 with crng_init=0

Instead, this moves rand_initialize() to after timekeeping_init(), and moves
canary initialization here as well.

Note that this warning may still remain for machines that do not have
UEFI RNG support (which initializes the RNG pools during setup_arch()),
or for x86 machines without RDRAND (or booting without "random.trust=on"
or CONFIG_RANDOM_TRUST_CPU=y).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Alternatively, ktime_get_real() could get mixed into the pools after
timekeeping_init(), and rand_initialize() could be run MUCH early,
like after setup_arch()...
---
 drivers/char/random.c  |  5 ++---
 include/linux/random.h |  1 +
 init/main.c            | 21 ++++++++++++++-------
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index c75b6cdf0053..deff1aa4d000 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1784,7 +1784,7 @@ EXPORT_SYMBOL(get_random_bytes_arch);
  * data into the pool to prepare it for use. The pool is not cleared
  * as that can only decrease the entropy in the pool.
  */
-static void init_std_data(struct entropy_store *r)
+static void __init init_std_data(struct entropy_store *r)
 {
 	int i;
 	ktime_t now = ktime_get_real();
@@ -1811,7 +1811,7 @@ static void init_std_data(struct entropy_store *r)
  * take care not to overwrite the precious per platform data
  * we were given.
  */
-static int rand_initialize(void)
+int __init rand_initialize(void)
 {
 	init_std_data(&input_pool);
 	init_std_data(&blocking_pool);
@@ -1823,7 +1823,6 @@ static int rand_initialize(void)
 	}
 	return 0;
 }
-early_initcall(rand_initialize);
 
 #ifdef CONFIG_BLOCK
 void rand_initialize_disk(struct gendisk *disk)
diff --git a/include/linux/random.h b/include/linux/random.h
index 445a0ea4ff49..13aeaf5a4bd4 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -36,6 +36,7 @@ extern void add_interrupt_randomness(int irq, int irq_flags) __latent_entropy;
 
 extern void get_random_bytes(void *buf, int nbytes);
 extern int wait_for_random_bytes(void);
+extern int __init rand_initialize(void);
 extern bool rng_is_initialized(void);
 extern int add_random_ready_callback(struct random_ready_callback *rdy);
 extern void del_random_ready_callback(struct random_ready_callback *rdy);
diff --git a/init/main.c b/init/main.c
index 18f8f0140fa0..e2b073bf846f 100644
--- a/init/main.c
+++ b/init/main.c
@@ -550,13 +550,6 @@ asmlinkage __visible void __init start_kernel(void)
 	page_address_init();
 	pr_notice("%s", linux_banner);
 	setup_arch(&command_line);
-	/*
-	 * Set up the the initial canary and entropy after arch
-	 * and after adding latent and command line entropy.
-	 */
-	add_latent_entropy();
-	add_device_randomness(command_line, strlen(command_line));
-	boot_init_stack_canary();
 	mm_init_cpumask(&init_mm);
 	setup_command_line(command_line);
 	setup_nr_cpu_ids();
@@ -641,6 +634,20 @@ asmlinkage __visible void __init start_kernel(void)
 	hrtimers_init();
 	softirq_init();
 	timekeeping_init();
+
+	/*
+	 * For best initial stack canary entropy, prepare it after:
+	 * - setup_arch() for any UEFI RNG entropy and boot cmdline access
+	 * - timekeeping_init() for ktime entropy used in rand_initialize()
+	 * - rand_initialize() to get any arch-specific entropy like RDRAND
+	 * - add_latent_entropy() to get any latent entropy
+	 * - adding command line entropy
+	 */
+	rand_initialize();
+	add_latent_entropy();
+	add_device_randomness(command_line, strlen(command_line));
+	boot_init_stack_canary();
+
 	time_init();
 	printk_safe_init();
 	perf_event_init();
-- 
2.17.1


-- 
Kees Cook
Pixel Security
