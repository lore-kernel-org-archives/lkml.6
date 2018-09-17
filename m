Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04085ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2884208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nlJhGAnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2884208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbeIQI1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:27:25 -0400
Received: from mail-eopbgr720118.outbound.protection.outlook.com ([40.107.72.118]:6704
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729316AbeIQI1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTuZjsMEFkYZwot7IkSTzNhuEIR2+7So+oeyaNFEVrI=;
 b=nlJhGAnjlPApVN+trKT4q+BkTpXoT6acCKIURUx86CVcifMv9/dNP0FdUiXITH8mS91+Yb3RSqULnvKrMAfpixGzBcEmhG5fJWH1ttQIGCNCSeCP6LQCZ/B4pZGe+IKP08ad3Q1HnImD//QVi42MzhGJ3zHtShKfowNOwX/zxgs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0790.namprd21.prod.outlook.com (10.175.121.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Mon, 17 Sep 2018 03:02:02 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:02 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ben Greear <greearb@candelatech.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 086/136] ath10k: protect ath10k_htt_rx_ring_free
 with rx_ring.lock
Thread-Topic: [PATCH AUTOSEL 4.18 086/136] ath10k: protect
 ath10k_htt_rx_ring_free with rx_ring.lock
Thread-Index: AQHUTjKtuVjmOmUQlk6Scff4xwSJkA==
Date:   Mon, 17 Sep 2018 03:01:06 +0000
Message-ID: <20180917030006.245495-86-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0790;6:3LnMCRBq3mXb/j6rQjsmZwWNA8523eDIm/OXbyp2FtYwJLX0I+b38BvsTxOGSLNsTuulwtjWZkQ/2YLY1GOXALTxttLAdf2S9/TJ7FBsCO1bDQsmRE63E1EH8DwXnrzGwhqDbcW/ohznyS6S7j9D0SABd//slLCexUaOJk7ZItYDT8bCD1Nbx7OMrODsodakZWFZyW2h8uRByI+btqvS16e6LgeexTyy5JRIftXikWilmj3TD4q9lRuQiegsJe77xRuVSbw+JtlNsM9uHRRt5g5pesMX/Khv9E5NFHvdC/fVrbrUV4ePxZ0rHSjJ+Cv12OeeyJV02xS2CCnzlblMh7faPhOrVbfglTcUaRd9TI+RT+oPYnJp3LvfwT1NZc56B9sQ6plFxRY0qYPhUdCDP8m9tfV4xTHkrhkqD11Y4mCO7F9HuKuFJFwoLvSQ3GUsm0H0Bv44EA2DOO2xQIVQnA==;5:Z61VZayIGKKrQjLG2Q0XPa9cDH32PZYQ+rFLG0uoPXnQvUI7DtzMQ6gtpPJd1BJiMdFcoGJLE4dGjsNQphtQEvwb70h3OLaT2FyajxxrAfIIAt/dqGsOfRA9yDJbJMxy/3//AYM3Sw8wx+zaWCAxDh468KyT5PDhIaywy/SUSpk=;7:B5HTuIQzcvofyUNlHTDyOow+yUGx6CSiL43K1rbkh9EDklUDw/HW8hPRkt/TDkWh12faq4AD4rc7YukGD2ILH2BeEASa5YUiA+7GAjy4VxgBvy2ERbNGl8EQ5zxVZ6geDCYHtCxCo9WNdW1fExyVkybKSTieBfwkv03Oxax8FR+LCKURSZSDsoU5e9Dzsf/CPKc3GiETz5CpZ5JQc4ri0gm0CliJa9lzawEDcnhzheGZhf+O6M6sjNS+V2IUb+jk
x-ms-office365-filtering-correlation-id: 74039440-ba64-4d0f-3080-08d61c49f130
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0790;
x-ms-traffictypediagnostic: CY4PR21MB0790:
x-microsoft-antispam-prvs: <CY4PR21MB079092085AB5A689E60BCC0FFB1E0@CY4PR21MB0790.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0790;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0790;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(396003)(376002)(366004)(199004)(189003)(76176011)(22452003)(110136005)(99286004)(6436002)(6486002)(2900100001)(2906002)(54906003)(6346003)(10090500001)(5660300001)(7736002)(6512007)(14444005)(217873002)(316002)(256004)(53936002)(36756003)(6506007)(15760500003)(25786009)(106356001)(26005)(86612001)(10290500003)(1076002)(68736007)(476003)(6116002)(3846002)(478600001)(5250100002)(11346002)(446003)(72206003)(2501003)(81156014)(81166006)(8676002)(14454004)(102836004)(107886003)(186003)(2616005)(575784001)(97736004)(86362001)(66066001)(305945005)(486006)(8936002)(4326008)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0790;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: OySqduqoviAEINdYOKHr2IcvOc8k+yyU34tPXsY9mKN+xTDRC8kDOvNit0Y54PUJRr+91VEiWGCFUPOK7jgiBZWEIXIp06RZrM/S3W+ESBWe4VbsfOvbm634Bx53t/hkiZJMiVfCFbUaCSz3tHvxM1ilwAMcnM6we6gQLwGS7alIkLupYEAOb6Hsi4W9DBi8t7lYigEQYqQFLcgIniQqhO/hDgvItWD/xKK6Bs6VdTzPEFPw6oyw34G9mH/DRbUYyPvj5Rr7157F7dm6XotJ87hnvaDtiXEb+ZxTWrKYjhRoPNlqNA9RWHRDcfbaYqmV6ReOlsGBbk91K2f3GNaCFYeRRYjm0QU/7JusrHV6pX8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74039440-ba64-4d0f-3080-08d61c49f130
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:06.1824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0790
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
index 86accfb8eb88..4d1cd90d6d27 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -268,11 +268,12 @@ int ath10k_htt_rx_ring_refill(struct ath10k *ar)
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
@@ -284,7 +285,9 @@ void ath10k_htt_rx_free(struct ath10k_htt *htt)
 	skb_queue_purge(&htt->rx_in_ord_compl_q);
 	skb_queue_purge(&htt->tx_fetch_ind_q);
=20
+	spin_lock_bh(&htt->rx_ring.lock);
 	ath10k_htt_rx_ring_free(htt);
+	spin_unlock_bh(&htt->rx_ring.lock);
=20
 	dma_free_coherent(htt->ar->dev,
 			  ath10k_htt_get_rx_ring_size(htt),
--=20
2.17.1
