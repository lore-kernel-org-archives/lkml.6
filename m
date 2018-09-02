Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EBCC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F6420835
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SELNtT33"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F6420835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbeIBRsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:48:22 -0400
Received: from mail-eopbgr680109.outbound.protection.outlook.com ([40.107.68.109]:62112
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728298AbeIBRUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfYP1kUWBEfb+lzv2iFZ9WzCa7gxl71xjwMllqz0hIY=;
 b=SELNtT33IFXECnpN/5FEtLjbkqyaTYv8UM9An0errAkfmZxZd+ehHCFJ5EhXce2R+/RuoxUBx20uNM9G4gbde/CQJNMZmkkpYVZcY2bOugDajPLDPtqp3T3F0pJaSf9hM5trLrQl+jWowuTltFSXM9Z/K/Z9AzBDC4uj6fP1f6M=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:56 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:56 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Chao Yu <yuchao0@huawei.com>, Yunlei He <heyunlei@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 081/131] f2fs: try grabbing node page lock
 aggressively in sync scenario
Thread-Topic: [PATCH AUTOSEL 4.18 081/131] f2fs: try grabbing node page lock
 aggressively in sync scenario
Thread-Index: AQHUQr2F3eGR8HspP0eWfDKnaktAag==
Date:   Sun, 2 Sep 2018 13:04:46 +0000
Message-ID: <20180902064601.183036-81-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:nyDRfSaYHg0eMHNK9l1wwom66y//wPMt89w4Og+gcjw2K6IZ8KEmK6BaBuW8dLRhhxYC/NDcXyAtcYtQoI0mRhSHSu6F33nERlEeSank+V/I4/dhxPR4w6li7RrQgQkUculzihUFaw71buQHAS57ng2jfpZ1MTAbZ9rGT2BOvcQVkLH9i1a1O9+9ymwn0bawCgAzhjOlThIAckGoxJTUGje+xbxHSJuSG3LDzaEFlryJ2pllwgFM/WQMDBaNgYs6obsO/CK32W9Cdh61aHNymgMggxinyKbXVDO4dc1d+zS6Gwy11YcfoCT5jvACTt05EW5BNphEzYPadmvgKzCeHglJEWInsY+bOrvI6n0cDtvo+Ti2E6b2V4r0DDFIzK0h7QZpMm+M0AnOeaWim17vU8vz6xWw6ntyqO+rM43GidA2rH9Hc+ikvIQnId8z7kuRVDkVzC3xZLM35AqMRBucTg==;5:6smvG9iIIa1RpyyvQehN+iNU9+CAoXLBSlk5qK4Ay8SVHlNeTT8TSPMQXgsgJTaeeuegXd6XNZU3C067TBsANoIvdWJb0XT4SLvWsMYzbwIwd1p7vEXmJbQtWGgfMV4rEBZI70/PD/jVj0BFVFLoL+/hr0raaqWxow12jFSqb2c=;7:bjP2uOdr1BSQVSCROin7NW+qMKOXJy6eICa64ky7TVERJgDWqXa1POpDi8i3rNl4kET11pzk2dkpp65h0hzL8/5EWBjoRu37deuYqwNct5gdo3NO7Rk198oy4S2NfyQtz4jsMpQlc4DxeBWR6rtr4aABAnk2HF5feNmSnF81sEPnLTJeNRTXnnpXB9qQaqjKG4Y0NpCWx5RX41lTG76N1fqzq+lvyMK4QlcQqOkawBajNhsKQdiU/r1ZhfCPIT88
x-ms-office365-filtering-correlation-id: e17224f3-4944-4acb-6de8-08d610d4aeb1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0741128C6662379D4827E0B6FB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(14444005)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(6666003)(99286004)(6486002)(105586002)(81156014)(81166006)(53936002)(5660300001)(22452003)(478600001)(6436002)(86362001)(575784001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(107886003)(217873002)(3846002)(2900100001)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jjHVzk57b+NILRyVO5YzkMcwOFMN7gOPintmjKYTjPBnFsV0S1Ncj6TqyrgidEB76hE53jlBtiVNCi2jVoT5kjtOHnLOk7lSqwtsGRPUMDG6f39HLbSxaIGnaUWWYZiBc5SCIKDYx3zxzPeAWXgbPNhrUc5ea3bzbogHI/LkCKysf5IMQeqB4Ef2gQ1kq7KgusCoFCjXxRcz9777ne5SvAkJS3iqzgCFHRgPJ24JT1k5WEklTajdmHqADguSaLiQILdqUMBUdOm0zI1tVHXCKdVHalllRdoQNjYVUrvflCaqdHK+AuESJiEL7/DOPyFa8cu8IHnJekPv2imn0CKryC/uYLfW32Wl3aHFZeFTDZM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e17224f3-4944-4acb-6de8-08d610d4aeb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:46.3170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 4b270a8cc5047682f0a3f3f9af3b498408dbd2bc ]

In synchronous scenario, like in checkpoint(), we are going to flush
dirty node pages to device synchronously, we can easily failed
writebacking node page due to trylock_page() failure, especially in
condition of intensive lock competition, which can cause long latency
of checkpoint(). So let's use lock_page() in synchronous scenario to
avoid this issue.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/f2fs/node.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 10643b11bd59..b949002e52a7 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1633,7 +1633,9 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 						!is_cold_node(page)))
 				continue;
 lock_node:
-			if (!trylock_page(page))
+			if (wbc->sync_mode =3D=3D WB_SYNC_ALL)
+				lock_page(page);
+			else if (!trylock_page(page))
 				continue;
=20
 			if (unlikely(page->mapping !=3D NODE_MAPPING(sbi))) {
--=20
2.17.1
