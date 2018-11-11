Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92299C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A04214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="nlwuJtSz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A04214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbeKLFDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:03:05 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:55672 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725725AbeKLFDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:03:05 -0500
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 091A3467C68;
        Sun, 11 Nov 2018 20:13:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1541963621;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=nxlSlnJD5j1rBOgHZfHr/8GOcBOOd/GOdaRvF5SN8OI=;
        b=nlwuJtSzadKGNWYYN0pfag/D4tW9doLeJkkyHXoITVpSHkc4+oyNZdTf5yIkQkUTjiaE9y
        FVLtmp8Yj5fP8Lwwh7chA00f8RO5x2hBKhRRWjC8dRDMy55wwDYWtlIoj7XW3bvJ2SzfMi
        eAeJnAGsPdRG9Z8CNhbXtjICVSfC270=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sun, 11 Nov 2018 20:13:40 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        Dave Jones <davej@codemonkey.org.uk>, netdev@vger.kernel.org,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: WARN_ON() in netconsole with PREEMPT_RT
Message-ID: <f9111ab09dbc264c8ff8b3b79e9f4c06@natalenko.name>
X-Sender: oleksandr@natalenko.name
User-Agent: Roundcube Webmail/1.3.8
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1541963621;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=nxlSlnJD5j1rBOgHZfHr/8GOcBOOd/GOdaRvF5SN8OI=;
        b=YiLV0/eYD4YGo6/ZMKR1gogTZwPUp1+qVDD4nPWr9/sbPzAjk1g61HMnK3CYY356ZIeHfk
        ZBgm6UetY4TxAVYsUSDmtHjM4ci04vL1motmh+qQ6Wa8EvF5FjO0NhsPYHZSHC2WNtz2Sq
        Zhi5QS8r1cFRzgPCDyPAWTntj99xGYU=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1541963621; a=rsa-sha256;
        cv=none;
        b=l2tyNUyYi1K+fWcjpnkb93qQGX6aKi7IRP0d98xqyJdNTpMEnoq3AK3mT4twgfb43M7s5QrJDmSNFUmiwj+n1KQyecNb30gkL0eJSykombKBvHVi9gxBOnI3Z6Yb1I1jGt7ivGu3G2d5Vn77D5cQocBJq1h+Eqegno3KiB9b5/g=
ARC-Authentication-Results: i=1;
        vulcan.natalenko.name;
        auth=pass smtp.auth=oleksandr@natalenko.name smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I was just curious about PREEMPT_RT and decided to give it a (small) 
shot on my laptop. As a safety measure, I've enabled netconsole to catch 
all the weird stuff that can pop up, and immediately it indeed did… in 
the netconsole code itself (irony):

===
[   64.018949] WARNING: CPU: 0 PID: 1204 at net/core/netpoll.c:372 
netpoll_send_udp+0x3e8/0x3ef
…
[   64.019057] CPU: 0 PID: 1204 Comm: bash Not tainted 4.19.0-ig1 #1
[   64.019058] Hardware name: Dell Inc.          Vostro 3360/0F5DWF, 
BIOS A18 09/25/2013
[   64.019063] RIP: 0010:netpoll_send_udp+0x3e8/0x3ef                    
                                                              [   
64.019066] Code: dd ff ff 41 ba 86 dd ff ff 49 2b 96 d0 00 00 00 66 41 
89 96 c6 00 00 00 66 44 89 48 0c 66 45 89 96 c0 00 00 00 e9
  93 fe ff ff <0f> 0b e9 40 fc ff ff 0f 1f 44 00 00 53 0f b7 57 42 48 89 
fb 48 8b
[   64.019068] RSP: 0018:ffffaa6743f87c98 EFLAGS: 00010202
[   64.019070] RAX: 0000000000000292 RBX: 0000000000000014 RCX: 
0000000000000028
[   64.019072] RDX: 0000000000000014 RSI: ffffffffb1e6a300 RDI: 
ffff95973d905668
[   64.019073] RBP: ffffaa6743f87cd8 R08: ffffffffc11f6ba0 R09: 
0000000000000000
[   64.019075] R10: 0000000000000008 R11: 0000000000000000 R12: 
00000000000003e8
[   64.019076] R13: ffff95973d905668 R14: 0000000000000014 R15: 
ffff95973d905668
[   64.019079] FS:  00007f2f8b809b80(0000) GS:ffff95976f000000(0000) 
knlGS:0000000000000000
[   64.019081] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   64.019083] CR2: 000055b8e126fbc8 CR3: 0000000415440006 CR4: 
00000000001606f0
[   64.019084] Call Trace:
[   64.019098]  write_msg+0xd1/0xe0 [netconsole]
[   64.019107]  console_unlock.part.6+0x55b/0x5a0
[   64.019115]  ? _raw_spin_unlock_irqrestore+0x20/0x60
[   64.019120]  vprintk_emit+0x16a/0x1a0
[   64.019125]  printk_emit+0x44/0x5b
[   64.019130]  ? _raw_spin_trylock+0x13/0x80
[   64.019134]  devkmsg_write.cold.16+0x21/0x4e
[   64.019140]  __vfs_write+0x136/0x1a0
[   64.019145]  vfs_write+0xa9/0x1a0
[   64.019149]  ksys_write+0x52/0xc0
[   64.019156]  do_syscall_64+0x5b/0x170
[   64.019160]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
…
===

This is a v4.19.1-rt3-based kernel.

The WARN_ON() is:

362 void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
363 {
…
372     WARN_ON_ONCE(!irqs_disabled());
…

If that matters, I have "threadirqs" passed to the kernel.

Netconsole seems to work even after this warning. Is this OK/expected?

Thanks.

-- 
   Oleksandr Natalenko (post-factum)
