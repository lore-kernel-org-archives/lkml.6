Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5EEC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A452077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="kbvxyLpw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A452077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbeIBRnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:43:52 -0400
Received: from mail-eopbgr680109.outbound.protection.outlook.com ([40.107.68.109]:27920
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727492AbeIBRWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJ7UVX9Ec7JPcjxuaT8P5GvB1FhgtYI/YwRs3SY7Anc=;
 b=kbvxyLpw8qu/xnA0k9hsl2R1Dhp7o2GPq7ifb+wSrjXAdwjyaUzYaday5DeMO6yAxUnCoks3to+32cvJiYVSfvwIvGjWU7GmQ+Id93euMBEHqjsNPGHZGR9kxFlvjBnhZvIEvSsPWTUILCvpWgQeim6sAyAktLz2mk539O8N2X0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:06:17 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:06:17 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 126/131] NFSv4.1: Fix a potential
 layoutget/layoutrecall deadlock
Thread-Topic: [PATCH AUTOSEL 4.18 126/131] NFSv4.1: Fix a potential
 layoutget/layoutrecall deadlock
Thread-Index: AQHUQr2mKAF4I+ze3EmPP7uAgzrEUw==
Date:   Sun, 2 Sep 2018 13:05:41 +0000
Message-ID: <20180902064601.183036-126-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:UFSHXHL+SvWt8K71m3VZObSZTNDn/FZqAMuJOCR9OAtc4HXsh34NPhHu4CpTeAdSAVtIT/egc+SpoOP25L985riNsd7mzNAGTOdwXW5mUwAD+PN8fGCYj74uyRmKIX0a5SooQbisE1SPNK6u8hDYG7W9miHh8kiMT5rs4kOopIWla89qDygQBj0KHUddhvwl7qfOn4CZ+ewdRP2YbIEw5Jp1tBZhKFQrooz9/D81asXGym+i3u3sx5nErXuyDyaZYCWvE0fg+/F+nZ58txDA6Ik1AfAt9Kj4mm18IJh5pezQV9Uz3nW5kplpf03ILh+35FTPFkMQj6p34Erjcl4SSTYiYum3S+8NLAmpkEUYZPeIjG+HUxOgOr9pSHMnvQrZZDH/Ip6gJngnaiQqydEzzcIdxCYXvogmPgQsrq9Ra+DvHiqJg/UEgi9i8V8857DOmgSBPm7yceOHwxm+vwTnhQ==;5:1HEg9zcGPYEaLsFVrdmfTa8BKk0kJhbmadjwvMnW8lCApZHmoV61DvXa0k2EHhgXWy1TebCNJPg/sgGuwZ2hE2bJY46UjenZl6mvrxjX/FFMqIw7NVyRqGdn7B/9neZRj5sRwxe+NXJU5iwP6mdpMjUZZdJl4BDMwblUx2xLjw8=;7:vX9lfdc71/b2b+fCOf72aIrG9QZLPwfXS9CTJ//qP4EEJZxaK3UInSOUCJpGwHMcq5YdypJ/6JcDMCKu0bMWVNqn1N2WS54mD61oyeP/Y82Mb+HqI6/0WMOXCZc1USr9BpuJJNlQ+DvWn78aQXtea+o0u/j91bhTpKyaKGzbRLuPkRKpYMElh+D/1mmJHHnimvMYaDtOhFGm34FrK9qCLt6cuFG/V82KNCRWyk1iA2FIh1DPGPnQWDhOgTCE33Gb
x-ms-office365-filtering-correlation-id: 4bf2844b-8486-4293-a0f9-08d610d4deef
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB0629999A46001112F5F2D4F0FB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(6486002)(8936002)(6512007)(22452003)(53936002)(6436002)(66066001)(4326008)(186003)(25786009)(575784001)(86362001)(2900100001)(107886003)(76176011)(486006)(68736007)(36756003)(99286004)(2501003)(6666003)(5250100002)(110136005)(54906003)(106356001)(316002)(105586002)(10290500003)(72206003)(10090500001)(8676002)(478600001)(14454004)(5660300001)(476003)(1076002)(3846002)(305945005)(446003)(6116002)(217873002)(6346003)(11346002)(97736004)(81156014)(7736002)(81166006)(2906002)(5024004)(102836004)(86612001)(26005)(6506007)(256004)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: x7sHdgauQ15N3eMqgZKcHQBoWtC2TUL2uG0E6zT/aPUkoXEjKTPJpCDQcNaDU410uit3BKtA8jFuiYniehDlJH8zQtnH+GqZh9UFBFsyyJsY3wCwZJ0rb2P/dLKuU70Ztd6McOzlvW6Av4Cqp/0NlmUyo7c/YN8SrYLvB9/oX1Wh6zGoK6SsadB1IZUSf96FqmP6F08M6c9QL+93RG+gDIdsKFnMWDNUjVuSYd+63b+fPSWOF+N5I6yCfFpqUj0u3dJ6YNmYBEeGIhfQulE02ZdXzzROKahzfUzj50kT16hL7Lu4sIXjr26mEa8Vc3HGHOt3i8CTw+wQlNbJvv5QMPVzyJPdyUJnRFQDlKBfKAs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf2844b-8486-4293-a0f9-08d610d4deef
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:41.7340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
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
index 64c214fb9da6..14333c482f86 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -215,9 +215,9 @@ static u32 pnfs_check_callback_stateid(struct pnfs_layo=
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
