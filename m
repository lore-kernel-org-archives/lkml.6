Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE25ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2DD20866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jCJB2nD7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2DD20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbeIOG7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:59:45 -0400
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:38374
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729373AbeIOGuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31y6LsX43HPgjEAfoulSIlulaX4BWwf0FeTsYmay6J8=;
 b=jCJB2nD78QpE/u38fjRzjI8b6zgG/2QrFJb0z4NkiM0cZKMfSMCC76cGFkwF4QWVAw3TJCm0c/42NsGVDb987YbPkL+rOpT/dnBrM1gbQ9HC9b3JOpsf2pwoX78J/cdCzSZ2209yAM1sie9Q8kgf7JbQb64AcW32NiB96kd0fgk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:33:21 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:33:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Tuomas Tynkkynen <tuomas@tuxera.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 37/57] staging: bcm2835-audio: Don't leak
 workqueue if open fails
Thread-Topic: [PATCH AUTOSEL 4.14 37/57] staging: bcm2835-audio: Don't leak
 workqueue if open fails
Thread-Index: AQHUTJQFHuqsmcMktEaE3AJy0pGfyQ==
Date:   Sat, 15 Sep 2018 01:32:53 +0000
Message-ID: <20180915013223.179909-37-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0471;6:H/VXUlpElMARwk2z/TMrNbKWX/6VNRGVrex5aJP25bjqgpMaKPbeLnXVOs8fj0F5jhNDOMo625rYVrR0n5MXXcacnAJ4wG9bh2LMIOH0mmCXfwT4O61j9A1tLRWBVsNZyy2KCqk9yFJnzwALFkW8uPNOUXe8KdMxVHbYZkkEcjyiiE0CBoH5kOoPq2QYjyYwPhqAbcn8pfuFyDfvx/D0ESUD4YrQW6nX7FV49ULpCVCic3TVixkfYUyLuRvmbDodKWWh12XExoAGWZmf/2bwLAKpViF5yHjjUblRIyO4zBRdA9EIFzv/pF6CfaRlnHt1olJx4dXdxCl082qF9yIsq4mMH5siN0Ja/ugW2x3M2Zrno8c1vkKNT5PS+otY8ow74FTJIjTt6hg+Rb+DQa9xrGOLwgmDpO0ofM4supKCEhXzEpPvzJO3Ozb46c6ZKwD82i7DYXmJej9/xLKx7VtKWg==;5:5dUtxZBTfAnCtuzEsAGKwTfYL2oPwXbCXeh6Kvt1LLn9qeIXnYwWOPZunDqJCZa5lXwEF3+v4splX4c8PHdlP0X/1iAdQUMzr33Yf1OxeHPVZCizEiYy4IgkuLQSnC3J9oq5I8+lq5iVDzvnZSqEx2omOZR34zBKX3Kz+ZL69x8=;7:afxKgYpmAkadM7Z5Cgj7O2SZYYUbLOIGx0szPZaqKwmXTBbQATZRvvvNdPT5M0e5BMvPfUoe6LHAPA0QkUUkwqb+S6zAQ84lUvqte7Dcf77As28415o+m1k3crnGr0sESU9b9fQjZb/nOX2niTZNaRYLh9e2kDVUuqHU6aZqJ15zxoCRcQZQTZEJy8fpEdIhnnGBmnkX/MoPSXL6VL8t7GKhpb8RXCC6HBHH4EyOd0quUJ1jj5DNalNI/N6YwqpW
x-ms-office365-filtering-correlation-id: 23f9021f-8210-472e-efda-08d61aab38b1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0471;
x-ms-traffictypediagnostic: CY4PR21MB0471:
x-microsoft-antispam-prvs: <CY4PR21MB0471E2ABDA2E827215B22990FB180@CY4PR21MB0471.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0471;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0471;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(396003)(39860400002)(346002)(199004)(189003)(7736002)(8936002)(81156014)(305945005)(81166006)(8676002)(66066001)(316002)(110136005)(106356001)(5660300001)(6666003)(54906003)(86362001)(575784001)(102836004)(86612001)(22452003)(53936002)(6506007)(36756003)(107886003)(97736004)(76176011)(2906002)(476003)(99286004)(486006)(26005)(1076002)(217873002)(6512007)(186003)(72206003)(10290500003)(6346003)(478600001)(256004)(6436002)(11346002)(10090500001)(5250100002)(446003)(6486002)(2900100001)(14454004)(6116002)(4326008)(68736007)(3846002)(105586002)(25786009)(2501003)(14444005)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: mdjziaqY2pyWw13+H9GPFBZKC5drhURspvxuVoQlwQO3annZ2HC+9xhf6YGepCDY/4yX9P1jm4ImQyeVD0/F297yafEUi/rpJaHKLVjMvDm0T6bAfQ2T5W60so0ZcfEy2rioVLt4Ew9np1vq6TOt73CHyze+XCQhhFQeaE/f82OjlvPMUZslAB8FtsxeQU1XQKaYbed7qpEF+7vjCCfnSZK7817HSqM8BFCs9NTqe9UG5gRe1ln/KSbvRBi61JZ2fFtf0VYkxi5eFeusQ8nwmwhKJkjDykS8UOKKcUkUXo1IpElOcwTbtxtItFFBOTni274B8hb752mVw694TrIv2zqBIv0JfLgjm+Yd16X8Sq4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f9021f-8210-472e-efda-08d61aab38b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:53.3523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
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
index 4be864dbd41c..9eb3b625a1b1 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -442,16 +442,16 @@ int bcm2835_audio_open(struct bcm2835_alsa_stream *al=
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
@@ -474,7 +474,11 @@ int bcm2835_audio_open(struct bcm2835_alsa_stream *als=
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
