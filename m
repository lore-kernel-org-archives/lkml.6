Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC023ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A07B2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="diwRsIFf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A07B2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbeIQI2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:28:09 -0400
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:22121
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729620AbeIQI2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFhuXHZKt2VH4XNVK/LgKmKi4lyY5eANc/fC16UVXOc=;
 b=diwRsIFfdvVt4CsStQvAV7tPIjtw1Eif+Orl4wySEeoxlDwaIYXNZcVNlhmEkuXfme0b069G5Gm60psrIJmeB4DdhhV633Qs9vZDQlXyjoci7dn6ONxIFI5jzAaaXFHfHGTr6Rr3E538eol/vfozXrLMvJU0y7KfEGZOjLkDnxY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0168.namprd21.prod.outlook.com (10.173.192.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:02:47 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:47 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Johan Hovold <johan@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 117/136] EDAC, i7core: Fix memleaks and
 use-after-free on probe and remove
Thread-Topic: [PATCH AUTOSEL 4.18 117/136] EDAC, i7core: Fix memleaks and
 use-after-free on probe and remove
Thread-Index: AQHUTjK4uiSSHV8+XkKCMK/o8x/AcA==
Date:   Mon, 17 Sep 2018 03:01:25 +0000
Message-ID: <20180917030006.245495-117-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0168;6:U7vcZse3/rnyJN3frySnmhPVlyDGtqI/yrY/fMbpa2uM/0eEnr0Hbcj8CWYzhjbhaEpcPmZ/Gs/4I9B8CFr+rVBjm+9PAizRJyYheqVD2ek7SR3QfhoQg2Qf9K5eEdwd1Vx6akznOrwwY6paC5QNC6wHH/nOJ61qTEd6+Z+dUNRiF7UvshSVxmzijvPdcjae+T9eUVVwWOHwaZoMK/joITEhgUmJPOznEhUmL8s2Y6D2W3y/tKAnK9uDCpCHalwaOqe8Klxlfd/4fRjupbGvmMYfRKGqIl9N1I6Wdr5IgewKvGPBrnEAlYMQ8tGEy3iO64r4GoO85BXYzJHA2479cr1H+ykYyawUAPFkG3zEeJ9ZOOYNLTmw7Uu49Bo8TGfhCqQfVtw84AyTNrcZH1/pcMZFbXjFpPnV/r1YoSz3++L1HwUKT6bGlYJF9Bsdbmb6BjKsLrs5eGVSCntqxSJtfg==;5:Z3NymFM/3WFWH44bC1nG97OXKlAEbD+b879Ze+H2pEjRjw+JB+elbtfVF17cX5pE5zccv3GAblcA1fTR622CvsmLClP/cUrIoRA0fFuYWoA757Mku1T1gW2HOjvdMcPZXRsf1KplDThTPJW+s1a+G+MB+Dcn1tgDrkT/8lMxxs8=;7:lZqJlMHUhLz80wwjl0s2gbp0/hFC5IdqW5IF6PmAUxnCZ7N0WarelYBkjos/TPAgRaLgpQRxYaxfPw7OIXCkulvQRR+4SXant3lbyFzD5rnxutyhZj3WdkhHl/hIFaq4avPeXu0Zw84HKjHqaHBTVqee4cVwEVAUouIM2YMopveY/fUC8cGoWCzJq5XSFBkemepc2lKrT20RbKPe71w/nrMiRtauFxMHDsp0/ltBX97kecleUMVKN/PPaiqmPAbY
x-ms-office365-filtering-correlation-id: 0d56ec46-ff16-4fe9-8e6b-08d61c4a0c21
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0168;
x-ms-traffictypediagnostic: CY4PR21MB0168:
x-microsoft-antispam-prvs: <CY4PR21MB0168C453EC3DE67B6E2932C9FB1E0@CY4PR21MB0168.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(42068640409301)(9452136761055)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0168;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0168;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(136003)(199004)(189003)(11346002)(4326008)(105586002)(106356001)(486006)(446003)(6436002)(2616005)(22452003)(966005)(107886003)(10090500001)(25786009)(476003)(14454004)(110136005)(54906003)(316002)(2906002)(76176011)(99286004)(575784001)(36756003)(186003)(26005)(6346003)(5660300001)(7736002)(305945005)(10290500003)(8676002)(81156014)(81166006)(6486002)(68736007)(6666003)(102836004)(6116002)(3846002)(1076002)(53936002)(217873002)(72206003)(97736004)(6506007)(8936002)(86362001)(256004)(6306002)(6512007)(2501003)(5250100002)(2900100001)(14444005)(478600001)(66066001)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0168;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: o7lUytZEd+snkHx9ZO3bKfdiqEo2FNTORdNX8G46VvUw+pa3Q+rI45r6TQUdNYZs4klwvD2fVmvush3lAWvHr4FQkNlWDXEbf8PfHsqiHgXeqzvt7Z454AM2AcSez4FnSemnkdY9CsZSDLkmyLte3ulDn0gpBUrzomWq0Z16LM/hXP3svDnNo/s7VGGu5AtKUMZTG5mO1qGGihW9+mUwFy2aZ5MSTpsJ9uCD3n7Re65R3tWAdhvUBs8dytaBnTL5p/2J9Azg0UaYuezVeQQZVGakC3/x5lPAz14WbZiZO6oTjNlB4SiT+Kk26Kr2J0glPelZjr3coMtboiFGZxgCYLB9csDdU1DboIvkws9e+Ao=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d56ec46-ff16-4fe9-8e6b-08d61c4a0c21
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:25.6665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 6c974d4dfafe5e9ee754f2a6fba0eb1864f1649e ]

