Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84348ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10296214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DUnkK3aI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10296214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbeIQI1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:27:22 -0400
Received: from mail-by2nam03on0112.outbound.protection.outlook.com ([104.47.42.112]:14944
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729253AbeIQI1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnYoxBoh6cNl67lCNv9naZ0jeLzqE7DcWCZvcxV83u8=;
 b=DUnkK3aIjTSPGKKyKT0cY63aqG0TB3V/Ow0NkMjfFNw4BqFm3VYZ2umcc/9jI5c5jRBjtPeVP4vYS/2efDVQe817G2tzVaypGhg5I208L8D8so3eCaudBbGpCaM/TXuwTvH7mh0/Qiuo+xllm7CiDxHwAYlK1Rdhpcmg7/0UNOw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0502.namprd21.prod.outlook.com (10.172.122.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.7; Mon, 17 Sep 2018 03:01:56 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:55 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bob Copeland <me@bobcopeland.com>,
        Bob Copeland <bobcopeland@fb.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 070/136] ath10k: use locked skb_dequeue for rx
 completions
Thread-Topic: [PATCH AUTOSEL 4.18 070/136] ath10k: use locked skb_dequeue for
 rx completions
Thread-Index: AQHUTjKnuSJrXpwSREC6m1t5JdN6xA==
Date:   Mon, 17 Sep 2018 03:00:55 +0000
Message-ID: <20180917030006.245495-70-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0502;6:1DT8EWdRbdhciVm6gzUQTPtkaw07aR4/LeMLzrVPojalDpyM7/4ovC+y4pnbjRxcEiUdA+hEh86ZbneDzZG/V/Weu8/L80sQyaLgdLhEPKFIzAUKSqi9OFpn6ucHsEqZ5Vz1ziAJWB2QHp+pADkqremGactYvdI05VHfwBhP3CXL1EmRHBb8y2PlAP52aYD/+HVFsD/1YxPLv9MVg/94M7aBdoVrJbhxWe3kSUHl9s3kjhdi23GPDvfKLEaumuQCW8BJCVO2vjPpRkO2DaTwzQGr+GTY9Y4HTurywFNBH6Mc/Rg70LEsXOa3KYVE3EtjxZoqpeFB2WK9/K22PLAM0WRx79hKUKIkrj5rYGXNcx/68MSzJkjQtWShiQd5pn35oQ/ahXN6FXdUdsKPGGGPaH+rkU/U18awpTFvTM6Jx3g7jW0V1rFdPfTFMx5Th9RjfqD3tapN+AhBuvwnoHlI0w==;5:Ag26KNjYXMSUtSvAodMcHAXtEprhhRK2YAnavQ3Ao2caA7uY7KuUmm8I6ueTb3TFN4ij9TbJYG54Fb4YbG8At0ek+FFC0flqI22YXJaJIIzriJiFMjzH7h0Zt7z6BDnkjhcSpxXiQ+aXHhHqa1myJNVmejZ7ta5nQ24eWQagC+w=;7:4OkCeLoiMgu0rLO1e4f1EIy2rKPUlxEgA0o/P8Kj8k5vY1p1TzzPTMNjXCxiiiNWnWzfoecusK4UGno/zHNZh4CPeDf51sBSs6ZdLTasEE9QYDI/KSQwk3uk3z2VuAzy226j+WIq2Pd98raymzdneO2yhTt/IhJOSGbCWJpJH4KZbxga+zDfmtDegddd3HB7kxrTvKr2m3OMhE5o0C44hga1uANCJ3k9Tbxk0oZQk9KMu3GLajRg9m7JetiayS53
x-ms-office365-filtering-correlation-id: 573560cf-49a5-4595-4d06-08d61c49ed5c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0502;
x-ms-traffictypediagnostic: CY4PR21MB0502:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0502114B50FAA5DFFD3243D2FB1E0@CY4PR21MB0502.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193)(67672495146484)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0502;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0502;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(136003)(366004)(376002)(189003)(199004)(86362001)(2616005)(99286004)(5660300001)(575784001)(1076002)(6116002)(3846002)(10290500003)(2900100001)(72206003)(68736007)(8676002)(22452003)(26005)(217873002)(86612001)(486006)(76176011)(66066001)(102836004)(2906002)(476003)(14444005)(186003)(256004)(6506007)(446003)(11346002)(36756003)(316002)(5250100002)(6512007)(97736004)(2501003)(107886003)(110136005)(54906003)(6486002)(8936002)(53936002)(81156014)(81166006)(10090500001)(25786009)(305945005)(7736002)(105586002)(106356001)(478600001)(4326008)(14454004)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0502;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8GzN38DD2IP0KuFtZ3Wt9iscJqiw6GTSLTiQFLClvdxcWIiU/4ZJRHx0bhAMBW9AGs/XEGPm93brRxfrVYUTeVztM7V1SpZlJ1NWpBQEOc+s27NvN/lMZDaTJbS3wVDBMqZpFv7b3Vu1HN//WM7FzEmJQv1vZW0WqASR8YosKvaP2FJ6jAbXVpeBcKPn4iiODK2BHPnm56hX39mW6IrbKvAciXJuB5CLAYVbGeVynacmbSYSj2k6q4u2sjA/LOqAF5M6ZuqnkOK64jOnPG0oHJdqVCh21wER5dUxkRoWCtY2GM69BMT9Pp195XSBf7reTIIcDAHZlkUhUgRP0RkiVjvoWm2BD6kTixZLi/I9r+U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 573560cf-49a5-4595-4d06-08d61c49ed5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:55.9169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0502
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bob Copeland <me@bobcopeland.com>

