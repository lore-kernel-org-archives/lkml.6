Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE531ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C58A21476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="A7u9O5jM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C58A21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbeIOG6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:58:47 -0400
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:38374
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729437AbeIOGuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3qYW/5LD2ELS8V99ZHDQyJAzeSIYeq2yovYzIOG9Vo=;
 b=A7u9O5jM8Rd1cfI7bnd1g9uAShBQnF+08MsL8PU8qxh9FnoWDuQrYXYJ7/aVdxq8OZHQ/kdLk9FOZXc/0FK0rcXcvxARuHzLmwF+nmx78JmWH0p2ZxY+FpMc7chzF2NwKeNt/t4Z5ujwjYQhbTXPrgrmMmy+f4tQj7ZCnSOg3pM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:33:23 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:33:23 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Timo Wischer <twischer@de.adit-jv.com>,
        Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 45/57] ALSA: pcm: Fix snd_interval_refine
 first/last with open min/max
Thread-Topic: [PATCH AUTOSEL 4.14 45/57] ALSA: pcm: Fix snd_interval_refine
 first/last with open min/max
Thread-Index: AQHUTJQIl0xVXZ7/wkOUm9DMCVRL+A==
Date:   Sat, 15 Sep 2018 01:32:57 +0000
Message-ID: <20180915013223.179909-45-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0471;6:l2XSHWQY1s8mfJ8K7FVFWmmWkdh+U4AxS+TydQjoVAGf0Xo9rm8iS/pQhiHaRkCsrWHZz2wGCF8bkIxDTJin1XfPffv+yFx6Ewm0vsEm8wY9Yrk1xq2ZOlnOS9Habz1NROfU90Tn3MoZ7TgxYg/2Aux+kkNU3bh1NYAq13waB2AsczkvrXpREXJzqIMP3mUVvb8GoqtqBFYQ9wQQzhcX6AOVhmSB3wUeFZxojhfpGoVutsA65FjwFZXesS+fKkWJsANkjm49sgfgRfJCDWSNuEMV4rgl8yckTeAh1EHLmtp+jhIat49bPkOP2tflYaypCgjUrWUghQbBIYAzIRHKMoskfBNCpazz7EhmXeMwpxSYFuAQa0jHOnWEpKx/Ap39UCSL+l4tIaUdJYRbo6hqJH0ndyHvdCVPjrg3FDdRMafwdakUBYVAFy/CuCk7su7dNMlHtM5d1XRiB9qacHghiQ==;5:UNEBHQmHTHK8kLdx12No0yVRHBctesiY33eivJ81m+xZ1+hSppGwWTOXiB6ekeNHNiFaKynoVXqak3RZSPwYPkZYClN4MpWBBV+dQINRBIZLl3zcTDHyR4eLr0rzJBwBxJdlbklWFJVh/XUHxIysn9sQoS9VdwVBU9O7saq0dUw=;7:dxw2so9n+UWw2HmHxJmog6zUeP4DrbmoYykrOjU3lIJ5XbYg5XxCFEOd1t1plMy7TJhnURMGJiqv0uPip9Agw+E0u0vG9I+B44dmrWs2+2vpcZTIBNQ6j0CaobUUBgbjMtf9dFq7ITVekga9Hzrh22viAbO7tOmBLDNAdit9mJsIyx2hRsZKTDdegdrvtYOMCw1ml1KykR5WpsuoI4ZJGV+NKNqCY8OKdU1BNqAZaavTlKBELTm6Y1JnEQ94/w9f
x-ms-office365-filtering-correlation-id: 3e8d434d-a5ec-4c17-c4cf-08d61aab3a50
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0471;
x-ms-traffictypediagnostic: CY4PR21MB0471:
x-microsoft-antispam-prvs: <CY4PR21MB047118D09F2D34629431096DFB180@CY4PR21MB0471.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0471;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(396003)(39860400002)(346002)(199004)(189003)(7736002)(8936002)(81156014)(305945005)(81166006)(8676002)(66066001)(316002)(110136005)(106356001)(5660300001)(6666003)(54906003)(86362001)(102836004)(86612001)(22452003)(53936002)(6506007)(36756003)(107886003)(97736004)(76176011)(2906002)(476003)(99286004)(486006)(26005)(1076002)(217873002)(6512007)(186003)(72206003)(10290500003)(6346003)(478600001)(256004)(6436002)(11346002)(10090500001)(5250100002)(446003)(6486002)(2900100001)(14454004)(6116002)(4326008)(68736007)(3846002)(105586002)(25786009)(2501003)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 2GQGR3NOkeTaxJzcnMtKL/JFCoAOzM5uZygTyXcZfXWeXO40qfAJNvfZ9wDiIIQErQFOrPFSfEfU1lYHqeMkXqLoDI0XqXhwHiEEE6KdmRT8XZZC5wiWI0UPeubIgT3z/xLhQwP22lTTLtSVA1Kylu/a1vyUUAuvIyxQYSH1rwZqk7Xi/YN06r6zeeiEqv6knaRARRNek0Z0mMYgg6i/h3uD4yNUHV/mX01+rGR9DDBcRFT0EW9GKnjJIwgI5iYCYW54h/a4MaSbQqWF9necXesNcpNCqjD1sY0usKskFfxijCHTxIY2NTagkuyne4awGkpOKa7vO7ci4FJ/ebo5o48k2qMF6+qcRCNvRcYKGp4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8d434d-a5ec-4c17-c4cf-08d61aab3a50
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:57.6490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
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
index faa67861cbc1..729a85a6211d 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -629,27 +629,33 @@ EXPORT_SYMBOL(snd_interval_refine);
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
