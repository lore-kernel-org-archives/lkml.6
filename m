Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F7CC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE9222098B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uVDDj8jr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE9222098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeHYCh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 22:37:29 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:42807 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbeHYCh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 22:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=CmvPqGsdv8cxd+iRh2wVhcrhYkRTBVRbGGcMmV7quUs=;
        b=uVDDj8jrR+pEngSwN4uqvpPKsygrDbrjKuCbBDf1XBwUHlt/IdLo/jtVLmEqYU7x9d36ZEJZWdzGNwtWIikL94aS31pWW1WE3P/K/xQITMIV5TgheEB7rfnSrh/yg/EOSwBjgbbRfs4glaALj+9yrKInmjW2G4Le9Ngg6UvfTTo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1ftL4Q-0003SJ-0J; Sat, 25 Aug 2018 01:00:46 +0200
Date:   Sat, 25 Aug 2018 01:00:45 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 17/17] net: WireGuard secure network tunnel
Message-ID: <20180824230045.GH27483@lunn.ch>
References: <20180824213849.23647-1-Jason@zx2c4.com>
 <20180824213849.23647-18-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824213849.23647-18-Jason@zx2c4.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason

It is normal to include after the --- what you have changed since the
previous version.

I ran checkpatch on this again.

Last time, we had:

total: 6 errors, 763 warnings, 6514 lines checked

This time, we have:

total: 8 errors, 196 warnings, 7470 lines checked

So much better with the warnings. Thanks.

The errors should be simple to fix:

ERROR: that open brace { should be on the previous line
ERROR: that open brace { should be on the previous line
ERROR: spaces required around that '=' (ctx:VxW)
ERROR: spaces required around that '=' (ctx:VxW)
ERROR: spaces required around that '=' (ctx:VxW)
ERROR: that open brace { should be on the previous line
ERROR: Use of __initconst requires a separate use of const
ERROR: trailing whitespace

One appears to be a false positive:

+static const struct {
+       bool result;
+       unsigned int msec_to_sleep_before;
+} expected_results[] __initconst = {
+       [0 ... PACKETS_BURSTABLE - 1] = { true, 0 },
+       [PACKETS_BURSTABLE] = { false, 0 },
+       [PACKETS_BURSTABLE + 1] = { true, MSEC_PER_SEC / PACKETS_PER_SECOND },
+       [PACKETS_BURSTABLE + 2] = { false, 0 },
+       [PACKETS_BURSTABLE + 3] = { true, (MSEC_PER_SEC / PACKETS_PER_SECOND) * 2 },
+       [PACKETS_BURSTABLE + 4] = { true, 0 },
+       [PACKETS_BURSTABLE + 5] = { false, 0 }
+};

Looking at some of the warnings:

WARNING: Avoid crashing the kernel - try using WARN_ON & recovery code rather than BUG() or BUG_ON()
#428: FILE: drivers/net/wireguard/allowedips.c:112:
+               BUG_ON(len >= 128); 

WARNING: Macros with flow control statements should be avoided
#5905: FILE: drivers/net/wireguard/selftest/ratelimiter.h:87:
+#define ensure_time do {                                                   \
+               if (time_is_before_jiffies(loop_start_time +               \
+                                          maximum_jiffies_at_index(i))) { \
+                       if (++tries >= 5000)                               \
+                               goto err;                                  \
+                       gc_entries(NULL);                                  \
+                       rcu_barrier();                                     \
+                       msleep(500);                                       \
+                       goto restart;                                      \
+               }                                                          \
+       } while (0)

WARNING: Macros with flow control statements should be avoided
#6948: FILE: drivers/net/wireguard/timers.c:29:
+#define peer_get_from_timer(timer_name)                                        \
+       struct wireguard_peer *peer;                                           \
+       rcu_read_lock_bh();                                                    \
+       peer = peer_get_maybe_zero(from_timer(peer, timer, timer_name));       \
+       rcu_read_unlock_bh();                                                  \
+       if (unlikely(!peer))                                                   \
+               return;

are not very nice.

WARNING: Possible unnecessary 'out of memory' message
#5306: FILE: drivers/net/wireguard/selftest/allowedips.h:261:
+       if (!peers) {
+               pr_info("allowedips random self-test: out of memory\n");

kcalloc and friends are pretty noisy when they fails. No need to add
your own print.

I see we still have a lot of __always_inline in C files :-(

	Andrew
