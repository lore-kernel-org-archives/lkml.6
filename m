Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FD3ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3572E21521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IETB3iO+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3572E21521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387942AbeITI3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:29:24 -0400
Received: from mail-dm3nam03on0091.outbound.protection.outlook.com ([104.47.41.91]:20832
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387539AbeITI3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdVimjti6h7Du7ntIaE08DUvrXF5KxZ83cp6pY2cc0g=;
 b=IETB3iO+1FUCq53PjKFI5TaXd3oVQnWdWnQebdqenryHw1F0Sv/a5s2eDVyMRLFTiLErIZrpaf8xOttgXPAlTRgrHlLREqVJkUI158x3DDKdpD16N/sKEPT2XTT0i0qFbevN/5oAryR1uanZAwAH9bsLJ+TlX/2s/Wn0RukLGVA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:48:19 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:48:19 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jacob Keller <jacob.e.keller@intel.com>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 31/56] ice: Use order_base_2 to calculate higher
 power of 2
Thread-Topic: [PATCH AUTOSEL 4.18 31/56] ice: Use order_base_2 to calculate
 higher power of 2
Thread-Index: AQHUUIxR6rVUMzr9OEOjT3EYDXtfSA==
Date:   Thu, 20 Sep 2018 02:47:49 +0000
Message-ID: <20180920024716.58490-31-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0165;6:PvD3TB8iemFX6MVNJE1pECJ5CgXi1NdjOTDURxWnmGVnBIBKaHrut1shuTXtsa6+tW4MFAOHKJfVtXehFqc9JW9xBold3Bfp71WmkBiqSNzNJ3Rq3HMqb7jHrEzRKsrYOjLARrf/AtCkhJZthPil/+so8jSVY4lqhzDRiN4N/jQpjVacCMc79d0djZXgUYDtIx1JXFvNuvYuyOHh8lMoCrZT7eJCz4NbJfYT1JMF7vwJaOBL8r5MtqHImrV5EHzuu0YEipjGhlfslMejyZUWQyGdvrmL6oBZPxMqpBCE/T3+8gbWjyDe6d0WXfG/M23IXA5OOXwkXs1AKrv8y6sCGuvr7gKXNeW/eS8iFWrOcm9Gue7e3Vxeh0a0oTwcZjvLdJs1WDKNVXQBXcAizXJFHifkYqw48nZjnUomh+EE6nC0hT8m8q/2haNwHtSJcxjV4OVE8fO1fyT6VxgQ7IFZ2A==;5:QniI8xn+S+ObJ9qrUGC/was7Emj/wFbuOC8QtpBQRWY14eVyRzNdsvPdhu3LhTL/ZygVougpDSyLYPzhl1Lhu1YnUugfZ395df+71cj22vGQG5TMWEI7aoyJTwGsllBImZHkzvb2LSqUNdOD+q7jTcGR4OeorRjOWN2mHJNNiAY=;7:6sQHZk2y+tay5EMHtRaEzV0tqeqa1Wvme2kQuh6oXxnolc6Cfy5AE8D8WZweqQU1qvurQVK1W/tBaNNMU8ARhn4BcAvn0jBf85aK7B2oI2Jr1cbxugijjkwef0eGxyEclNvy4c9+J9N1/61mO6gnNnPHkX0HM1Wd6x1BNUsKmGpzIdZqi1D6k+s0LRXo0k1+CazHyV5/eZzBWGsk58NVLGPMrwtveKHJEnXG7m/2n53WnAlVZF6f7Y2jxL/kixzE
x-ms-office365-filtering-correlation-id: 6d9d82dd-e695-4cd6-9021-08d61ea38621
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0165;
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-microsoft-antispam-prvs: <CY4PR21MB0165A6EB17CD431C9CA84D12FB130@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0165;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0165;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(71190400001)(71200400001)(22452003)(53936002)(66066001)(6436002)(72206003)(97736004)(6512007)(478600001)(1076002)(36756003)(5250100002)(217873002)(10090500001)(6116002)(2501003)(14454004)(3846002)(106356001)(256004)(105586002)(2906002)(14444005)(99286004)(8676002)(81156014)(81166006)(86362001)(8936002)(316002)(2900100001)(5660300001)(76176011)(7736002)(305945005)(446003)(11346002)(2616005)(486006)(86612001)(476003)(68736007)(102836004)(6506007)(107886003)(10290500003)(6486002)(6666003)(110136005)(54906003)(186003)(6346003)(25786009)(4326008)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0165;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: mwCGBGwRnlxnHz9b0WIWlzV7cDzwMEOj7H1cwQ1EEMYps3syylRIqciQMwIaqjWFclPt+gezEElpzt/g3bIqrC9Xno2ZiRHmCLnZEVlSgsgLN3ZaK5xs7rVhMjXBU6/VB4+l9ERyQf7Noskw45QwXqevfYf2dxyrGBMsImZPx2yVVj9QjjXaTrVlMKJIIj2iPPh18+fC3FsdpblVwT+bChdaFf3yekcKfI2F1OlaIuWKFhCSLOoL3ll0iyoC7uKEz2tGTYv4UCFXvkKXQNmIOzp6Xn1wfZKtuTrZLRbeoPMIvXkz9AG+gNax0DVYeEJEzKFTavKRNcxi7pxWrQUq2rRzekJVeg5eFgIS/+qfGm0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9d82dd-e695-4cd6-9021-08d61ea38621
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:49.1012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacob Keller <jacob.e.keller@intel.com>

[ Upstream commit 1eb43fc754485d772b1165118a8fb80c385f0492 ]

Currently, we use a combination of ilog2 and is_power_of_2() to
calculate the next power of 2 for the qcount. This appears to be causing
a warning on some combinations of GCC and the Linux kernel:

MODPOST 1 modules
WARNING: "____ilog2_NaN" [ice.ko] undefined!

This appears to because because GCC realizes that qcount could be zero
in some circumstances and thus attempts to link against the
intentionally undefined ___ilog2_NaN function.

The order_base_2 function is intentionally defined to return 0 when
passed 0 as an argument, and thus will be safe to use here.

This not only fixes the warning but makes the resulting code slightly
cleaner, and is really what we should have used originally.

Also update the comment to make it more clear that we are rounding up,
not just incrementing the ilog2 of qcount unconditionally.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethern=
et/intel/ice/ice_main.c
index 46b35b78e8aa..db580d41dbf9 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1313,11 +1313,8 @@ static void ice_vsi_setup_q_map(struct ice_vsi *vsi,=
 struct ice_vsi_ctx *ctxt)
 		qcount =3D numq_tc;
 	}
=20
-	/* find higher power-of-2 of qcount */
-	pow =3D ilog2(qcount);
-
-	if (!is_power_of_2(qcount))
-		pow++;
+	/* find the (rounded up) power-of-2 of qcount */
+	pow =3D order_base_2(qcount);
=20
 	for (i =3D 0; i < ICE_MAX_TRAFFIC_CLASS; i++) {
 		if (!(vsi->tc_cfg.ena_tc & BIT(i))) {
--=20
2.17.1
