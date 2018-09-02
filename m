Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDE3C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D3C620856
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LW5xI8cu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D3C620856
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbeIBRbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:31:37 -0400
Received: from mail-cys01nam02on0104.outbound.protection.outlook.com ([104.47.37.104]:45376
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729427AbeIBRbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiJBcW3gGeYqP+HyNGqqcYMIpEfzsK1KebscW19M1Kk=;
 b=LW5xI8cuqSMD2LHXFJJk9Urn7gyqJgjbspQtMYJzUQyP+RHEMApHGfSrXAaoijyFQ3mt2S0G8Rp443gB+pQ0WePdkUzw+VMdsnSbss9i+fPi2wWG7jrgjHnclh2kC5RS7cot+5IDFa+cVHpT7fleThGYuQH+umVSN8iR6KpVD3U=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:15:34 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:15:34 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 59/62] NFSv4.1: Fix a potential
 layoutget/layoutrecall deadlock
Thread-Topic: [PATCH AUTOSEL 4.9 59/62] NFSv4.1: Fix a potential
 layoutget/layoutrecall deadlock
Thread-Index: AQHUQr78n0guma2xzk+PWYyQgUAizw==
Date:   Sun, 2 Sep 2018 13:15:14 +0000
Message-ID: <20180902131411.183978-49-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:NW9ObBdPvvzrFHVPDK1omf0pKN1+VBuKJ6MNcC/we5zV+2EyIhOYnuaOtlMinTiGIywwMHSZoUVVrZHSenF9BZwUeHjIam8oyP8N+nitkBNYEB+i7GD2h31fRSmKUaeXXKlRMmKNG2r1IvDAriOg/DPu4dpHTJna1SmYtKTZfS9+380FcYAXtWuM/zZjhCq9EtGTpn/JKD/HGg8JRr/L1u6AFpnlLT/7E+IWUJ1dV0uMV6SLwMxB/PPFhJwgDtckDtNKzNmyVqorU2B/ESDrIoQeEwfkiECwlZUBKumjmBTRSFBrrEPuqA+Vy9leepxtkywvSkJJ/YC1rAktjX5DScuMYMh5zUNralf5e2EKeB2Pjylktzu2OlAUg9j3R8UmQF2L7T0O8bmODkS3edim8G2qZBE04R2q2Pg4ykRDcfwrQRTynbUzWiXrCPuncdWiOZsBVdOrIMBaSHcdT1ywqw==;5:upvagqFPcIIUlwVOYjAcYWnTPXBqui5BoiUQvPvyQUWdyIpHyEIF8ZNxyfQmSzRxBv4lYEPKwy3kzzy3umtrbqbcgivbuxkV1yVkA9SQcq4d9If8JlQl87FxKvw2TgbzziL8zOTJJ+LLFwLRFFIOVmgPto1GtByzZ7OMC1PIxjM=;7:8pZFajQvq5cpeC5ZGuzTJaqLLAXQzwlk1wzgRkZHu7+CfcGJlG1A258BXPWx1LZorWGsWSmvVaJZhEgTXCz30PZ+E98q+wWNfRqohj9+FHFLcQJMXw2tsaY1PheceDzIcvXGSkBKU51wuGNooqTftq9Sc7YntoIO3PwkPGvQ7bnvYmzqjQhpklFX34FyqPqQ3v+8E95rm70QXO7ehi1TF01p43jSLM+Z/IRznJ2WXkjXE4fscrje6MtrsEsmk3b5
x-ms-office365-filtering-correlation-id: c9164a11-6913-459e-883c-08d610d62a6b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB018403A6D06DAAA952EFB66AFB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(2616005)(10290500003)(68736007)(476003)(81166006)(11346002)(2906002)(8936002)(76176011)(3846002)(6506007)(5660300001)(81156014)(1076002)(8676002)(99286004)(102836004)(575784001)(14454004)(446003)(2900100001)(86612001)(478600001)(186003)(305945005)(7736002)(72206003)(217873002)(86362001)(486006)(6666003)(4326008)(97736004)(6436002)(6512007)(53936002)(107886003)(22452003)(25786009)(105586002)(106356001)(36756003)(66066001)(5250100002)(316002)(10090500001)(5024004)(256004)(6116002)(26005)(2501003)(6486002)(54906003)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qaT27ZcwfyiZtBi5rEQnhIKMPc95hB+qv5gkoTYdK6qlmLcChiKFk+3Z0lEqq0LiBtSvXs3sxVk0PmCuvTRbp4d7DFQ4b+F38H/YbRWgnbh5CcgrOiLurF56a8kEgPLPBnnrf0o/kypWmH5GEbAI1ANYum49gzOrl2ourRXStZjOtst4nWp+zmqK31qlhpGCsjCQxqDe80xN5f3Pze3acOwWLPqcP6eJ3e7uBZ2JIf/RGi6tI0Bowx17ZIlSG2f74q5d3pkL3bdx3TuE6ahWr5dsxskUHqYMSrFAAmweXhrJ7Lz5iq3OnTCMt1hS+cbFUFyy1FID4TpPlzjAxem6ECT6Viopoxeixzt7SjnhU2Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9164a11-6913-459e-883c-08d610d62a6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:14.3127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit bd3d16a887b0c19a2a20d35ffed499e3a3637feb ]

If the client is sending a layoutget, but the server issues a callback
to recall what it thinks may be an outstanding layout, then we may find
an uninitialised layout attached to the inode due to the layoutget.
In that case, it is appropriate to return NFS4ERR_NOMATCHING_LAYOUT
rather than NFS4ERR_DELAY, as the latter can end up deadlocking.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/nfs/callback_proc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index 2e7ebd9d7168..9d7537446260 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -175,9 +175,9 @@ static u32 pnfs_check_callback_stateid(struct pnfs_layo=
ut_hdr *lo,
 {
 	u32 oldseq, newseq;
=20
-	/* Is the stateid still not initialised? */
+	/* Is the stateid not initialised? */
 	if (!pnfs_layout_is_valid(lo))
-		return NFS4ERR_DELAY;
+		return NFS4ERR_NOMATCHING_LAYOUT;
=20
 	/* Mismatched stateid? */
 	if (!nfs4_stateid_match_other(&lo->plh_stateid, new))
--=20
2.17.1
