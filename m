Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01B0C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8717C20666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="mqj2fDNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8717C20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbeJAHQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:16:22 -0400
Received: from mail-by2nam03on0129.outbound.protection.outlook.com ([104.47.42.129]:45056
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729868AbeJAHQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUBOVEDJ6EZLuSJKhCUwgus2E3VH/bKW+dtc0qlyBrI=;
 b=mqj2fDNsRRE2eDv0+LPn26CsIxYXMQZweayf9H2WeqEkXYXM4CMoPtWsUmCXAoXat2ByvTweSs3yOndWEnv/3PrZUz0g58nITJpJWT477+eIjVKLdfcI+mpOVSmX8cZaa2167elWhTppOdxn820sAkHoBxjKz2YIUzK9hlhEF0M=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:40:36 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:36 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Heinz Mauelshagen <heinzm@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 12/26] dm raid: fix rebuild of specific devices by
 updating superblock
Thread-Topic: [PATCH AUTOSEL 4.9 12/26] dm raid: fix rebuild of specific
 devices by updating superblock
Thread-Index: AQHUWR9eRPvifl38A0yOZ7FoPMWYRw==
Date:   Mon, 1 Oct 2018 00:40:36 +0000
Message-ID: <20181001004026.147201-12-alexander.levin@microsoft.com>
References: <20181001004026.147201-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004026.147201-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:YwWJMphoK0CzZD9UrPlf9U/R+lqT/1/236DLor8FL2U7WrN/JLSdu+yKYqpEQMTBBmA/aewmBhuNjRRhALtQQ+FygaT09P4KG5uqlxjp2sSggWSkEIuI1JVMe0yy5YMMFdPHcsgtTjyBK0s9HQtmklWtyP1+GRG84FxGPxcynm+ip46X0RiM1sl9d66MvBz4pdunmzNsNnXcDiLEISARn0w5fOER9i4Z8wXNy7+RSM05EtVLet6lg0EUy2XGCsjKmUEaNEIpOzptqFe0h/GY6x6aWwvD7p9CEI4LkBBEAQG0+djq/fJl8TuLVDsq/fexDUa9oXoz43hB8Wv6I1fVJ0cg6iNkdVrzX5saLamLYJnD3G/sifsNVj67auEYFr2wXM4Tz/ZBFOLr4X2U9HB7VcRg6IeRmZSdhGvhsU7p/AN/n2+r6YKpFCgdvu8BFdKdCEh1Dt4q9FzyW7uDwcONAw==;5:47+KLhkmGfZUzub3rKtlCTx4C2hwsxrekqa/b/YrT570NZZ4DH1kLJNAc6+t9edQFDWAAvDhUxrix3XXyVMIP0xx2kXrpdnJLV8kJ1fFjqA3BNSkpHAbxGZPDYiZHbh37VixGOuraskDb7Bqrmiv99VlJiSZB/vp3z3u6fY81WQ=;7:gPzFQnKUVUXfaAJ1QywVsIsfm2oNPuNlwQPqLcIIHhFwfeSa1CQAyTJOHeGoeqo5M7++JYgA6H6mf0sd5hXZUmX1nLM8voB3dp89moXnKlYGRMI/28H6i873sjlIdV04zVlCeH+Emlfc7EVjH5fPyGJEypgh2HZWqJ45U8bpw7La/Zi9A5NzArD+fQ1vQ17NdKdMIint4d1V28wda85d4YhZdpNAgny9/lijQrDuzg+gy9yT43eRizLeZA5rhUtj
x-ms-office365-filtering-correlation-id: 69b5fe93-bafd-4991-42ad-08d6273680f3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-microsoft-antispam-prvs: <CY4PR21MB0120C21F592D8A1B1070AFBDFBEF0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(346002)(39860400002)(376002)(199004)(189003)(86362001)(8936002)(6436002)(99286004)(6512007)(305945005)(76176011)(2616005)(68736007)(53936002)(34290500001)(186003)(10090500001)(105586002)(106356001)(86612001)(6486002)(81156014)(81166006)(8676002)(71200400001)(36756003)(54906003)(5250100002)(2501003)(26005)(110136005)(97736004)(6346003)(6116002)(3846002)(1076002)(5660300001)(102836004)(71190400001)(107886003)(2906002)(486006)(6506007)(2900100001)(4326008)(66066001)(446003)(11346002)(14454004)(7736002)(476003)(25786009)(14444005)(256004)(478600001)(72206003)(10290500003)(316002)(22452003)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 2C3Dt06f/LxiG/nn1Md4Zm2J2S7BitBHboKC6c8eVcxsEQaaI2dF2EbMmfNOCN6ENq1YPsim7BhbKvTreSEBftHMWlGrSVHjx90bik3VLadwVakTapSNzNYL2YJRti9OvqMBR/zjFXILgpjokLWUymZTZe99ED9l8LFUN9PhA09rAFhQhq0f25KgYvwFZOqUwiUYCaZx3djkWrKTqThFGvrBzg1kzF/zVZnkrmevdlu2AA3EqG6Irf+6qZv2MTaCvBVEyiXgVwmyUPGtCygBMt9d56IGFZMspS4Z80R9pnnFtvOE484DdS0nKjz/z01X7vWnor71GYhf8k7dRjdRqkowHvcLpbldQ2U/p49T6PU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b5fe93-bafd-4991-42ad-08d6273680f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:40:36.3406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heinz Mauelshagen <heinzm@redhat.com>

[ Upstream commit c44a5ee803d2b7ed8c2e6ce24a5c4dd60778886e ]

Update superblock when particular devices are requested via rebuild
(e.g. lvconvert --replace ...) to avoid spurious failure with the "New
device injected into existing raid set without 'delta_disks' or
'rebuild' parameter specified" error message.

Signed-off-by: Heinz Mauelshagen <heinzm@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/md/dm-raid.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index ee75e3510be6..3f389b267e04 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -2880,6 +2880,11 @@ static int raid_ctr(struct dm_target *ti, unsigned i=
nt argc, char **argv)
 		set_bit(RT_FLAG_UPDATE_SBS, &rs->runtime_flags);
 		rs_set_new(rs);
 	} else if (rs_is_recovering(rs)) {
+		/* Rebuild particular devices */
+		if (test_bit(__CTR_FLAG_REBUILD, &rs->ctr_flags)) {
+			set_bit(RT_FLAG_UPDATE_SBS, &rs->runtime_flags);
+			rs_setup_recovery(rs, MaxSector);
+		}
 		/* A recovering raid set may be resized */
 		; /* skip setup rs */
 	} else if (rs_is_reshaping(rs)) {
--=20
2.17.1
