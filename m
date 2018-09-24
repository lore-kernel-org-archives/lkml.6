Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9782ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6842087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ozpiQTYc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A6842087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388947AbeIXUxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:53:43 -0400
Received: from mail-eopbgr720095.outbound.protection.outlook.com ([40.107.72.95]:35088
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388728AbeIXUxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yV/S1gU8cEZcYnljXosh9phtVs0ASvuidyR7jbVOsd8=;
 b=ozpiQTYcA2npBAkIrWMGDXW2VempizX6BSatlnPEwUtVlK2X0X6NLheu6Ca2TGwxSnxqnny1mvkdch4DQqHfQt7B6sEuwpLNtTG1gZXckXk+0+s6AWmFptrOuQkTs4Cac5bZ6/+pmjAhcBehysZAoL2cXG6UE9VNgz3jkdQIG3Y=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:51:04 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:51:04 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Danek Duvall <duvall@comfychair.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 02/18] mac80211: correct use of
 IEEE80211_VHT_CAP_RXSTBC_X
Thread-Topic: [PATCH AUTOSEL 4.4 02/18] mac80211: correct use of
 IEEE80211_VHT_CAP_RXSTBC_X
Thread-Index: AQHUVBXWyPqFmBpR/kuK594YRloN2w==
Date:   Mon, 24 Sep 2018 14:49:46 +0000
Message-ID: <20180924144942.164688-2-alexander.levin@microsoft.com>
References: <20180924144942.164688-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144942.164688-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:7SbByCg3YmOgHIejjyup0Wqjqn2t2dD9BKgIes8oQ3IvwDmttLtMhs5+9boaSZV6yX5UGyJP1y7HuLfm64mzQihj3P1NUSrSSbPgwlTUInm44fHvDSMDOGvDoj/EsNkbipSEEfBgnR4ucCqoQ5G5+Mf5gGDtaAs1LOjj546crAqks0bEAAuBrVqzS5YdkGNhSIlP5V89SBnLAa990QcnaF91hEB7wyvZ7nFq9WjNeLO1pE/KF8/xQycpuFfT1DS1trZHsk7nWJtgVofR6+f1FPYHkndt3hxHSqWVTtNGG18sWgvme7Y0Q5TR1Ecgx0WsVU2VtdBhPAl//7kGMGa2vgehPsth/SywZymEp8NW8tkk0ZAx1kx5tsVxkrQtTbzcO8LiEEb2fpkSy7lBv+5Ge6U4EX1c3OdFn1isx6rMJMWkghBVv97Y0uG8IKxSPO+SXpydSfFBs44no1N17LsDMQ==;5:J9+TBVysTBwkp+3CoAy61IG3Fw1sQMD8crM5KSHlyxDvSyZ9ZH5fBnCYH53e7H9pE8D4pdr4H6NVekihRmeEHXMyt0+18yT1nbTBLbIherbla0COntnnxGwHB/1m/jKhxiIZFD0cRiVKBRo4AKlC/aUg4AUy9CMJoHhvoNOMHDU=;7:qH2aXoltKumIgZ4ZulMeEdj7tmNkcVb0BmtTRbGZs26u8xLAJ7PVKXPdrIgeNcBeJ4/RoW6TAeB0s/w+8qyxkSdT3zUTojzCXy+VyfVda9Yaf0Ubvg2gjD4t9KqDiLyanhKmXrmca+U1aB3YercPCTPNkoj2IYFvTla2YUltzWYyeftkgMFl6YqfaJ5qtnjH1WmAXQwIwSi54jQ3dhf3DbugQ1aKfEumFU4P4k6eFlUp2FAXUIUvH8lXycnKhhCe
x-ms-office365-filtering-correlation-id: 389afcad-66bf-4121-e9ae-08d6222d2763
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB0821F67367D919443B5DEA42FB170@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(136003)(396003)(366004)(199004)(189003)(102836004)(5660300001)(53936002)(6512007)(6436002)(256004)(217873002)(6666003)(6486002)(2501003)(10090500001)(2906002)(68736007)(5250100002)(97736004)(107886003)(66066001)(36756003)(4326008)(25786009)(1076002)(3846002)(6116002)(2900100001)(8936002)(81166006)(81156014)(8676002)(86612001)(575784001)(86362001)(7736002)(305945005)(72206003)(186003)(26005)(10290500003)(6506007)(6346003)(478600001)(14454004)(110136005)(2616005)(446003)(11346002)(476003)(76176011)(486006)(54906003)(15760500003)(99286004)(105586002)(106356001)(71190400001)(71200400001)(22452003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: K/D8DYpnEJKwGTq+9Wb3v6C1lsiq2Ds2z7U03Vl31HpzuxakcsYWaWvQlD+Im1h1BwJYEQ5pK+tSX6yy12TTrB4dgYwTGI0NXxgGH1mt9KlUCQ84KBtfSwCwwV+gqqdnDy68+YUZNmMVZ4bqxAO8a5YT+VorrJ8/jOafJ51mNjaHgeAw09qoeGDqsOhwRyjMXbzIChzhj9Xf8ST1lTQSqcXAGpYctvS19dfo1ch41uffPYdDnqJ/T0qFQY9M/XSKgvlax3gwo/7Zil2bP4VFZXFA48TB4f7XquCToy9BEu+VZKVcVWWQ8XXVN+Syr5bpjMrTXojpSImmZPSmOEu5IEOhFyFO0A7szUaTSR13X8k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389afcad-66bf-4121-e9ae-08d6222d2763
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:46.2808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Danek Duvall <duvall@comfychair.org>

[ Upstream commit 67d1ba8a6dc83d90cd58b89fa6cbf9ae35a0cf7f ]

The mod mask for VHT capabilities intends to say that you can override
the number of STBC receive streams, and it does, but only by accident.
The IEEE80211_VHT_CAP_RXSTBC_X aren't bits to be set, but values (albeit
left-shifted).  ORing the bits together gets the right answer, but we
should use the _MASK macro here instead.

Signed-off-by: Danek Duvall <duvall@comfychair.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/mac80211/main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 2ee53dc1ddf7..d784d29a4fd6 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -460,10 +460,7 @@ static const struct ieee80211_vht_cap mac80211_vht_cap=
a_mod_mask =3D {
 		cpu_to_le32(IEEE80211_VHT_CAP_RXLDPC |
 			    IEEE80211_VHT_CAP_SHORT_GI_80 |
 			    IEEE80211_VHT_CAP_SHORT_GI_160 |
-			    IEEE80211_VHT_CAP_RXSTBC_1 |
-			    IEEE80211_VHT_CAP_RXSTBC_2 |
-			    IEEE80211_VHT_CAP_RXSTBC_3 |
-			    IEEE80211_VHT_CAP_RXSTBC_4 |
+			    IEEE80211_VHT_CAP_RXSTBC_MASK |
 			    IEEE80211_VHT_CAP_TXSTBC |
 			    IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE |
 			    IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
--=20
2.17.1
