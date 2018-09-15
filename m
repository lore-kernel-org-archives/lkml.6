Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6A3ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394BA21477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Kl8C0ps4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394BA21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbeIOHFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:05:09 -0400
Received: from mail-cys01nam02on0095.outbound.protection.outlook.com ([104.47.37.95]:24416
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728607AbeIOGr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5l9noCVJ4wwIhVGeFsAyJOzC5I22LuCJcyBLahKtOs=;
 b=Kl8C0ps4wlZK/M3Bn5k7M5LMN0eKDaVqAVMbgIZ/yyybHmctuTMa7PJ7Xkj50oCLDCg+cu/immUY1SXLlNuaVSWzXbFfaneWku8FFs+knnXz49NQ77TE66ZKVxBofavvAF8PH679menMbwaHXSl1TCVRnP7LSBftPRDHqSH6Cmk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.6; Sat, 15 Sep 2018 01:30:55 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:55 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Tuomas Tynkkynen <tuomas@tuxera.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 56/92] staging: bcm2835-audio: Don't leak
 workqueue if open fails
Thread-Topic: [PATCH AUTOSEL 4.18 56/92] staging: bcm2835-audio: Don't leak
 workqueue if open fails
Thread-Index: AQHUTJOvaPBSaxQfi067pAqVpf1xSQ==
Date:   Sat, 15 Sep 2018 01:30:29 +0000
Message-ID: <20180915012944.179481-55-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:n10w/Kj6WDGJm0LPXbv314YyjKKRWqHvc0+w9EQqLUyNBNQtuDqaaOqlgimMyOZtLob5HrPy00k33anQOHr0+fBqyiaFPR9zW1rZyzE4Ts0EDQ5gQSc4Tf8QFr4oFQ5kbnKhikO3cOxoKPk29I60ga+tOaOWtEr6fTWNzPz2637wvH8RgNZ2AvxTyBmgcjbBGjgm4s39+v8qJYOCWEj18IVH6pd+n+T+2krMYhIbBp7lSOYYvgWfivPEOfIAn+b4oRFxUHYnKb4ctIQUzTPQuzXrM7YKd8aIN92G0ZHuShRuWFmSPuIfdvD2osWQIGJBuaqwUsxU3/VqIpeNcuKx0k+UojK3kigmlHeCpoDxlSwVT0JZ3qPVZ0nqN2vJ1au6fWaPBpOVtjBpbZhTic/Zvm2WzsNg4fimAdw+hDtCZ8zkfblYiqhryjRpzpv+/F80+vI2bQZF0pdZjDeo3sSZRw==;5:QdoorEUwtrs6ccuTtLV0ysFy0uulWte1VzSIfmemfV+4tty87P+kj3Y4UFq1ZVQCaq/SPa3KkanEgnGT5nMB6dPR3OoJCU+rGBwl16d9mABITjDUj5Tf3vj86nwUDKDUqkM/qQZcg/VdP57uXutvzwkt3favTyN8UHmkSPxIBMo=;7:MhDSiwWPVscQipX1GB6y3b+3JSkh9CiRTk8kLjqhwwna23NFCY36XhRObiBHDIdBZNbAweVJRIX6dpk1nNkkm1RiSXXSHZJO3yRkwMNFrDa/pnNsWJu79c1ETF676zF8tHk87bJDTTOo2vkl3Mzy48ITHy8vRaI+g5okogHls5W7E1AoGB3y31mh7FzSXAln+JUDbWMMbdMcBDjboaUyzYfLyrCCdQKmj2MmqfAk2VUPCPPXOpjYqtfsMR1LRpNv
x-ms-office365-filtering-correlation-id: bf04ae92-4277-4cba-4e23-08d61aaae1ef
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
x-microsoft-antispam-prvs: <CY4PR21MB08569616122A77B618FA114FFB180@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(346002)(376002)(199004)(189003)(36756003)(6116002)(486006)(316002)(3846002)(8936002)(22452003)(446003)(11346002)(2906002)(476003)(2616005)(6512007)(107886003)(53936002)(54906003)(1076002)(110136005)(25786009)(102836004)(66066001)(4326008)(217873002)(99286004)(14444005)(76176011)(68736007)(575784001)(6666003)(86362001)(5660300001)(6346003)(8676002)(86612001)(256004)(186003)(81156014)(81166006)(6506007)(26005)(2900100001)(10290500003)(478600001)(7736002)(72206003)(305945005)(97736004)(10090500001)(14454004)(106356001)(105586002)(5250100002)(2501003)(6436002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ddSGUKBphBJlKZGjULzo4kx56CwPFD9vFGeRlVk+Lq91JCbHp4tEOCHgPsTDLYZeq6wQi4SFFN9WzS0Iirys9FXMheJALOAXhOjiU2aC+/xR3tO9GbnzYLWHyXmfyBnJR5q8m2uxaorZA/lf5EgWo2W+Jpf8BRPPN7+K4/hT8I+asxyTMPMmJGsPlLlk8fbarhPUiQkdoZmXFMAJf1U/2wiRJj8V/2aoSxaqFzQ8Alb4VfyorWfqtIj7wUh6f5Tb64fcREUKrHAMHc55pYc9a+ngywQlcJ0PYppzJkgA2Rmu+FF6rUfcy4XFVgnQssLm4V8pX5Oyd9XYS3rDu6txasWTW91YcD7Vz7soAadHcBY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf04ae92-4277-4cba-4e23-08d61aaae1ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:29.0574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tuomas Tynkkynen <tuomas@tuxera.com>

[ Upstream commit 678c5b119307c40f9a17152512f9c949d0ec7292 ]

Currently, if bcm2835_audio_open() fails partway, the allocated
workqueue is leaked. Avoid that.

While at it, propagate the return value of
bcm2835_audio_open_connection() on failure instead of returning -1.

Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 .../vc04_services/bcm2835-audio/bcm2835-vchiq.c  | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/=
drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index f0cefa1b7b0f..b20d34449ed4 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -439,16 +439,16 @@ int bcm2835_audio_open(struct bcm2835_alsa_stream *al=
sa_stream)
 	my_workqueue_init(alsa_stream);
=20
 	ret =3D bcm2835_audio_open_connection(alsa_stream);
-	if (ret) {
-		ret =3D -1;
-		goto exit;
-	}
+	if (ret)
+		goto free_wq;
+
 	instance =3D alsa_stream->instance;
 	LOG_DBG(" instance (%p)\n", instance);
=20
 	if (mutex_lock_interruptible(&instance->vchi_mutex)) {
 		LOG_DBG("Interrupted whilst waiting for lock on (%d)\n", instance->num_c=
onnections);
-		return -EINTR;
+		ret =3D -EINTR;
+		goto free_wq;
 	}
 	vchi_service_use(instance->vchi_handle[0]);
=20
@@ -471,7 +471,11 @@ int bcm2835_audio_open(struct bcm2835_alsa_stream *als=
a_stream)
 unlock:
 	vchi_service_release(instance->vchi_handle[0]);
 	mutex_unlock(&instance->vchi_mutex);
-exit:
+
+free_wq:
+	if (ret)
+		destroy_workqueue(alsa_stream->my_wq);
+
 	return ret;
 }
=20
--=20
2.17.1
