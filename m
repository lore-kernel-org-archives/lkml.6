Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB75ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBCA208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Dvmeocyi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BBCA208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbeIOGtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:49:55 -0400
Received: from mail-sn1nam02on0127.outbound.protection.outlook.com ([104.47.36.127]:18752
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728682AbeIOGty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVP+wxpmE/K1X6QSVxX81mG/DkeAgqOOcOlLfrsT4DI=;
 b=DvmeocyiKx66w8HNbye+c3Ahz3vmGSs5Z1Y0nFHJinVNWwZ7yXyOHsNA7hmDIBWLbYSsINSymcaejVIhAZThhRzP+Z90Z/LRdHpS4AHaDp+eQz1SYvTu4hOogYZddu4DHuYN0vycVwCOxVy836zPLNWlK8/uNh4kibAX9L2tDkM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:32:47 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:32:47 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 29/57] drm/nouveau: Fix runtime PM leak in
 drm_open()
Thread-Topic: [PATCH AUTOSEL 4.14 29/57] drm/nouveau: Fix runtime PM leak in
 drm_open()
Thread-Index: AQHUTJQCAhTbeZnceEWfcfLZwfJWgA==
Date:   Sat, 15 Sep 2018 01:32:47 +0000
Message-ID: <20180915013223.179909-29-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:JZ7aM/+tVZ+5949AJkIdtqm8JgUnlCKVDue9nmpyHQkdbqvqAC8p+6zAFCLIY/uErS3WrG6VTgW5UEAIU6KgeQq1D8Wm2dpVPTkvNAWPsujhx1cbLA7+Q+CX6mqJgdEEgx78aulZaP9iCWAcxGCMy90pOm+Ldu3S51Av3pT+NhmSsvGvBS0NcxqER4QgFnMoW2TS49US3ShTP3lVjpjjA7u5u7BvFWr7H++iIQLYY332vee3jGlfmwm1mSAldEwHXKpLEJACOXjn8py52pfoEpiPVQwmV7ow6NHrOYgf+OroGX8q8Qjdjs7n2gSkPHi1ZOWYLY2asfzawUM+hgkUbHXiVf4dN7kz0AGQ2o+kJ6bRlhNorSOjLJ2JBZv0DjA/lkxND8xTjgA5EwjUkTE3mskFAIu0QxLNvchP8dCSii7hnLMbFRdO/mmAPR4A0rCuQhxBLFdVAtsqV5ISq3GzjQ==;5:BTOq+FZnRG39uGUacsVXpsxMzVh6PsgjQ522HdL8/uDM9h1WvhP7Bj3e43xh5ASLi8LaBcZx083/5uJly5FntpGCcJjcOzwNTCrN11Zxl/qrIpI3saHnclkBbfRVVZUOK7xnR4S6o/p6Rrcd2FxP7bfVVPMnHMrJNrPZKGnhiUs=;7:S/yM/IzoBtVEvpPIztVFXKDbPt8GyWBa7+4bvXcVU+Wqbsy7t39oTAfdMMZCToCqlTrRbhRMS3Vl0yx1Ww0gZs1XUgFmH9F3/mFAlkbBAM5ij0VSb9REZbYrnvr8AoL+iyYG1zmhVt+EW4NRGIVC1JK9YUji30G+mCQ5PHPsp1Kdem9kiuHGcCPX9ol9XCYv0YsfFV6iZ/PCoWsPEA7SCV9+/nmvnd4/xIOryioh/JhbHWodpHvL/LdDqU0br0mH
x-ms-office365-filtering-correlation-id: 6597bc0b-7bdb-4894-bed9-08d61aab24c8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0822BEEB6EE231BD7A8F979AFB180@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(1076002)(72206003)(6506007)(102836004)(478600001)(8936002)(10290500003)(2906002)(81166006)(81156014)(5660300001)(22452003)(2900100001)(8676002)(110136005)(54906003)(107886003)(99286004)(25786009)(4326008)(316002)(10090500001)(97736004)(305945005)(7736002)(6116002)(3846002)(256004)(66066001)(76176011)(217873002)(6436002)(14454004)(36756003)(476003)(86612001)(6512007)(26005)(5250100002)(53936002)(486006)(106356001)(11346002)(2616005)(6486002)(86362001)(446003)(186003)(105586002)(2501003)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: q8/FOFKcqeAplKnDq32RJ2YLMR+CSjIgD9KwBWz1tsPINONHPZzo8HB3GYZeqRJGPXVq5k+HBRJwKdAq7HoFvjJdkvWeG02Btr+sEez/PAHGTfnEFfut8GVlzl6edFnXPEyXEc1OwO1ku3WOVFQKwQF8BojZLOEMpOCxCl2LRQGFdZBVJG6r+yneyGWuNX7T3ibqFrFPocfIc8WlfnLccjOMcljir4CKI5Lm7o8ZtOPRn9rjRaH6xYamA/rkvB5r6o1WR9gQgzoKPOI7iVseh02b6QW5Tfnkru3T346SzlQBBvff28/ELP90Hzp1asNq6fj1MpsdOlkq5p6cNxE12invNz7O+nDvK2PG3vRZ3Jo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6597bc0b-7bdb-4894-bed9-08d61aab24c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:47.7432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
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
index 362a34cb435d..d6f13d7254de 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -848,8 +848,10 @@ nouveau_drm_open(struct drm_device *dev, struct drm_fi=
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
