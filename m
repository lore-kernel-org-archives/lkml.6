Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3340C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 522AB2077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ktzUh5Vr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 522AB2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbeIBRgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:36:44 -0400
Received: from mail-cys01nam02on0104.outbound.protection.outlook.com ([104.47.37.104]:45376
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728551AbeIBRbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYna49u/9sJdkv/IqWtg41bisq5PqG/6SKyIck6rctQ=;
 b=ktzUh5VrGq0UtCKDLrAKpVOQ175gWpMahHIPlUUtqbAQhuLpLe0/U+HBQgmAtQ8uyOGe8FPR09T3YoI7SzfeLK+1AkAR8hXYmuSvjuvEcylu+L/LbwKpfwMQCxX6Jf64qtNp4fwxIV11Fr27Yrjt5oVrzJJrI23ww5wRFSOcVag=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:15:35 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:15:35 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 62/62] fuse: Add missed unlock_page() to
 fuse_readpages_fill()
Thread-Topic: [PATCH AUTOSEL 4.9 62/62] fuse: Add missed unlock_page() to
 fuse_readpages_fill()
Thread-Index: AQHUQr7+i0TsKnM8+E+nOTCr4qg1/w==
Date:   Sun, 2 Sep 2018 13:15:17 +0000
Message-ID: <20180902131411.183978-52-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:EgdrptDytKTlp38bxKIA5f3wUzCEgeoo+rv15N2SIjGGSnCIhQo4Vyq98TlyWOovUvUYZy79GdcsEPose8+tq1nacahWzSaZJIBRJsXRA33s+K6VON2CEHd0KIkhEV1Xrd0KzCbe/UyoqREf1sRJdlWv1n3ADxHZC0EWmFkNrBVqR3ekv8x9/qWHulYHJ4apPVaXol83dHd0mDIKVk+19riHlJ+wHGIhB/QTUWCTEntCyeWnia0KODbEFFNL/Y/h0dnPqd2TdahU/2EJa2TBtuDULubuhAeLC9cT9KGqBM55JByYPkOjFqKPyFXZyDjijwARCJtJNb/cJ+hn42eOWkrvZNI3/0HOzibSlXaDXFLivQuEFTeIqWqpiOruMmfHNwSects+9Q5y/auaCGLNFcumePVZWJS1NyUlQ2JlgGQGq2qpoLr9O44vxf7ZfyozoHrh5bzETHGgMxAqMvyOow==;5:Y8a8tcfraLQE/FFJKnOOehlhuq2c+BnQbhkZaLQwaYuleZYQhEOP3r/5dkRlRN4vHAtP9P99zE1OmFeNZbc00/SZzqAFUiEs30OKUl2DmWA2Blraw94JKr+/Khq26kJDR6/snbsDuWPoTlRUgKhXNIuDZxUuEciw+yACcNnfsoE=;7:j/6NRMAwyFrRn1K1POvfWnkeHP4mKJ9BaV29/5H7gIFnlkBQaPQr5let8k3osKFnW+gBo7587EKnhXQvvq3idZMX3mmni2zcANui4pM+s7SQlT1z7KxxAwEz5EfZasfCafgs7g2nZsFN6l+VhBeQJtn196C6LsGDlID1fHYAx9fyKV6xkcINsJsnn9vk+8IAVDLua2ThyWz+SbtceTnpF/Zl1YP95Xiic7AcO8o1ERu2GI8+NKenCxSwjX4bU+BU
x-ms-office365-filtering-correlation-id: afc08379-e9f6-496e-e079-08d610d62b16
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0184535EB42D7797C21145C0FB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(2616005)(10290500003)(68736007)(476003)(81166006)(11346002)(2906002)(8936002)(76176011)(3846002)(6506007)(5660300001)(81156014)(1076002)(8676002)(99286004)(102836004)(14454004)(446003)(2900100001)(86612001)(478600001)(186003)(305945005)(7736002)(72206003)(217873002)(86362001)(486006)(6666003)(4326008)(97736004)(6436002)(6512007)(53936002)(107886003)(22452003)(25786009)(105586002)(106356001)(36756003)(66066001)(14444005)(5250100002)(316002)(10090500001)(256004)(6116002)(26005)(2501003)(6486002)(54906003)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TU574iOgXIFqfqsz23t7KnPw/nOCGhAaPgmDCSMYxx/NKuovtKoVfluqt4rVpXKek6VZAOSzKtcdr+bxGk6x2VCv48HVJ/6NpC9mLAEK7ge2QQH9KRSiY3SyIuHF8Z4tD0k+r1tvCmR9EwdFoAVbiRqiEP3uzxYarDhAt9GZSmeKdNv5JqD71QWysPAEv4aokl5cKIAVjMOaUoFc9YspAdXbZ5gNCfC56n7aR2Ocu0k5vZsM/DxpIl2TuHtszUIfpBEVJd6ETetV+4JaHWyW0oeNv2bs4U6ALqmYrLkQ8OaSRn6eFQzR5N5lHoiqnViEYyQU5aBITP7F0SlNoNkusdiO0sG3pA3RYn9fiaa8Zns=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc08379-e9f6-496e-e079-08d610d62b16
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:17.5874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kirill Tkhai <ktkhai@virtuozzo.com>

[ Upstream commit 109728ccc5933151c68d1106e4065478a487a323 ]

The above error path returns with page unlocked, so this place seems also
to behave the same.

Fixes: f8dbdf81821b ("fuse: rework fuse_readpages()")
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/fuse/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 996aa23c409e..4408abf6675b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -868,6 +868,7 @@ static int fuse_readpages_fill(void *_data, struct page=
 *page)
 	}
=20
 	if (WARN_ON(req->num_pages >=3D req->max_pages)) {
+		unlock_page(page);
 		fuse_put_request(fc, req);
 		return -EIO;
 	}
--=20
2.17.1
