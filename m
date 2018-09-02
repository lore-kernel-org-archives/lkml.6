Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA25DC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA97205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PIW3gq5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA97205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbeIBRXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:23:39 -0400
Received: from mail-dm3nam03on0093.outbound.protection.outlook.com ([104.47.41.93]:1728
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727049AbeIBRXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFroTuEDcaqeaBwaokh8DUi5+XH+g8oLorBbv7aeww4=;
 b=PIW3gq5Q7Uy5kqvWMWNFgsWH6qbnA/xd8OVDJNRGI/5qJDWgdqlx5ibonZo3P8jDqha62D4fAfQ1gwpB1jKvnRVEtRFc0HGy3K8ASVKhTjNrY6GroUAObb5Zg6yHdFSkX0yy94LTiK+Hbr56EVrgC1deunuB3rB1rRFLyjABb5M=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:07:49 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:49 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Petr Machata <petrm@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 63/89] net: dcb: For wild-card lookups, use
 priority -1, not 0
Thread-Topic: [PATCH AUTOSEL 4.14 63/89] net: dcb: For wild-card lookups, use
 priority -1, not 0
Thread-Index: AQHUQr3l4NjZwg4vWk6rSr4qs7vIVQ==
Date:   Sun, 2 Sep 2018 13:07:27 +0000
Message-ID: <20180902064918.183387-63-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:IqTdzLiIWW+R2bJdslIeJPtKwcBmI8mASk8Vj1yMM+HjkRGafNnTvltPjK1VpaynM6guNk25s8M8pebYa+4xr7/nfIjdng16pYSlHUp0sbv67HuTWdq4kCe0gXyx+s0C0pzDk+xMPLnqNaQUNjb+INzPSp+QJk9WKSHmH0OYAbEOud/EN/aM86MHAx7BuxSvzO+oB+6Vqc0bHBwdJwLMDOvGNekFhACy8BS4CY2hb0jxOiLqkUrQ2PkPwk6AnXzNiLMXvHey2uAHPemGaHUZzxbibnqSXB/qlg0fHFWBIGZG2/c+rwhnUJwR+gZJr+g4QK7Zn0PINDjg0SIfYrVTpz74oftYqQ8cxiLojc5acNzogAtDH0zhmX/3g4l3ztvofFt1d0CaYFHO2b9iUjIyOEieSLQdQDaZDg8S2U68ZDGgiu60jwhqMIEFUx1xnhqcjLbNhomiKzfOjMip/zVZ2w==;5:2jCyeENBpCss3txXvLyPYbEEnc6wCtzvyRlh8ZlHbGURLlawgmZVuXRNhrliEcjc1+O0U95ytsXMo2RK9JtUHDYaFObtONSiejzDsKLdkHbzXk22eoHmODzw69wPRqP/P/2yudNkbgi7X9M5MFEtuaiqrjtzRbKyq9Gcbjlu8zo=;7:gPyUrJLL7Oe6yarvzATMXq3KtYVPW1Fa4xtB9qkAZYoaquxJMiRyc7L62Jj60/PmO33YULwoItMrap4WBNgFXqIJ9NKzt5+wssb5bu7PZw4RCCMQm+NGZ++sRwRValxMykRK0eJZaFC1miIw5DVoiKx0EEbEikMuESrXXFtL87x0ZrO7AXFGjSS1lLUOSQU+XH+E53OmRi6ZtjQN1lYbKsRlfMa2mF5qIDKojUR8KOmcZqLqjpVL4uA+KniiqNnR
x-ms-office365-filtering-correlation-id: 4f1bf15e-e0f4-4172-3a81-08d610d515a9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0149DA945314E38F610EDF15FB0D0@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(199004)(189003)(76176011)(6116002)(446003)(11346002)(3846002)(5660300001)(110136005)(54906003)(102836004)(26005)(22452003)(316002)(99286004)(6506007)(186003)(6666003)(107886003)(25786009)(1076002)(4326008)(305945005)(2501003)(7736002)(66066001)(97736004)(10090500001)(68736007)(5250100002)(8676002)(81156014)(81166006)(6486002)(6512007)(6436002)(2906002)(53936002)(256004)(14444005)(217873002)(36756003)(86362001)(10290500003)(105586002)(106356001)(72206003)(14454004)(478600001)(2616005)(476003)(486006)(2900100001)(8936002)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: z9fXJWrj9UDJLNSUeLY4zDo0S2mk8wkXU+LfXLUheBgwVXdpu+iqsipT3mJfN1S3I/66JKVIM+13RDSmmeB/Gsbi/VekLs8ufJuH36aE+kLcd6pb8J72hdUJxt5b0oDsCktA9q8Y4uoLmH0s0N6U2TJauCHSB+bNg9gn+Q8CARSI9RNEUhFhWBqLnqbbpZ9HeG7dCG8jnlGSj6hOdk4TtTURjkprfIqP3B+Vohdklw/7DU2T7Xav+JE3ABAM6i73bSatTweckj5vlISZ3d2fGX5QGLkcbbH9qXX5c9S6qgiitmrvBXfzocSE2wyDR32++jMdAgQJVmWcRQUTZWncNEo6GQr2fx7EjwD2n38WdJs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1bf15e-e0f4-4172-3a81-08d610d515a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:27.2147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Machata <petrm@mellanox.com>

