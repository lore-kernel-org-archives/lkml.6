Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA2FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17A4204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AnG/s8oT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C17A4204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732888AbeIXVOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:14:19 -0400
Received: from mail-eopbgr720093.outbound.protection.outlook.com ([40.107.72.93]:21257
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730414AbeIXUup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynxbbZww56HpNXd01kuE+t/C50ZIqKuJfVPMNyrOq/U=;
 b=AnG/s8oTHmk1Zbfq/QIgYyD0aShGUq4i4pMlbIS4dF3OSVPdGPpUQcKikiIkjq96t22VnZQU650wvL9lfYzLaie/8Mp4V5b6ebjBN5qKCZaZiNvEU9mYeZCux/Dcu39aUdcP53rXDeKPs1fVPRUNtE3wwwlEqfdsCZjIe17eIZg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:48:11 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:11 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Haim Dreyfuss <haim.dreyfuss@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 18/76] nl80211: Fix nla_put_u8 to u16 for
 NL80211_WMMR_TXOP
Thread-Topic: [PATCH AUTOSEL 4.18 18/76] nl80211: Fix nla_put_u8 to u16 for
 NL80211_WMMR_TXOP
Thread-Index: AQHUVBWdcflYl1I07UCEmX7n91jUzQ==
Date:   Mon, 24 Sep 2018 14:48:11 +0000
Message-ID: <20180924144751.164410-18-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:7ZvSsYR7ziQLxSQEMrzUzpinSL/LYqRc9ozqKld4uuWJUGC9GTNTmMbfD5lmX6Ob2ojHWSdPa2dCj0gZwXGeEykizRetVe5J46EvK3QdyMH0iaWeLnbiU9NpniJ+gOBo6rKOaP6hMV48QWQCbf9mPi8+JXQZzdWTE4u5rZFhjFc3PFPAlA7ihTrysAZzTydFexAzh+NLVOZCYk6q1LXvjo6oVbYgP5B8Q78s1j/b+9YXImdb1qutaKgC2BWFb/7ZdwMaVSfg4TpyYL3w49okhsEZL15slVCM+jAm79KU5YphpwFtJjvmzqMiuA3pFBsdZlHVBDEpWOND6Kzyj2d/3zYOM3y9dYsaRJxwhLUpW3zLCq9k2bTr3qaqYlcvFPVoufQCYyAOk4O5uyJC1sem/eDvzDv54lno2oxcj2RBpsCZOJd9Dnio/v1vEOGEPvYKKF4inSkIko6114oXLxSnJA==;5:I5/hIyn5wHFQylCVTl9r+2HqfiA9kGF7+L9wDPLQW84MY0qQUCLhI0cehnW9AwD6L71Hwc5TOOt41V/IsiRxI90GlFQH4CZGeY9FjwVnMVqIWLl9tD7NzNqDeDcc1+Xum8hLjWthaPVhwuM7RTIihXmCF4RFvf5GrwVlOtx5IYc=;7:r8bxWx68+usFnmXErFGS+/d1VCQgFmonsbne/CTYNfm7u6WM7MLsRaDRsJip9U//XRF4COs+TZIB15GxXpsO4txv2MibSR89suYZuXq+Jy/aOXA+I66kmgqnd2qeKojwraaifgA1nR5DIu8TfDZj6PXNQr4rFWvEz8omTdxq2ILX6VEN6Yo0rVi0YBr99+DxGrBhAqeH5qH2k2Pr1lT1VsIfdp4krzPr0VTItjO3NEp/hmZ3lzAKQW0Swy9v/yJL
x-ms-office365-filtering-correlation-id: 0e563505-b17a-40b6-ac99-08d6222cc01b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB08210BA293C2D8B9DEC92B7BFB170@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(376002)(346002)(39860400002)(189003)(199004)(2900100001)(86612001)(81166006)(81156014)(8676002)(8936002)(1076002)(4326008)(25786009)(3846002)(6116002)(86362001)(15760500003)(99286004)(486006)(76176011)(54906003)(71190400001)(71200400001)(22452003)(316002)(106356001)(105586002)(6346003)(478600001)(10290500003)(6506007)(26005)(7736002)(305945005)(72206003)(186003)(476003)(446003)(11346002)(14454004)(2616005)(110136005)(217873002)(6486002)(53936002)(102836004)(5660300001)(14444005)(256004)(6512007)(6436002)(107886003)(66066001)(97736004)(36756003)(10090500001)(2501003)(68736007)(5250100002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: GDyjscosZd6k6Ghdtm82LYlRZweoPxdmlQXCHUiznXIVc8ho03w7KXdxCBhr0xki07TQIUkgW902RHymLM9W8W4vKq88UTynMHzFzzyMtbn2i2RHeJ/msh5+C99F1k2Xg3c3yfItccBT3ZCOwSWX2f4snD0mIMgPiYPG4UQOpYWNSXeTf/E2v9RA3cLscw5x+mN5azhjJpAAzV1MglvdUrwDmX+ojjFiEeIUWG8crz/jDHF9XXXqIC7vColV1wN3sYwou5adwgrYtcVRJDS75bTZz3BmVeBLfVx4+k1Xm/ND4zfhm6b4j6tkE4qxOU0mBUlQPI77m0kWUv4PSIIEtD9noyLscreYXdbhe4wrTps=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e563505-b17a-40b6-ac99-08d6222cc01b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:11.5397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haim Dreyfuss <haim.dreyfuss@intel.com>

[ Upstream commit d3c89bbc7491d5e288ca2993e999d24ba9ff52ad ]

TXOP (also known as Channel Occupancy Time) is u16 and should be
added using nla_put_u16 instead of u8, fix that.

Fixes: 50f32718e125 ("nl80211: Add wmm rule attribute to NL80211_CMD_GET_WI=
PHY dump command")
Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/wireless/nl80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index e3dcffd96919..3f7ffbe6c634 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -672,8 +672,8 @@ static int nl80211_msg_put_wmm_rules(struct sk_buff *ms=
g,
 				rule->wmm_rule.client[j].cw_max) ||
 		    nla_put_u8(msg, NL80211_WMMR_AIFSN,
 			       rule->wmm_rule.client[j].aifsn) ||
-		    nla_put_u8(msg, NL80211_WMMR_TXOP,
-			       rule->wmm_rule.client[j].cot))
+		    nla_put_u16(msg, NL80211_WMMR_TXOP,
+			        rule->wmm_rule.client[j].cot))
 			goto nla_put_failure;
=20
 		nla_nest_end(msg, nl_wmm_rule);
--=20
2.17.1
