Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D48DC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC74204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="lsDS+wzf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC74204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbeIBRW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:22:59 -0400
Received: from mail-by2nam03on0090.outbound.protection.outlook.com ([104.47.42.90]:31424
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728492AbeIBRW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hb5q/Yqm0kftbnUP3Pk3eerZ9egyqwmgkiQlP7tQWoQ=;
 b=lsDS+wzfRAVqo5kZe+yxedQmQkf5YZakHxKfSdLXpnH6js5EB75IN00qxKunYCPLQwIa6T8dd0s62SbWwavLDQxtEOKOqAeX4OAtA8vTqXtC1V2JOGdgceodj0AMOia9KmgyEG3vgtX3XQJuv75Zi5xdxxgBzjfNc3uJMET70wA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Sun, 2 Sep 2018 13:07:05 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:05 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Yunlong Song <yunlong.song@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 27/89] f2fs: do not set free of current section
Thread-Topic: [PATCH AUTOSEL 4.14 27/89] f2fs: do not set free of current
 section
Thread-Index: AQHUQr3JC5ZZ+5vZYU2GjpVVIyN+eQ==
Date:   Sun, 2 Sep 2018 13:06:40 +0000
Message-ID: <20180902064918.183387-27-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:yX1TqerlE8IvP3LNMsPUyDhTE9BjzL2KZj4vROIO6CNjvvgRH3YMQlrqnF5Mc82F0ppKS6IlgrWhZONcEzqbujNnXhKeAU1mnT3gemUT4g7ysItnY6w5lowyJZzFvcGrg3D20c//NYY3a4+2HKYdxYmk+/Gu/qzY7v2ye+Euxno67xUt8E0vdUEFtA1Ef5CJhzdQNYRiLx2vi6dWzUpeD4LuwFzdA/CNviwjkizAby31lrCZ9fJXSUO52IZ2Qvi6FSYErz4GwAneXZkT6ylGZWcO8XAafIibN8LPLrM9SIDkXtTH+bE0tcsDfJyeR8IVERLl2m9RihS+c4PkgkK/VoGaRRiIlCrCKLrP/TFrrHzkR5sU6JEmrSKQj4S/3uwFNovDgsNAvx3nIZgqiIJy/h2xBp4m+V0tOFYXfjZAo0f890x4dV5QibujwALChRkUBl5fXEQQn4AS3Sd3M4sB6A==;5:yosftax7ESBp9mIvaQC7/b0nWoe0vGRh+GMXrfmy4CLa+6jwMvXO3xZ2ZDGKYC3Q8ZDBtv3CFwAiIwOCwYG75EDpIRvMHbrFLRt6k5XpVShM5Z7LpOG3WVjcxcCfE0oGIyEk8ZgU1OcHuoDppOgLPfvVz8y1GUL3+TrVxPLu+oQ=;7:5ALHS6yozq9Tv3Uzxepj18FfTyC3UthPd5QFOoRS8eN6Sv/gzGwkr117kAHftZuuFhFYUlUAn4NZhe60Gp2xiFrZxeqdZ04m28gIyxg0HAjI7NqU1Mg0u/47OdAzEmQat64SlclBeX2vw1VMDnPxxCH2CAOADqh9p4m/vWG2No0sWj6J/fXMc/03R/k48KagYC/1IxlMO8reMCvwa/BDCDA3cRfjjfGCZcflkQoUkkbPgs5qtz/Fu8qNr1Q1FXvj
x-ms-office365-filtering-correlation-id: 98db4d63-7268-40f1-5947-08d610d4fb84
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08564EC567F42C293FD0A49FFB0D0@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(39860400002)(366004)(189003)(199004)(53936002)(81166006)(11346002)(81156014)(446003)(476003)(4326008)(5660300001)(25786009)(86612001)(8936002)(26005)(6506007)(6486002)(102836004)(2616005)(86362001)(8676002)(6512007)(14444005)(6436002)(107886003)(66066001)(256004)(10090500001)(217873002)(14454004)(3846002)(478600001)(1076002)(72206003)(6116002)(99286004)(305945005)(7736002)(22452003)(36756003)(76176011)(105586002)(486006)(106356001)(2900100001)(186003)(97736004)(68736007)(6666003)(316002)(10290500003)(2501003)(110136005)(54906003)(2906002)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EVtFBJ+WjULWZNEGTisC0pdeK69vTFS4aFze2Z+fdDDzHt2s32QKSZWodTJB/0CoXjPxnjYDlh9jWoX5aAFEXYSJm8Ox8PBATQMAksASMtpqJmptRim+Tt8ntYO69bZJS4mxtkwaqiTD3Mj/wYl7CemwA+bNulIU71gn9Zlthn/l3j7yPpp/WzI5HvbDsg/XKBsVmZTZs2cEXxWw7jEP9zDv4GY+XNh8Pve0urrSdXuWYycDeIpv/FZogWfY/zit3wtS1DTBqFclVgrraFLQcTF8CDcgQAEjjYnTm2GPlzAp1feA6rAvJuSUXjvCrhhREBUmDN/igg+3OeiMXyM6QPByvGmWxtmkT3GoP++/60E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98db4d63-7268-40f1-5947-08d610d4fb84
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:40.3197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
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
index 39ada30889b6..4dfb5080098f 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -414,6 +414,8 @@ static inline void __set_test_and_free(struct f2fs_sb_i=
nfo *sbi,
 	if (test_and_clear_bit(segno, free_i->free_segmap)) {
 		free_i->free_segments++;
=20
+		if (IS_CURSEC(sbi, secno))
+			goto skip_free;
 		next =3D find_next_bit(free_i->free_segmap,
 				start_segno + sbi->segs_per_sec, start_segno);
 		if (next >=3D start_segno + sbi->segs_per_sec) {
@@ -421,6 +423,7 @@ static inline void __set_test_and_free(struct f2fs_sb_i=
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
