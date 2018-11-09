Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D23C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1E920855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="T4YYbOvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A1E920855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbeKIURY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:17:24 -0500
Received: from mail-eopbgr80055.outbound.protection.outlook.com ([40.107.8.55]:63072
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727653AbeKIURY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:17:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwIrXRDJ71k3/xTsBjZAD4DCgbIRgy0eZV2XCClQVLQ=;
 b=T4YYbOvbv9DAFSt/e1DSaF/0hJFakpEEPxAQrYYq0IdSJra5s7Jd6moo/1vIRXob7PVMmX48I2Mzdt1ElRn9+gFvUdBrFeV0bx6OlKhT3c19C6fLzGleRKYTUeE3evZqP5LxL35EzacWgzMz1dZpmtGI2DNeLtAtVcOojPNajHc=
Received: from DB6PR0801MB1384.eurprd08.prod.outlook.com (10.168.11.148) by
 DB6PR0801MB1944.eurprd08.prod.outlook.com (10.168.85.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Fri, 9 Nov 2018 10:37:19 +0000
Received: from DB6PR0801MB1384.eurprd08.prod.outlook.com
 ([fe80::18c0:5914:2fff:72f0]) by DB6PR0801MB1384.eurprd08.prod.outlook.com
 ([fe80::18c0:5914:2fff:72f0%5]) with mapi id 15.20.1294.034; Fri, 9 Nov 2018
 10:37:19 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     nd <nd@arm.com>
Subject: [PATCH] drm/arm/malidp: Consider rotation memory requirement in case
 of AFBC framebuffer
Thread-Topic: [PATCH] drm/arm/malidp: Consider rotation memory requirement in
 case of AFBC framebuffer
Thread-Index: AQHUeBgwDmeN6yfix0edeKIT8EiTRg==
Date:   Fri, 9 Nov 2018 10:37:19 +0000
Message-ID: <1541759832-19211-1-git-send-email-ayan.halder@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0150.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::18) To DB6PR0801MB1384.eurprd08.prod.outlook.com
 (2603:10a6:4:b::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.50]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0801MB1944;6:rv8/tLhBpd4oPq97jJOv6f75sshEd9PQPmMMhM81uYZM3RX064j9dmsWu7Sw/tUu8aW0qJi6dnersBqw+VueLUYkc1xaLQsFtGXukq+HLgCpoWZFz9VzvDePe9ocr3CnhneLKv6qNMb1ci6DbK13EVNSFgjixbsqcfk5KCvCLT3OUjL4dQonEyFq+lPBO8QYZafsbhNFnxn2eXVLgc7fF0Rc23W6DfBI97bs7hynE7zGKtLRgzd9PYVedvKGGz9+cxtZ0umN+nw5dq2EpNn8Gxgu95FW5OLtZPDc0YkDI/A99U1lZsSd/Im6H6lkDVkpQDU004ZMdpXUfKCPzzZ07nI6DlDHECrRj3iaUCF5Bo8IfdzxC07Jx5B9eP0Qvh1SMKQWctEJMPDBX65UwfQ+FblbD/CIuOZcHkc399KULor58soote1R6d4KeSTLkAZMW9cxvTbtw7Egg9hhO8sFuA==;5:gOc19zyiyCUHbB2731+VuggGD922qwfSeidtBE9iqSrwHD4kJTDBdFsxA/wXYBt78p00YSY5cisHaQZZGdDSMThDbvAXwAi4tCEI1fd39CyslCKe/N5rFHCPfgFD52MWhjONFDb6urhi709XcveK6nOkEqca0v066ooo65j12PU=;7:bIUX9TIMkIC6gfe8feZEYVgsIQHWULWjR9/0ZBasRRhUca2fnfXkDNye4wkSFKES7MknD5BNSjNHpP26sSbt99OemGYGfl5jRDZaV6qigJdDSWQmAgUWcFkdwJXvYiToXXzhvR4Xea9C5mysXPKCzA==
x-ms-office365-filtering-correlation-id: 69de23d7-53df-4fa4-87aa-08d6462f5339
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1944;
x-ms-traffictypediagnostic: DB6PR0801MB1944:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB1944C1AB92A0985B13A04A35E4C60@DB6PR0801MB1944.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB6PR0801MB1944;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1944;
x-forefront-prvs: 08512C5403
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(376002)(396003)(39860400002)(189003)(199004)(2501003)(52116002)(71200400001)(99286004)(476003)(110136005)(186003)(71190400001)(316002)(86362001)(2201001)(1857600001)(66066001)(486006)(14444005)(26005)(106356001)(97736004)(68736007)(2616005)(305945005)(386003)(6506007)(105586002)(7736002)(8676002)(102836004)(3846002)(6486002)(25786009)(5660300001)(14454004)(53936002)(2900100001)(81166006)(81156014)(6116002)(256004)(44832011)(4326008)(36756003)(72206003)(6436002)(6512007)(478600001)(2906002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1944;H:DB6PR0801MB1384.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 13UPsv08EL6DtfqU8gGu8xLCXFUA/c9xFDFGVclPoa+bzNR+QSu+mw/Jgp/+Si8YYu/bXoqV/HkDWSozF++4x9ZrOmoZShSF09SdS8XVeXsvOgbOyaQpEyY931f/Qw/Pngy0CwcNKROGURSiDN2++c/Ouwe1unGRshlgzk3aBU7eLfwO8O4bvAYWYCsJSgm0Sh2nQ1afdiHCy7APMcEuJrS+AXwcuWp8gEZ+fZk5TksYkhsO8l8BaQbWjQ+EaGoT9/JsEZEWbw7MTHt1AJ7uecxA7SNI4ToaLjasTYOg+VvfoJoW3onUrTdprUoeCkpcJJPP9Qn5UeUezS30biHs3RxT/JzpGIVAVqfqHjsBrPg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69de23d7-53df-4fa4-87aa-08d6462f5339
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2018 10:37:19.6853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1944
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rotation memory for layers is shared with AFBC decoder block. Thus one need=
s to
calculate rotation memory requirement in case of AFBC framebuffer. This is
used later to verify if it can be sufficed by the hardware rotation memory
availibility.

Fixes: 66da13a ("drm/arm/malidp: Validate rotations for compressed/uncompre=
ssed framebuffers for each layer")
Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
---
 drivers/gpu/drm/arm/malidp_planes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/mali=
dp_planes.c
index c9a6d3e..3f4dc64 100644
--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -470,7 +470,7 @@ static int malidp_de_plane_check(struct drm_plane *plan=
e,
 	}
=20
 	ms->rotmem_size =3D 0;
-	if (state->rotation & MALIDP_ROTATED_MASK) {
+	if ((state->rotation & MALIDP_ROTATED_MASK) || fb->modifier) {
 		int val;
=20
 		val =3D mp->hwdev->hw->rotmem_required(mp->hwdev, state->crtc_w,
--=20
2.7.4