[ Upstream commit 08193d1a893c802c4b807e4d522865061f4e9f4f ]

The function dcb_app_lookup walks the list of specified DCB APP entries,
looking for one that matches a given criteria: ifindex, selector,
protocol ID and optionally also priority. The "don't care" value for
priority is set to 0, because that priority has not been allowed under
CEE regime, which predates the IEEE standardization.

Under IEEE, 0 is a valid priority number. But because dcb_app_lookup
considers zero a wild card, attempts to add an APP entry with priority 0
fail when other entries exist for a given ifindex / selector / PID
triplet.

Fix by changing the wild-card value to -1.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/dcb/dcbnl.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/dcb/dcbnl.c b/net/dcb/dcbnl.c
index bae7d78aa068..fbeacbc2be5d 100644
--- a/net/dcb/dcbnl.c
+++ b/net/dcb/dcbnl.c
@@ -1765,7 +1765,7 @@ static struct dcb_app_type *dcb_app_lookup(const stru=
ct dcb_app *app,
 		if (itr->app.selector =3D=3D app->selector &&
 		    itr->app.protocol =3D=3D app->protocol &&
 		    itr->ifindex =3D=3D ifindex &&
-		    (!prio || itr->app.priority =3D=3D prio))
+		    ((prio =3D=3D -1) || itr->app.priority =3D=3D prio))
 			return itr;
 	}
=20
@@ -1800,7 +1800,8 @@ u8 dcb_getapp(struct net_device *dev, struct dcb_app =
*app)
 	u8 prio =3D 0;
=20
 	spin_lock_bh(&dcb_lock);
-	if ((itr =3D dcb_app_lookup(app, dev->ifindex, 0)))
+	itr =3D dcb_app_lookup(app, dev->ifindex, -1);
+	if (itr)
 		prio =3D itr->app.priority;
 	spin_unlock_bh(&dcb_lock);
=20
@@ -1828,7 +1829,8 @@ int dcb_setapp(struct net_device *dev, struct dcb_app=
 *new)
=20
 	spin_lock_bh(&dcb_lock);
 	/* Search for existing match and replace */
-	if ((itr =3D dcb_app_lookup(new, dev->ifindex, 0))) {
+	itr =3D dcb_app_lookup(new, dev->ifindex, -1);
+	if (itr) {
 		if (new->priority)
 			itr->app.priority =3D new->priority;
 		else {
@@ -1861,7 +1863,8 @@ u8 dcb_ieee_getapp_mask(struct net_device *dev, struc=
t dcb_app *app)
 	u8 prio =3D 0;
=20
 	spin_lock_bh(&dcb_lock);
-	if ((itr =3D dcb_app_lookup(app, dev->ifindex, 0)))
+	itr =3D dcb_app_lookup(app, dev->ifindex, -1);
+	if (itr)
 		prio |=3D 1 << itr->app.priority;
 	spin_unlock_bh(&dcb_lock);
=20
--=20
2.17.1
