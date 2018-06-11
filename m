Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id FNr6BGtVHlv5bQAAmS7hNA
	; Mon, 11 Jun 2018 10:57:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BAC4F607E7; Mon, 11 Jun 2018 10:57:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6B866601C3;
	Mon, 11 Jun 2018 10:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6B866601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932856AbeFKK5S (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 06:57:18 -0400
Received: from smtp1.it.da.ut.ee ([193.40.5.66]:57398 "EHLO smtp1.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932740AbeFKK5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 06:57:17 -0400
Received: from math.ut.ee (unknown [IPv6:2001:bb8:2002:2400:5054:ff:fe3b:8db9])
        by smtp1.it.da.ut.ee (Postfix) with ESMTP id D45349068A;
        Mon, 11 Jun 2018 13:57:14 +0300 (EEST)
Received: by math.ut.ee (Postfix, from userid 1014)
        id C45E022239B; Mon, 11 Jun 2018 13:57:12 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by math.ut.ee (Postfix) with ESMTP id D5427221F45;
        Mon, 11 Jun 2018 13:57:12 +0300 (EEST)
Date: Mon, 11 Jun 2018 13:57:12 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: 4.17.0-10146-gf0dc7f9c6dd9: hw csum failure on powerpc+sungem
Message-ID: <alpine.LRH.2.21.1806111352330.17091@math.ut.ee>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am seeing this on PowerMac G4 with sungem ethernet driver. 4.17 was 
OK, 4.17.0-10146-gf0dc7f9c6dd9 is problematic.

[  140.518664] eth0: hw csum failure
[  140.518699] CPU: 0 PID: 1237 Comm: postconf Not tainted 4.17.0-10146-gf0dc7f9c6dd9 #83
[  140.518707] Call Trace:
[  140.518734] [effefd90] [c03d6db8] __skb_checksum_complete+0xd8/0xdc (unreliable)
[  140.518759] [effefdb0] [c04c1284] icmpv6_rcv+0x248/0x4ec
[  140.518775] [effefdd0] [c049a448] ip6_input_finish.constprop.0+0x11c/0x5f4
[  140.518786] [effefe10] [c049b1c0] ip6_mc_input+0xcc/0x100
[  140.518807] [effefe20] [c03e110c] __netif_receive_skb_core+0x310/0x944
[  140.518820] [effefe70] [c03e76ec] napi_gro_receive+0xd0/0xe8
[  140.518845] [effefe80] [f3e1f66c] gem_poll+0x618/0x1274 [sungem]
[  140.518856] [effeff30] [c03e6f0c] net_rx_action+0x198/0x374
[  140.518872] [effeff90] [c0501a88] __do_softirq+0x120/0x278
[  140.518890] [effeffe0] [c0036188] irq_exit+0xd8/0xdc
[  140.518908] [effefff0] [c000f478] call_do_irq+0x24/0x3c
[  140.518925] [d05a5d30] [c0007120] do_IRQ+0x74/0xf0
[  140.518941] [d05a5d50] [c0012474] ret_from_except+0x0/0x14
[  140.518960] --- interrupt: 501 at copy_page+0x40/0x90
                   LR = copy_user_page+0x18/0x30
[  140.518973] [d05a5e10] [d058cd80] 0xd058cd80 (unreliable)
[  140.518989] [d05a5e20] [c00fa2bc] wp_page_copy+0xec/0x654
[  140.519002] [d05a5e60] [c00fd3a4] do_wp_page+0xa8/0x5b4
[  140.519013] [d05a5e90] [c00fe934] handle_mm_fault+0x564/0xa84
[  140.519025] [d05a5f00] [c0016230] do_page_fault+0x1bc/0x7e8
[  140.519037] [d05a5f40] [c0012300] handle_page_fault+0x14/0x40
[  140.519048] --- interrupt: 301 at 0xb78b6864
                   LR = 0xb78b6c54


-- 
Meelis Roos (mroos@linux.ee)
