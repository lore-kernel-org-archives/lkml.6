Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40930ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E419721476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ajCMpZCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E419721476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbeIOGsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:48:43 -0400
Received: from mail-eopbgr730117.outbound.protection.outlook.com ([40.107.73.117]:17920
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728265AbeIOGsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eA8qarTD2odkNGpVnATJEZ67bKEQgD6u+uER3OZ4TSI=;
 b=ajCMpZCdjv4SDhaG61Lxm9/zNxMpr6pKyrF4l6Jkw1ipg+VXPy3lXF80WaQtO6yoKQknefuvT4eRVt/kDyfSMFZK+BXe3Z77Zxom9qzvzzRRoPfJdHe6BS9cPBcb3TRtN3pRY8HkuzIUf9geEZGgj8LrcJa/iavABi3Quw/wIV8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:31:34 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:31:34 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Timo Wischer <twischer@de.adit-jv.com>,
        Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 70/92] ALSA: pcm: Fix snd_interval_refine
 first/last with open min/max
Thread-Topic: [PATCH AUTOSEL 4.18 70/92] ALSA: pcm: Fix snd_interval_refine
 first/last with open min/max
Thread-Index: AQHUTJO1sNffwhb0M02HehZkfrLqRw==
Date:   Sat, 15 Sep 2018 01:30:38 +0000
Message-ID: <20180915012944.179481-69-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:1SaRgHlDYcXGuK/6/bE8fCXB1ObvfH2kPMg3LgXbb6QaQVd5m55jGotqBD2aOkjTVVUazZyfnNDJ/G7K9YAO79lovtu/FlOH8K3hiWmSlyRBqn9Dun7uhmeBVMVFLYdk2To0vquF/OQDgpnTbUOHSpNgz3Z8SOYO70iMlov/haslzE0L9/JTjBol0nGTYxWlhH52KdxoJXFimZc59PTmLayQnPhkxjtOTQc4zsVWlKQUA2JxDqwzVmuiH6tAHYXt9Oqb8esa/FW8GIC5GWrzrcAxe8cHAM7pZkwSjeBL1K3hdDBI0nY/yb5ZzdgKfoDDkkf0Np2tkHaQOR/4CAxBFt2sX8wtEDzW6OI/7hGYV5d9JX6b98OylM1QYmvWU2tCe4AOQo80e18Gb+ivkUYiBaYz2yYNeyHYaemEUiOOO7NdT5onDkWMaUK9tbMORDojqBie/r+vViTui2Fph3fQtg==;5:M+9HiQ2Zkx9KbB5JDuWJNZyJjTvhnSZ9uXtgfVrSxsWHipWT2uw3MJwxZg5adl+xN7P4IVjIkZq2aK509agoRJH2vvC64cKkQiDi+N8eXpBjJl/53UoQiQm316KUqt4s/OjTrVdMSO7OACqcsu2rIC1MCvoqBPQ7XbeNZbeqMyg=;7:TV60yeIRNFBY9Sp9m1H9Uhaic7rlTQ+WfyQYI18fK15km96YI+TyGKjiend5pPZsgo3AjKScIJjUY/Cn3VbGYN7FU0aFf7SPDnDyQU2IO6rhzN7UjPNlI0Qfksj8a5D9YxcVvi/ME3+iRv1DUQSKA8qZLASRMCViqEJLdNo1v7DSWxJ430sOiY+2O5JCRoSd9uB13R7iqU6xivekzRPRG9aZVOVu6PGYHT6sHsws6FDv3Ps1fk8wsIIVoz26HAle
x-ms-office365-filtering-correlation-id: e83e4159-9493-4464-b380-08d61aaaf8df
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
x-microsoft-antispam-prvs: <CY4PR21MB0470FD5136326458D34DA29DFB180@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(6506007)(2501003)(2906002)(6486002)(6436002)(5250100002)(99286004)(486006)(14454004)(81156014)(26005)(81166006)(8936002)(6346003)(102836004)(8676002)(186003)(2616005)(476003)(446003)(10290500003)(11346002)(97736004)(478600001)(72206003)(10090500001)(105586002)(217873002)(36756003)(106356001)(22452003)(316002)(256004)(5660300001)(54906003)(110136005)(3846002)(6116002)(25786009)(66066001)(107886003)(4326008)(86362001)(2900100001)(68736007)(6512007)(53936002)(86612001)(76176011)(1076002)(305945005)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: L9WDk6wlMJiZ+WHvfn7DXST3ZDzIxz5cEC9XEWGwb8nHmioq4ciygo520TLJ7/5akhcrPCgwFgxhYatActXgFUJCnBV/VzQVpwyK2zL1QmJXDphBaSpeSvEswWIQTulnv4AFBFsCT8ml96EZXl142dMcvYvywxHijLXimyUwIzBAq/AvjjEePD+vpS84yB4M/M/GZDFjYTahZLG8963Yf7BEQTYXUFNVGzrMKzNBLTUitYE7aJZNqv+NkZTn8zvzAP01qNsZI7fd9qC0DEbgIJjRhvEFZnhg4YMleBgBnhOJXNkGA2m4uHXaL+z1Bq7uaALI0Ka+BFga/yCx/4203VuoB6kKdg4hssEb8ehvJiE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e83e4159-9493-4464-b380-08d61aaaf8df
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:38.8386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Timo Wischer <twischer@de.adit-jv.com>

[ Upstream commit ff2d6acdf6f13d9f8fdcd890844c6d7535ac1f10 ]

Without this commit the following intervals [x y), (x y) were be
replaced to (y-1 y) by snd_interval_refine_last(). This was also done
if y-1 is part of the previous interval.
With this changes it will be replaced with [y-1 y) in case of y-1 is
part of the previous interval. A similar behavior will be used for
snd_interval_refine_first().

This commit adapts the changes for alsa-lib of commit
9bb985c ("pcm: snd_interval_refine_first/last: exclude value only if
also excluded before")

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/core/pcm_lib.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 44b5ae833082..a4aac948ea49 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -626,27 +626,33 @@ EXPORT_SYMBOL(snd_interval_refine);
=20
 static int snd_interval_refine_first(struct snd_interval *i)
 {
+	const unsigned int last_max =3D i->max;
+
 	if (snd_BUG_ON(snd_interval_empty(i)))
 		return -EINVAL;
 	if (snd_interval_single(i))
 		return 0;
 	i->max =3D i->min;
-	i->openmax =3D i->openmin;
-	if (i->openmax)
+	if (i->openmin)
 		i->max++;
+	/* only exclude max value if also excluded before refine */
+	i->openmax =3D (i->openmax && i->max >=3D last_max);
 	return 1;
 }
=20
 static int snd_interval_refine_last(struct snd_interval *i)
 {
+	const unsigned int last_min =3D i->min;
+
 	if (snd_BUG_ON(snd_interval_empty(i)))
 		return -EINVAL;
 	if (snd_interval_single(i))
 		return 0;
 	i->min =3D i->max;
-	i->openmin =3D i->openmax;
-	if (i->openmin)
+	if (i->openmax)
 		i->min--;
+	/* only exclude min value if also excluded before refine */
+	i->openmin =3D (i->openmin && i->min <=3D last_min);
 	return 1;
 }
=20
--=20
2.17.1
