Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5F8ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1DF20693
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SM1xR3MK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF1DF20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbeIQIcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:32:39 -0400
Received: from mail-sn1nam01on0093.outbound.protection.outlook.com ([104.47.32.93]:10176
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731275AbeIQIch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ei+A4/rngbkgTOinOMBAJTHvQcLnubtt4EjfQieNwUQ=;
 b=SM1xR3MKM3x79/BI+s8GqDUw/FiR2U6SmPX1m2K11gQu42j0+omdk7PD+Bh0g/t0qcXJH9QQ2yjsPLEBHpPu+MfX83HnjUeL+nqBYAilzzf+c0AGVvPY/RzD+c0ujktc3Ls9FbvcIMUV4uBWYv6mnX2RiTLYGlKSWc3J40RoI68=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0759.namprd21.prod.outlook.com (10.173.192.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.5; Mon, 17 Sep 2018 03:07:13 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:13 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ben Greear <greearb@candelatech.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 32/43] ath10k: protect ath10k_htt_rx_ring_free
 with rx_ring.lock
Thread-Topic: [PATCH AUTOSEL 4.4 32/43] ath10k: protect
 ath10k_htt_rx_ring_free with rx_ring.lock
Thread-Index: AQHUTjM+CQ+kSIn2eEujMYlWhxQFZg==
Date:   Mon, 17 Sep 2018 03:05:09 +0000
Message-ID: <20180917030445.484-32-alexander.levin@microsoft.com>
References: <20180917030445.484-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0759;6:TWAdfXwIRNO5JlGfU3X+SyIPXYngSsmWLHJ2chHm/AbHV01PHW+gtaG88pTXHGWF/SDJBl9u/WMgaTeZrEi86ys+PL2tN6T1drLI8/s4VpGhGAHQ72Os33JIkFfS47E1GoO9UigAK47cFlnAnstngRF7ZlZlMkvoOyrdLQy0gXpMTYwPVYMEvDqa1rShEmnDjo9FtLVFUk/8a+RpJBPZKHBlvTs4s11w7ul+VuhJJ73JYlzp4nKPZGUCjn4jq0DHEPZU6aUpgfgco5oGcHD2mGRoJlmO81oFrXa48fKErB5yql7ADD6I+MstXsXAZFLsy4Q8WJrLFhcqnJhfd5WwQ66O8MTqXEvHRoYUr1iwyobnH04f7ZE7hKx+b4CaGphHw5K9kh/x9FWfDfxunDU1GAw8yWwqy4VdUn/pvUjPP8b9s+lmoI40iZQdqncVIonqwKO5UEVIXaba55lU82HZ/w==;5:v7Jdk0AEDxFOrrQlR56RtLJ0Yn9fOGLYx0Tqaum0IWV8xwWpmTuCpt6IfGiQUWJmdRChOJOkfXwfwOoO3y8iKWQQw80xxlA7C5s0AfZgQ+jZGz+PBfLVCScppQQipHkFrI7DK+uJODQtif6xaKbA3MBAcRV/eA/m9kdLRYO08nY=;7:AezkUW0uSyktFX476AN5t0Q8z5edAVKmrxUbxoF0NKEZ4CHID7IdZhqAIKsnNWdpJtzaUrXqKK7YxJNZw9nGFHaBjX+FJBedntrz8MFwSQXopTXHZqa6k/mStDNdPIZWtXiOqHqCgWylyc0DW9WatQLG3iswaSrKVTCd3H2ou+tcJ7C7gGe6IowoWeuCegx46oiw5AyT2hzPmyDWqPzx5Fxvs7QIpO105ycG9l8UCmgu1JtPiqMvJhRN8e+ygTKT
x-ms-office365-filtering-correlation-id: 73ae53f0-511d-43c0-5d2f-08d61c4aaaa7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0759;
x-ms-traffictypediagnostic: CY4PR21MB0759:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0759DD4464D17902AD5F72B3FB1E0@CY4PR21MB0759.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0759;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0759;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(39860400002)(366004)(189003)(199004)(2501003)(2900100001)(305945005)(7736002)(5250100002)(6436002)(5660300001)(53936002)(1076002)(86612001)(6512007)(2906002)(6116002)(3846002)(6666003)(6486002)(86362001)(575784001)(97736004)(10090500001)(26005)(54906003)(256004)(14444005)(106356001)(102836004)(25786009)(99286004)(105586002)(6506007)(446003)(478600001)(10290500003)(72206003)(11346002)(217873002)(66066001)(15760500003)(68736007)(107886003)(4326008)(76176011)(36756003)(486006)(2616005)(476003)(316002)(14454004)(186003)(110136005)(22452003)(8936002)(8676002)(81166006)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0759;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9k3PxTBEkjmCiPE791f8YuWwI4Jqn75+u3Vz6KxPhMQqUl5gLpgb8LN4qVJUoLeTjg2frLGyyg2yo77Dzpntpii444wIZLNGfFjQ5h2OIX/uldgguBZuMw4p2WnYQUs1NfAnJm0XnH0OI7y5CYyWOqYsafiRmBSO3Tf2v52s+u0Lv4nijxMzTHrXq9xLUe7G8pXh6BtPSbuH45+I4mQNJHOfxwdQ1tBMaX/VdhJU7Ys2mrDpUPSadXxZrBAwfCsoGRvi5Nod5YD8tfCoOchf1FAY1qZeusoF/ZZA2Pfh4SaHd+0H4egalz+pw3JrwI6FPy+t54CAIGu6lq2QLKQNE8bGT5T6LjfcIMILudyBHwY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ae53f0-511d-43c0-5d2f-08d61c4aaaa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:09.4610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0759
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
index b32c47fe926d..a65b5d7f59f4 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -212,11 +212,12 @@ int ath10k_htt_rx_ring_refill(struct ath10k *ar)
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
@@ -230,7 +231,9 @@ void ath10k_htt_rx_free(struct ath10k_htt *htt)
 	skb_queue_purge(&htt->rx_compl_q);
 	skb_queue_purge(&htt->rx_in_ord_compl_q);
=20
+	spin_lock_bh(&htt->rx_ring.lock);
 	ath10k_htt_rx_ring_free(htt);
+	spin_unlock_bh(&htt->rx_ring.lock);
=20
 	dma_free_coherent(htt->ar->dev,
 			  (htt->rx_ring.size *
--=20
2.17.1
