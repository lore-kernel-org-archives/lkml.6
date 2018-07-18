Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C03ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8862075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC8862075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbeGRMsp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 08:48:45 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:33980 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730213AbeGRMsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 08:48:45 -0400
Received: from [192.168.0.117] (188.146.100.122.nat.umts.dynamic.t-mobile.pl [188.146.100.122])
        by mail.holtmann.org (Postfix) with ESMTPSA id 741C9CF2BA;
        Wed, 18 Jul 2018 14:17:59 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH] Bluetooth: Use lock_sock_nested in bt_accept_enqueue
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180717114112.857-1-pp@emlix.com>
Date:   Wed, 18 Jul 2018 14:11:04 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <9843EAA5-912F-408F-8ED2-D033376B1A10@holtmann.org>
References: <20180717114112.857-1-pp@emlix.com>
To:     Philipp Puschmann <pp@emlix.com>
X-Mailer: Apple Mail (2.3445.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

> Fixes this warning that was provoked by a pairing:
> 
> [60258.016221] WARNING: possible recursive locking detected
> [60258.021558] 4.15.0-RD1812-BSP #1 Tainted: G           O
> [60258.027146] --------------------------------------------
> [60258.032464] kworker/u5:0/70 is trying to acquire lock:
> [60258.037609]  (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}, at: [<87759073>] bt_accept_enqueue+0x3c/0x74
> [60258.046863]
> [60258.046863] but task is already holding lock:
> [60258.052704]  (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}, at: [<d22d7106>] l2cap_sock_new_connection_cb+0x1c/0x88
> [60258.062905]
> [60258.062905] other info that might help us debug this:
> [60258.069441]  Possible unsafe locking scenario:
> [60258.069441]
> [60258.075368]        CPU0
> [60258.077821]        ----
> [60258.080272]   lock(sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP);
> [60258.085510]   lock(sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP);
> [60258.090748]
> [60258.090748]  *** DEADLOCK ***
> [60258.090748]
> [60258.096676]  May be due to missing lock nesting notation
> [60258.096676]
> [60258.103472] 5 locks held by kworker/u5:0/70:
> [60258.107747]  #0:  ((wq_completion)%shdev->name#2){+.+.}, at: [<9460d092>] process_one_work+0x130/0x4fc
> [60258.117263]  #1:  ((work_completion)(&hdev->rx_work)){+.+.}, at: [<9460d092>] process_one_work+0x130/0x4fc
> [60258.126942]  #2:  (&conn->chan_lock){+.+.}, at: [<7877c8c3>] l2cap_connect+0x80/0x4f8
> [60258.134806]  #3:  (&chan->lock/2){+.+.}, at: [<2e16c724>] l2cap_connect+0x8c/0x4f8
> [60258.142410]  #4:  (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}, at: [<d22d7106>] l2cap_sock_new_connection_cb+0x1c/0x88
> [60258.153043]
> [60258.153043] stack backtrace:
> [60258.157413] CPU: 1 PID: 70 Comm: kworker/u5:0 Tainted: G           O     4.15.0-RD1812-BSP #1
> [60258.165945] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [60258.172485] Workqueue: hci0 hci_rx_work
> [60258.176331] Backtrace:
> [60258.178797] [<8010c9fc>] (dump_backtrace) from [<8010ccbc>] (show_stack+0x18/0x1c)
> [60258.186379]  r7:80e55fe4 r6:80e55fe4 r5:20050093 r4:00000000
> [60258.192058] [<8010cca4>] (show_stack) from [<809864e8>] (dump_stack+0xb0/0xdc)
> [60258.199301] [<80986438>] (dump_stack) from [<8016ecc8>] (__lock_acquire+0xffc/0x11d4)
> [60258.207144]  r9:5e2bb019 r8:630f974c r7:ba8a5940 r6:ba8a5ed8 r5:815b5220 r4:80fa081c
> [60258.214901] [<8016dccc>] (__lock_acquire) from [<8016f620>] (lock_acquire+0x78/0x98)
> [60258.222655]  r10:00000040 r9:00000040 r8:808729f0 r7:00000001 r6:00000000 r5:60050013
> [60258.230491]  r4:00000000
> [60258.233045] [<8016f5a8>] (lock_acquire) from [<806ee974>] (lock_sock_nested+0x64/0x88)
> [60258.240970]  r7:00000000 r6:b796e870 r5:00000001 r4:b796e800
> [60258.246643] [<806ee910>] (lock_sock_nested) from [<808729f0>] (bt_accept_enqueue+0x3c/0x74)
> [60258.255004]  r8:00000001 r7:ba7d3c00 r6:ba7d3ea4 r5:ba7d2000 r4:b796e800
> [60258.261717] [<808729b4>] (bt_accept_enqueue) from [<808aa39c>] (l2cap_sock_new_connection_cb+0x68/0x88)
> [60258.271117]  r5:b796e800 r4:ba7d2000
> [60258.274708] [<808aa334>] (l2cap_sock_new_connection_cb) from [<808a294c>] (l2cap_connect+0x190/0x4f8)
> [60258.283933]  r5:00000001 r4:ba6dce00
> [60258.287524] [<808a27bc>] (l2cap_connect) from [<808a4a14>] (l2cap_recv_frame+0x744/0x2cf8)
> [60258.295800]  r10:ba6dcf24 r9:00000004 r8:b78d8014 r7:00000004 r6:bb05d000 r5:00000004
> [60258.303635]  r4:bb05d008
> [60258.306183] [<808a42d0>] (l2cap_recv_frame) from [<808a7808>] (l2cap_recv_acldata+0x210/0x214)
> [60258.314805]  r10:b78e7800 r9:bb05d960 r8:00000001 r7:bb05d000 r6:0000000c r5:b7957a80
> [60258.322641]  r4:ba6dce00
> [60258.325188] [<808a75f8>] (l2cap_recv_acldata) from [<8087630c>] (hci_rx_work+0x35c/0x4e8)
> [60258.333374]  r6:80e5743c r5:bb05d7c8 r4:b7957a80
> [60258.338004] [<80875fb0>] (hci_rx_work) from [<8013dc7c>] (process_one_work+0x1a4/0x4fc)
> [60258.346018]  r10:00000001 r9:00000000 r8:baabfef8 r7:ba997500 r6:baaba800 r5:baaa5d00
> [60258.353853]  r4:bb05d7c8
> [60258.356401] [<8013dad8>] (process_one_work) from [<8013e028>] (worker_thread+0x54/0x5cc)
> [60258.364503]  r10:baabe038 r9:baaba834 r8:80e05900 r7:00000088 r6:baaa5d18 r5:baaba800
> [60258.372338]  r4:baaa5d00
> [60258.374888] [<8013dfd4>] (worker_thread) from [<801448f8>] (kthread+0x134/0x160)
> [60258.382295]  r10:ba8310b8 r9:bb07dbfc r8:8013dfd4 r7:baaa5d00 r6:00000000 r5:baaa8ac0
> [60258.390130]  r4:ba831080
> [60258.392682] [<801447c4>] (kthread) from [<801080b4>] (ret_from_fork+0x14/0x20)
> [60258.399915]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:801447c4
> [60258.407751]  r4:baaa8ac0 r3:baabe000
> 
> Signed-off-by: Philipp Puschmann <pp@emlix.com>
> ---
> net/bluetooth/af_bluetooth.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

