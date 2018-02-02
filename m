Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2948269-1517591385-2-15866060044261530100
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES sk.us-asciiensv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591384; b=cAkB/v4/WnemXFnVVD1U4c4LUG49UeojU6dTacCKzpUab0u
    yjfnRKrceYgKlSk2OOXNLHLyjdkWq39C2TLAd1eAPaF5O/VAfg3s2K5zkQ/+brcF
    3ZzfAHCjXv2WNmOGXOVagFGKtAULtksQEe1zfnPvKjlq5OJ5gElG6ud6FAmZZOqK
    9bXhnyQm79EPr/4dVBARwE77Trx+im2iWVLaDgj5aGwj6lSo/2OL0gAzL4EADOY0
    ZFaGdeSOfDTbKvdA9lK3WWn7CgFVKMJ7hv74pgirrECCOPmP7QO8Ul5Hx0+5KHGL
    WHYdjzLs149O/onbE75Ust3bQ0C6OWcJJ+3+WUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591384; bh=Hqu6nuAf40fotSo4G23R4hM5uP
    ONipEFmlJudIwSpqY=; b=uJvu9NA1UWhYzKjee2WJNc63atc1TUmCwg+qgjYvwB
    JVY1JsU3nGTApkybDLKO+fk9XusHO1F5KCuXV9peLYSZq/RONQemZgGtGgOqkc5/
    TERoe7TXbv2yrd92wvwrtMVWokt1iKnpZYGsf2S7aMzHI0ZXe97YBC+hAZhi5Mgd
    5SGUqYJ6SzKbnMEd2KK6j1/vFvAO8YEAW16JGpOYjmCFCedBpA5TqAbfy7qUhDZE
    CGwVl20dhqyDZqHaNAPUsIwZDPCn09uMr6XCfIRQK70YlPCWz3WGs5ydMD6zj2Sk
    VVbQDBlz21T1nCZYL0LxwepLBm6ZoGfuZz8HZv6nBM0g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753253AbeBBRJi (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:09:38 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37976 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752669AbeBBRJb (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:09:31 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shaohua Li <shli@fb.com>,
        David Disseldorp <ddiss@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 056/156] null_blk: fix dev->badblocks leak
Date: Fri,  2 Feb 2018 17:57:17 +0100
Message-Id: <20180202140842.829885141@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Disseldorp <ddiss@suse.de>


[ Upstream commit 1addb798e93893d33c8dfab743cd44f09fd7719a ]

null_alloc_dev() allocates memory for dev->badblocks, but cleanup
currently only occurs in the configfs release codepath, missing a number
of other places.

This bug was found running the blktests block/010 test, alongside
kmemleak:
rapido1:/blktests# ./check block/010
...
rapido1:/blktests# echo scan > /sys/kernel/debug/kmemleak
[  306.966708] kmemleak: 32 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
rapido1:/blktests# cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff88001f86d000 (size 4096):
  comm "modprobe", pid 231, jiffies 4294892415 (age 318.252s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814b0379>] kmemleak_alloc+0x49/0xa0
    [<ffffffff810f180f>] kmem_cache_alloc+0x9f/0xe0
    [<ffffffff8124e45f>] badblocks_init+0x2f/0x60
    [<ffffffffa0019fae>] 0xffffffffa0019fae
    [<ffffffffa0021273>] nullb_device_badblocks_store+0x63/0x130 [null_blk]
    [<ffffffff810004cd>] do_one_initcall+0x3d/0x170
    [<ffffffff8109fe0d>] do_init_module+0x56/0x1e9
    [<ffffffff8109ebd7>] load_module+0x1c47/0x26a0
    [<ffffffff8109f819>] SyS_finit_module+0xa9/0xd0
    [<ffffffff814b4f60>] entry_SYSCALL_64_fastpath+0x13/0x94

Fixes: 2f54a613c942 ("nullb: badbblocks support")
Reviewed-by: Shaohua Li <shli@fb.com>
Signed-off-by: David Disseldorp <ddiss@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/null_blk.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -467,7 +467,6 @@ static void nullb_device_release(struct
 {
 	struct nullb_device *dev = to_nullb_device(item);
 
-	badblocks_exit(&dev->badblocks);
 	null_free_device_storage(dev, false);
 	null_free_dev(dev);
 }
@@ -578,6 +577,10 @@ static struct nullb_device *null_alloc_d
 
 static void null_free_dev(struct nullb_device *dev)
 {
+	if (!dev)
+		return;
+
+	badblocks_exit(&dev->badblocks);
 	kfree(dev);
 }
 
