Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754248AbeD2Vei (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 17:34:38 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:41872 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752238AbeD2Veg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 17:34:36 -0400
X-Google-Smtp-Source: AB8JxZrcy/P4AzRVb0LOojBB4MXFDffqHOH41rowsGGRpY7q/SrWArFDCfccoKJckaYNleXJgTOUqA==
Date: Sun, 29 Apr 2018 14:34:31 -0700
From: Sultan Alsawaf <sultanxda@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>
Subject: Re: Linux messages full of `random: get_random_u32 called from`
Message-ID: <20180429213431.7mupyregrnp2ytqq@sultan-box>
References: <20180426192524.GD5965@thunk.org>
 <2add15cb-2113-0504-a732-81255ea61bf5@gmail.com>
 <20180426235630.GG5965@thunk.org>
 <3eb5761e-7b25-4178-0560-fba5eb43ce6a@gmail.com>
 <20180427201036.GL5965@thunk.org>
 <20180429143205.GD13475@amd>
 <20180429170541.lrzwyihrd6d75rql@sultan-box>
 <20180429184101.GA31156@amd>
 <20180429202033.ysmc42mj2rrk3h7p@sultan-box>
 <20180429211855.GA17525@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180429211855.GA17525@amd>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2018 at 11:18:55PM +0200, Pavel Machek wrote:
> So -- I'm pretty sure systemd and friends should be using
> /dev/urandom. Maybe gpg wants to use /dev/random. _Maybe_.
> 
> [    2.948192] random: systemd: uninitialized urandom read (16 bytes
> read)
> [    2.953526] systemd[1]: systemd 215 running in system mode. (+PAM
> +AUDIT +SELINUX +IMA +SYSVINIT +LIBCRYPTSETUP +GCRYPT +ACL +XZ
> -SECCOMP -APPARMOR)
> [    2.980278] systemd[1]: Detected architecture 'x86'.
> [    3.115072] usb 5-2: New USB device found, idVendor=0483,
> idProduct=2016, bcdDevice= 0.01
> [    3.119633] usb 5-2: New USB device strings: Mfr=1, Product=2,
> SerialNumber=0
> [    3.124147] usb 5-2: Product: Biometric Coprocessor
> [    3.128621] usb 5-2: Manufacturer: STMicroelectronics
> [    3.163839] systemd[1]: Failed to insert module 'ipv6'
> [    3.181266] systemd[1]: Set hostname to <amd>.
> [    3.267243] random: systemd-sysv-ge: uninitialized urandom read (16
> bytes read)
> [    3.669590] random: systemd-sysv-ge: uninitialized urandom read (16
> bytes read)
> [    3.696242] random: systemd: uninitialized urandom read (16 bytes
> read)
> [    3.700066] random: systemd: uninitialized urandom read (16 bytes
> read)
> [    3.703716] random: systemd: uninitialized urandom read (16 bytes
> read)
> 
> Anyway, urandom should need to be seeded once, and then provide random
> data forever... which is not impression I get from the dmesg output
> above. Boot clearly proceeds... somehow. So now I'm confused.

Hmm... Well, the attached patch (which redirects /dev/random to /dev/urandom)
didn't fix my boot issue, so I'm at a loss as well.

Sultan

>From 15f54e2756866956d8713fdec92b54c6c69eb1bb Mon Sep 17 00:00:00 2001
From: Sultan Alsawaf <sultanxda@gmail.com>
Date: Sun, 29 Apr 2018 12:53:44 -0700
Subject: [PATCH] char: mem: Link /dev/random to /dev/urandom

---
 drivers/char/mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index ffeb60d3434c..0cd22e6100ad 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -870,7 +870,7 @@ static const struct memdev {
 #endif
 	 [5] = { "zero", 0666, &zero_fops, 0 },
 	 [7] = { "full", 0666, &full_fops, 0 },
-	 [8] = { "random", 0666, &random_fops, 0 },
+	 [8] = { "random", 0666, &urandom_fops, 0 },
 	 [9] = { "urandom", 0666, &urandom_fops, 0 },
 #ifdef CONFIG_PRINTK
 	[11] = { "kmsg", 0644, &kmsg_fops, 0 },
-- 
2.14.1
