Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2D5C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A9E20857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="N4NWcA8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A9E20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbeIGFRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:17:18 -0400
Received: from mail-cys01nam02on0116.outbound.protection.outlook.com ([104.47.37.116]:29216
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730304AbeIGFRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqZ7NyAkuvKyUQIRoSHa7zXs4kJrEODGXZmotAt/SVA=;
 b=N4NWcA8D2Nb32/kyrvO54KLcyunU2TTR3/4yFPksBzKxl1TGsk9/uYOIJ78+M49cQowLV3YcDyJSiNDeNy20MtuBtmCXwT9+wUsNxGRZbXC2jln08O9msODUEo9pxGrlDKvgFu5x48ChgpLDpjHXv6LBrBlrSy2ffZjb8j/U5Xo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0840.namprd21.prod.outlook.com (10.173.192.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:39:01 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:39:01 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 43/67] staging: bcm2835-camera: fix timeout
 handling in wait_for_completion_timeout
Thread-Topic: [PATCH AUTOSEL 4.14 43/67] staging: bcm2835-camera: fix timeout
 handling in wait_for_completion_timeout
Thread-Index: AQHURkMDu2deiuPZ2kqYXV1nSggfZQ==
Date:   Fri, 7 Sep 2018 00:37:53 +0000
Message-ID: <20180907003716.57737-43-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0840;6:A18c9uDxKdU/JhfjdpVseEYlNTN11oYrRHPJ/AH+kshODiFl062mm1BguG3xtHWnb6q926clWcdNw7/OhC5bnVzt8CwH/7w2n52j/xaDH2+sgzE7kMOpgguKKYck+F/tsXPkHX/RFSr9Ml8ERqWahpTesrH8eg+q3bfeiluqUtNFciSodgNINUCQanka+B0zBvj95h3MKQN4zB87xkQLWH4vFmL0Q+zrrDFP/v4RjXDb52gT9EFqb999fv3yEcArbN5+5n0oahwdhrlLDRkDAFEmQbkxIQJ6UsnPX3tQOHAPKTemUTSbqulEGaFNIWzL4XnSgQEUPf52mVgjYBYq9HqBtO/13rZ0tf+s3HY8OXJorMyjEDhmphILjnc/Wh12ZeTqeQwUahEmgEo6zc/7mCKvb1ddukcUFrVJjGyjUVAlBxG5wJdThjMOUSoh5nQiCGnYdHR+spMM8vrp00t0Mw==;5:u2qKSwFOatpL68EwSiyMsNlDSbauP++ycFW75dHFZkCzJmAbeNbzp9TEiP4jjQMNXNldNW7N9ab9ZVInIAHwEh0OdcY9XqYBZMaZi2MSlUiyS67kRag6eVFjeaaDkSLdRcHVlIFGGrWFVk46ZI8nOSvzklOUMQ7errmg7U0Liaw=;7:1nPcEhJZn2s5VX9h+Tfl6AWH78l0C79/rHp+QVi84rdmBvFYlqXbiIivn//h60hRWH5Izxs4NbgcN+wYkkitrq+2Tj6TKoKwNgdF0J3wmPMIWzNOMc58tEkbwNXbz1XTQhS2LccNlBONgnc8fOZYOLj8Q4960oIhbAlbCodFcak3h2Vj42cuKyNGZDz43/3Bc2aWqMED5mFqvB2IhB2LafCswdOt+XTwSPXEAhaH30ISxK3Xe7N+MauCuyv7LLIF
x-ms-office365-filtering-correlation-id: a44572f4-4edc-43a0-4876-08d6145a4e3a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0840;
x-ms-traffictypediagnostic: CY4PR21MB0840:
x-microsoft-antispam-prvs: <CY4PR21MB08403BCC56D8F77DA3B191C8FB000@CY4PR21MB0840.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0840;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0840;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(39860400002)(396003)(136003)(189003)(199004)(66066001)(186003)(99286004)(26005)(8936002)(76176011)(102836004)(81166006)(81156014)(5250100002)(54906003)(6506007)(110136005)(11346002)(446003)(316002)(476003)(2616005)(106356001)(6486002)(86362001)(6436002)(105586002)(86612001)(97736004)(486006)(6346003)(53936002)(6512007)(68736007)(10090500001)(2501003)(1076002)(22452003)(6116002)(3846002)(36756003)(4326008)(8676002)(10290500003)(2900100001)(25786009)(256004)(14444005)(305945005)(72206003)(7736002)(478600001)(14454004)(217873002)(6666003)(5660300001)(107886003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0840;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: UvDFNXB6Qb64QeDpYa79U5andZdnFIduszR1NHeaVhpu82D14p4QeQglljJ9oKH3jz5/54o6gK4TABIPLpZhxzujUeg1Sq+OhN+laiZZsYlsheGH+JLp4VaZ1xGO6jVeAln7uoGWWReILPnOgbnhnb8bYucQWhzGTCGMSuZ+erOFfjVbv+1Nz5165d3+J4mB4jwhv23D0JvGPwt1r0gatmKJ8/T5+UVSd1ixHsvmTTOnVVaQbpvwJ0yv6GxVU0e8rtxELyTESC2QdJiuPXs4RPSLAHntxqEAI5pP/LrO1/lkpbbVLYJ3SgwFDL6v+p02i2E6RxSAYuQeYNZbJMyb9m7AAmH+QN3d2nXx7q9gT4Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a44572f4-4edc-43a0-4876-08d6145a4e3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:53.4234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0840
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit b7afce51d95726a619743aaad8870db66dfa1479 ]

wait_for_completion_timeout returns unsigned long not int so a variable of
proper type is introduced. Further the check for <=3D 0 is ambiguous and sh=
ould
be =3D=3D 0 here indicating timeout which is the only error case so no addi=
tional
check needed here.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 7b3ad5abf027 ("staging: Import the BCM2835 MMAL-based V4L2 camera dr=
iver.")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 .../staging/vc04_services/bcm2835-camera/mmal-vchiq.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c b/dr=
ivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
index 4360db6d4392..b3176f42c820 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
@@ -834,6 +834,7 @@ static int send_synchronous_mmal_msg(struct vchiq_mmal_=
instance *instance,
 {
 	struct mmal_msg_context *msg_context;
 	int ret;
+	unsigned long timeout;
=20
 	/* payload size must not cause message to exceed max size */
 	if (payload_len >
@@ -872,11 +873,11 @@ static int send_synchronous_mmal_msg(struct vchiq_mma=
l_instance *instance,
 		return ret;
 	}
=20
-	ret =3D wait_for_completion_timeout(&msg_context->u.sync.cmplt, 3 * HZ);
-	if (ret <=3D 0) {
-		pr_err("error %d waiting for sync completion\n", ret);
-		if (ret =3D=3D 0)
-			ret =3D -ETIME;
+	timeout =3D wait_for_completion_timeout(&msg_context->u.sync.cmplt,
+					      3 * HZ);
+	if (timeout =3D=3D 0) {
+		pr_err("timed out waiting for sync completion\n");
+		ret =3D -ETIME;
 		/* todo: what happens if the message arrives after aborting */
 		release_msg_context(msg_context);
 		return ret;
--=20
2.17.1
