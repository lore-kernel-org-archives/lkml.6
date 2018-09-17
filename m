Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A45CECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7645214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="lMtOZ0ga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7645214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbeIQIaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:30:12 -0400
Received: from mail-dm3nam03on0114.outbound.protection.outlook.com ([104.47.41.114]:30720
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728385AbeIQIaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PG0hfmg3bpshTX0qpNyes15CZfDCrUmxPwoaahZnvZY=;
 b=lMtOZ0gal2daYz/nj/a+2q/HbUECv3+RGkzAvQZGrpSvTfo9jTgNXsCBwl6UjdK334cVZvxBF5Gi6oDDhpDIxyDiPsUUUvl48rQnsjI1Ij8sYosSzYGyNeQ6zcjMvW17VpjODeWxtvLEXXXo63J7DeEVGiCbgZEk82vc4eiY6o0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0774.namprd21.prod.outlook.com (10.173.192.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:54 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:54 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ben Greear <greearb@candelatech.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 61/87] ath10k: protect ath10k_htt_rx_ring_free
 with rx_ring.lock
Thread-Topic: [PATCH AUTOSEL 4.14 61/87] ath10k: protect
 ath10k_htt_rx_ring_free with rx_ring.lock
Thread-Index: AQHUTjLyFPozW7sm20+4wdBqETZ5wQ==
Date:   Mon, 17 Sep 2018 03:03:03 +0000
Message-ID: <20180917030220.245686-61-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0774;6:RLrJyqEaw54BGl5p2NodHgfA3jJGxpNFgi/azOVUURWEyregy50kyyTmarm4qatMXTkTxHtUxCxnw4mPnsBcuazCfstLtlt76NnfPp9XmPursGEp+HYY+s+VKl4g3Swp8fw07Uryasm8r9QOzAW9rmlEozBMi7AvIWgJ1QxXC77fsNW+0r9VCtAqL2uWF8xfSsBXs6//OG8L0+IcBWL7POzJ5FnnZZVqV7Eqw9mGNit033nMaccUM7TvkUZpTggKaE2GrezKlj2xz1gRud3rwakul4nLk9kw3CypFs8n2Gov9v8UAVRlCchwxhFlo48zqFJGEjrhV9uxY5jOOK6KZ6EcE/3q4fkYxEk7cSz9+QjgMrksRPYgNguEmLC7hXRHa84yKRuwdqzkca73AbZFG5BUocmpmfWgg+MWQWnvrqtlDtPRu98luxHGOWn8rLJb5X5gCzajmAK90gooo32/9Q==;5:wnij6w9w9fCgoUEa59+5X+S96+TT8C+N2necG45xrqygOGhBQ1ruihu30xFPRFRbNr1ee2SadFGLzx7wEJbkNC+JeMptFMumd/iHs+tTvJjnD9+uBcLcfr/zH81GTGleWf04zzbdpNpANZ6MKKzrul1vszBYipcsEYrDo1j2dcc=;7:FhEue1ofK0YAFuiEEIE+DaANOi2Wc9v8bHglerU/7mvbktghh7gfc+w7x7RAKsmAKiKiHygy0iQ83mm6B4ZDmHCxM9ThMFPEX4M8uncU8qVl5CuHoJW4thy+c5+Cb1is6+py1E/a9fMAABypoYEFaGtw0yJvOVKrGfRCa1bt+y4Y3/80k71Sq30+R3FuZCK4mtDGp+XBezkgUAaexNoA6jtwn+L95HBrxCf/fTKwR6tHrCDMP3MAk4rKOdQ4BGsk
x-ms-office365-filtering-correlation-id: 713018ee-4e94-4752-569c-08d61c4a57a4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0774;
x-ms-traffictypediagnostic: CY4PR21MB0774:
x-microsoft-antispam-prvs: <CY4PR21MB0774B133E6A83D9FB9C42D0AFB1E0@CY4PR21MB0774.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0774;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0774;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(396003)(39860400002)(346002)(199004)(189003)(54906003)(105586002)(316002)(4326008)(6116002)(1076002)(14454004)(305945005)(7736002)(22452003)(81156014)(66066001)(81166006)(99286004)(8936002)(15760500003)(8676002)(3846002)(478600001)(72206003)(53936002)(10290500003)(68736007)(106356001)(6512007)(25786009)(76176011)(110136005)(11346002)(476003)(2616005)(446003)(6436002)(486006)(6506007)(86612001)(10090500001)(102836004)(575784001)(86362001)(6346003)(186003)(26005)(36756003)(97736004)(2906002)(256004)(14444005)(2900100001)(6486002)(217873002)(107886003)(2501003)(6666003)(5250100002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0774;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: APA+c2IIs+TXQykWw8X39sn2SpPUFjQ59DYs3NY8Bb82IEjuLF9Y3+VPe6Dx7Hs8eVqnKM0rulRSj2vkWfsoRhR+buYUgU1xp1i37Ta7nwnFi20E0jUOl/AKrvg5QvmGfamD3zS0WyLj95luCpHZkRUmg2dH07p+Vv4b0OdwMwKl36VkP6ohZhEzjfChLKTSL1qa/r+CaWHT+3YgqgestQkQqb4D2CzjHGi4b41Nls/cwe02VNp5LsLPhQDOFQDzRX1Ws65OMNqgSMn/9kUt8TvsMWl5OeK5L83vbFMBTNfRy4/Pr6Xbp+Vjg1NnIvkziS5nFwYx5MdrH4Zep2VjXbXLjKthFph0xUYIhlcT/nY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 713018ee-4e94-4752-569c-08d61c4a57a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:03.2904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0774
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

[ Upstream commit 168f75f11fe68455e0d058a818ebccfc329d8685 ]

While debugging driver crashes related to a buggy firmware
crashing under load, I noticed that ath10k_htt_rx_ring_free
could be called without being under lock.  I'm not sure if this
is the root cause of the crash or not, but it seems prudent to
protect it.

Originally tested on 4.16+ kernel with ath10k-ct 10.4 firmware
running on 9984 NIC.

Signed-off-by: Ben Greear <greearb@candelatech.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ath/ath10k/htt_rx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireles=
s/ath/ath10k/htt_rx.c
index 0aeeb233af78..21642bab485a 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -215,11 +215,12 @@ int ath10k_htt_rx_ring_refill(struct ath10k *ar)
 	spin_lock_bh(&htt->rx_ring.lock);
 	ret =3D ath10k_htt_rx_ring_fill_n(htt, (htt->rx_ring.fill_level -
 					      htt->rx_ring.fill_cnt));
-	spin_unlock_bh(&htt->rx_ring.lock);
=20
 	if (ret)
 		ath10k_htt_rx_ring_free(htt);
=20
+	spin_unlock_bh(&htt->rx_ring.lock);
+
 	return ret;
 }
=20
@@ -231,7 +232,9 @@ void ath10k_htt_rx_free(struct ath10k_htt *htt)
 	skb_queue_purge(&htt->rx_in_ord_compl_q);
 	skb_queue_purge(&htt->tx_fetch_ind_q);
=20
+	spin_lock_bh(&htt->rx_ring.lock);
 	ath10k_htt_rx_ring_free(htt);
+	spin_unlock_bh(&htt->rx_ring.lock);
=20
 	dma_free_coherent(htt->ar->dev,
 			  (htt->rx_ring.size *
--=20
2.17.1
