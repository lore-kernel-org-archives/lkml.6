Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368B3C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC22F20685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC22F20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632851AbeKXCz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 21:55:27 -0500
Received: from relay.sw.ru ([185.231.240.75]:47852 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390927AbeKXCz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 21:55:27 -0500
Received: from [10.94.4.83] (helo=finist-ce7.sw.ru)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <khorenko@virtuozzo.com>)
        id 1gQE2I-0003fC-CB; Fri, 23 Nov 2018 19:10:30 +0300
From:   Konstantin Khorenko <khorenko@virtuozzo.com>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc:     Konstantin Khorenko <khorenko@virtuozzo.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 0/1] drivers/i40iw: out of bound access in i40iw_net_event()
Date:   Fri, 23 Nov 2018 19:10:27 +0300
Message-Id: <20181123161028.22633-1-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running debug kernel on a node with infiniband card, got a KASan complain:

 ==================================================================
 BUG: KASAN: slab-out-of-bounds in i40iw_copy_ip_ntohl+0x1c0/0x220
 Read of size 4 at addr ffff88852d477380 by task swapper/6/0

 CPU: 6 PID: 0 Comm: swapper/6 Not tainted 4.20.0-rc3-00087-gc8ce94b8fe53-dirty #15
 Hardware name: DEPO Computers Super Server/X10DRL-i, BIOS 2.0b 05/05/2017
 Call Trace:
  <IRQ>
  dump_stack+0x92/0xeb
  print_address_description+0x6a/0x280
  kasan_report+0x260/0x380
  i40iw_copy_ip_ntohl+0x1c0/0x220
  i40iw_net_event+0x150/0x200
  notifier_call_chain+0x90/0x160
  atomic_notifier_call_chain+0x6c/0x100
  neigh_update+0x82f/0x15c0
  neigh_event_ns+0x4c/0xe0
  arp_process+0x1733/0x1f60
  __netif_receive_skb_one_core+0xe6/0x150
  netif_receive_skb_internal+0xe5/0x4c0
  napi_gro_receive+0x2d1/0x3b0
  i40e_clean_rx_irq+0x9a5/0x2eb0
  i40e_napi_poll+0x11fd/0x2410
  net_rx_action+0x62f/0xbf0
  __do_softirq+0x256/0x9de
  irq_exit+0x29b/0x2d0
  do_IRQ+0x87/0x1a0
  common_interrupt+0xf/0xf

 Allocated by task 0:
  kasan_kmalloc+0xa0/0xd0
  __kmalloc+0x177/0x390
  __neigh_create+0x1e3/0x1820
  neigh_event_ns+0x6b/0xe0
  arp_process+0x1733/0x1f60
  __netif_receive_skb_one_core+0xe6/0x150
  netif_receive_skb_internal+0xe5/0x4c0
  napi_gro_receive+0x2d1/0x3b0
  i40e_clean_rx_irq+0x9a5/0x2eb0
  i40e_napi_poll+0x11fd/0x2410
  net_rx_action+0x62f/0xbf0
  __do_softirq+0x256/0x9de

 Freed by task 0:
 (stack is not available)

 The buggy address belongs to the object at ffff88852d477080
 to the cache kmalloc-1k of size 1024
 The buggy address is located 768 bytes inside of 1024-byte region [ffff88852d477080, ffff88852d477480)
 The buggy address belongs to the page:
 page:ffffea0014b51c00 count:1 mapcount:0 mapping:ffff888107c0ea00 index:0x0 compound_mapcount: 0
 flags: 0x17ffffc0010200(slab|head)
 raw: 0017ffffc0010200 dead000000000100 dead000000000200 ffff888107c0ea00
 raw: 0000000000000000 00000000801c001c 00000001ffffffff 0000000000000000
 page dumped because: kasan: bad access detected

 Memory state around the buggy address:
  ffff88852d477280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff88852d477300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 >ffff88852d477380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                    ^
  ffff88852d477400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff88852d477480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ==================================================================

