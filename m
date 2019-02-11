Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C64C282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38993222A8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549898059;
	bh=rmqXNwyfU696H9HyM8vF1CQSzZqn0yAqRtAIQvlUp8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oPuw706AGLa9/zcMAq0oWTNHw7H2eOcBI436dTfdMQL7uYn61PZxwYUuMeqrmmMN2
	 D4ZR9BfXEY+M3Nt9eWT4KCcVlMuN6c0alFmDnitYvyOTY3WivhyYJHHhDlin56mI2c
	 3sppGaxxMsxfYuRdQpHuCz1PEOSmgUqzbJY5Pcaw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391573AbfBKPOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:14:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:58632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391508AbfBKPIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:08:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D361217D9;
        Mon, 11 Feb 2019 15:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897724;
        bh=rmqXNwyfU696H9HyM8vF1CQSzZqn0yAqRtAIQvlUp8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=drDTD+GM/BQ9xx2Nxb5aH3ZqzQJbb5pr1LjT778N75sroOoTFqbA1mmyJBAj8rJuX
         UzlKUuUq1p8I7o9Oxnwqq/WSA3f2pvec94VLrH/2EdbiDgymeooMi28py3/TV9Vm1x
         2/bYIiTdl/OKWWvQZZZjnhz4ZeqXN3Ihh7wyPZaQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Scott Wood <oss@buserror.net>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 095/137] fsl/fman: Use GFP_ATOMIC in {memac,tgec}_add_hash_mac_address()
Date:   Mon, 11 Feb 2019 15:19:36 +0100
Message-Id: <20190211141820.874955174@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
References: <20190211141811.964925535@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 0d9c9a238faf925823bde866182c663b6d734f2e ]

These functions are called from atomic context:

[    9.150239] BUG: sleeping function called from invalid context at /home/scott/git/linux/mm/slab.h:421
[    9.158159] in_atomic(): 1, irqs_disabled(): 0, pid: 4432, name: ip
[    9.163128] CPU: 8 PID: 4432 Comm: ip Not tainted 4.20.0-rc2-00169-g63d86876f324 #29
[    9.163130] Call Trace:
[    9.170701] [c0000002e899a980] [c0000000009c1068] .dump_stack+0xa8/0xec (unreliable)
[    9.177140] [c0000002e899aa10] [c00000000007a7b4] .___might_sleep+0x138/0x164
[    9.184440] [c0000002e899aa80] [c0000000001d5bac] .kmem_cache_alloc_trace+0x238/0x30c
[    9.191216] [c0000002e899ab40] [c00000000065ea1c] .memac_add_hash_mac_address+0x104/0x198
[    9.199464] [c0000002e899abd0] [c00000000065a788] .set_multi+0x1c8/0x218
[    9.206242] [c0000002e899ac80] [c0000000006615ec] .dpaa_set_rx_mode+0xdc/0x17c
[    9.213544] [c0000002e899ad00] [c00000000083d2b0] .__dev_set_rx_mode+0x80/0xd4
[    9.219535] [c0000002e899ad90] [c00000000083d334] .dev_set_rx_mode+0x30/0x54
[    9.225271] [c0000002e899ae10] [c00000000083d4a0] .__dev_open+0x148/0x1c8
[    9.230751] [c0000002e899aeb0] [c00000000083d934] .__dev_change_flags+0x19c/0x1e0
[    9.230755] [c0000002e899af60] [c00000000083d9a4] .dev_change_flags+0x2c/0x80
[    9.242752] [c0000002e899aff0] [c0000000008554ec] .do_setlink+0x350/0xf08
[    9.248228] [c0000002e899b170] [c000000000857ad0] .rtnl_newlink+0x588/0x7e0
[    9.253965] [c0000002e899b740] [c000000000852424] .rtnetlink_rcv_msg+0x3e0/0x498
[    9.261440] [c0000002e899b820] [c000000000884790] .netlink_rcv_skb+0x134/0x14c
[    9.267607] [c0000002e899b8e0] [c000000000851840] .rtnetlink_rcv+0x18/0x2c
[    9.274558] [c0000002e899b950] [c000000000883c8c] .netlink_unicast+0x214/0x318
[    9.281163] [c0000002e899ba00] [c000000000884220] .netlink_sendmsg+0x348/0x444
[    9.287076] [c0000002e899bae0] [c00000000080d13c] .sock_sendmsg+0x2c/0x54
[    9.287080] [c0000002e899bb50] [c0000000008106c0] .___sys_sendmsg+0x2d0/0x2d8
[    9.298375] [c0000002e899bd30] [c000000000811a80] .__sys_sendmsg+0x5c/0xb0
[    9.303939] [c0000002e899be20] [c0000000000006b0] system_call+0x60/0x6c

Signed-off-by: Scott Wood <oss@buserror.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/fman/fman_memac.c | 2 +-
 drivers/net/ethernet/freescale/fman/fman_tgec.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c b/drivers/net/ethernet/freescale/fman/fman_memac.c
index 71a5ded9d1de..21dd5579130e 100644
--- a/drivers/net/ethernet/freescale/fman/fman_memac.c
+++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
@@ -923,7 +923,7 @@ int memac_add_hash_mac_address(struct fman_mac *memac, enet_addr_t *eth_addr)
 	hash = get_mac_addr_hash_code(addr) & HASH_CTRL_ADDR_MASK;
 
 	/* Create element to be added to the driver hash table */
-	hash_entry = kmalloc(sizeof(*hash_entry), GFP_KERNEL);
+	hash_entry = kmalloc(sizeof(*hash_entry), GFP_ATOMIC);
 	if (!hash_entry)
 		return -ENOMEM;
 	hash_entry->addr = addr;
diff --git a/drivers/net/ethernet/freescale/fman/fman_tgec.c b/drivers/net/ethernet/freescale/fman/fman_tgec.c
index 4b0f3a50b293..e575259d20f4 100644
--- a/drivers/net/ethernet/freescale/fman/fman_tgec.c
+++ b/drivers/net/ethernet/freescale/fman/fman_tgec.c
@@ -551,7 +551,7 @@ int tgec_add_hash_mac_address(struct fman_mac *tgec, enet_addr_t *eth_addr)
 	hash = (crc >> TGEC_HASH_MCAST_SHIFT) & TGEC_HASH_ADR_MSK;
 
 	/* Create element to be added to the driver hash table */
-	hash_entry = kmalloc(sizeof(*hash_entry), GFP_KERNEL);
+	hash_entry = kmalloc(sizeof(*hash_entry), GFP_ATOMIC);
 	if (!hash_entry)
 		return -ENOMEM;
 	hash_entry->addr = addr;
-- 
2.19.1