Make sure to free and deregister the addrmatch and chancounts devices
allocated during probe in all error paths. Also fix use-after-free in a
probe error path and in the remove success path where the devices were
being put before before deregistration.

Signed-off-by: Johan Hovold <johan@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-edac <linux-edac@vger.kernel.org>
Fixes: 356f0a30860d ("i7core_edac: change the mem allocation scheme to make=
 Documentation/kobject.txt happy")
Link: http://lkml.kernel.org/r/20180612124335.6420-2-johan@kernel.org
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/edac/i7core_edac.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
index 8ed4dd9c571b..8e120bf60624 100644
--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -1177,15 +1177,14 @@ static int i7core_create_sysfs_devices(struct mem_c=
tl_info *mci)
=20
 	rc =3D device_add(pvt->addrmatch_dev);
 	if (rc < 0)
-		return rc;
+		goto err_put_addrmatch;
=20
 	if (!pvt->is_registered) {
 		pvt->chancounts_dev =3D kzalloc(sizeof(*pvt->chancounts_dev),
 					      GFP_KERNEL);
 		if (!pvt->chancounts_dev) {
-			put_device(pvt->addrmatch_dev);
-			device_del(pvt->addrmatch_dev);
-			return -ENOMEM;
+			rc =3D -ENOMEM;
+			goto err_del_addrmatch;
 		}
=20
 		pvt->chancounts_dev->type =3D &all_channel_counts_type;
@@ -1199,9 +1198,18 @@ static int i7core_create_sysfs_devices(struct mem_ct=
l_info *mci)
=20
 		rc =3D device_add(pvt->chancounts_dev);
 		if (rc < 0)
-			return rc;
+			goto err_put_chancounts;
 	}
 	return 0;
+
+err_put_chancounts:
+	put_device(pvt->chancounts_dev);
+err_del_addrmatch:
+	device_del(pvt->addrmatch_dev);
+err_put_addrmatch:
+	put_device(pvt->addrmatch_dev);
+
+	return rc;
 }
=20
 static void i7core_delete_sysfs_devices(struct mem_ctl_info *mci)
@@ -1211,11 +1219,11 @@ static void i7core_delete_sysfs_devices(struct mem_=
ctl_info *mci)
 	edac_dbg(1, "\n");
=20
 	if (!pvt->is_registered) {
-		put_device(pvt->chancounts_dev);
 		device_del(pvt->chancounts_dev);
+		put_device(pvt->chancounts_dev);
 	}
-	put_device(pvt->addrmatch_dev);
 	device_del(pvt->addrmatch_dev);
+	put_device(pvt->addrmatch_dev);
 }
=20
 /*************************************************************************=
***
--=20
2.17.1
