Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55272C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E3320861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="D6CGN218"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E3320861
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbeIGFPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:07 -0400
Received: from mail-sn1nam01on0109.outbound.protection.outlook.com ([104.47.32.109]:39556
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729123AbeIGFPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFXhncnaSamTD/fePgiWQnJLGAgIPSaED/pZYRVPAOc=;
 b=D6CGN218PQmW2bug1XwgoOHcocILLVo62WfJSoeCdF8vV8xPHcytc3n/lakE513rlTV7PS7iLiUSBjQ/+Z5onvfcvRyTb43Wb+jswZ3SePCFltzAC+3xPCSFTpIq9KlQPgR4NWjFj9go0nqNoruRjJyPFHbczpFlntDoxDVLHyk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:36:58 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:58 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 57/88] staging: bcm2835-camera: fix timeout
 handling in wait_for_completion_timeout
Thread-Topic: [PATCH AUTOSEL 4.18 57/88] staging: bcm2835-camera: fix timeout
 handling in wait_for_completion_timeout
Thread-Index: AQHURkLT58TWUo+XxUifPeIhNKkIUw==
Date:   Fri, 7 Sep 2018 00:36:33 +0000
Message-ID: <20180907003547.57567-57-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:J2vGBkox92HuHy4Ra8eR28drcMUBd9H1GYb7BXe+Mawb7cZxxpvY5E2axZ+I2aHStYKT41/2ozw+lEvhS3hVaNg/2YfOsc44LiUJsEMFqhxs7pbeWGfSuhUZBjkEI2KuIinNqp1ja7BBQxXYQ8qADp008YSvMdg8vyIE5ZMN94JhTUc5leQhmUdsdV2SI6ntWt8I05+DE+AST9MnPkx/mFVU++HAyPWFwr1AemQRsnFcINuGiBZGcgxzVBRJq6OqOKq4pUtX2rfP0m0m9Vn3Ry+K+mRBc89JvdjK1QmZuuoEStunr1czTHUezEAR7/3Pa/zNci5fqfKss/kY2SrJ2Wk/3T1/ZV0z0ZF+ZVnikN9nCA+gfXXMVAMHTUqUlN/fJWwfMBI6XkY190PDcW8ui+JCGL3dyO+Wuwk+89T4YBXcc/e01npWVKaPGtIoQ/ApXQp3jkaHMVmjqh7L7XhrWg==;5:Xo9FHzmcg6NppRW6f6LwkR/DPw+dflOfVUoKhZv21I1JFAqLdQgyfGJK6xZjhuiAumPns0bqvlL5jdDBposXQvrx3hMWxoWlC3/5jMGGhqIyraYcQD5aj6/tYzHs3nD1lJwI60lS4BEb9SGytN+/0fUbmoNhp4dHvVrtWP6lexM=;7:H+ZZ3zhCxmrIirMH1LW8qmaDP9OZluBWE8SlRhpBkvKT3IiA6G6tOMkSb5+7znueJFviZeQZFtJ29VsJ28avkm3CamTk3J0so7FmoIvCoF0+NRSRx9tJtxUov+i64xeOnXHrpykuRl7dbj9pqkS9eUc1h47kTrJXAC8sEGLMH7NwkHsatSqrbYkKPgfy5Aknp0RNdk/8w/zSVvWKo+xozJdlxuZVuRQ1ZuCcmwX3wzgYf3Li6yBUq9iYZ1mgfEyz
x-ms-office365-filtering-correlation-id: 4dffb49f-54fe-41c1-5d59-08d6145a04f0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0469E370329219A9CF40D468FB000@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(25786009)(446003)(316002)(86612001)(54906003)(76176011)(86362001)(110136005)(256004)(6486002)(10090500001)(14444005)(26005)(2900100001)(476003)(2616005)(102836004)(5250100002)(22452003)(186003)(6506007)(11346002)(53936002)(217873002)(66066001)(4326008)(575784001)(486006)(6512007)(107886003)(2906002)(8676002)(105586002)(72206003)(99286004)(1076002)(6666003)(68736007)(2501003)(7736002)(10290500003)(106356001)(305945005)(14454004)(6116002)(3846002)(5660300001)(36756003)(478600001)(81166006)(6436002)(97736004)(81156014)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: i7apJV1FDnhkPYra3/RKq+asZTE0eOvzMpFI3RMf5Z7OghK5F4r1+sRnbrJEKE/6jOSOYeBem9s2+fRtsj4MF7n+/qG8TWG3YtaBS8osBvOTx5rNnyH0x4p1WMnzEOzpzFPOfrX91SU/F7bBTRXnq/ZjBAoePIuxDwNFfIosCGPAXFx+WvqWTzogdJrZ0OsU39bVUDhWJ3uMzSOIf7n2d3OoIAiPlL6kCNVeph37uUU5Rfy2Ga9n9zfTgnyoxEgKiY/x2xhu1s8kk0J151fgrBFn1v0pBgaHTf8rBioCOjfCQ0ZKHqTIq73+ZVmld0vVthDiiULMvsOvsBCr9ZuMM0sIrt2qDwm8c5XZ7Xh/WRA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dffb49f-54fe-41c1-5d59-08d6145a04f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:33.7881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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
index f5b5ead6347c..51e5b04ff0f5 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
@@ -630,6 +630,7 @@ static int send_synchronous_mmal_msg(struct vchiq_mmal_=
instance *instance,
 {
 	struct mmal_msg_context *msg_context;
 	int ret;
+	unsigned long timeout;
=20
 	/* payload size must not cause message to exceed max size */
 	if (payload_len >
@@ -668,11 +669,11 @@ static int send_synchronous_mmal_msg(struct vchiq_mma=
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
