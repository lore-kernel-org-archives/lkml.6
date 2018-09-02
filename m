Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722BAC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D101204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="j/HaS7XZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D101204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbeIBRZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:25:29 -0400
Received: from mail-bn3nam01on0116.outbound.protection.outlook.com ([104.47.33.116]:32952
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728973AbeIBRYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwpGyZsmKILRHXqGHQafA3+PKgTBGcLa2oz1aakx9X4=;
 b=j/HaS7XZs/IObfj4ruIWdRrubzlDp1crRjhXcs3WR5wrKafnCasvKrgDoZYUs1h1cyV74LxGkqd9UKy8s9CpYoxmSCPeqjcBxPCKonwRJoSCTcwlJEn810cXkYswwfP8FqoaWlIvKl5grPFMRGQ9mAv3HJBpopLcrEb2gHsCc/Y=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:08:51 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:08:51 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 86/89] NFSv4.1: Fix a potential
 layoutget/layoutrecall deadlock
Thread-Topic: [PATCH AUTOSEL 4.14 86/89] NFSv4.1: Fix a potential
 layoutget/layoutrecall deadlock
Thread-Index: AQHUQr31H2Caat+37kKAJZ5X8D2Ghw==
Date:   Sun, 2 Sep 2018 13:07:53 +0000
Message-ID: <20180902064918.183387-86-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:2C1X+AMju0ZyHH72zS/41zaE1+MzMDWsUMBsMlasP9onrueNkFaGein12xuVNP0+BLy4NaWE2yfeAOzht4V5W/dgP1febMgd6Iny61ibSBM+w5T6qXe90eRYScB1EJaysOMtWmdPIjwQXFd9lEQKC3yHLCIMFOoMralMYWT1TCNarFN9qzxaMZo96bR+ikTckzFcrZSuaiBtV1KV1x0x052IwBNITBLm89onEMUMyGld3dgU7CYVslqRPZAr6JWty/EtwzT1eiRHK7nIUdUeTbfTE3CSVkvKM9K3fukvsQdxkIRRCG6jqCWAK6MOwWnKcVId9ijJeZmdxBxmdkL8MSONEX0cWeUSBI596TesaBK1udM6EF9ch6bLIgUAZwypdfFXm6mFioL1sNJfw+XdKV6AiW+7Mu2LSyLl3uC9HQnVeLW7xGZfT6sv3GnldQLYL9fiVmVV8mzNuk/IDxoCJQ==;5:Bu/5fj/B17q7DYqsI2SttOqlv+GLG8VAWB0WYVOcs4aZNhqHRklSxdiqK50TsI9Idz+NgbaSmDngvwXBM1rPCj/9v4paCeHqej9mwqRmEFwznn/4HYhY6kUJ9oOA12LhXSiX7uYDt3BgGIP7VX+jEOwWqma5kvsFP+ghc1UAP84=;7:UK6Jw6/03zsuskHV04j/uHRrk8NdHrgXnfxpm5zLjtXR4x1/QE56tuJWn7sRlSVnJyYbYcJYSX+LJmmV1ZrFnF4LT0jwdWhdLdZYhusfDm6WtC1qB5DPi/E0plfzVy2dv6NBawSe7J//tkUTLgQRYO9wBSQW93MKXhE1jzk5MKVseH0W3pJIFFTq7NYZYX1xaD+tNEjxOKvBrr8yE3CkfRMeNWVVdkV4Fax7xFudGLyoVL/9Csrx9lwWHGI8Ayob
x-ms-office365-filtering-correlation-id: 8e4e92ee-fbcf-4258-cb4c-08d610d53aa4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0469FFB814D7CF60C2144796FB0D0@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(136003)(366004)(346002)(199004)(189003)(110136005)(68736007)(36756003)(316002)(72206003)(54906003)(2501003)(81166006)(81156014)(8936002)(14454004)(97736004)(10090500001)(25786009)(106356001)(7736002)(2900100001)(4326008)(2906002)(8676002)(105586002)(305945005)(5660300001)(53936002)(1076002)(6116002)(478600001)(5250100002)(3846002)(107886003)(10290500003)(76176011)(11346002)(99286004)(6486002)(6512007)(6436002)(2616005)(66066001)(6506007)(22452003)(446003)(26005)(186003)(86362001)(5024004)(575784001)(217873002)(476003)(486006)(256004)(102836004)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Sc1mP2NopFwPla5evu4YocApGSUXeHrxEb3PWdy+bNkRllqFIycOWqii9M1rsu59M90D2yF9XEJNtwBh6GbpF/A+wKVc10R68RmZf42aW9gYBQqSqSRe2htx6VFzJ5OUtNkaY00cnu9pAq44Ta6NS/m4vKUbwqx7PkLV65bD0kIZ+73yZk2+AGKXY+uj+OJJJH1yDPfjV3BFiHyL6qtwlc8dKLpXD+Ihder5tH+1Chney+AafCvnz2TCV9IvxMuplU95pH2sN9P95VUOFBlD8Mr9HdCaFopHDZFZOX3z0uGi+hVXH6W+8q2S0CgofHCdIahmCGZ196DW15T/afRBESmeuUA7RNnob0qxT+HAzFM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4e92ee-fbcf-4258-cb4c-08d610d53aa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:53.6571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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
index 516b2248cafe..85591428fa0f 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -213,9 +213,9 @@ static u32 pnfs_check_callback_stateid(struct pnfs_layo=
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