[ Upstream commit 62652555c616cad23a572f76cb5e870ab5395191 ]

In our environment we are occasionally seeing the following stack trace
in ath10k:

Unable to handle kernel paging request at virtual address 0000a800
pgd =3D c0204000
[0000a800] *pgd=3D00000000
Internal error: Oops: 17 [#1] SMP ARM
Modules linked in: dwc3 dwc3_of_simple phy_qcom_dwc3 nf_nat xt_connmark
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.9.31 #2
Hardware name: Generic DT based system
task: c09f4f40 task.stack: c09ee000
PC is at kfree_skb_list+0x1c/0x2c
LR is at skb_release_data+0x6c/0x108
pc : [<c065dcc4>]    lr : [<c065da5c>]    psr: 200f0113
sp : c09efb68  ip : c09efb80  fp : c09efb7c
r10: 00000000  r9 : 00000000  r8 : 043fddd1
r7 : bf15d160  r6 : 00000000  r5 : d4ca2f00  r4 : ca7c6480
r3 : 000000a0  r2 : 01000000  r1 : c0a57470  r0 : 0000a800
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5787d  Table: 56e6006a  DAC: 00000051
Process swapper/0 (pid: 0, stack limit =3D 0xc09ee210)
Stack: (0xc09efb68 to 0xc09f0000)
fb60:                   ca7c6480 d4ca2f00 c09efb9c c09efb80 c065da5c c065dc=
b4
fb80: d4ca2f00 00000000 dcbf8400 bf15d160 c09efbb4 c09efba0 c065db28 c065d9=
fc
fba0: d4ca2f00 00000000 c09efbcc c09efbb8 c065db48 c065db04 d4ca2f00 000000=
00
fbc0: c09efbe4 c09efbd0 c065ddd0 c065db38 d4ca2f00 00000000 c09efc64 c09efb=
e8
fbe0: bf09bd00 c065dd10 00000003 7fffffff c09efc24 dcbfc9c0 01200000 000000=
00
fc00: 00000000 00000000 ddb7e440 c09e9440 c09efc48 1d195000 c09efc7c c09efc=
28
fc20: c027bb68 c028aa00 ddb7e4f8 bf13231c ddb7e454 0004091f bf154571 d4ca2f=
00
fc40: dcbf8d00 ca7c5df6 bf154538 01200000 00000000 bf154538 c09efd1c c09efc=
68
fc60: bf132458 bf09bbbc ca7c5dec 00000041 bf154538 bf154539 000007bf bf1545=
45
fc80: bf154538 bf154538 bf154538 bf154538 bf154538 00000000 00000000 000016=
c1
fca0: 00000001 c09efcb0 01200000 00000000 00000000 00000000 00000000 000000=
01
fcc0: bf154539 00000041 00000000 00000007 00000000 000000d0 ffffffff 3160ff=
ff
fce0: 9ad93e97 3e973160 7bf09ad9 0004091f d4ca2f00 c09efdb0 dcbf94e8 000000=
00
fd00: dcbf8d00 01200000 00000000 dcbf8d00 c09efd44 c09efd20 bf132544 bf1321=
30
fd20: dcbf8d00 00000000 d4ca2f00 c09efdb0 00000001 d4ca2f00 c09efdec c09efd=
48
fd40: bf133630 bf1324d0 ca7c5cc0 000007c0 c09efd88 c09efd70 c0764230 c02277=
d8
fd60: 200f0113 ffffffff dcbf94c8 bf000000 dcbf93b0 dcbf8d00 00000040 dcbf94=
5c
fd80: dcbf94e8 00000000 c09efdcc 00000000 c09efd90 c09efd90 00000000 000000=
24
fda0: dcbf8d00 00000000 00000005 dcbf8d00 c09efdb0 c09efdb0 00000000 000000=
40
fdc0: c09efdec dcbf8d00 dcbfc9c0 c09ed140 00000040 00000000 00000100 000000=
40
fde0: c09efe14 c09efdf0 bf1739b4 bf132840 dcbfc9c0 ddb82140 c09ed140 1d1950=
00
fe00: 00000001 00000100 c09efe64 c09efe18 c067136c bf173958 ddb7fac8 c09f0d=
00
fe20: 001df678 0000012c c09efe28 c09efe28 c09efe30 c09efe30 c0a7fb28 ffffe0=
00
fe40: c09f008c 00000003 00000008 c0a598c0 00000100 c09f0080 c09efeb4 c09efe=
68
fe60: c02096e0 c0671278 c0494584 00000080 dd5c3300 c09f0d00 00000004 001df6=
77
fe80: 0000000a 00200100 dd5c3300 00000000 00000000 c09eaa70 00000060 dd4108=
00
fea0: c09ee000 00000000 c09efecc c09efeb8 c0227944 c02094c4 00000000 000000=
00
fec0: c09efef4 c09efed0 c0268b64 c02278ac de802000 c09f1b1c c09eff20 c0a16c=
c0
fee0: de803000 c09ee000 c09eff1c c09efef8 c020947c c0268ae0 c02103dc 600f00=
13
ff00: ffffffff c09eff54 ffffe000 c09ee000 c09eff7c c09eff20 c021448c c02094=
24
ff20: 00000001 00000000 00000000 c021ddc0 00000000 00000000 c09f1024 000000=
01
ff40: ffffe000 c09f1078 00000000 c09eff7c c09eff80 c09eff70 c02103ec c02103=
dc
ff60: 600f0013 ffffffff 00000051 00000000 c09eff8c c09eff80 c0763cc4 c02103=
bc
ff80: c09effa4 c09eff90 c025f0e4 c0763c98 c0a59040 c09f1000 c09effb4 c09eff=
a8
ffa0: c075efe0 c025efd4 c09efff4 c09effb8 c097dcac c075ef7c ffffffff ffffff=
ff
ffc0: 00000000 c097d6c4 00000000 c09c1a28 c0a59294 c09f101c c09c1a24 c09f61=
c0
ffe0: 4220406a 512f04d0 00000000 c09efff8 4220807c c097d95c 00000000 000000=
00
[<c065dcc4>] (kfree_skb_list) from [<c065da5c>] (skb_release_data+0x6c/0x10=
8)
[<c065da5c>] (skb_release_data) from [<c065db28>] (skb_release_all+0x30/0x3=
4)
[<c065db28>] (skb_release_all) from [<c065db48>] (__kfree_skb+0x1c/0x9c)
[<c065db48>] (__kfree_skb) from [<c065ddd0>] (consume_skb+0xcc/0xd8)
[<c065ddd0>] (consume_skb) from [<bf09bd00>] (ieee80211_rx_napi+0x150/0x82c=
 [mac80211])
[<bf09bd00>] (ieee80211_rx_napi [mac80211]) from [<bf132458>] (ath10k_htt_t=
2h_msg_handler+0x15e8/0x19c4 [ath10k_core])
[<bf132458>] (ath10k_htt_t2h_msg_handler [ath10k_core]) from [<bf132544>] (=
ath10k_htt_t2h_msg_handler+0x16d4/0x19c4 [ath10k_core])
[<bf132544>] (ath10k_htt_t2h_msg_handler [ath10k_core]) from [<bf133630>] (=
ath10k_htt_txrx_compl_task+0xdfc/0x12cc [ath10k_core])
[<bf133630>] (ath10k_htt_txrx_compl_task [ath10k_core]) from [<bf1739b4>] (=
ath10k_pci_napi_poll+0x68/0xf4 [ath10k_pci])
[<bf1739b4>] (ath10k_pci_napi_poll [ath10k_pci]) from [<c067136c>] (net_rx_=
action+0x100/0x33c)
[<c067136c>] (net_rx_action) from [<c02096e0>] (__do_softirq+0x228/0x31c)
[<c02096e0>] (__do_softirq) from [<c0227944>] (irq_exit+0xa4/0x114)

The trace points to a corrupt skb inside kfree_skb(), seemingly because
one of the shared skb queues is getting corrupted.  Most of the skb queues
ath10k uses are local to a single call stack, but three are shared among
multiple codepaths:

 - rx_msdus_q,
 - rx_in_ord_compl_q, and
 - tx_fetch_ind_q

Of the three, the first two are manipulated using the unlocked skb_queue
functions without any additional lock protecting them.  Use the locked
variants of skb_queue_* functions to protect these manipulations.

Signed-off-by: Bob Copeland <bobcopeland@fb.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ath/ath10k/htt_rx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireles=
s/ath/ath10k/htt_rx.c
index c72d8af122a2..86accfb8eb88 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -1089,7 +1089,7 @@ static void ath10k_htt_rx_h_queue_msdu(struct ath10k =
*ar,
 	status =3D IEEE80211_SKB_RXCB(skb);
 	*status =3D *rx_status;
=20
-	__skb_queue_tail(&ar->htt.rx_msdus_q, skb);
+	skb_queue_tail(&ar->htt.rx_msdus_q, skb);
 }
=20
 static void ath10k_process_rx(struct ath10k *ar, struct sk_buff *skb)
@@ -2810,7 +2810,7 @@ bool ath10k_htt_t2h_msg_handler(struct ath10k *ar, st=
ruct sk_buff *skb)
 		break;
 	}
 	case HTT_T2H_MSG_TYPE_RX_IN_ORD_PADDR_IND: {
-		__skb_queue_tail(&htt->rx_in_ord_compl_q, skb);
+		skb_queue_tail(&htt->rx_in_ord_compl_q, skb);
 		return false;
 	}
 	case HTT_T2H_MSG_TYPE_TX_CREDIT_UPDATE_IND:
@@ -2874,7 +2874,7 @@ static int ath10k_htt_rx_deliver_msdu(struct ath10k *=
ar, int quota, int budget)
 		if (skb_queue_empty(&ar->htt.rx_msdus_q))
 			break;
=20
-		skb =3D __skb_dequeue(&ar->htt.rx_msdus_q);
+		skb =3D skb_dequeue(&ar->htt.rx_msdus_q);
 		if (!skb)
 			break;
 		ath10k_process_rx(ar, skb);
@@ -2905,7 +2905,7 @@ int ath10k_htt_txrx_compl_task(struct ath10k *ar, int=
 budget)
 		goto exit;
 	}
=20
-	while ((skb =3D __skb_dequeue(&htt->rx_in_ord_compl_q))) {
+	while ((skb =3D skb_dequeue(&htt->rx_in_ord_compl_q))) {
 		spin_lock_bh(&htt->rx_ring.lock);
 		ret =3D ath10k_htt_rx_in_ord_ind(ar, skb);
 		spin_unlock_bh(&htt->rx_ring.lock);
--=20
2.17.1