The complain is valid:

i40iw_net_event() reads unconditionally 16 bytes from neigh->primary_key
while the memory allocated for "neighbour" struct is evaluated in neigh_alloc() as

  tbl->entry_size + dev->neigh_priv_len

where "dev" is a net_device.

But the driver does not setup dev->neigh_priv_len and we read beyond the neigh
entry allocated memory, so the patch in the next mail fixes this.




More debug details:

crash> list net_device.dev_list -H 0xffffffffa908ec88 -s net_device.name -s net_device.neigh_priv_len
ffff88065a92a200
  name = "lo\000\000\000\000\000\000\000\000\000\000\000\000\000"
  neigh_priv_len = 0
ffff880642340000
  name = "eno1\000\000\071:00.0\000\000\000"
  neigh_priv_len = 0
ffff88064aa6a200
  name = "enp6s0f0\000\000\000\000\000\000\000"
  neigh_priv_len = 0
ffff880641180000
  name = "eno2\000\000a:00.0\000\000\000"
  neigh_priv_len = 0
ffff88063e8fd500
  name = "enp6s0f1\000\000\000\000\000\000\000"
  neigh_priv_len = 0
ffff880031400000
  name = "ens11f0\000\000\000\000\000\000\000\000"
  neigh_priv_len = 0
ffff88063c800000
  name = "ens11f1\000\000\000\000\000\000\000\000"
  neigh_priv_len = 0
ffff8808ff4ea100
  name = "bond0\000\000\000\000\000\000\000\000\000\000"
  neigh_priv_len = 0
ffff88101e334400
  name = "ib0\000\000\000\000\000\000\000\000\000\000\000\000"
  neigh_priv_len = 200
=========================================
crash> list i40iw_handler.list -H i40iw_handlers
ffff88004bbc0000 ldev.netdev == 0xffff88063e8fd500
struct net_device {
  name = "enp6s0f1\000\000\000\000\000\000\000",

ffff881049120000 ldev.netdev == 0xffff88064aa6a200
struct net_device {
  name = "enp6s0f0\000\000\000\000\000\000\000",
=========================================
net_device allocation stack:

alloc_netdev_mqs
 alloc_etherdev_mq
  i40e_config_netdev
   i40e_vsi_setup
    i40e_setup_pf_switch
     i40e_probe

=========================================
After the patch:

crash> list net_device.dev_list -H 0xffffffff92a19b48 -s net_device.name -s net_device.neigh_priv_len
ffff88065a2dc400
  name = "lo\000\000\000\000\000\000\000\000\000\000\000\000\000"
  neigh_priv_len = 0
ffff8808fb6dc200
  name = "bond0\000\000\000\000\000\000\000\000\000\000"
  neigh_priv_len = 0
ffff880652600000
  name = "ens11f0\000\000\000\000\000\000\000\000"
  neigh_priv_len = 0
ffff880651a00000
  name = "ens11f1\000\000\000\000\000\000\000\000"
  neigh_priv_len = 0
ffff880651454000
  name = "eno1\000\000\071:00.0\000\000\000"
  neigh_priv_len = 0
ffff880651550000
  name = "eno2\000\000a:00.0\000\000\000"
  neigh_priv_len = 0
ffff8806515cc400
  name = "enp6s0f0\000\000\000\000\000\000\000"
  neigh_priv_len = 16
ffff880650932200
  name = "enp6s0f1\000\000\000\000\000\000\000"
  neigh_priv_len = 16
ffff880642903300
  name = "ib0\000\000\000\000\000\000\000\000\000\000\000\000"
  neigh_priv_len = 200

=========================================

Konstantin Khorenko (1):
  drivers/net/i40e: define proper net_device::neigh_priv_len

 drivers/net/ethernet/intel/i40e/i40e_main.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.15.1

