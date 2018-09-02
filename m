Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F1DC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A53720835
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="aiTlfZRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A53720835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbeIBRvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:51:22 -0400
Received: from mail-sn1nam02on0123.outbound.protection.outlook.com ([104.47.36.123]:20160
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727789AbeIBRT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZQg+h/wl8yY1MViUuUTAcMu4Bt/z8AYnABwpMDdRYQ=;
 b=aiTlfZRJK6v4cicVF/etoIGHzSQ4VWD7WN5P4CzT3eur7ojjtIx5uLwd/IV7BctU1tuNDFGiS66RsN6CleZ43UqYa2cJoJb2Y+RNEt1szXvRYpPehqbzZqtvv4c9vxp502Wh4YdZW8C5zKBHuIWWYZ9w7wQEMujso1fJfjDuYXs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0135.namprd21.prod.outlook.com (10.173.189.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:09 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:09 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Yunlong Song <yunlong.song@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 038/131] f2fs: do not set free of current section
Thread-Topic: [PATCH AUTOSEL 4.18 038/131] f2fs: do not set free of current
 section
Thread-Index: AQHUQr1jzWtQBxW90U+i3Qn5Q3T2Ww==
Date:   Sun, 2 Sep 2018 13:03:47 +0000
Message-ID: <20180902064601.183036-38-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0135;6:tayscMhBRjl4vVTE7+YB/Pp2bbbEkq8UUw91TUIONjdmcpRRCzFs6/PUHES655YrYXtvLALu7yKghEguNaA3SSZNBxhRnHER5zwaHZHj7yGGkaixZhlZ53KloXI7MXLINfTKn46AC9AfcLCT3GltoZLjpxcNuJcIuxnXnrPkDlv4cTeTo7V0rbV5DU4mKof+YYL0TlLILXCc42Z6s6hZ/V0ywXJ2iOmSIsYoLXmMxE+uHdrkCTnCXdKtiYu4gV0Cw0Ofjwb4Ycy1MlMYKduX0AvqC0O7jgW8MxAetanb+2C8hSsUczzHXCiDQyQOrk+AWShPbsRACsLtDpygymsAkkdUUEuZuuvSy0h4oyVGFIRzOH3ZLBm6tu+p1BoefYmQqPuuBJvgneWrbFUvEoRksU2jyuIInU35uHtvC42/1o7UC7M0+F5Wc8jTubbnc8p3SrFCylG3NClSVsh5sQT3+A==;5:r3u6top9lFCKXh4zb+n2P2XeUUDRUKJOUFC3eGJ8TLw+Vmy3c3yoq8mIqejgdlMeBOBjT+4eqIDAsUqNo2MmDpggs8w7aIyuxipDj7Z600qHbBtTHT46aftiFUt8H9euowembZmrQp425r/GfVcnyRhiVLQf7JN9i34RzU2guyQ=;7:Bkjx42dcet/T4V5vmiQqD6ORMVaKqOhpZVOxVCLfAhlYXeyxaLfoT9ENITSVEY+JY+X5/z/BHRSmnORgpu5mBP4wcDajiYlT0iStI8seN/O0DPOjhxhsfb/5PgE95oBFZxGPQsNXD107pvSiLVMSxAKHLEyo4kH6ORMXauC4qO+hK7V/7pYanXfiZULTme7fR/Pjv7AqeEweBzCCYz4YQuYnnw0LB6LgcYVS8WyPs61dJQ5E13WY2yyyEpL2SFRC
x-ms-office365-filtering-correlation-id: 60ad8dc1-3f8b-4518-9f31-08d610d4928b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0135;
x-ms-traffictypediagnostic: CY4PR21MB0135:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0135AE228FDBEB427EE5B88EFB0D0@CY4PR21MB0135.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0135;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0135;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(376002)(346002)(189003)(199004)(478600001)(76176011)(53936002)(2616005)(6512007)(476003)(446003)(11346002)(36756003)(486006)(106356001)(305945005)(6486002)(6436002)(97736004)(102836004)(6506007)(5250100002)(2906002)(14444005)(256004)(72206003)(2501003)(10290500003)(14454004)(86612001)(186003)(26005)(217873002)(99286004)(86362001)(2900100001)(22452003)(81156014)(81166006)(10090500001)(316002)(107886003)(8676002)(105586002)(6116002)(8936002)(25786009)(4326008)(7736002)(5660300001)(6666003)(110136005)(54906003)(1076002)(68736007)(66066001)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0135;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cZeuzB3T6lC2/VS5GK1BL8ospI2Is/VvXh2ms0Xt1Vk1cZMIKp2VL5fk1Z18gncVnTk8myESq/ZxhbQI+qAleUxEZ77t5Aco/k2bDJedEw4OXyfYGvSRTgCqyLaiIesPKZqQNS/uqbJc7Iq9JYOMOlCg75vlgQLhpvPv8NLu81mAv2vl+ZIq7/anqQLvnb2hhgGP9Z1OxatfPcdC35PSeoASfZEf8jBdzokg+dmqY+vjkoTkbsCIvqzaRkhWo99o35esb8pTw19BdEKKmoGUjd3uL7qRjIIJoqyNFN+/dtm4P4uJztyrs9ae+u0hesrf8WMGWB9aHUJLY/JeC5GhHaxs0z8fx6fjhbd2SvlRunI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ad8dc1-3f8b-4518-9f31-08d610d4928b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:48.0290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunlong Song <yunlong.song@huawei.com>

[ Upstream commit 3611ce9911267cb93d364bd71ddea6821278d11f ]

For the case when sbi->segs_per_sec > 1, take section:segment =3D 5 for
example, if segment 1 is just used and allocate new segment 2, and the
blocks of segment 1 is invalidated, at this time, the previous code will
use __set_test_and_free to free the free_secmap and free_sections++,
this is not correct since it is still a current section, so fix it.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/f2fs/segment.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index f18fc82fbe99..38c549d77a80 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -448,6 +448,8 @@ static inline void __set_test_and_free(struct f2fs_sb_i=
nfo *sbi,
 	if (test_and_clear_bit(segno, free_i->free_segmap)) {
 		free_i->free_segments++;
=20
+		if (IS_CURSEC(sbi, secno))
+			goto skip_free;
 		next =3D find_next_bit(free_i->free_segmap,
 				start_segno + sbi->segs_per_sec, start_segno);
 		if (next >=3D start_segno + sbi->segs_per_sec) {
@@ -455,6 +457,7 @@ static inline void __set_test_and_free(struct f2fs_sb_i=
nfo *sbi,
 				free_i->free_sections++;
 		}
 	}
+skip_free:
 	spin_unlock(&free_i->segmap_lock);
 }
=20
--=20
2.17.1
