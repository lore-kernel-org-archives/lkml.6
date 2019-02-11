Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBCEC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21AD218F0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=oneplus.com header.i=@oneplus.com header.b="Wu0M2ITt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfBKMyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:54:04 -0500
Received: from mail-eopbgr1280132.outbound.protection.outlook.com ([40.107.128.132]:54816
        "EHLO KOR01-PS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727106AbfBKMyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:54:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oneplus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLbLzWsxzkZbWuSjvlGXl9in8bxDCkieJpOFt7iv164=;
 b=Wu0M2ITtoHvBsqKLpBmCfk7eIxgUVX9+ZWxWohhy32pOLl30jonEpqJik51yHStqEKFjbZ7AitR6goKCG+1CdZDU7vWDY7ynawSc9tisiFfSx1FNvR5P4SNsulAiyA1xbcH3fFi5D334WOgw/eKUZoXMLI9+fzATKixBxdGeZEQ=
Received: from SL2PR04MB3323.apcprd04.prod.outlook.com (20.177.176.10) by
 SL2PR04MB3081.apcprd04.prod.outlook.com (20.177.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Mon, 11 Feb 2019 12:53:55 +0000
Received: from SL2PR04MB3323.apcprd04.prod.outlook.com
 ([fe80::c429:c599:d8eb:22ce]) by SL2PR04MB3323.apcprd04.prod.outlook.com
 ([fe80::c429:c599:d8eb:22ce%3]) with mapi id 15.20.1601.023; Mon, 11 Feb 2019
 12:53:55 +0000
From:   Chintan Pandya <chintan.pandya@oneplus.com>
To:     Linux Upstream <linux.upstream@oneplus.com>,
        "hughd@google.com" <hughd@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "mawilcox@microsoft.com" <mawilcox@microsoft.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Chintan Pandya <chintan.pandya@oneplus.com>
Subject: [RFC 2/2] page-flags: Catch the double setter of page flags
Thread-Topic: [RFC 2/2] page-flags: Catch the double setter of page flags
Thread-Index: AQHUwgjYN9vE1noifk67qEptfCyN+Q==
Date:   Mon, 11 Feb 2019 12:53:55 +0000
Message-ID: <20190211125337.16099-3-chintan.pandya@oneplus.com>
References: <20190211125337.16099-1-chintan.pandya@oneplus.com>
In-Reply-To: <20190211125337.16099-1-chintan.pandya@oneplus.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR04CA0193.apcprd04.prod.outlook.com
 (2603:1096:4:14::31) To SL2PR04MB3323.apcprd04.prod.outlook.com
 (2603:1096:100:38::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chintan.pandya@oneplus.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [14.143.173.238]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SL2PR04MB3081;6:O1yiluLSwZpyQGic/Gt2mi8+f+bChcksqjwUvRCODLvgQN+ce0u2yCbShOwBI0P9UwarpjiDqmQHr+w8xrruNVpGBrDQOoo5g0iU3H26zIPTAid5u9Cx53a4eWqeRpTKlLFwDOINJNsKujQOSp2RAMPzF1TXzBpMHdrIsh7l/wNTaPTcjKOozGk8SKdrkEwtUx7VgVWrwCccQ2ZCGXY3VI8QxQjYr038bEna13UrQKkqeK/J6gI4NdDJkmTuObWLO5yt3kamXrvHNwo6BqlTRO5qf0HxRcwzdZ38zxGmC5tDpoUe4HyuM2vVqxFT8oSRbu9/Dme+/aI99xTEwlr+6G7w8OZuoyMflJ4B7L+nnuCPXyWV+GXHl7gGPUhi4jJe2H4+gxTTY5cZuF/wKv0+7Yg/7jvdCOVJBqOZAupXciLqbFHZZQ5BAnGyDlUvkL7SnuwYc0jNHF+9VLCTZ2Mj4g==;5:EEQDNB3+FN3SPOC0UThKOME05FEP5LSkQ1kr8mm1PCW+gbUwE0kI5L8hiIqBRBeRMboCgAbaErFU/QH07Qr1RJfKIRFDK6q2sW8a+o8CkUxDI+oVCOt9BAl1CL/+VW55LHAE+MAKJsbfas29ELKIHPJF4usCX/D6sE5TGhkoBk0/82AvlUpowxpGOetQMgDFDCvCHOekB1742lIvnTtKPg==;7:z+Cmn4pLfWaYDse0Ozjgsb9cL6O8GjnohXujLlMWkOhM4LDK+BfLgFzSKunYnOG7zREFas1pJXsct94BEOaVJlOQSP14vyhp7ZylZJT+jiEAgK+Plt3YC3BbfaXybt2ijb+H1wLFEOwKTXbTOAZi4Q==
x-ms-office365-filtering-correlation-id: 362dd64b-3dc8-49aa-f190-08d6901ffb37
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:SL2PR04MB3081;
x-ms-traffictypediagnostic: SL2PR04MB3081:
x-ld-processed: 0423909d-296c-463e-ab5c-e5853a518df8,ExtAddr
x-microsoft-antispam-prvs: <SL2PR04MB30815804DBCB110164C5B9FA91640@SL2PR04MB3081.apcprd04.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(366004)(39860400002)(189003)(199004)(7736002)(81166006)(50226002)(478600001)(8676002)(105586002)(8936002)(66066001)(81156014)(106356001)(1076003)(78486014)(305945005)(14454004)(71190400001)(71200400001)(2906002)(1511001)(36756003)(316002)(110136005)(54906003)(2501003)(2201001)(97736004)(6512007)(52116002)(76176011)(6506007)(386003)(68736007)(14444005)(53936002)(44832011)(6436002)(6486002)(25786009)(2616005)(86362001)(486006)(476003)(4326008)(186003)(26005)(102836004)(11346002)(446003)(6116002)(3846002)(99286004)(256004)(107886003)(55236004);DIR:OUT;SFP:1102;SCL:1;SRVR:SL2PR04MB3081;H:SL2PR04MB3323.apcprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: oneplus.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UqnQyUNS5Okl8AkUoaGuqmfNAZOyjNTLfai48itRgRWQ6fho0nlBZuSkbwfP8Wqj8m5PdZ6W4CrbxfW84bRudAaF+3VTbm3FD7ZnseIdEVI/90MHRr5rSPOFRn9m2z5HylkAUVITgA+h2Kh1+KsBKOL2Pu1PqLQo+U/+TC2BQEp8CR2dUPuK/7gWzkzpsy7d1Ugm2lDTR3B/cjxQZIXfebrbyrfn4JyB4VdKUhsQ+CrR3eDt6dkQSJwOnx+aYq21nZg92fN7v65GlcQdWS0n+2uu1rsffn1Qd6WEtBs3AUn+lhQNlUYMROF+bz2CXYnfRGhk4Ft7gR7ReoQI+ubhOyFw0zZKK9whBkYjCJVfSH4OMBlR55qWriNQ5WSNk0Y3KuHiWjSQhH9QFMoSpMV0PzMyfFwhhpfPa4V9cMlOMI4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oneplus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 362dd64b-3dc8-49aa-f190-08d6901ffb37
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 12:53:53.8857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 0423909d-296c-463e-ab5c-e5853a518df8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR04MB3081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the page flags, like PG_locked is not supposed to
be set twice. Currently, there is no protection around this
and many callers directly tries to set this bit. Others
follow trylock_page() which is much safer version of the
same. But, for performance issues, we may not want to
implement wait-until-set. So, at least, find out who is
doing double setting and fix them.

Change-Id: I1295fcb8527ce4b54d5d11c11287fc7516006cf0
Signed-off-by: Chintan Pandya <chintan.pandya@oneplus.com>
---
 include/linux/page-flags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index a56a9bd4bc6b..e307775c2b4a 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -208,7 +208,7 @@ static __always_inline int Page##uname(struct page *pag=
e)		\
=20
 #define SETPAGEFLAG(uname, lname, policy)				\
 static __always_inline void SetPage##uname(struct page *page)		\
-	{ set_bit(PG_##lname, &policy(page, 1)->flags); }
+	{ WARN_ON(test_and_set_bit(PG_##lname, &policy(page, 1)->flags)); }
=20
 #define CLEARPAGEFLAG(uname, lname, policy)				\
 static __always_inline void ClearPage##uname(struct page *page)		\
--=20
2.17.1

