Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95937C46462
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602BF2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 602BF2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lisas.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbeJKB2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 21:28:55 -0400
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:39328 "EHLO
        rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbeJKB2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 21:28:55 -0400
X-Greylist: delayed 307 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Oct 2018 21:28:51 EDT
Received: by rhlx01.hs-esslingen.de (Postfix, from userid 102)
        id 463BA210EA5A; Wed, 10 Oct 2018 20:00:29 +0200 (CEST)
Date:   Wed, 10 Oct 2018 20:00:29 +0200
From:   Andreas Mohr <andi@lisas.de>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [BUG] Bluetooth 4.14.74-v7+: hci_connect_le_scan_cleanup() crash
 NULL deref Raspberry Pi 3B+
Message-ID: <20181010180029.GA13522@rhlx01.hs-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Priority: none
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

[long time no see, good to be back!]

just newly got the following crash with a new setup:

[    6.234357] Adding 102396k swap on /var/swap.  Priority:-2 extents:1 across:102396k SSFS
[    7.114565] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
[    7.114582] brcmfmac: power management disabled
[    7.522803] smsc95xx 1-1.1:1.0 eth0: hardware isn't capable of remote wakeup
[    9.102052] smsc95xx 1-1.1:1.0 eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
[   11.887650] Bluetooth: HCI UART driver ver 2.3
[   11.887660] Bluetooth: HCI UART protocol H4 registered
[   11.887663] Bluetooth: HCI UART protocol Three-wire (H5) registered
[   11.887811] Bluetooth: HCI UART protocol Broadcom registered
[   13.399873] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[   13.402896] Bridge firewalling registered
[   13.424852] nf_conntrack version 0.5.0 (15360 buckets, 61440 max)
[   14.284667] Netfilter messages via NETLINK v0.30.
[   14.290169] ctnetlink v0.93: registering with nfnetlink.
[   14.405316] IPv6: ADDRCONF(NETDEV_UP): docker0: link is not ready
[   33.422932] NET: Registered protocol family 38
[75215.105699] Unable to handle kernel NULL pointer dereference at virtual address 00000012
[75215.109883] pgd = 80004000
[75215.112020] [00000012] *pgd=00000000
[75215.114129] Internal error: Oops: 17 [#1] SMP ARM
[75215.116262] Modules linked in: aes_arm_bs crypto_simd cryptd algif_skcipher af_alg ipt_MASQUERADE nf_nat_masquerade_ipv4 nf_conntrack_netlink nfnetlink iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 xt_addrtype iptable_filter xt_conntrack nf_nat nf_conntrack br_netfilter bridge stp llc overlay hci_uart serdev rfcomm cmac bnep brcmfmac brcmutil cfg80211 snd_bcm2835(C) snd_pcm snd_timer snd uio_pdrv_genirq uio fixed ftdi_sio usbserial btusb btrtl btintel btbcm bluetooth ecdh_generic rfkill i2c_dev ip_tables x_tables ipv6
[75215.133930] CPU: 2 PID: 167 Comm: kworker/u9:2 Tainted: G         C      4.14.74-v7+ #1149
[75215.139286] Hardware name: BCM2835
[75215.142121] Workqueue: hci0 hci_rx_work [bluetooth]
[75215.144853] task: b9315a00 task.stack: b71f8000
[75215.147707] PC is at hci_connect_le_scan_cleanup+0x14/0x124 [bluetooth]
[75215.150642] LR is at create_le_conn_complete+0xcc/0xd8 [bluetooth]
[75215.153455] pc : [<7f0dd0cc>]    lr : [<7f0df4d4>]    psr: 60000013
[75215.156326] sp : b71f9df0  ip : b71f9e10  fp : b71f9e0c
[75215.159124] r10: b2e86180  r9 : 00000088  r8 : b924b780
[75215.161834] r7 : b9da97e8  r6 : b9da9008  r5 : 00000000  r4 : b9da98b4
[75215.164616] r3 : 00200400  r2 : b9da98b4  r1 : 00000000  r0 : 00000000
[75215.167400] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[75215.170254] Control: 10c5383d  Table: 195ac06a  DAC: 00000055
[75215.173069] Process kworker/u9:2 (pid: 167, stack limit = 0xb71f8210)
[75215.175869] Stack: (0xb71f9df0 to 0xb71fa000)
[75215.178574] 9de0:                                     b9da98b4 00000000 b9da9008 b9da97e8
[75215.183810] 9e00: b71f9e2c b71f9e10 7f0df4d4 7f0dd0c4 7f0df408 b9da9000 b2e86180 0000000e
[75215.188960] 9e20: b71f9ebc b71f9e30 7f0e57bc 7f0df414 b71f9e70 b71f9e74 b9315a80 b9315a00
[75215.194193] 9e40: ba372d78 00000000 b9315e60 80b8ed40 b71f9e8c 80b8ed40 a72136c0 b9da97f4
[75215.199699] 9e60: 60000013 00000000 00da97e8 b9da200d 7f0df408 00000000 b71f9e9c b71f9e88
[75215.205455] 9e80: 807a3eec 801ee19c b9da97e8 b2e86180 b71f9ebc b9da9708 b9da98b4 b9da9000
[75215.211367] 9ea0: b9da97e8 b9da9008 00000088 b2e86180 b71f9efc b71f9ec0 7f0d8b3c 7f0e54f4
[75215.217508] 9ec0: b9da9718 b9da901c b908c300 80137520 b71f9efc b9092580 b9da9708 b70dae00
[75215.223972] 9ee0: b908c300 00000000 00000088 00000000 b71f9f34 b71f9f00 801376f0 7f0d89d0
[75215.230596] 9f00: b70dae18 80c02d00 00000088 b70dae00 b9092598 b70dae00 b70dae18 80c02d00
[75215.237352] 9f20: 00000088 b9092580 b71f9f7c b71f9f38 80137a50 801375a4 b71f9f5c b71f8000
[75215.244292] 9f40: 00000000 80c02d00 80c88562 b71f8038 b979b01c b979b000 00000000 b722f300
[75215.251303] 9f60: b9092580 801379ec b979b01c b732fe80 b71f9fac b71f9f80 8013dad4 801379f8
[75215.258312] 9f80: 80102d94 b722f300 8013d998 00000000 00000000 00000000 00000000 00000000
[75215.265319] 9fa0: 00000000 b71f9fb0 8010810c 8013d9a4 00000000 00000000 00000000 00000000
[75215.272327] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[75215.279336] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[75215.286614] [<7f0dd0cc>] (hci_connect_le_scan_cleanup [bluetooth]) from [<7f0df4d4>] (create_le_conn_complete+0xcc/0xd8 [bluetooth])
[75215.293988] [<7f0df4d4>] (create_le_conn_complete [bluetooth]) from [<7f0e57bc>] (hci_event_packet+0x2d4/0x2de8 [bluetooth])
[75215.301354] [<7f0e57bc>] (hci_event_packet [bluetooth]) from [<7f0d8b3c>] (hci_rx_work+0x178/0x250 [bluetooth])
[75215.308585] [<7f0d8b3c>] (hci_rx_work [bluetooth]) from [<801376f0>] (process_one_work+0x158/0x454)
[75215.315681] [<801376f0>] (process_one_work) from [<80137a50>] (worker_thread+0x64/0x5b8)
[75215.322757] [<80137a50>] (worker_thread) from [<8013dad4>] (kthread+0x13c/0x16c)
[75215.329829] [<8013dad4>] (kthread) from [<8010810c>] (ret_from_fork+0x14/0x28)
[75215.333466] Code: e92dd8f0 e24cb004 e52de004 e8bd4000 (e5d04012) 
[75215.337146] ---[ end trace f3a6771e5232874d ]---



Context notes:
- Raspberry Pi 3B (not 3B+), Raspbian
- Linux [HOSTNAME] 4.14.74-v7+ #1149 SMP Mon Oct 8 17:39:42 BST 2018 armv7l GNU/Linux
- updated to *custom* manual setup (very newish kernel) yesterday (via rpi-update), rebooted
- builtin Bluetooth (hci0)
- external Bluetooth (hci1, CSR I believe)
- FHEM, with various modules regularly polling various Bluetooth clients, via hci0 only
- very newly erected wiring (relocated to different location, new external Bluetooth, etc., yesterday) setup

Returned to the location today, merely to
find external Bluetooth LED blinking *very* rapidly, then
fumbled the stick, at which moment LED went solid.
I returned a couple seconds later, LED had gone dark.

Few minutes later, connected to box, only to find this crash dump trace there.
It seems quite obvious that
this crash may have happened due to
implementation stack mis-handling a (temporary??) connector disconnect/power-loss issue.

Ran
git log v4.14..master -- net/bluetooth/hci_conn.c
, did not immediately see (m)any obviously relevant items.

Thus now reporting here (get_maintainer.pl...).

Thank you!

Greetings,

Andreas Mohr

-- 
GNU/Linux. It's not the software that's free, it's you.
