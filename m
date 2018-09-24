Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEF4C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7262087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="icqqwCTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C7262087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388479AbeIXUw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:52:56 -0400
Received: from mail-by2nam01on0106.outbound.protection.outlook.com ([104.47.34.106]:32486
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729888AbeIXUwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wX4jW4HH7h7ADdQ926043NQjb+x74cwrL1ZVwJ6iGP4=;
 b=icqqwCTGelGD67cRjbDDLzOzqt5vrfS3qxczayrFZNeihFMLaZP90PaQknvBIYkkU0ExnylJtwMQ3WGsf84uwaLXux+TIYNbzd5rbR4bYjMIJ/u/5qdlnVBAczm7HzSBufrb8beYBILEDre4tlPGKlZhI22FOtWFBUbcgCC5bk0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:50:21 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:50:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 30/36] cfg80211: fix a type issue in
 ieee80211_chandef_to_operating_class()
Thread-Topic: [PATCH AUTOSEL 4.14 30/36] cfg80211: fix a type issue in
 ieee80211_chandef_to_operating_class()
Thread-Index: AQHUVBXAHok6m7B3WkuUBJBu38S1BQ==
Date:   Mon, 24 Sep 2018 14:49:10 +0000
Message-ID: <20180924144851.164533-30-alexander.levin@microsoft.com>
References: <20180924144851.164533-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144851.164533-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:tOOz37VVtsKEhpXv8bYIkeM26UNSv82Q5vSUX+xuoG7eh8fOIbL9aNiGKIk30MRSsDthh/UV1cSmkpni/DP4iU4ZGK60VxWmTzOLCZ8iNttQASfrllCDpb2tsJgVmh+L2Z8uTVLrk2uqybIQvBRdZzb3xaDbZIQDQQUBxtx6E/tt0wN8fh6vPbaTRtVbojcm/XdUsitNp57xnuXg7p8MB+YLADhSUY/zUi4LWUdjP98ebAzEMSPZxGoeOI4Jl9TcdIircjg7l/KWYh/oy1bAtEApxOIEowrG2yzaTeAOqJ5Gi6a3kW1wyYymVN+25gcHmWAv7rQdSd3WQT8ShwDNbQblbDLt5WgzjHoj4H8wL5amgsGYxDBEtGoPJPex6p+4TTNd4GZzAB1wYBt3dFU+Hv4/J1+reL39fvqHnT/lYM5xAZVF/CbJnvZeevc3FNhYN0fd8CFzUfdWMWCesPEj/g==;5:jmKB4DBNKg97BE0mqPX6N6rvEDtONAKjFmBrh6gwd2rfyqdODi4dcbq+fwGMzzHF3KS4ueyZPbO4rm6uXBfeaoTK08594KmtGbKk5Fvma7GoP8icjqypbPzoANZGBAk7aNQ6KLH01+wsuxFORVx2BbazUVE6+m6KH/sVzq1M9s0=;7:BO5wlXccJf6/OFRsq1XLur8Knfiz6qeRfw032M4odffqti6UbXdcF01ftjzKEKEbbClpMJzoSMjdJOl6GuQCGX7NlwBcEuP5+bTJ2DGq/gVJBSaookLdeD8rdcPaa77eQZUidY+bfzGLtAoY/jrLgzICRQT0f/QoTZ/V+wl3gqn1TKVUyiW4h0k+oUYCa/nZUpHN9PLsu0uj8eIl1oTXvz9E+4k44WkumhWRtuoX4qnKJnLj2soGo0iaFkjCRFJ9
x-ms-office365-filtering-correlation-id: 34883376-4f4c-434c-1bc9-08d6222d0d65
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB018161DCE9DF88D70B4424C3FB170@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(575784001)(10290500003)(6116002)(26005)(102836004)(3846002)(5660300001)(22452003)(110136005)(10090500001)(8676002)(1076002)(54906003)(105586002)(186003)(316002)(106356001)(2501003)(6436002)(97736004)(6486002)(107886003)(7736002)(36756003)(478600001)(72206003)(14454004)(71200400001)(71190400001)(305945005)(256004)(14444005)(5250100002)(217873002)(6666003)(2616005)(68736007)(53936002)(81166006)(81156014)(2900100001)(476003)(86612001)(15760500003)(4326008)(8936002)(486006)(99286004)(6512007)(86362001)(2906002)(25786009)(66066001)(6506007)(11346002)(446003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lo/O2ieibAJVfNviiqE+ygsih5N1GDS2dXMCmCPrRS4TgMplc/O0pW1vaEyCf2s4wFvtykhpvJoPY4RTYt4KDgx0Gc3kpF41FEjfIQ5S2qdzHVrBqskmKif5MftqdZ9GoS93rrSwl0yr0wFJ0aiaMZnW2+4pmafFKITZ7/Fra6ou5AcwynWa/ydxiLTm/qjNuEUhfVgbdq9mObthGc2jWO2ZiOaSts8Nk9HPoFN/rLHipJEXOY96p7qfhslR4SKTpxufC/Y3cMO+QiJN/wMkTHlRMDLlxVPYJo3FyQXpTRu6/HEQ8DWHkR7UJwVPmBGA1nrJC+K70qo0PULi7KY+zZkxd0P2pp628LOfbraO2Vg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34883376-4f4c-434c-1bc9-08d6222d0d65
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:10.4242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 8442938c3a2177ba16043b3a935f2c78266ad399 ]

The "chandef->center_freq1" variable is a u32 but "freq" is a u16 so we
are truncating away the high bits.  I noticed this bug because in commit
9cf0a0b4b64a ("cfg80211: Add support for 60GHz band channels 5 and 6")
we made "freq <=3D 56160 + 2160 * 6" a valid requency when before it was
only "freq <=3D 56160 + 2160 * 4" that was valid.  It introduces a static
checker warning:

    net/wireless/util.c:1571 ieee80211_chandef_to_operating_class()
    warn: always true condition '(freq <=3D 56160 + 2160 * 6) =3D> (0-u16ma=
x <=3D 69120)'

But really we probably shouldn't have been truncating the high bits
away to begin with.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/wireless/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index c1238d582fd1..ca3361a3e750 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1449,7 +1449,7 @@ bool ieee80211_chandef_to_operating_class(struct cfg8=
0211_chan_def *chandef,
 					  u8 *op_class)
 {
 	u8 vht_opclass;
-	u16 freq =3D chandef->center_freq1;
+	u32 freq =3D chandef->center_freq1;
=20
 	if (freq >=3D 2412 && freq <=3D 2472) {
 		if (chandef->width > NL80211_CHAN_WIDTH_40)
--=20
2.17.1
