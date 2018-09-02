Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C45C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A6320837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KBgwagoP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A6320837
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbeIBRkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:40:23 -0400
Received: from mail-co1nam03on0123.outbound.protection.outlook.com ([104.47.40.123]:41136
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729554AbeIBRaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuKZI6n+lmvxf1XHxBPEVLgnvFjqZn9b0fpe7jJd8Q8=;
 b=KBgwagoP7OaewYiJ1+8ANmIvtah2C7YOoDEfX8Vx+oNIdJlhenHu259BQEChGgrNLoeFg5P5ZNJDwE/yBRXqA0AGW1lUrGRyY7J5jWfcYewStdx5WrY8V6xBeO+EOOogLGAJc2FczhDTBnbrze/IcZkY91Dlye34cT8BzIpmrQ8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:14:21 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:14:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Zimmermann <tzimmermann@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 16/62] fbdev/core: Disable console-lock warnings
 when fb.lockless_register_fb is set
Thread-Topic: [PATCH AUTOSEL 4.9 16/62] fbdev/core: Disable console-lock
 warnings when fb.lockless_register_fb is set
Thread-Index: AQHUQr7cSWnyiD87w0eQzivsE90jzQ==
Date:   Sun, 2 Sep 2018 13:14:21 +0000
Message-ID: <20180902131411.183978-6-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:aEOwj7kfOM+5yp4oKHeXpX+VzfP6xQawjOQDWJsd62EHAwb91pxb1AdZGnjJETCHOMTgMAYPJ5xvcbpvdEZDrD/U29NAUSKurT0MmvqEtarbO1C9DpK3+PRKOecntBHoVCRw1ds5msg5/V+z9ZZQhenphoH9Aso2RAmyGGV6qpeAWg43KDU5ChxpJT2bIPCxRIRoE0xlPO347QRLwPTtXOfR0v9PfvvJqb1alKXGiUcS5UJcCuSV6r60WxQ2GbJca59/2xmHxyPRxNeYUekQ2dZPmPkzC/qICWq2S9DDmQ1VzGO5UVmQJKlceAyxCVT+of/4Wpn3tdo342TfvT98qPeqSbhl3r5IEQIzLkek58+t+vsINlgXEC8d6FLI5BW1imX4ptNIu7PJCM4PMT/DAn6WhUgNtZopX18jwHqu3FBRXh6XFCjw855VNeqwQmJDj/YAB9EGUlvxhBUKTeQTcg==;5:GGvzwCI/YrBlRI7/RicJbKA9+AudqRUPdYGAKhNGJMx9+cjm14vmx5M/qunUOzxHRQknQbtTGHcRC36vFwzbZoLVp51NM31DJucGIns7QbxXWb73O/kxemmhNT4suKzdufoRRZX8bMWnd+CRaCBTPFGlGeE2sh9Qk+sp/RryyKA=;7:h//PBIrtuBcDULNh+/fCOG8uRl7wP0yWIA+stIegTn5eaJ0Qpi67TzJdzhwfH3Dka0AaUHa9IDhgKWNMFynOwvaSovPtPHLXyqLgo2qmzlBAUJzy4X0ErW7avM6TwE3laMmFBDwMy5K9+SQAodB2JCPMMTkFfQhd3XOilhAEqmkyaLm0hNYy80kCXnnSGDLS5GvF2M3r54XwM4nFZ/4lTnsvJawbTav8d7MqnDEbwBlbLnV57Lb9IbGLX+/e5dBe
x-ms-office365-filtering-correlation-id: 76e075bf-4ab9-4cff-fa7a-08d610d5ff5a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01202AA19481FA6553245E2FFB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(376002)(396003)(366004)(189003)(199004)(106356001)(53936002)(72206003)(5250100002)(22452003)(97736004)(6512007)(10090500001)(2616005)(2501003)(446003)(11346002)(478600001)(10290500003)(476003)(14454004)(81166006)(186003)(486006)(25786009)(4326008)(36756003)(102836004)(8676002)(81156014)(105586002)(8936002)(2900100001)(99286004)(66066001)(68736007)(110136005)(26005)(107886003)(6506007)(5660300001)(76176011)(14444005)(54906003)(316002)(1076002)(86612001)(3846002)(6116002)(256004)(7736002)(6486002)(86362001)(6436002)(305945005)(217873002)(2906002)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fqrvjtA+8vXBEM7qa2ahVBMEVn14qFil8iws0c3pvLDMSMu+YpAtEBHp7luxYq2T4BIhR6XXereeilmQkQrWuP3AhemhVqy/9T+3zi7wkApkxYWvnfAjqwmi5R8MS6Wfk8c2Ct1xW4HKVqXuokXLjEHP3ZZh14JNyDILxwOsp6TTA3C75cPCzYYf96gMbpHouyIZAgA3Ci9WG9FBqlk2QKaQSDS+chEKU4+P56R990r6sgZX622+IxyBKcUoX/Ih+sWolQhna8z7DFCY+IkTzWNBNm8rylFHpD3d4b36xvYj91ju25D6UNO8IWEq5gGDHnWFijRFbv+jel6+1bkUyI8AvU9mVzH87mM3tkb/B0M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e075bf-4ab9-4cff-fa7a-08d610d5ff5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:14:21.6363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 3f2ce54284a60500eb6dca1dca6fd615df8f9aa3 ]

If the console is unlocked during registration, the console subsystem
generates significant amounts of warnings, which obfuscate actual
debugging messages. Setting ignore_console_lock_warning while debugging
console registration avoid the noise.

v3:
	- manipulate ignore_console_lock_warning with atomic_{inc,dec}
v2:
	- restore ignore_console_lock_warning if lock_fb_info() fails

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/video/fbdev/core/fbmem.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fb=
mem.c
index 76c1ad96fb37..34e8744a52e0 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1682,17 +1682,22 @@ static int do_register_framebuffer(struct fb_info *=
fb_info)
 	event.info =3D fb_info;
 	if (!lockless_register_fb)
 		console_lock();
+	else
+		atomic_inc(&ignore_console_lock_warning);
 	if (!lock_fb_info(fb_info)) {
-		if (!lockless_register_fb)
-			console_unlock();
-		return -ENODEV;
+		ret =3D -ENODEV;
+		goto unlock_console;
 	}
+	ret =3D 0;
=20
 	fb_notifier_call_chain(FB_EVENT_FB_REGISTERED, &event);
 	unlock_fb_info(fb_info);
+unlock_console:
 	if (!lockless_register_fb)
 		console_unlock();
-	return 0;
+	else
+		atomic_dec(&ignore_console_lock_warning);
+	return ret;
 }
=20
 static int do_unregister_framebuffer(struct fb_info *fb_info)
--=20
2.17.1
