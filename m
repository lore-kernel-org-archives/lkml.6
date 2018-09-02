Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43E8C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB28205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="azHtxMsd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB28205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbeIBRbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:31:18 -0400
Received: from mail-co1nam03on0101.outbound.protection.outlook.com ([104.47.40.101]:4252
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728112AbeIBRbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLwB90n5bqyZDppJPkB95gvRAix5c1IdExIm5PsZuHo=;
 b=azHtxMsds9IkzM9Zqk3HERI60GJBZ2AqRe/xRS9Gns1axmbph2HceyyfAYrZkxPGuexU7aAMcMnDbr0zxWHYt2KkhYyJf32Vr3biU5Q3Qsixrm974en+q/jdtejizcKtNf8DXgG0qJWIT2F6/cRDxD03VQwHQUKmscjowBtpLD4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:15:28 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:15:28 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mauricio Faria de Oliveira <mfo@canonical.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 44/62] partitions/aix: fix usage of uninitialized
 lv_info and lvname structures
Thread-Topic: [PATCH AUTOSEL 4.9 44/62] partitions/aix: fix usage of
 uninitialized lv_info and lvname structures
Thread-Index: AQHUQr7yQHCufiYQWkKl5CfD1FuC5A==
Date:   Sun, 2 Sep 2018 13:14:58 +0000
Message-ID: <20180902131411.183978-34-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:0+N8bVRTL1ODl6TkmaYqc+l2SxrrBc7KoRy0pzS/cNG61y40jg6P65I8N4d/ptGeqPZ1dJpBI6bxCAKsWkOLhCEvvpKWqeAHBxXPiCcofoTee3bEVdkYCdaXks1+ERv5NzEZEibqx/njn3c8s3JkXDVcIShs6px9QymA8VDKbfr+YoQgmXUXrXjwt2jn0NfhgMPSH668XV2LUJ6vuMXBBWOPhXMjcIgjwc81hd8blxpH9Dqc9B37Ft7CGVBAT/rjELqt0BynykOom7fYpuvd/z5YY6Z3BySScnWC3vF3SplcfmJaiMo7737bkD15OHQVB6J2jU+mHHGaAxHyjR2tTxzWyXY8F2B/jcxZ7/XWp39IyUzRkMe4icx8npAK5pkunG96OtPFLakLdkFf+ZvHJySBMZP+Uqrpn1os7emRGuBc6Rdmkoe5U43spx9+B/ESK9L72d5HEqfx7Kdd4FXMRQ==;5:UiQAGrR0X3JlurDppLZmTAQNRUKcCoU+yVaBJLdZg2XH38jaWrHLF99SsEK22V2rvn1/v0ap4QIYPXhNwmS1i25AoNqkDWguWLt+drqdGdacdFijNjSMz7iCWMe6CcQ8DnUQs5p9G/TNbToNuaGLgS+Omz3OpD97SPW3h8orPRI=;7:bWAVQnioVU5XaT295ltjekUGMANAhDL4dDv0iiky2TKB7FIVyl8sbgmkvywRc21jKdLNBRNf2plerA0tkNx6sa3W6Z4pZltEfjQhkq06xhO35IAYkT3wpH63o//qLBkrrRILVZdW7wBef7hU7NfdNieKpkfLizSI8UjZ895pO83q9EHVBBogqBgV+hj9zVdnjBXzqncbC8flDtZ7V8NzH6AzZPNtUW6KhlHuAf7sHVlkwosyBWM+MDNEjVLCS5Dv
x-ms-office365-filtering-correlation-id: 64adff5f-339b-42b6-c990-08d610d626e1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB074166909D46F4149DE13626FB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(198206253151910);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(5024004)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(6666003)(99286004)(6486002)(105586002)(81156014)(81166006)(53936002)(5660300001)(22452003)(478600001)(6436002)(86362001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(107886003)(217873002)(3846002)(2900100001)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lrmd9wmdAHsFoGSun7vjvdEl6lKqCj5fRNK2fD6jxuAXYY5W3rGLDrJ9Kmm83eCptNYpEIDa1pScL2gnUNB9aVyzxAvzmsY80t8V/bkiBZd8okDHe+rTAcXsraoOm/oqlXua5LxvL6w0V66GPSs8pP3EA4ap7Y/X5f4/eefoYNFpPmhB1vtmg71rIWoQpH03SLDEqg4ND0SpMTJ7UrUvnXGyBR94MOpGsfyL/pyzh6I2idaVA7sNzKycLwynfQPrNK65gpV2ksnExSsryzmpXhm/RIMZV9KKsxVEQj3l/7AEi3cViPFQl9HjZB4Obuhw2Zg4UxuKyfWJjilBAk86SaNphSI28RDZZ+vAQ0WaTi4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64adff5f-339b-42b6-c990-08d610d626e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:14:58.5487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauricio Faria de Oliveira <mfo@canonical.com>

[ Upstream commit 14cb2c8a6c5dae57ee3e2da10fa3db2b9087e39e ]

The if-block that sets a successful return value in aix_partition()
uses 'lvip[].pps_per_lv' and 'n[].name' potentially uninitialized.

For example, if 'numlvs' is zero or alloc_lvn() fails, neither is
initialized, but are used anyway if alloc_pvd() succeeds after it.

So, make the alloc_pvd() call conditional on their initialization.

This has been hit when attaching an apparently corrupted/stressed
AIX LUN, misleading the kernel to pr_warn() invalid data and hang.

    [...] partition (null) (11 pp's found) is not contiguous
    [...] partition (null) (2 pp's found) is not contiguous
    [...] partition (null) (3 pp's found) is not contiguous
    [...] partition (null) (64 pp's found) is not contiguous

Fixes: 6ceea22bbbc8 ("partitions: add aix lvm partition support files")
Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 block/partitions/aix.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/partitions/aix.c b/block/partitions/aix.c
index fa74698e12a6..8e7d358e0226 100644
--- a/block/partitions/aix.c
+++ b/block/partitions/aix.c
@@ -177,7 +177,7 @@ int aix_partition(struct parsed_partitions *state)
 	u32 vgda_sector =3D 0;
 	u32 vgda_len =3D 0;
 	int numlvs =3D 0;
-	struct pvd *pvd;
+	struct pvd *pvd =3D NULL;
 	struct lv_info {
 		unsigned short pps_per_lv;
 		unsigned short pps_found;
@@ -231,10 +231,11 @@ int aix_partition(struct parsed_partitions *state)
 				if (lvip[i].pps_per_lv)
 					foundlvs +=3D 1;
 			}
+			/* pvd loops depend on n[].name and lvip[].pps_per_lv */
+			pvd =3D alloc_pvd(state, vgda_sector + 17);
 		}
 		put_dev_sector(sect);
 	}
-	pvd =3D alloc_pvd(state, vgda_sector + 17);
 	if (pvd) {
 		int numpps =3D be16_to_cpu(pvd->pp_count);
 		int psn_part1 =3D be32_to_cpu(pvd->psn_part1);
--=20
2.17.1
