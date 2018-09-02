Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF2FC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C46D20855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QkqXUoB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C46D20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeIBRTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:19:34 -0400
Received: from mail-cys01nam02on0094.outbound.protection.outlook.com ([104.47.37.94]:40784
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726155AbeIBRTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Ytbx7twZWDv+rageEX1UaZBdi+/6dw3bLcrbgYjWxs=;
 b=QkqXUoB3uM1gkXugsqFUkRaR6Q0BgR5vCI7KWhqUq1+JiK5U6S1XbX7bo+9ONvGCpMPu9GShIzzg8KQ2AEpaxkVwTpKPbOi6xZ0QwGJumBYWuWyvX9ArshDi9Z91iDVtZPxBw44Pak+SNyz7L8vVAxUG+VUiPkNTv7T2c/fc830=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0150.namprd21.prod.outlook.com (10.173.189.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.4; Sun, 2 Sep 2018 13:03:27 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:03:27 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 023/131] media: usbtv: use irqsave() in USB's
 complete callback
Thread-Topic: [PATCH AUTOSEL 4.18 023/131] media: usbtv: use irqsave() in
 USB's complete callback
Thread-Index: AQHUQr1XMJiNwqt7F0W1mA0oF8IsIQ==
Date:   Sun, 2 Sep 2018 13:03:27 +0000
Message-ID: <20180902064601.183036-23-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0150;6:/eO9ufLs6g97WI9Z0flRepJg7faUIesgH14J/0tpeJClp8yQ/BQvvqlCDgG1cJi6jKzaj54SnsB1cei3hLpJwQ6deC6xvDB/zUywz8JIXpcPPyXZ+NT8MJzuSpuCoyaHyf+Pm1E6+k8Xs0NZKFSsicFy5tbc0Ji7+8yD9wLnZE2EJ+72qiOrwVuoo6TXw5dgdrBbHeyamsvWwj7/JA94isljldYq/IsvWzpNaC7N8Uhm21vbpCU9M9CKfUG/2sOSoUbXMVKMAujxQXjQbI2pto5p1cMAouAiU/ArceW0P/uPa631Y/AlaDKbCnlwXhphc2X16i3Ql5YfBCjflWzoHBm+QqJk9Ms6B5sZQUycogbm1EZavFX94XjZ9ywDT1GGPdVkqyauAbQcGL+AauriM7aEb3SIi/mZfcimomyKSGXHaRrK/FtszmxL1agMaCnZ0OPNf1ptcuIlprlJsth3Kw==;5:uaUU2aBL+w8WDYadBN0MX/fIKcgJ3BBVhPIqQ7SNzbtcd8kX+IiOY09nCaje09SiY5slKrKrWErVPVkHesvs71YES/9IegTW7pnTVu10RzLtdoejYeEPVUfySDR5d+mbkuG8ubtS8GBNuK4v4sNlPjJ7Whtq1RCrXlCCUuQJ+ew=;7:eFsSdZKlJAbEv81dPAcAVGY5g5j6qOT2k6unOI2wDWNgNgawEYlxvJzAcgYO8cK3N7wI3DyvmA50BguqCbnzMh0rSQbYwVpGUywbG2F5m+PpMdRkKGsVF96QtG4wNMEje8jQeeJ9C7WcsGanoLlPdVef/jqBuHymtEHukfKv/F4bhtkZcQRDEnfLAsaDFOUPjw3/5dOS5nJbUJGQdI+sFKsGXueAiBF6JrqJAXLT0RNQ09DFpg/nMB16skurhv8s
x-ms-office365-filtering-correlation-id: ea0c15df-a882-4b91-01f4-08d610d479a0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0150;
x-ms-traffictypediagnostic: CY4PR21MB0150:
x-microsoft-antispam-prvs: <CY4PR21MB0150E635BAE3E22535D79846FB0D0@CY4PR21MB0150.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(95692535739014);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0150;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0150;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(256004)(22452003)(2906002)(217873002)(3846002)(68736007)(10090500001)(6506007)(6116002)(1076002)(6436002)(102836004)(486006)(53936002)(76176011)(106356001)(105586002)(14444005)(7736002)(305945005)(8676002)(316002)(5660300001)(6512007)(99286004)(36756003)(4326008)(97736004)(5250100002)(2616005)(476003)(2900100001)(11346002)(186003)(2501003)(81166006)(26005)(8936002)(81156014)(110136005)(54906003)(107886003)(66066001)(478600001)(86612001)(14454004)(6346003)(6486002)(10290500003)(86362001)(72206003)(25786009)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0150;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: i1T1F6TjpNu6Viy2pL7qPi4EvU//hJA8xaZSsTsdIfDyyQSGk6Ly82oDVsUPEU/CpuczMBrHKdq6tLGEFAqOXrwQoRYUvhof6brnQn8YfvJGls6CXx5/fdw9TKAfCyCFBxHSM9FUI/1mE+qpJJv2bLxdU6HJREr3aVI20tNfYdc4b86o7Npkoza/X+62Hem8Q7ttTGGV3PZ0cnqnfD83xPQD/gQkdttZ61wLt171AATmCcnDhYOgfDy93LL/FD0zyPt4M/VA6PQL46fxwTX2rv5DpCcVL1DzaS9JBDCpSb4R0v/m2acZOykzCCqGEzf9N49fXwSGFnLHn8oyTqwiUzsypXqzNPzfja4F2r337yg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0c15df-a882-4b91-01f4-08d610d479a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:27.7683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0150
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
