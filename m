Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AE7ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07907214C3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="RaxzGn2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07907214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbeIQIaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:30:20 -0400
Received: from mail-dm3nam03on0099.outbound.protection.outlook.com ([104.47.41.99]:12736
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730392AbeIQIaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rS9JH16We9CZS4dw6iOpgzZJ9bgZRotVycKZOIqCEw=;
 b=RaxzGn2VZ+tlsfV3QPeX0c1ttV/o1UD+uO/EsxRPpwjkUZ8G1sRsGhNlE9MyoUKqF23hyRmFWPulnu3CdGXjq5UwijL119f1tzc21WFWLLNwFpTBxb3ALsm95xxo6rhxoVFWaaI5uP4vsFG3c8sDABWHInDJfhHlBFlc8ARqujs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0774.namprd21.prod.outlook.com (10.173.192.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:55 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:55 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Niklas Cassel <niklas.cassel@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 64/87] ath10k: transmit queued frames after
 processing rx packets
Thread-Topic: [PATCH AUTOSEL 4.14 64/87] ath10k: transmit queued frames after
 processing rx packets
Thread-Index: AQHUTjL0QD3pwFtI/ki594ZEq13sDA==
Date:   Mon, 17 Sep 2018 03:03:05 +0000
Message-ID: <20180917030220.245686-64-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0774;6:LAUuc6eQDYTmtZBexnWgjwJb0R/6yZxR2nBAlFAEKCEX4jHZd+lWsGNhV1p57QaqquB8YVd9LCJe28d0X/IwuTXpwkQ3eAzl+VUkjhMekN5aElkENrAAnTUC8K/N1YpfZdWR2n73RhCWKKAWWO/G6qeLTVMOSCYHiIoE/0j3oc1MnfgsfVxjvS+Pt9QM0Rz6H1JhGeqcYMXuRzgUx7HNhLWk4tB5NJtzSQ2vhO6Wpjog17DH/1mtAR2sOfY1Q6e3eg8B6XcwvakVjVWpvjWD5Q5IhwKwokPz+7/p4bQtYW83VOaprLBK6CfWx4yr/ncFP+HSJ0f/TvtnHTFE84x2/lUtyeVeDMDkvMCeb/34hBlwVHd3e0eQlTBioSSQ/KPBmCSyDwEIByqByk661TskMA0gcQNZW4o/h0PNAkyuun2AdqxP1kVAMyicEtxXcVPinbT9+wAf3qgJ4FpKRH6Jug==;5:xWzypzgtaHixymuhqNDAhRo9YfBmcmt0SZxUHayB3S/NGjELEtM7Y6z2u/5zZIzlRX+pjkistGCJQns2sx4Uef93hXTlJbjmVfZAA3br/m1MHrC4R8ocFPd6J1/GY1HIsEJDmgkDR5t2FIsnMLdlnjCu/9L5tbIbDwcnOz/5olI=;7:Bl2FiH/1ey+U2B8p51mdyZ2khojszG5+JF9tblwV/FDhexGoC1D6XZAdp1d/0vc49pjHMsdQfLFM4wCLJgx5k1+5LbpuE6SzPM711nlBhC9p2VVU76VX3TuYck+iOj7kZftDelsKwCvzdZnMXpx1tHXazHu3mAybrRemGL9e69a2pjVM85Wl6MwVu6WQMJzPj+Xq/HrYNfU9k1VqMIRbwWeS/IJSd8vHy9ZopS1LzXI6b0g25Z+qeK+QMrfsrp55
x-ms-office365-filtering-correlation-id: 30b47b0a-ce5e-4197-3ab9-08d61c4a584b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0774;
x-ms-traffictypediagnostic: CY4PR21MB0774:
x-microsoft-antispam-prvs: <CY4PR21MB07743E058DAC1DFA54C319C4FB1E0@CY4PR21MB0774.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(116097685857584)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0774;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0774;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(396003)(39860400002)(346002)(199004)(189003)(54906003)(105586002)(316002)(4326008)(6116002)(1076002)(14454004)(305945005)(7736002)(22452003)(81156014)(66066001)(81166006)(99286004)(8936002)(8676002)(3846002)(478600001)(72206003)(53936002)(10290500003)(68736007)(106356001)(6512007)(25786009)(76176011)(110136005)(11346002)(476003)(2616005)(446003)(6436002)(486006)(6506007)(86612001)(10090500001)(102836004)(86362001)(6346003)(186003)(26005)(36756003)(97736004)(2906002)(256004)(14444005)(2900100001)(6486002)(217873002)(107886003)(2501003)(6666003)(5250100002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0774;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Zu9m/bBY3C1zBCD1h+ZBWDWtM+aHzRn8n/EE01hh+nOSfYFdZ98FkEW9Hczjo9oleNydMUW3nQYz//mKP/1B0RyV7gznk6VFTyMfkj/n0gTS0n92rLIOlYd3rRKZydZMaScYQtwZ1Jvv0p9/et/e327tFlJFaO2tCDx5bQosbhfQC5JetKINynBclkUuuBpnbZrV21p9zljkCNcKaqkJMAFiAKnqdBgT7JMTK1n/SXRZhZt2rAyylv76x9yXfWTKM/7P71I4m/DtdvdLuNrG/qYUehDj40+YrWsYFt+c+nuLyo0D0q/+LWZYggL77ppeQk15QfvbrHOpUCBzm61ai5t4wRPbjfie39bjGKATSKk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b47b0a-ce5e-4197-3ab9-08d61c4a584b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:05.4778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0774
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
index 52ebed1f55a1..556e44454ed8 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -4008,6 +4008,7 @@ void ath10k_mac_tx_push_pending(struct ath10k *ar)
 	rcu_read_unlock();
 	spin_unlock_bh(&ar->txqs_lock);
 }
+EXPORT_SYMBOL(ath10k_mac_tx_push_pending);
=20
 /************/
 /* Scanning */
diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/=
ath/ath10k/sdio.c
index c5e6f4254e49..da9dbf3ddaa5 100644
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
