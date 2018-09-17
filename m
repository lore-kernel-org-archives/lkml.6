Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2EAECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380F22147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="mN7r3fiu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 380F22147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbeIQI11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:27:27 -0400
Received: from mail-eopbgr720118.outbound.protection.outlook.com ([40.107.72.118]:6704
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729354AbeIQI11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0yqqrx6rQ2rBgZSZ81e8RtCIkdE3p8L0fHxovUcfwI=;
 b=mN7r3fiuc5pnNyEdOLscZydEWQdWMv+1Cf3rCf4TkOUV1CiNE3rF6/Zxv6Wny+IdWsrrJGdNE9a9hPkE0CS+5dlFhVDMejaN4BdMv3DxYRQKxGYikKfw1cvVyKADgh9UsS3Cx90kLy9sa2rrqcFLdq2qLOCCeOfLIyXW2TzOYkM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0790.namprd21.prod.outlook.com (10.175.121.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Mon, 17 Sep 2018 03:02:03 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:03 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Niklas Cassel <niklas.cassel@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 090/136] ath10k: transmit queued frames after
 processing rx packets
Thread-Topic: [PATCH AUTOSEL 4.18 090/136] ath10k: transmit queued frames
 after processing rx packets
Thread-Index: AQHUTjKuBZBy7hVoh0SSewsP52Zc9Q==
Date:   Mon, 17 Sep 2018 03:01:08 +0000
Message-ID: <20180917030006.245495-90-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0790;6:nVyns4xE0C9SlYVvN66r4SZFtALF34u3LpXylG0mH3J/4WydqNqtsCQzXJuCHLp5YSAxfiGZXds1mtAvQ+6hqtDy4v+oz4jngxgzeBz90ljlCvtUHIm3BItgU9C8zcDetEUaYLw1Mz9KYYxQY8jw6SvRoIJViRCSey17RaivoDP9mhi+CgGH54sYyatEBTE13Lq1czCIAdRpde+VC4BQwRJezO8e9a5/B3NXewtJvtqnO+en7ot3/P9MMXicsCQFYw+RTeEeeUsWTxh8hCOSxIx3eWk3bKpLfRE7jG4CmwxH5kRHU8rm8qQFHz68AoMmALqdVyMKLBqnzJRXxvhpl7pTSEdXKxpJlAKVteBK3lMPHNRcezHP5tafQnOcJ/M5XQ0xAbDdhHdzPPxoyIyW3uzjrpnKrFU7yvWbGqm6HKNSezQVFRlKRcsVzvl9mZ4heoUiIEobANFDaZEHuo4tvA==;5:SsMpZqGezYrOrfbuNxhBw1Yifvd9I1tp76Ry+lQx3LdTJc/gJhdvvsNchh8HwahIBvBR0BXpT35/uwXM/3nThxZB1j8RepPwUFznst9ryjLL+pj6XBixkIca8SC74Cte1YhnmaaFcdZKBCjpimSjDQgN4N4ZEXyMOezF7KZEW+s=;7:dlYtt8XNQWlGfl5DUoSsmBuDCeG5ug1LFWz/j0dO0HaRz4OPJKRYG6PtUPZgHWyXsdLCFyqQ8dHJtgyYUGnp2Gow+12JcwTLtVK1MH32652ce39mlH14EA541quS0eUn5ljVa9qbdggG9Ce3VsGRMFydgK7V+i/VpjoRyurvZ3EIigM8n5ZOu1ylpxqhark3+u8sax8shbuXM18InwLbH1InDeN/VGaPOb8CEQ65YFqFWgAtGRSZCNckceXL1z71
x-ms-office365-filtering-correlation-id: 31f0c25b-d7a6-42f3-d7bf-08d61c49f1fa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0790;
x-ms-traffictypediagnostic: CY4PR21MB0790:
x-microsoft-antispam-prvs: <CY4PR21MB0790E08873AC266F6512B33DFB1E0@CY4PR21MB0790.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(116097685857584)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0790;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0790;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(396003)(376002)(366004)(199004)(189003)(76176011)(22452003)(110136005)(99286004)(6436002)(6486002)(2900100001)(2906002)(54906003)(6346003)(10090500001)(5660300001)(7736002)(6512007)(14444005)(217873002)(316002)(256004)(53936002)(36756003)(6506007)(25786009)(106356001)(26005)(86612001)(10290500003)(1076002)(68736007)(476003)(6116002)(3846002)(478600001)(5250100002)(11346002)(446003)(72206003)(2501003)(81156014)(81166006)(8676002)(14454004)(102836004)(107886003)(186003)(2616005)(575784001)(97736004)(86362001)(66066001)(305945005)(486006)(8936002)(4326008)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0790;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: BaQravjF4kjC1ajAGDHIH8Pnb/VD4Xj9aoW1KuteJjqW7g8LMND8F8hT8Smpm7bq2HACEri9tgHo2h2NgrIrSGHR6mMmdtv8kwp+uvK58HqVRK7aGYPX6OHwEGCdTqSH6q/0ydtmSpd9ZdEo63FdKWYz3cg6v0mzNh4rnEX+YuGQ3zmPFg9JRLGGRyV/3nC5Ztxh02pSWlbzl0iRnXNvoMhdBpXE/eTTBSBc99VnYiEZvPrqhB/or94M8uzfj5ugZOZIVJf/F/GMYBAZ6dOMWi5hVQ4xKtdW88oKlq3u7lE4OENm4zsqIEqQ+lLiVeTEDMAMnI242kgnY+4ihn1MRQg1FoKp6gaZHyFBGAUGSZs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f0c25b-d7a6-42f3-d7bf-08d61c49f1fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:08.9792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0790
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Cassel <niklas.cassel@linaro.org>

[ Upstream commit 3f04950f32d5d592ab4fcaecac2178558a6f7437 ]

When running iperf on ath10k SDIO, TX can stop working:

iperf -c 192.168.1.1 -i 1 -t 20 -w 10K
[  3]  0.0- 1.0 sec  2.00 MBytes  16.8 Mbits/sec
[  3]  1.0- 2.0 sec  3.12 MBytes  26.2 Mbits/sec
[  3]  2.0- 3.0 sec  3.25 MBytes  27.3 Mbits/sec
[  3]  3.0- 4.0 sec   655 KBytes  5.36 Mbits/sec
[  3]  4.0- 5.0 sec  0.00 Bytes  0.00 bits/sec
[  3]  5.0- 6.0 sec  0.00 Bytes  0.00 bits/sec
[  3]  6.0- 7.0 sec  0.00 Bytes  0.00 bits/sec
[  3]  7.0- 8.0 sec  0.00 Bytes  0.00 bits/sec
[  3]  8.0- 9.0 sec  0.00 Bytes  0.00 bits/sec
[  3]  9.0-10.0 sec  0.00 Bytes  0.00 bits/sec
[  3]  0.0-10.3 sec  9.01 MBytes  7.32 Mbits/sec

There are frames in the ieee80211_txq and there are frames that have
been removed from from this queue, but haven't yet been sent on the wire
(num_pending_tx).

When num_pending_tx reaches max_num_pending_tx, we will stop the queues
by calling ieee80211_stop_queues().

As frames that have previously been sent for transmission
(num_pending_tx) are completed, we will decrease num_pending_tx and wake
the queues by calling ieee80211_wake_queue(). ieee80211_wake_queue()
does not call wake_tx_queue, so we might still have frames in the
queue at this point.

While the queues were stopped, the socket buffer might have filled up,
and in order for user space to write more, we need to free the frames
in the queue, since they are accounted to the socket. In order to free
them, we first need to transmit them.

This problem cannot be reproduced on low-latency devices, e.g. pci,
since they call ath10k_mac_tx_push_pending() from
ath10k_htt_txrx_compl_task(). ath10k_htt_txrx_compl_task() is not called
on high-latency devices.
Fix the problem by calling ath10k_mac_tx_push_pending(), after
processing rx packets, just like for low-latency devices, also in the
SDIO case. Since we are calling ath10k_mac_tx_push_pending() directly,
we also need to export it.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ath/ath10k/mac.c  | 1 +
 drivers/net/wireless/ath/ath10k/sdio.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/a=
th/ath10k/mac.c
index 836e0a47b94a..b8ef919daa6b 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -4047,6 +4047,7 @@ void ath10k_mac_tx_push_pending(struct ath10k *ar)
 	rcu_read_unlock();
 	spin_unlock_bh(&ar->txqs_lock);
 }
+EXPORT_SYMBOL(ath10k_mac_tx_push_pending);
=20
 /************/
 /* Scanning */
diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/=
ath/ath10k/sdio.c
index aebdf99068e7..299db8b1c9ba 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -30,6 +30,7 @@
 #include "debug.h"
 #include "hif.h"
 #include "htc.h"
+#include "mac.h"
 #include "targaddrs.h"
 #include "trace.h"
 #include "sdio.h"
@@ -1346,6 +1347,8 @@ static void ath10k_sdio_irq_handler(struct sdio_func =
*func)
 			break;
 	} while (time_before(jiffies, timeout) && !done);
=20
+	ath10k_mac_tx_push_pending(ar);
+
 	sdio_claim_host(ar_sdio->func);
=20
 	if (ret && ret !=3D -ECANCELED)
--=20
2.17.1
