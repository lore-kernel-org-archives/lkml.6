Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1861C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:21:13 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B04921917
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ItJkOl7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B04921917
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392411AbfBOJUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:20:39 -0500
Received: from mail-eopbgr720043.outbound.protection.outlook.com ([40.107.72.43]:6656
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731423AbfBOJUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:20:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+u6RoTRdoGhEVESbGSMlcUG1s89MHz/sXu3iIQfqFLw=;
 b=ItJkOl7AaLCgG9/vaVz3fS494DaNvyuuEDx6mCyV4Bm95oYC/6YX8kqK4PLSS0bKmlo+u7N9KObrgT+51A0WlO5drMAIFidJF7a7bvNzAJ/4+65a3om8nknDZN+pD5e9RC3gMAvNoGHGk+KrAWhk3mEFbH+gW7iKaBTVU+k5dIs=
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (20.178.244.22) by
 MN2PR12MB3294.namprd12.prod.outlook.com (20.179.83.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Fri, 15 Feb 2019 09:20:31 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::f01f:c1eb:8483:1679]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::f01f:c1eb:8483:1679%5]) with mapi id 15.20.1622.018; Fri, 15 Feb 2019
 09:20:31 +0000
From:   "Mehta, Sanju" <Sanju.Mehta@amd.com>
To:     "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "allenbh@gmail.com" <allenbh@gmail.com>
CC:     "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>
Subject: [PATCH 2/4] NTB: ntb_perf: Disable NTB link after clearing peer XLAT
 registers
Thread-Topic: [PATCH 2/4] NTB: ntb_perf: Disable NTB link after clearing peer
 XLAT registers
Thread-Index: AQHUxQ+yeEPlMiHOyU+ZfWzrIjPePA==
Date:   Fri, 15 Feb 2019 09:20:30 +0000
Message-ID: <1550222411-29072-1-git-send-email-Sanju.Mehta@amd.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::15) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64bc91a3-fddf-4fce-1df9-08d69326d486
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB3294;
x-ms-traffictypediagnostic: MN2PR12MB3294:
x-microsoft-exchange-diagnostics: 1;MN2PR12MB3294;20:K9zUKSJLhzb4eSSKJnJg3KkIuJEbpxX5PJ+cg/J0wwI1ewb+8qizPXm1j2/kJRqV2//dUekPXZgYYZ4MP/fK79qkI9zbj3WJ0BcnXM3vBEa0IlPgL9rE76pmPRelK1K48mlXLXl1qv1b83Vh1OhE05T7VXxcs4NXqaq9YZcEJZLzZStS5lVHvm893Pi1y1uyKXidHo1MBZBtpTRRsWr/w40ONAXACGhEuRhMTZ/UiJRUHXRwnF3a2XA5n5YPYpri
x-microsoft-antispam-prvs: <MN2PR12MB32942AA473B8E0DEF54C0411E5600@MN2PR12MB3294.namprd12.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(346002)(39860400002)(136003)(189003)(199004)(305945005)(7736002)(6436002)(99286004)(72206003)(68736007)(25786009)(8936002)(50226002)(81156014)(81166006)(8676002)(478600001)(14454004)(6486002)(2906002)(71190400001)(71200400001)(2616005)(476003)(14444005)(36756003)(256004)(486006)(316002)(186003)(54906003)(66066001)(97736004)(386003)(102836004)(6506007)(110136005)(26005)(52116002)(6512007)(3846002)(6116002)(86362001)(53936002)(4326008)(2201001)(106356001)(105586002)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3294;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bl1gPJhPuzMvKsA/2WmzwmWee9EAoRYVRkb+XBnIQ7sqO0V6QmHWof1UZo8UZbesEJco/q9P5LtMDG59fCoq41eZsX+SUHzmjOoAj/HC1Q6Wgf8g7eQ3Jty4E5vpIwi+SIsxgbupn73PQBZvD/ifHdupo6EhsOsXGMIpZdS9IbqtdJwqK67mt5GfaZtnRxdrWz3AYpmHYTUSrFet0NTZlXZ2e9uhcR50ocbD349AOLhiqX3S2n8S8Df/bO4uPMoyeVH2TY2RQgu6S5s3AhxftRoXR1/6uwWSBcYAZrctKXL51ZIOMXch6EEb3OPqzwNeEZ/wElxMjy5yywJFyxSuR3A7wFfGNOOGNatA0K6N58rprqWtI2Jb6H7Xae8y1i1q28/OqxCT+1iaosjvHPCvvlvL9rnto5SgGAaOYWfkq6M=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64bc91a3-fddf-4fce-1df9-08d69326d486
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 09:20:28.0717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3294
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

If ntb link disabled before clearing peer's XLAT register, the clearing
won't have any effect since the link is already down. So modified the
sequence so that the link is down only towards the end of the function
after clearing the XLAT register

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/ntb/test/ntb_perf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index a828d0e..4a3fba4 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -737,8 +737,6 @@ static void perf_disable_service(struct perf_ctx *perf)
 {
 	int pidx;
=20
-	ntb_link_disable(perf->ntb);
-
 	if (perf->cmd_send =3D=3D perf_msg_cmd_send) {
 		u64 inbits;
=20
@@ -755,6 +753,8 @@ static void perf_disable_service(struct perf_ctx *perf)
=20
 	for (pidx =3D 0; pidx < perf->pcnt; pidx++)
 		flush_work(&perf->peers[pidx].service);
+
+	ntb_link_disable(perf->ntb);
 }
=20
 /*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
--=20
2.7.4

