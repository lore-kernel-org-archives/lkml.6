Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB12ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68AE221477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EfjQsyKR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68AE221477
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbeIOGrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:47:49 -0400
Received: from mail-eopbgr700137.outbound.protection.outlook.com ([40.107.70.137]:63424
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728462AbeIOGrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeWQWUeIEBBfRvoy+utdCvZzqYkbbUEINqvxdU9qvfM=;
 b=EfjQsyKR1rjCjD5Y7gW8dlGmuBEsvTSk38Vbpm4D0jk0Fg66mKrncNjBamkqjyRpNTSFjvdGIeRDWVzexpXELsrV6k8NnOLY2hLpGypXRhqq38u5Yp8zZnHCZ2oblWnXqkOt47tdiWqkJMHhUEwkTBz+nnakIvZ0R2oEupreySg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.6; Sat, 15 Sep 2018 01:30:47 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:47 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 41/92] drm/nouveau: Fix runtime PM leak in
 drm_open()
Thread-Topic: [PATCH AUTOSEL 4.18 41/92] drm/nouveau: Fix runtime PM leak in
 drm_open()
Thread-Index: AQHUTJOpVLWFeT5HPEmc83dUnTNicQ==
Date:   Sat, 15 Sep 2018 01:30:18 +0000
Message-ID: <20180915012944.179481-41-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:h6v/c7TF/cin58S0m5sMmiRJb6Ov9MnI887aWTdMCKl8WazKW2MF8xSWsWZDlBLMrR1jOshvoHErYGQ2T9Qlfs59H1aBAV3f+w1vl/nq5a1XR+s1HSj5htXVOAzLrAb0VBXih1to2l+fQlX3S4jjHmoiT4gbqz7pU13az9wLno6OxulUs31TvQLToHvTs8gKJidEMDcYxZ+EgD4bC/doFU7FFBkiH1C+dOQ1bPVFy8QuaUshqGA7s1RwncLLeWsB8sc5ZFepuH39HWuhsAQiJaGfNcgGwAFwU7wh6e2EkG+TRYgh6k8QMpHfZOJE53lQIX6CU2auaiReI3toKDblVQJPtcglyFdEtwx/W9M0+zNqyxZufUaSZxj+oziRq+u2k+NUbPthKHWabdz7+xARs4VdqfP65v0jDO8Oose4vsCGU7gGs9dektFpOJ9IK0TXmCDVMeBCA+th9MjLtZFAUw==;5:pHI9zGq0JkeK/bmWLTY8pUXAl8qlZdavccGHbHD1v6T0SvBqLPB4RRK7r09aAUFs2Dt2fZkESkzpG6wnJ/SRgWlrHortzWMqAOiej4XlZqopQDuSkCtoJ+gLzyKKlGBsrsczpZd+pumtX/VGj7Mx5UGRDhHG4YmBjNi1usUvB1o=;7:isYcI2G67/C/9+1yQAE71DK7HcpAn9MuiLCDh0dGB//MPnkxRlwYXgksvJefkKw88jkT++uHwqGRQwsXQCeHKPRjkYY+bn4ukjUIk95jkLixSl+SFIxkyNlG/WWgAE3USD5D8/cJAEtzBJtG2AZ0UnbAMREUrGQ0SvzrVXnSbOYOnfe+xivEYEeQHRiEMeVaIuVbPltDtJAyIuN3vcZcZLsUzebo655kppTRMFf6S2s0QW01jdfvyvG4GHBPsphW
x-ms-office365-filtering-correlation-id: 832c9ca7-44a1-4198-50b5-08d61aaadcde
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
x-microsoft-antispam-prvs: <CY4PR21MB08560D02F08C347F22615257FB180@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(346002)(376002)(199004)(189003)(36756003)(6116002)(486006)(316002)(3846002)(8936002)(22452003)(446003)(11346002)(2906002)(476003)(2616005)(6512007)(107886003)(53936002)(54906003)(1076002)(110136005)(25786009)(102836004)(66066001)(4326008)(217873002)(99286004)(76176011)(68736007)(6666003)(86362001)(5660300001)(6346003)(8676002)(86612001)(256004)(186003)(81156014)(81166006)(6506007)(26005)(2900100001)(10290500003)(478600001)(7736002)(72206003)(305945005)(97736004)(10090500001)(14454004)(106356001)(105586002)(5250100002)(2501003)(6436002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: vOzvQ3UuwCFQ/sb0vdRlChBF60T6y8Mq/HNKVCJ4J7cFZTV3YtL98sIua65XsIx8ui4+2ojMBbitDYmcWghgSCKDwgEVt3ok74PP9ndsS+dfDG4/R0cVZV+Dx/wpj5aRpkmPUgl1e6w0VBdofQREMUVGbk6feGY4eoTsg9YokkC/xZhla52ePy9ppUpnp//nqqvDWrE6jrlgfwcYysHvxczL86Dh6DH66uDjTojLOfY6qe6dd1pmFc2ZCKdlVVK9o0mc/bd0pMZAsNNQvOtGtR9tVWE1pPDpZShuWR8gnxWKKez5fwVcDnFaB8JEIya8kZ0OIplb9li0J4iEwdA9UEKg5E9UEI/MMVpd8E+v94I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 832c9ca7-44a1-4198-50b5-08d61aaadcde
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:18.0418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lyude Paul <lyude@redhat.com>

[ Upstream commit 922a8c82fafdec99688bbaea6c5889f562a42cdc ]

Noticed this as I was skimming through, if we fail to allocate memory
for cli we'll end up returning without dropping the runtime PM ref we
got. Additionally, we'll even return the wrong return code! (ret most
likely will =3D=3D 0 here, we want -ENOMEM).

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouvea=
u/nouveau_drm.c
index f5d3158f0378..c7ec86d6c3c9 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -908,8 +908,10 @@ nouveau_drm_open(struct drm_device *dev, struct drm_fi=
le *fpriv)
 	get_task_comm(tmpname, current);
 	snprintf(name, sizeof(name), "%s[%d]", tmpname, pid_nr(fpriv->pid));
=20
-	if (!(cli =3D kzalloc(sizeof(*cli), GFP_KERNEL)))
-		return ret;
+	if (!(cli =3D kzalloc(sizeof(*cli), GFP_KERNEL))) {
+		ret =3D -ENOMEM;
+		goto done;
+	}
=20
 	ret =3D nouveau_cli_init(drm, name, cli);
 	if (ret)
--=20
2.17.1
