Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFC5C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D4A2077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="F86tMhbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D4A2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbeIBRg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:36:26 -0400
Received: from mail-cys01nam02on0104.outbound.protection.outlook.com ([104.47.37.104]:45376
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728464AbeIBRbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrGYJ0EEc3JfqbLQHpEh0BehxdoGOiVMBtS9cIu1vgw=;
 b=F86tMhbloJ2aqi1bb1LjIkpzZP95xOsHm1AhTXyTxhKVoVrH548Zyby2U1nm8c3o58CHnYEqh16Jw1Zf1xnSaDUJtrjdLabUsQYO6j/8k01m0ZV6VV/bxANHZrAE+bz/ZH77RoaLz/DFC/0jnWSEBepACrfJ0KQBu8PCFRGqeGQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0184.namprd21.prod.outlook.com (10.173.193.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:15:44 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:15:44 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 06/47] media: usbtv: use irqsave() in USB's
 complete callback
Thread-Topic: [PATCH AUTOSEL 4.4 06/47] media: usbtv: use irqsave() in USB's
 complete callback
Thread-Index: AQHUQr8OJuJDZHKD7EOUt9DmhKVLCw==
Date:   Sun, 2 Sep 2018 13:15:44 +0000
Message-ID: <20180902131533.184092-6-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0184;6:P7j2jFtO3mV0SAEbppwpRZg0zYN18EujtOQggXIZkjKgrYg2OcoFHUNnQ0mYrgw5gDIe1DyAOt4PgAVloARR6c+PfWugKfGX22kLn1pVgcYhKI6vY5vJ5Z3m3HoOd7rLJn8sNgQtO+YrPgSMmR7nWHrs+7pr314kR5l5Jv3iW/Ib99pbGh0Fk/Byd8fz1acIU/3NqHjjZjsVvOWM0ppXdAY0EbrLTvQ+vm70xAjYPmt39j84YYEisqOiJAus9P974Ssr9gk4Kf1ockjS/uwAGjajv0cSCF5fkxDnXIFH5B55q448izjvKgOikrpsu1tVt0pAraMVP9PvhPK8UMcB+iGcHqAssaQjZsuZyPuZ6+fsMKKuMghhnbXd2K8W9OA1hFRIaSFcEAOWfukb+oqtPAeDIQLcCVAz9DPrjK40g3KxLKmYWki3eW7r7ck76FLFQzM6gP75zxGP9DqrCtntKA==;5:7Ch8UeTH0/260UP+W+Oh9pcgnvPHD7BSgoTw5Yhpen334G0vs7xtnnRuwGrjrUaGY/ohixHJVXfi2I3FDFcBTYtRmikpigZpF5mY2bOPkqmjW/G+0qL+/5VueGPSnM4sriqp19xn8+SIaPH5uw7msoUtfKf/q+RR9wEoeN1VYCU=;7:Hm/DnlTR/adbLoPdyJKSNg442fodiRhG5uagLRFBEeh2NX9+2BNESyMy954Z5PTqkUmsLY30Z4ypw17f+ePH5olvdWpfq8TbFqx404CwuL38EikaX2awEVcLdDVlIx8LsOgq5XBMX+KtwRZTQ0ZLrvaf9d2j+Onszy/EPeC/TjyGOxSYFsQvIcVFwYweTpG62dthhrfAonTVOnRrOZvdv6es21hHLpyEmLCZOrPjq2Ec2rr6twikODoEliUrozK8
x-ms-office365-filtering-correlation-id: 7129c375-38bb-4d57-f263-08d610d630a4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0184;
x-ms-traffictypediagnostic: CY4PR21MB0184:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01846B0A921CA5D8CE6D96F5FB0D0@CY4PR21MB0184.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(95692535739014);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0184;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0184;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(2616005)(10290500003)(68736007)(476003)(81166006)(11346002)(2906002)(8936002)(76176011)(3846002)(6506007)(5660300001)(81156014)(1076002)(8676002)(99286004)(102836004)(14454004)(446003)(2900100001)(86612001)(478600001)(186003)(305945005)(7736002)(72206003)(217873002)(86362001)(486006)(4326008)(97736004)(6436002)(6512007)(53936002)(107886003)(22452003)(25786009)(105586002)(106356001)(36756003)(66066001)(14444005)(5250100002)(316002)(10090500001)(256004)(6116002)(26005)(2501003)(6486002)(54906003)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0184;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: lhz0QtfEaP4JjrPihsr3xGhv+12FIMplVnXT/2mlYDorHB4hWT8d+B4EobHlGzRxhq7/G4zNzpba+GPJ2YYt5nLK/nhOLhlPWj1ZbLI4ySFtZ5ASONBI0PnJjkgtGuEYXtO2wWzzcAQzviubQHy8E2x3N/EtSCMwv3wQcmfQjX9CLu/2OVS79AdPRYU7IjA6C3xXci3YGh1IBrS6DgQZO3MAiWMH//jXCbQHyPWII3OPY/FkC9rhyTvtVteRi4pqCgnaykodIVamDn+Wuq+vJOYjUlLJIGD3JTC6Ae06GXAizdP9LbEOVSwU1WNWPu7uwuwBPkCWcC0ekL7kSnEa0+i9AneYM31OUNW66LhZqMQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7129c375-38bb-4d57-f263-08d610d630a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:44.2944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 320905baa1dbddd3991c287432176d536e1d5b79 ]

The USB completion callback does not disable interrupts while acquiring
the lock. We want to remove the local_irq_disable() invocation from
__usb_hcd_giveback_urb() and therefore it is required for the callback
handler to disable the interrupts while acquiring the lock.
The callback may be invoked either in IRQ or BH context depending on the
USB host controller.
Use the _irqsave() variant of the locking primitives.

Cc: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/usb/usbtv/usbtv-audio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/usbtv/usbtv-audio.c b/drivers/media/usb/usbt=
v/usbtv-audio.c
index 5dab02432e82..ec1b9a1432b1 100644
--- a/drivers/media/usb/usbtv/usbtv-audio.c
+++ b/drivers/media/usb/usbtv/usbtv-audio.c
@@ -112,6 +112,7 @@ static void usbtv_audio_urb_received(struct urb *urb)
 	struct snd_pcm_runtime *runtime =3D substream->runtime;
 	size_t i, frame_bytes, chunk_length, buffer_pos, period_pos;
 	int period_elapsed;
+	unsigned long flags;
 	void *urb_current;
=20
 	switch (urb->status) {
@@ -165,12 +166,12 @@ static void usbtv_audio_urb_received(struct urb *urb)
 		}
 	}
=20
-	snd_pcm_stream_lock(substream);
+	snd_pcm_stream_lock_irqsave(substream, flags);
=20
 	chip->snd_buffer_pos =3D buffer_pos;
 	chip->snd_period_pos =3D period_pos;
=20
-	snd_pcm_stream_unlock(substream);
+	snd_pcm_stream_unlock_irqrestore(substream, flags);
=20
 	if (period_elapsed)
 		snd_pcm_period_elapsed(substream);
--=20
2.17.1
