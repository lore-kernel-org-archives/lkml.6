Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1C8C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B638720837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gdpnXb8s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B638720837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbeIBRkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:40:35 -0400
Received: from mail-eopbgr700130.outbound.protection.outlook.com ([40.107.70.130]:49888
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729423AbeIBRaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaZ4xkCZ5VF2NrhWwdVQjlh8HFrn7BUDy0VrcrTbv38=;
 b=gdpnXb8sAqzv7Aw/09WKTajVU3OaudAdEC/70NrSknPTM6qkkXkYg7pIjsnMtXyORgPNobBRybPe139ycb2CYMXpZy2xsIrv6aadebE47IMfkw1crdQ+ulQraSagwUbFpVnNH9/ksN8z86MhpmIAvlNGRiBnbboz5ISU06KDsww=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:14:18 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:14:18 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Yunlong Song <yunlong.song@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 13/62] f2fs: do not set free of current section
Thread-Topic: [PATCH AUTOSEL 4.9 13/62] f2fs: do not set free of current
 section
Thread-Index: AQHUQr7aAQw+li75k0aHZGkwTAQBeA==
Date:   Sun, 2 Sep 2018 13:14:17 +0000
Message-ID: <20180902131411.183978-3-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:L2CtGYYAYI06Fv+ctRWPE/b56owUKmOTStIJql2KEfU46JmP+Y5RjRyHuTSIV7pr0NcXijGxd/VdoSUEnBVoH+gOyWKN72cLAjTjvmNpemun9009naDxopypr2T08gwxAcwjlpTadK40yuQ5SXuUajYNcssmN2FmuS04Xc+srrdUlt7/0Wv66rP7KSkC4hkokz8drfsNFb++pFDGZJbITEjFhXdy35DMR9xxVjbzs/f0/lWyjV2XaAkUXbDv3OqB46mxF3X4v7pT/nPmE0AziQl/lhiJWImx2TUQM1da49guZkOaOCdHkXiitQZM2I7ZA23iW9UVQxeU1jafx3YG3CACOTaHkgNaBvyzzANM1w3hSyhm6U/J/S66gLEmRIJiCloO8uH0J6hA/KPTlsKAlI/oSggzHuEPVWbMARCX08oBJssZhXL7AH9XDAM8puDDke/fNoPlgRP+Qus+meZMwQ==;5:yku/B4apDTms9DU/ELSeCbpXraIjPqgwzcNZ6XuvTc7pyviqHlio8x6/pVC9c8FlgQL+JwADpvLEAKphdBuOEW7TSDRfv3Ojx97V0ppSP/MDcFzqM3ZqMI5trpBYyuIM79Zl+fwtl4aJtbefgYa4GEDvGd6D1n/lYh68BZhMxug=;7:j8+rtm31MVc+QnbXLhCLBHcNILnOJiL3oIZK89OQJfdlHwG9tyucJZ2dbxDglekFTEilAXcnoBfrvYYcyp2lcumt5xgbpmpTowO8e6uX76w3cSPIcExPN6FAwNVMPdQ4XTO4YR4qAtpvuS5LDJXCRZo0kiKzgx0iTqHUs3RvqxP3E6EfbxT5KKDq5EctG2+4O8DLE8zPRog+ZTwE6ZyVPCDyaI8ZafvzSchHc+VAFIrYEZYI55uWvT6O3SJPWPu2
x-ms-office365-filtering-correlation-id: aff80889-60db-4371-9cf3-08d610d5fd32
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01202458DBB3A98476BB67ECFB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(376002)(396003)(366004)(189003)(199004)(106356001)(53936002)(72206003)(5250100002)(22452003)(97736004)(6512007)(10090500001)(2616005)(2501003)(446003)(11346002)(478600001)(10290500003)(476003)(14454004)(81166006)(186003)(486006)(25786009)(4326008)(36756003)(102836004)(8676002)(81156014)(105586002)(8936002)(2900100001)(99286004)(66066001)(68736007)(110136005)(26005)(107886003)(6506007)(5660300001)(76176011)(14444005)(54906003)(316002)(1076002)(86612001)(3846002)(6116002)(256004)(7736002)(6486002)(86362001)(6436002)(305945005)(217873002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: e0h6egKbDSwFzbDdoiNrCZJx2zmtenEyltHNFJLwLaranjtQB4aWdAUQxv3AIsZ9Bb2iVXcuAPta7UD8fsUKoJS6FfJu1wBH7qsHFHBmSq4DX0OCxpigFAljmFy1IXmgZf2w2zjdULYNhE3n5GL/Nm412c8ROv38CWNm/lU0M2xsibQ175c7kBmIpS8aY4Qmqzt8UQZHkjkJ4UiGQTbLttuglnKr69Q8Csy/VQLB//TmYZbfSPrPb8bBIG3IvspAzvmhwQnkDL8N6cgCZJz7xtnNnDZbVhiOziArWghV+YoupMu1AvnK7yW3dlBUWiH4L3urqaLM6ZgZqH0eu66iViR+A9l39q1Okw1An5nwvc8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff80889-60db-4371-9cf3-08d610d5fd32
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:14:17.9943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
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
index b164f8339281..3d9b9e98c4c2 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -386,6 +386,8 @@ static inline void __set_test_and_free(struct f2fs_sb_i=
nfo *sbi,
 	if (test_and_clear_bit(segno, free_i->free_segmap)) {
 		free_i->free_segments++;
=20
+		if (IS_CURSEC(sbi, secno))
+			goto skip_free;
 		next =3D find_next_bit(free_i->free_segmap,
 				start_segno + sbi->segs_per_sec, start_segno);
 		if (next >=3D start_segno + sbi->segs_per_sec) {
@@ -393,6 +395,7 @@ static inline void __set_test_and_free(struct f2fs_sb_i=
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
