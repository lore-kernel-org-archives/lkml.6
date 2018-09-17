Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F298ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCEC3214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="W6cty7u9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCEC3214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbeIQI1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:27:52 -0400
Received: from mail-eopbgr710102.outbound.protection.outlook.com ([40.107.71.102]:64704
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727664AbeIQI1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2ujs9VfzxyqS2enHBWbzN6KuKM6f4+YSgQ3GMDmCnQ=;
 b=W6cty7u9ONXnoOexmVou91ma4QBIBUTQAFTOti45g2U9AK1eKhUZYCVIt2FU6wcALiVjnqc6Jh6F8LtcopafCebK9UxlkopOaIvWHZasISgf0YOMHX+Nv1k3cR/wPheEE3xMG3yItxzEJxTqwUuXO1avp4THum6+vvw7RR73p64=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0790.namprd21.prod.outlook.com (10.175.121.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Mon, 17 Sep 2018 03:02:34 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:34 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 091/136] mt76x2: fix mrr idx/count estimation in
 mt76x2_mac_fill_tx_status()
Thread-Topic: [PATCH AUTOSEL 4.18 091/136] mt76x2: fix mrr idx/count
 estimation in mt76x2_mac_fill_tx_status()
Thread-Index: AQHUTjKvPxUkt6FdSUWi1Td3YJzU9A==
Date:   Mon, 17 Sep 2018 03:01:09 +0000
Message-ID: <20180917030006.245495-91-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0790;6:0mVoTsCiZeOmA6zLmoD9pNFhDSxXDErSVn701i/nIdlg4lbC9yCotK6V6ULMFfa5o0nHIN7ufMPdKGZd4RXEblU/KpBatPjJ+59TE5/dDm/zGypa5VlIHLOoKFiWRlu6ePCi1pZdoCJpNIhbSX3jou1XpA29YU+HxjGACPq9Af685koPDRD1NQYG88/AzADuZdg+AhX1aZo5LCJIo00wsoHTGCpimDTCC4n9vJ8I/RrrLfMLL+dA8kILcwUFj+c26fnsHuBxvOxBS23VcA2zOd0aYWy6b00LDdu6ACeDyuZfGHkQe3j2NQbQUxczf6PsEX4Z6HPvskQ8sMd5Umal26aVGc0GLqB5UgWecvCCqnqqfLHh/kQAP9CTirujbM+d0ljwfge+7B8wNALsIGEFFC2v9kjR0yzQTVv4ZFoWeowaAfjqqCja4vIaA6WJ1RfrAscH1WmTgeEGAcibWUarzA==;5:nNcHmCUM+1+dJKZZmJbU+XcAMZd/C9LyXvZG4QVUWot5NXnAxKOzGMJmOteXOkMcPDEHV4NWWRdQcHqu4YgAFp6L4wJOqpTRRqv03ft4nUC/O7qaEkWyBILg464RqqgQdbOykuEUrFyrhT3KdHMjJ837pNvnP/vpIoatsemq5P0=;7:HH0jaQRiEupYOYZpa2xAEYKhRhnFZ1ItWKbSUeWIxiFUz9Sg1RRbFO+8rDmNOlsSgHq+F0giK7EMrHV2dQYOfwWUhgrCOYOGN2W/O8kq5QMrOrb2CvbOan6Fa9csTaaVppxMDCC1lQ3WzIhUmKIcQrc2OzRV2QfGA1ByzjJB5UuwFuIMoO7MD5zIwllIulpsB5nrOxauEtJWu1RI+zdg5mb3/uYgNTuRBGTM4zFo2RZg50zSyjHG4KeaJEO5TUji
x-ms-office365-filtering-correlation-id: 3e232e40-b042-4361-a373-08d61c4a0434
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0790;
x-ms-traffictypediagnostic: CY4PR21MB0790:
x-microsoft-antispam-prvs: <CY4PR21MB0790E4D716517AA96E7F5873FB1E0@CY4PR21MB0790.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0790;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0790;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(396003)(376002)(366004)(199004)(189003)(76176011)(22452003)(6666003)(110136005)(99286004)(6436002)(6486002)(2900100001)(2906002)(54906003)(6346003)(10090500001)(5660300001)(7736002)(6512007)(217873002)(316002)(256004)(53936002)(36756003)(6506007)(15760500003)(25786009)(106356001)(26005)(86612001)(10290500003)(1076002)(68736007)(476003)(6116002)(3846002)(478600001)(5250100002)(11346002)(446003)(72206003)(2501003)(81156014)(81166006)(8676002)(14454004)(102836004)(107886003)(186003)(2616005)(97736004)(86362001)(66066001)(305945005)(486006)(8936002)(4326008)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0790;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Vd2sPTWYKYrXbt0LjeazDHPHgJ8N0E88mzrOj4L8ClojFS3hyhDyy0GuTahDdon9j+2ImZJlDYhpzkm1JXLUj3WqJbCYOSSdKbpSosUXGqklhgyGiVOdwEif6foRKLzoN+45iN4YIeJMa2tKSkb5FCj4UNyVU6cVmvQjLJr8/RH4U3bmyOcmC6Vjageu1MqwnovWGt4gUkRjcmgaueaKlCRjA+yO6uYYHjnbDGJr/nYo/RITOhGRfqTbiXL/NibidZ4STpFTlBDcXr5xIDOTaTadh6IvuS1F48FcAFVxukxYa/XqPer5coN7g3KFcYY2k1BxEBTYkrcwSPr4Tuw3M+uzBnO9WoHQ4qMCiyP9Z/c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e232e40-b042-4361-a373-08d61c4a0434
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:09.5886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0790
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

[ Upstream commit 2d1e9be0016230f3707812243561fbd16f1aea4b ]

Fix mcs and attempt count estimation in mt76x2_mac_fill_tx_status routine
if the number of tx retries reported by the hw is grater than
IEEE80211_TX_MAX_RATES

Fixes: 7bc04215a66b ("mt76: add driver code for MT76x2e")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/mediatek/mt76/mt76x2_mac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2_mac.c b/drivers/net/=
wireless/mediatek/mt76/mt76x2_mac.c
index b49aea4da2d6..8985446570bd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2_mac.c
@@ -439,15 +439,13 @@ mt76x2_mac_fill_tx_status(struct mt76x2_dev *dev,
 	if (last_rate < IEEE80211_TX_MAX_RATES - 1)
 		rate[last_rate + 1].idx =3D -1;
=20
-	cur_idx =3D rate[last_rate].idx + st->retry;
+	cur_idx =3D rate[last_rate].idx + last_rate;
 	for (i =3D 0; i <=3D last_rate; i++) {
 		rate[i].flags =3D rate[last_rate].flags;
 		rate[i].idx =3D max_t(int, 0, cur_idx - i);
 		rate[i].count =3D 1;
 	}
-
-	if (last_rate > 0)
-		rate[last_rate - 1].count =3D st->retry + 1 - last_rate;
+	rate[last_rate].count =3D st->retry + 1 - last_rate;
=20
 	info->status.ampdu_len =3D n_frames;
 	info->status.ampdu_ack_len =3D st->success ? n_frames : 0;
--=20
2.17.1
