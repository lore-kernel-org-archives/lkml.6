Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19589C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA28F204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="S8yIRThD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA28F204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbeIBRZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:25:21 -0400
Received: from mail-bn3nam01on0116.outbound.protection.outlook.com ([104.47.33.116]:32952
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729788AbeIBRY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dtpd+HtDoeqmVzNKHQvKMU7vX0xpTtdntiDl2Dx9f5s=;
 b=S8yIRThD32JFeyaiawKTsR+IJwal5msSiTsem+W0kjbUi5b/vPZIiF+huBAIazpVJbCd9hjOHAXIbaK8toeITCWjeKFcaIaorQ2oBbJV8rdmq7Akt57WnyWvKEieFJ8MMydZ+YQ/WFV5TvfNpOhvi7TO+fhAz2TySOg8xWAbviM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:08:55 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:08:55 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 07/62] media: usbtv: use irqsave() in USB's
 complete callback
Thread-Topic: [PATCH AUTOSEL 4.9 07/62] media: usbtv: use irqsave() in USB's
 complete callback
Thread-Index: AQHUQr4R3ZsUBbLVfke/oJA+Y4PBhw==
Date:   Sun, 2 Sep 2018 13:08:40 +0000
Message-ID: <20180902065131.183542-7-alexander.levin@microsoft.com>
References: <20180902065131.183542-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902065131.183542-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:5Eb8oKUs4K+MakBgcNT04+SfydjKDih7Q8T1jmCbc3Cs3NZ/U2lL4MC4KMV63ZmSSwlswmduYwmk+Z2AqnR28hGylUqQRsm4Vcdn5GUqiBd+aKQLJFXGFlVsd0CR+i7NH2CNGyunh0v8Dt6kF6j2Wct/8n+diiVeWeYrklGLMYTH42jSy7Ac8bIEhKRxOrHi31iZEA4lbbh6s/ZTb53qpetthRHp00UUvl+tTsyCaP0B93qbrzzuQ1gqfknlpxJtWxp8EnZCFfq8ksOI6MZEltMR7dkGNB/WmFJm4IrlzPN7be+HVtQDkK9bVmYxmWZ5ZqQThoQEg0l2GUihQdWNbr4WzFXlzWZJffkl4K3sJDbBCDu8TFlNra0h58YpV69HwjpEzoTQzYkORsPQSRCAM8IJuI8UYrdLJYJpgh3MqZ9lH6blehe19W9rJaClBXU/DMAJrtLcfFhzmSgUvVy7lg==;5:L7lAOHlhnJSXVo5MlNL2DNdD+VaEhptWw17gsU3vEzFC/HGH1WChNovuUk+haf3FP+VcemiXVMaoTxHN2fkZwNrFLRq2Jy2NO5JDGZW9aLcMjDqbayYI85c45oTeHcWlMU956p/nklkwm97I/S6JLBErWK9uYc9XY5lFMw0y1FM=;7:YgB/9hq9ovjmQp61lSt1sM2JDLlrvVGwujbBg48b19bqsMlK/0ZobtKaXNT5uotRoWJrt7IiHfUH1TXJKEcw3kYp9vbD7ZRlc64g9IDJLJwuTXM2JK7Mt+XTzOqbFksTG42kGAuTqd5Wec7c0afPow9v9jnq++JEfeAjaOYXcI5LFIs+wKl7gkXIPtQxu/UEBG315UU1+ry7G8D/NhnZtPGa95I3kzzfq3CSGv9IHlwhkQzgpY8mAUMHSIDtdOX3
x-ms-office365-filtering-correlation-id: 060fec1c-889b-4134-81a0-08d610d53ce4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB04696138D0A439D19A96CC30FB0D0@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(95692535739014);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(136003)(366004)(346002)(199004)(189003)(110136005)(68736007)(36756003)(316002)(72206003)(54906003)(2501003)(81166006)(81156014)(8936002)(14454004)(97736004)(10090500001)(25786009)(106356001)(7736002)(2900100001)(4326008)(2906002)(8676002)(105586002)(305945005)(5660300001)(53936002)(1076002)(6116002)(478600001)(5250100002)(6666003)(3846002)(107886003)(10290500003)(76176011)(11346002)(99286004)(6486002)(6512007)(6436002)(2616005)(66066001)(6506007)(22452003)(446003)(26005)(186003)(86362001)(217873002)(476003)(486006)(256004)(102836004)(86612001)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VyMhUZrE8NARyg3K52iAO53A+TJB7svmsJSvBCkDo1w3CdWIF6A3t0tdvkMU2yhW5Wdp6CS/F0t55HAVSkXN84ZfQyQdpc2VOqRw0dg5iExplhipzGpSsfKvR3SJ9fO/IOaFJ9S98ul+ssQ+v/IzmRyzxHaKlLLRzzngL8BlRSr5LkHVqjaoG85CRSS7edBw/bznPz93GTjCAVDSUMKz5FeCNhGcZhCqfjSKh3HFn83RzmE41SInBfXn75k8mN1ItSLRidBxbxyBNvhlo7he11jOUmwcauCRE/4wEEwSZD5HE6H4q0OMbrg8DcemENBohfAEV9QN7ytdrfkeeCCSHHT6H/QSZHPd6oI8Ok1BeJg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 060fec1c-889b-4134-81a0-08d610d53ce4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:08:40.5401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
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
index 9db31db7d9ac..647237d797e0 100644
--- a/drivers/media/usb/usbtv/usbtv-audio.c
+++ b/drivers/media/usb/usbtv/usbtv-audio.c
@@ -126,6 +126,7 @@ static void usbtv_audio_urb_received(struct urb *urb)
 	struct snd_pcm_runtime *runtime =3D substream->runtime;
 	size_t i, frame_bytes, chunk_length, buffer_pos, period_pos;
 	int period_elapsed;
+	unsigned long flags;
 	void *urb_current;
=20
 	switch (urb->status) {
@@ -179,12 +180,12 @@ static void usbtv_audio_urb_received(struct urb *urb)
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
