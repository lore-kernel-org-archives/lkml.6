Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBA6C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D64520841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PMIAFil0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D64520841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeIBRTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:19:40 -0400
Received: from mail-cys01nam02on0094.outbound.protection.outlook.com ([104.47.37.94]:40784
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727628AbeIBRTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ndyzw4iajCPGjL9ZLXjpClaXLhhrGWWPUDpwKm00vTI=;
 b=PMIAFil0oYKMgGNBPBW7aWuTOt4cF+//LjXFDEVH2IaXwfAYbubbbwplkLYj5Pp9wGszagLKeX02e31QwWVWcdnxlqAsEmTLECqBPFenD1RRicyQcpF5AXn6PTDmv2Tz5m4VB0dw/sTWcyY6n5nYLdsdBtDFiE5woqOJgWwfME4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0150.namprd21.prod.outlook.com (10.173.189.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.4; Sun, 2 Sep 2018 13:03:33 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:03:33 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anton Vasilyev <vasilyev@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 028/131] misc: ti-st: Fix memory leak in the
 error path of probe()
Thread-Topic: [PATCH AUTOSEL 4.18 028/131] misc: ti-st: Fix memory leak in the
 error path of probe()
Thread-Index: AQHUQr1ab6vnZ5kMHEmAc7zXLvDnoQ==
Date:   Sun, 2 Sep 2018 13:03:33 +0000
Message-ID: <20180902064601.183036-28-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0150;6:dKANH60pi1Ud/vAFNytzjYT6Q/fZNFCo6ayAaeH7OVpV7u+Z4hOHRNHc/f6+1g5onIMEnUaE87Ph6PSdq1/SG3EuacT974jMMUmQO63piNsDpv1hI+wukpUE/oqIADaHNNywojzUJ+f2wZfZ1OLaf54D/3Dug8BPiFcMkI+OJ/6oveG4UW6B7wnH8hBKlLHt+mrPIfI3MMvhf7+JzvwbMg/lh7Jankph5atWQVHCDinTYkVWPhcctG2v9uVUrkSymz1MgCNoYvoAqbGO1C7cfTqJC/v084LMRfS/JFWSGamICLB6hJ+G6r67wiwvUCuzjZBI311guNZLfYz8N0193+k90bwW5EZhxcgaNb3AfTgW7D4oCft4hcb4sW9UPadD9oaij7nW9+ejUuhn7yJTDFFkibDkCfZ06YMGQ9jHJ4Cq7u7hKJ68a/YFDOOmf1cDschJZqkCKb0nSW6djspN0A==;5:N6nCG7qVuVc2dhldbpixnluaCEZIJVhPcPATyCKxpSdebAV5sn171jFEefPald4kXn/wv3hP0bcCE2TNtQgsrS0ZYx0ivF+ezgaTl2xxfN3A8OEtWcKLPBi+ik6BnasjLM0OJOTfHviAeZkqQngRDI/D5o4qeNxmm0O5Bv4iGWI=;7:juLMnCfqP2T2G64ImUfwA2wjdTFNsS2AQmpP8P3rjNenH5gZRQYixUUq4TD3jUnxlKI3j97hVvGRQpPpF+cWR3OJp+2DM85EOzgaLN+9/m/MWth/leJyzy6tPLBxohJ4zSp7RW/oVI53bm8/JDjk0cfXSnxkDIsiLS8Bjvd+bjj1WvPvfdSapASwIF+TskoFdWMYDMO5OM+3vSHxi57WkQr/3gU+Wzp/ckyfC1h3o2Z8G3BgTHSCMgDz7vKRVXNY
x-ms-office365-filtering-correlation-id: b3a78c41-e7c3-4acc-138e-08d610d47cfe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0150;
x-ms-traffictypediagnostic: CY4PR21MB0150:
x-microsoft-antispam-prvs: <CY4PR21MB0150B32CDA948F2E61160C9CFB0D0@CY4PR21MB0150.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0150;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0150;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(256004)(22452003)(2906002)(217873002)(3846002)(68736007)(10090500001)(6506007)(6116002)(1076002)(6436002)(102836004)(486006)(53936002)(76176011)(106356001)(105586002)(14444005)(7736002)(305945005)(8676002)(316002)(5660300001)(6512007)(99286004)(36756003)(4326008)(97736004)(5250100002)(2616005)(4477795004)(476003)(2900100001)(11346002)(186003)(2501003)(81166006)(26005)(8936002)(81156014)(110136005)(54906003)(107886003)(66066001)(478600001)(86612001)(14454004)(6346003)(6486002)(10290500003)(86362001)(72206003)(25786009)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0150;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: X5wKFuVGzYhqlyTKk0g1PxnhtyNeUJYHegvR0T5quYD2IOFg6deAOCDdwpsWeOhiEiTH22Cbop2aVPqWhqf8H5ZQYsFqO5F8/SrxHkiJfv9yyvNk1QJcI3TXphsi3wbn2bqCwGVrnFbp1LAb/ReidN/0jlPJF+2oR5tFTEjujDVMR9YXNM1piHcD4zlMfMKLXAo50Y1BM0G67MYtU/p119INdIBuH/XaMPzAValrKCHFmheUuamNijjX/sR8GbQzkNTmmDtCdsuwg4Nb3aL1C85PZTCFju1kvMiQNCrLXb0k1UAvNARac9zDEMSYtUhv07sSF3PIWB0VD0xjd7xyi07b6GnsazQMatpoCwtAYW4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a78c41-e7c3-4acc-138e-08d610d47cfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:33.3899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Vasilyev <vasilyev@ispras.ru>

[ Upstream commit 81ae962d7f180c0092859440c82996cccb254976 ]

Free resources instead of direct return of the error code if kim_probe
fails.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/misc/ti-st/st_kim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/ti-st/st_kim.c b/drivers/misc/ti-st/st_kim.c
index 5ec3f5a43718..14a5e9da32bd 100644
--- a/drivers/misc/ti-st/st_kim.c
+++ b/drivers/misc/ti-st/st_kim.c
@@ -756,14 +756,14 @@ static int kim_probe(struct platform_device *pdev)
 	err =3D gpio_request(kim_gdata->nshutdown, "kim");
 	if (unlikely(err)) {
 		pr_err(" gpio %d request failed ", kim_gdata->nshutdown);
-		return err;
+		goto err_sysfs_group;
 	}
=20
 	/* Configure nShutdown GPIO as output=3D0 */
 	err =3D gpio_direction_output(kim_gdata->nshutdown, 0);
 	if (unlikely(err)) {
 		pr_err(" unable to configure gpio %d", kim_gdata->nshutdown);
-		return err;
+		goto err_sysfs_group;
 	}
 	/* get reference of pdev for request_firmware
 	 */
--=20
2.17.1
