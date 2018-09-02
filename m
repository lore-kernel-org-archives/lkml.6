Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7C5C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A2A420841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hzvgTgAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A2A420841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbeIBRVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:21:18 -0400
Received: from mail-eopbgr710112.outbound.protection.outlook.com ([40.107.71.112]:8317
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727450AbeIBRVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52m91UHH/CrcfeVpn1BurLiLt5QFXz8cLhB9W6dFC48=;
 b=hzvgTgAniFJ3elLujpXiPwGXjcrbDBJ+/duC3ON5snuIhA9iaiTAogvm3Bis06H+kPNnqlF/BFmAnAuz4PSH/ss/vVPOt/h1Gqxvj4VrSaqbtp+iJYQAuRgauLR/kBL43k5o7Fk01xkqmavdt8z0S7WQ3Ig41JEnraf5BT7lwJA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:05:32 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:05:32 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     John Pittman <jpittman@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 093/131] dm cache: only allow a single io_mode
 cache feature to be requested
Thread-Topic: [PATCH AUTOSEL 4.18 093/131] dm cache: only allow a single
 io_mode cache feature to be requested
Thread-Index: AQHUQr2O4AUpTLCwnEq5YazQedEwsg==
Date:   Sun, 2 Sep 2018 13:05:01 +0000
Message-ID: <20180902064601.183036-93-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:5iadeKz3vvPnppTtoSnYuXamq+ds44nRuL02DMAXUaaqEIaLovoIlTwR0WlJUkoN5sGNe9AtrZitU9sSz8ltZXhD+G+lnM9kM8CZFa51SxHdYJms/9wX9HDHaNPRogN29yFTejtXTPEsHfGulvcnffiAgoe0zR5kb4h5gAv55IOAeaNPVF+SSQ8ieA1W5A80CwAWmQCNbYoncTFeKczM7sGm+7VWBH1u57ILkYt/XHIw9+vlaBKwrh/oeVNXLmFv3bt2nuTDP9IYS1M60DeuY8FwBzXxP49Q19qJUVgX8S5Zs/tf52C2VhuS3G7joqEAszW+B6szaw9A+cjBn8irk0sn2+fUlKH7tLBfO44LcF2AdXuXyMChZK3LSiWFXI1IUqo3v67jupkQIYEhJDF9Ha/eF0ZMSBRSecg5WfAdGU0lz7Glrs1tU8VAKsrlfZoQK+2dr5WiavmIZWAll0QKRg==;5:rsHi6wtgP2PrOovCRANrt1PiubFMPI4iUXQEVRTu8vr+lNavd/hLGOrKJVED42IZwLie0zMtlbmgs20QgCbjiv6u+x+bpo3Ts0tgDkrAyOpn6tmeflGs5fdoeNVDPcWdBzCrxcTKFsuJVxXiykYZV0eAq2aqPjbsKtIKl0dAqCA=;7:4rIKbjVFDDVzGbzz+X+mBhgcFEl+FZas96vwyl0fYJ1CK+4H9eV8CvkuxejBKI2xaskfLY7fcznnT1u2zb9/SZrFy0xRLNfggQp4JCwLQtsFS1SvK1ZQuslj6gP5tW7aR29QIvrgZuKODzLBNtYUNRbnSDS7tgzisZZYFJZTj4U33SDdg0BH/Tudmh2YiowkVhSpFPhpiqUcxPSZc1OKkrNg9mOlpWJT4u+yBv6cdoltDYojFaUgtgoUqmMgy9Xb
x-ms-office365-filtering-correlation-id: a0f2c1d4-b6b8-4fbb-d694-08d610d4c3b0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0184C9B169EF6F89EC366C90FB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(366004)(136003)(396003)(376002)(346002)(189003)(199004)(6512007)(53936002)(6436002)(97736004)(105586002)(22452003)(25786009)(106356001)(107886003)(4326008)(6486002)(110136005)(54906003)(316002)(10090500001)(5250100002)(256004)(66066001)(36756003)(6116002)(2501003)(26005)(6506007)(5660300001)(3846002)(81156014)(76176011)(99286004)(102836004)(1076002)(8676002)(81166006)(10290500003)(2616005)(68736007)(476003)(2906002)(8936002)(11346002)(72206003)(186003)(305945005)(7736002)(486006)(6666003)(217873002)(86362001)(2900100001)(86612001)(446003)(575784001)(14454004)(478600001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nsikz/Ba58VSH4ls7EBI7vcy9kJNlabpSt0+rQzJtahTSgqdLTiiu/5vd620vjvVT7lmWrDKxtyHXR5Ge89sITTzpadif7HpjvifBHRRAy5oBBIKxzP2txR92kSRWfcc33UFkQS1ET1SM4fbqEgPumfnOknkAoL1lm9Gme3H/vks3+zbHssdJ0OVYUDjS03odnlsQnNVzy+43gU55GceZO5GkCTs/HFHkqvUpbCyTUJTKNTs9CQwGK6U0WYCabRq/r0FNKtOUdYxetUg9gyrnegfedyb/IcrPqlXaZwrZ8s8U2sFkhMuQ4dYoShdMWuHmB8h9yAselzJVh3A52s9EhgVf1aBTG3IXfiS6Gzb4qE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f2c1d4-b6b8-4fbb-d694-08d610d4c3b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:05:01.4385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Pittman <jpittman@redhat.com>

[ Upstream commit af9313c32c0fa2a0ac3b113669273833d60cc9de ]

More than one io_mode feature can be requested when creating a dm cache
device (as is: last one wins).  The io_mode selections are incompatible
with one another, we should force them to be selected exclusively.  Add
a counter to check for more than one io_mode selection.

Fixes: 629d0a8a1a10 ("dm cache metadata: add "metadata2" feature")
Signed-off-by: John Pittman <jpittman@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/md/dm-cache-target.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index ce14a3d1f609..44df244807e5 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -2250,7 +2250,7 @@ static int parse_features(struct cache_args *ca, stru=
ct dm_arg_set *as,
 		{0, 2, "Invalid number of cache feature arguments"},
 	};
=20
-	int r;
+	int r, mode_ctr =3D 0;
 	unsigned argc;
 	const char *arg;
 	struct cache_features *cf =3D &ca->features;
@@ -2264,14 +2264,20 @@ static int parse_features(struct cache_args *ca, st=
ruct dm_arg_set *as,
 	while (argc--) {
 		arg =3D dm_shift_arg(as);
=20
-		if (!strcasecmp(arg, "writeback"))
+		if (!strcasecmp(arg, "writeback")) {
 			cf->io_mode =3D CM_IO_WRITEBACK;
+			mode_ctr++;
+		}
=20
-		else if (!strcasecmp(arg, "writethrough"))
+		else if (!strcasecmp(arg, "writethrough")) {
 			cf->io_mode =3D CM_IO_WRITETHROUGH;
+			mode_ctr++;
+		}
=20
-		else if (!strcasecmp(arg, "passthrough"))
+		else if (!strcasecmp(arg, "passthrough")) {
 			cf->io_mode =3D CM_IO_PASSTHROUGH;
+			mode_ctr++;
+		}
=20
 		else if (!strcasecmp(arg, "metadata2"))
 			cf->metadata_version =3D 2;
@@ -2282,6 +2288,11 @@ static int parse_features(struct cache_args *ca, str=
uct dm_arg_set *as,
 		}
 	}
=20
+	if (mode_ctr > 1) {
+		*error =3D "Duplicate cache io_mode features requested";
+		return -EINVAL;
+	}
+
 	return 0;
 }
=20
--=20
2.17.1
