Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281C4C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE1202077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cYMET7Mt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE1202077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbeIBRnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:43:23 -0400
Received: from mail-eopbgr680128.outbound.protection.outlook.com ([40.107.68.128]:38064
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728614AbeIBRWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Ytbx7twZWDv+rageEX1UaZBdi+/6dw3bLcrbgYjWxs=;
 b=cYMET7Mte/tc4zS7xkEz/3bX0VOL20VqaU+pts+W781QGSllWmk0OEN7da8vI0dmH2pgm2QFR8nF1OzzzZs1wpfnZQomMAu6Vbi192P9KcSJ7t8N4wM9ViUV+e+RM7+IOh1v2MnlINwBJxIYtfeflMmGDAtyYudktEZU83ZcOAA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:06:27 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:06:27 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 15/89] media: usbtv: use irqsave() in USB's
 complete callback
Thread-Topic: [PATCH AUTOSEL 4.14 15/89] media: usbtv: use irqsave() in USB's
 complete callback
Thread-Index: AQHUQr3B2Do9Bzvisk6hzSSAc7LSOQ==
Date:   Sun, 2 Sep 2018 13:06:27 +0000
Message-ID: <20180902064918.183387-15-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:Rvyojw3RymQa09xylMkXlNC3XwI9zaCxqicU/vjHC5r6zioH6RqlNAjVdp6NAvSVK76RH8nwpBMe7C1R87NBcHX4OjTKJuQ3irIBcSQWHBSoCCLexxC0Zdybvyx7J4qZby7NgHeVV3C7TDIYqvslwyDBaAq5u0Lb21TG1ibDsrvx9m9hPUS78Tf9r5W8ZNpoPpTkqr1EY57JCQp7GD0zWEkXpR1p9HTGi/CeVP7Eao9Br0bc22tVuHbUDVfHEbNW/QT273NYhcFQ7TKwgaomBpG8Q1gThZAgyx7sEMKxRoQnhQHzEEK3UChKAeNpuM157TVgDLspFhMYDmQNTcYFCOCrSJQLxYi5/bx3nBrdR+0NX+kDcsTBGZ5x1J5rFomEABf99aBMd5isH9+sM1i5iryy3mjdlvt04k4/e3NHSBXe7yQXyP89aOHbMFI9IEEoG0AxURrNoJ7lqkGhRlzZ/A==;5:3EZok4Ip1evFussaM9598sAsewBmaXBq4g/FeXPN76LFZMxuMu+CVUgD60ZPjSsACOZM9ZQw17wy/ehh8X2d2PQsI0tzsMaG8YoO1HWXF2WwDYMMptpIjbMsFX1l333aoUMwq5wfobBU1JiomDUyKQMkueK2TFsaYMsEehAj0CM=;7:nOz8CC+TeNSHAvdL9j03ID5I7xXL2jNJ5EDbCP5r0zn6O0Ki5SSUAjbQCVnbMy38fJGhoppQJwNA/ZrEnehbxJo5GDBqBzEtEsfF/tl7R4G1dGdm5c/rmPcaAHCDaET1tpBdWC9OF3IE36HNFHYXQvk2yPIr2xVUIGkXppZ6lLOrakELzh8Mp7YvZNcLgOJY6islKz0feWpuoqI9Bnq/nIhUdOdGkWpZ82RLg8KIn/u5PHMen8ni/L3e+g6BwQNF
x-ms-office365-filtering-correlation-id: 2b195369-d09d-4f59-2c64-08d610d4e492
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB06296EDE32529CFED66677CAFB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(95692535739014);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(6486002)(8936002)(6512007)(22452003)(53936002)(6436002)(66066001)(4326008)(186003)(25786009)(86362001)(2900100001)(107886003)(76176011)(486006)(68736007)(36756003)(99286004)(2501003)(5250100002)(110136005)(54906003)(106356001)(316002)(105586002)(10290500003)(72206003)(10090500001)(8676002)(478600001)(14454004)(5660300001)(476003)(1076002)(3846002)(305945005)(446003)(6116002)(217873002)(6346003)(11346002)(97736004)(81156014)(7736002)(81166006)(2906002)(14444005)(102836004)(86612001)(26005)(6506007)(256004)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: yEgBw4UCapRF2FdHed8HJAaDAOJxD+Rd6JFfTATaEmn3UBpgL84zr0QdUREbKGRBh4MVsrWwYsxPkE8nTbRhIUa4oMnxnGX0ny21t4YQLX62hI7GjmF12i2LLwaMdQg+x/8SxHkUcwHb9BFoVFO65fWbfqz89DF1dXqo+ilqwrIuq2jQ+XmVmiHgH03dvTAqZOONyIoGoT2FYsy4TJ5W9yTIHEbrrM89oxZkSLbywmys686VMFVyNyQB87a7jzGJkiPDaNsYlOqXP4zcX/ofolLRms7wTIXnqNwp6nKeHa1/Aet2/2lWRFrRLSXjc1SWGHmmbpqJJ1zDVGzrVqRniDYlUsNoaEIlhp82+oSlZiI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b195369-d09d-4f59-2c64-08d610d4e492
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:27.1658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
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
index 2c2ca77fa01f..4ce38246ed64 100644
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
