Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D2BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D55D4205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MG6FwBbN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392436AbfBOJVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:21:22 -0500
Received: from mail-eopbgr740089.outbound.protection.outlook.com ([40.107.74.89]:50560
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730658AbfBOJVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:21:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dkb6YRvYahndkN7KpJdzLPL/ogP8OKIdCq9P2ZGbn4k=;
 b=MG6FwBbNM0vY63UY2lEOIoCHCefxxnkWFORB0DJUL1vAZI3CFgEhwh2zFSxsO7KZsb2i/FxJ5YzscoBP0spIABaquqlsRn9VKEvDxiuU4yEDcaR2c1+Z2u3t96ivZ+eu9dVW2S0BVxychaWMb8Pk4oePUZkA3H9x8zMMUt2mnu8=
Received: from MN2PR12MB3455.namprd12.prod.outlook.com (20.178.244.22) by
 MN2PR12MB3615.namprd12.prod.outlook.com (20.178.242.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Fri, 15 Feb 2019 09:21:19 +0000
Received: from MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::f01f:c1eb:8483:1679]) by MN2PR12MB3455.namprd12.prod.outlook.com
 ([fe80::f01f:c1eb:8483:1679%5]) with mapi id 15.20.1622.018; Fri, 15 Feb 2019
 09:21:19 +0000
From:   "Mehta, Sanju" <Sanju.Mehta@amd.com>
To:     "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "allenbh@gmail.com" <allenbh@gmail.com>
CC:     "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>
Subject: [PATCH 3/4] NTB: ntb_perf: Clear stale values in doorbell and command
 SPAD register
Thread-Topic: [PATCH 3/4] NTB: ntb_perf: Clear stale values in doorbell and
 command SPAD register
Thread-Index: AQHUxQ/PFpGWwibjHUiIpVygKk1G6Q==
Date:   Fri, 15 Feb 2019 09:21:19 +0000
Message-ID: <1550222458-29752-1-git-send-email-Sanju.Mehta@amd.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR0101CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::14) To MN2PR12MB3455.namprd12.prod.outlook.com
 (2603:10b6:208:d0::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Sanju.Mehta@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e42562cc-74b5-45b5-1ad5-08d69326f15b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB3615;
x-ms-traffictypediagnostic: MN2PR12MB3615:
x-microsoft-exchange-diagnostics: 1;MN2PR12MB3615;20:Cxp9KcZxt8WCoapLKJ9/766UYTYB4McdtGamjeS+VLgKud9q3z7AtzA3+7W+S5vcozfWRNspwhavqjICDKxWnp0OQJjXpkEbAQs1BVu7IDwBU8S/j96iEcxd5SwjTK+dZ6YVJD7nbFTNEue7ZII6r5FJPkA4GEgEyS88x6wV8uZ3AFvakO4vZvxJswUK0/PtSK2fuwUJ4AgA12CyqCmEG8S9yFe5oAROO6qJPcIZkC6eiSdCcKQ60Dq1vN/JMOaW
x-microsoft-antispam-prvs: <MN2PR12MB3615F6C70F2EF96D7C03841CE5600@MN2PR12MB3615.namprd12.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(396003)(346002)(39860400002)(189003)(199004)(68736007)(256004)(86362001)(2501003)(14454004)(6486002)(6436002)(97736004)(2201001)(6116002)(3846002)(72206003)(2906002)(66066001)(478600001)(36756003)(2616005)(186003)(476003)(26005)(52116002)(6512007)(486006)(4326008)(25786009)(110136005)(316002)(54906003)(99286004)(50226002)(8936002)(81166006)(81156014)(8676002)(305945005)(7736002)(106356001)(71190400001)(71200400001)(105586002)(53936002)(386003)(102836004)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3615;H:MN2PR12MB3455.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7E77FJLhiMyqo0mttf8sE6Yrjth8Y+ZKuQCOi1NXU+3FtJ7BezYITum5DNq3J9bbSY8Tx8yNwt1qc8D6vUCeGspv82DXoeawpLw9A90PPyfs5le0Jf1nQsPq+OzoW82c8DTvlvq3zkIGQTqKa1h/lZwb1zBIjUMOoQWw3Cs3Yy3ofKPb/hAY8ExZ1ePPVzT8fdpbCxefGXM7s3OvPzoybZnXwxiEX06/OTiJ9uMdYiwhHnPm/RhOlshKHKQg0f5RMrz/9A0qEjdDnWYmC4/ndU1qTYYP2e+YOC2mONTCaqCy0A2x1jki65NR9mmGclQf5P3OQ1BX+hvu9ZWwbPVMJN4TCfqSx34ouRUmM1ZBsfjoIbyGkaTpPqLPy46kD8Up/jWkB/yBK4ukyMnKKCC6MpL/z418Os7pU+LAfxgzwPo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e42562cc-74b5-45b5-1ad5-08d69326f15b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 09:21:15.7913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3615
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sanjay R Mehta <sanju.mehta@amd.com>

when ntb_perf is unloaded, the command scratchpad register still
retains the last initialized value of PERF_CMD_INVAL. When ntb_perf
is re-loaded and reads peer command scratchpad register and it mis
interprets the peer state as initialized.

To avoid this, clearing the local side command scratchpad register
in perf_disable_service

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/ntb/test/ntb_perf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 4a3fba4..c7d1a48 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -754,6 +754,14 @@ static void perf_disable_service(struct perf_ctx *perf=
)
 	for (pidx =3D 0; pidx < perf->pcnt; pidx++)
 		flush_work(&perf->peers[pidx].service);
=20
+	for (pidx =3D 0; pidx < perf->pcnt; pidx++) {
+		struct perf_peer *peer =3D &perf->peers[pidx];
+
+		ntb_spad_write(perf->ntb, PERF_SPAD_CMD(peer->gidx), 0);
+	}
+
+	ntb_db_clear(perf->ntb, PERF_SPAD_NOTIFY(perf->gidx));
+
 	ntb_link_disable(perf->ntb);
 }
=20
--=20
2.7.4

