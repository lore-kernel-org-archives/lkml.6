Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE8CECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6585520867
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="F7DsbsAv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6585520867
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388076AbeITIiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:38:54 -0400
Received: from mail-sn1nam01on0116.outbound.protection.outlook.com ([104.47.32.116]:8864
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726000AbeITI2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGPVsfs9Bkg9rnpyCtxVBNNmJC7GcUbB2sDQaBDB7N8=;
 b=F7DsbsAvJBswZBOkfg1REi4h7ivz3KSZYdWIplhfQ9+AV9aBmwtCxAJ9BM1Bl0Zmc38dAfnFBxf3Vk/VHR2TNF7W/DTkMewfV/fQvtXr7lpDMbXz4qll55E67dLCLsd7bgD8DIU/T2cbHeEc2R5i+2vaJsMIK4L9J3T6rl+AhMQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 02:47:32 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:47:32 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anson Huang <Anson.Huang@nxp.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 08/56] thermal: of-thermal: disable passive
 polling when thermal zone is disabled
Thread-Topic: [PATCH AUTOSEL 4.18 08/56] thermal: of-thermal: disable passive
 polling when thermal zone is disabled
Thread-Index: AQHUUIxHb+Wv1hti1kOfsA8W4I1VSw==
Date:   Thu, 20 Sep 2018 02:47:31 +0000
Message-ID: <20180920024716.58490-8-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:fThlaAiTZECj9sDJ2q6iiDgfEPWJ5lIVhJ4V8cYVw/PSGWJcTDqqlXPZVsnBSi3Yq/BDQp2fUtDZhBkEaiXykVUvdTBWDNXdBRmy1Ok4DNrf8SSxXxDej/micqmBtFWR08Kzg971F1CVX3PFtBIO/hLHkM+4tz924G5NJ18GlREdgspj3O7GieYsqltPxlHolaS+vYBfKkWnGyw0lJyfI/LMINJ+1k67ISiQfT1yZIJoLdLyy1yHhhxhyyDXrNqcaojNwJgUEaUIVAtua+0PRVePoGoslEzRngXmjpNmVysbmJyfdAjTomORrNmD23POM9TW78rQgv3mwOnawI1oDrhRNJqVOb59cBQd3V33GBI6oqzLOHZKJk14A4XjPRNNE0FKvrY+YL1Xpg626g7zZTWbm+aqNgQg4x0X/EAs4jSno7boch8ujifM9KjmkL/sjR2aZxuhl4V0DiNAMcDJOg==;5:pDx2kcYG7IQr8KijLttmxl9SkY2HU3mfomyw0CAk/+0hl1J20XzstrvFe4bS5UPNI0ofrsiSlmvHKQBndUTkOjKSG8jlwzpvqU8nxZ4LFt2hiZ8iSNVvD7NokCkgm3mBfZoIJvFe6hLFr2qa19xCu7yjgMNU5i/hk6EakxG8PPA=;7:6Cu9uI6YQgnwmYcY2y342h60kM5+w22LR0hL17Qc9h389HkT1oQr20qd4LJOtUkcXVJHFWoW45hoex9jygIqCyjM0zYJuDWigXKXSCM9k0ijYms+OH1kzJDpQOEh4CutYMPFUmZb2FJNyyUVhOxbrLYnsxSYD44NTavJ5/n0L/2/2zSahwneTPKfTfj1BjJpWP6Y3EG/uXzC8Ll0V90Y8NR5uqU6n037CxFecMeITsjuNiZb5FlVU/XqPxv9wY0S
x-ms-office365-filtering-correlation-id: 5465442d-64e3-4273-0ab4-08d61ea369a2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB08559C8F703983012992FF4BFB130@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(39860400002)(346002)(136003)(396003)(376002)(189003)(199004)(2501003)(186003)(86612001)(10290500003)(478600001)(2906002)(86362001)(106356001)(3846002)(5660300001)(2900100001)(6116002)(8936002)(105586002)(1076002)(53936002)(14454004)(7736002)(305945005)(81156014)(81166006)(8676002)(6512007)(68736007)(72206003)(6346003)(107886003)(102836004)(26005)(14444005)(256004)(6506007)(36756003)(39060400002)(446003)(476003)(2616005)(71200400001)(71190400001)(486006)(217873002)(66066001)(11346002)(97736004)(25786009)(22452003)(5250100002)(10090500001)(6436002)(316002)(6486002)(110136005)(54906003)(99286004)(4326008)(76176011)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: wjvDBbSTIxvq+pg7U7W0taj0rsuI6peSmAJNoWqZyckwZLAu+qq+ZcyG3HzJKXNxIJkmYEesmK6GRY2VWuqYQvVKGIOWPQXH0FThJaGxVsUR1UVF6Hu0hUmyb7fIZ5udf50Y7GVeLajv8XJehiJgfGH3NephflwP9YGuJsfosfEF1IE9EWgGLDRUBgnfP1i8OABBMVnPJvV/jyzcM6OhPQQLNoNpvOX7EK0ZTHdW1aKrpGGUKlhTn4smQeioNbpRQAF9gRy8RRQrGWsDCS9XPjyHmkcvErB6V0ORS/1LhS98NYBKxil7RIzhLMeNZJh6q7RaedRxfpRbazs/YAZsvIp/khIpqZvpBvPZAz6VJ+0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5465442d-64e3-4273-0ab4-08d61ea369a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:31.8671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

[ Upstream commit 152395fd03d4ce1e535a75cdbf58105e50587611 ]

When thermal zone is in passive mode, disabling its mode from
sysfs is NOT taking effect at all, it is still polling the
temperature of the disabled thermal zone and handling all thermal
trips, it makes user confused. The disabling operation should
disable the thermal zone behavior completely, for both active and
passive mode, this patch clears the passive_delay when thermal
zone is disabled and restores it when it is enabled.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/thermal/of-thermal.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 977a8307fbb1..4f2816559205 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -260,10 +260,13 @@ static int of_thermal_set_mode(struct thermal_zone_de=
vice *tz,
=20
 	mutex_lock(&tz->lock);
=20
-	if (mode =3D=3D THERMAL_DEVICE_ENABLED)
+	if (mode =3D=3D THERMAL_DEVICE_ENABLED) {
 		tz->polling_delay =3D data->polling_delay;
-	else
+		tz->passive_delay =3D data->passive_delay;
+	} else {
 		tz->polling_delay =3D 0;
+		tz->passive_delay =3D 0;
+	}
=20
 	mutex_unlock(&tz->lock);
=20
--=20
2.17.1
