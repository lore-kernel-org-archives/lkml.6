Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927D8C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EACA2077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iUY0/G9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EACA2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbeIBRXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:23:03 -0400
Received: from mail-by2nam03on0090.outbound.protection.outlook.com ([104.47.42.90]:31424
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727712AbeIBRXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCnaN5+IfoVfpGjO2CxpeLEG347N6exa0IxzmrA0FBw=;
 b=iUY0/G9lh/ZIenWeEAqabBR7Al+DiMOrF+ph5o9hg6sZIArtbHJICSdd4pg0ggsA/e4RMYOLpbctZbAFHoCXqBxY3SmFOuXjdxHwS1j4Hl34q99VHRVjH7leEBBiF1/oAMj+tNhUGq4uZu2wDTPFcGvzoUY60iFVN/VQ/muZHqw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Sun, 2 Sep 2018 13:07:07 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:07 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Zimmermann <tzimmermann@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 32/89] fbdev/core: Disable console-lock warnings
 when fb.lockless_register_fb is set
Thread-Topic: [PATCH AUTOSEL 4.14 32/89] fbdev/core: Disable console-lock
 warnings when fb.lockless_register_fb is set
Thread-Index: AQHUQr3NwHGd1RQgm0izHdVtup6wew==
Date:   Sun, 2 Sep 2018 13:06:46 +0000
Message-ID: <20180902064918.183387-32-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:vNsztFRPnwTk76K41jhrMZt1xR5Gm0GWAt8RIoFFClGFlDHEYJFWRlAJ3QIi3N5nowx67IkS0hK8z5W2yAvjcdu/yyP3I0BzkY2wBMhoiQNWexn1Jok9XgW3VfNFcJgYoMwswmU3xA7WWHyHUL1wekRF2odZFoCMHdrKq/zMNIgsWB+dLdCV7WBZnQBFbFTaH4KnLeE0YJ+TIsZfz7GkEYkagNhcIt1MVzu2CUKBsml8ayI74XNQTPrml9HYiEOdmEVS3pqtbCiN01CE4oeOf29jo/mHgsQ2kQmG/Zql/5bX8AZeyQ4u86Yyck52oWEUxzhXVk6Mj+v5t43D+yAOw0fTCNZb3gM/7rPzWzT8JuEbuwkhpM+0R5ZJEos1a4qCZQU4dcYRBbTXDximcbgSpeGK+ci6oa9dLJj97oK49u8pysCSbL0CZgvx22EOePeTtDI5UtrUhAIVPVNZkMymyg==;5:OKhSD0e+IUYejUix/aBeCiX5BFkqiPopUVpxsHE9L/ygw/Fd67zDvgQSXvawzXLodBws0uv2Ubb7kwqO2GgR6y6w7X8KvESPA/iMIPmDvrHLOFd+AIDfbmDalAZ+VJqe98GKT9arS2gvtRzmQCBW3zF0eKdvWMOpvTKwLkLEp8g=;7:eZLmyAjhAPW2GE5edE4D2+1op1HjPGdhVa2RIuLi4Yk712MX/nugSq09+QM9VWi0rQlDSR04uq+7fi0Xz+nk4UbF5gMXNih1lpM2m9K6nQMfoFe5qMCOIZT6r2PwtHOBssIe0+bow0jlDBgNSkhnVdJjJZihbv043zCgJ3srRl8ewD5BZQApODPjujXWFjxcQwnK2tB+Y9i8llkQ3wlrIw6IyJGfkMDzbn48oCb2H/oZL4v0kdqLg3J3zsMIaM08
x-ms-office365-filtering-correlation-id: ae4a2f0d-88f3-40c4-598e-08d610d4fcb1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB08565C996421FFC854CD2C81FB0D0@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(39860400002)(366004)(189003)(199004)(53936002)(81166006)(11346002)(81156014)(446003)(476003)(4326008)(5660300001)(25786009)(86612001)(8936002)(26005)(6506007)(6486002)(102836004)(2616005)(86362001)(8676002)(6512007)(14444005)(6436002)(107886003)(66066001)(256004)(10090500001)(217873002)(14454004)(3846002)(478600001)(1076002)(72206003)(6116002)(99286004)(305945005)(7736002)(22452003)(36756003)(76176011)(105586002)(486006)(106356001)(2900100001)(186003)(97736004)(68736007)(6666003)(316002)(10290500003)(2501003)(110136005)(54906003)(2906002)(5250100002)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uFySiVKRKO0o2KQJEliceWsorYlWtQfq1u7VRmfStN7gLo+KUUY1mlB+DVz2t5iKcHj8k28iJBfwgxKlrY2kKM4mnrNheOfnMx+yp+dUv9xycvGcH3HPKSfiDWKG49FjurQvphLmdwdWgh9+2LAzWKFU3qClKJvS8crpLjxJsxY/scHDbBTgxLpc1Crlu7AOzNxKAZYkvEH6Zu34c7Ooz3wC10UZkJhc58ZwZN17EZ0ZVoTvSm9gHHSbYk2JAX1zR3on78OPkxwI9my+OCWu9XYL5PB6qmdLVuJz1kSjxAibWadvyXacfxCuz7avJ+eaD4oa7ExHE2rlhti2Zo/plV8eBvk9xPev+yplpwYZ6+w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae4a2f0d-88f3-40c4-598e-08d610d4fcb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:46.9372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
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
index f741ba8df01b..cd659f862d74 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1703,17 +1703,22 @@ static int do_register_framebuffer(struct fb_info *=
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
