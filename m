Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9722C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4172077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QXFI09Er"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4172077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbeIBRiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:38:02 -0400
Received: from mail-co1nam03on0122.outbound.protection.outlook.com ([104.47.40.122]:34400
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729287AbeIBRbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nxeXOefapU7t+Krb21ajyrfNgLxUWkQNCQ0PF9WSio=;
 b=QXFI09ErrSAJlWZDKN9iPiqyAT6+ejjfeOUR8aqvZ/XtwILnO/jnYFuPkW0eLP0u5qU85Lv8GbT76N01ZE+bABA4GKySuGxaNTzJeoy8bx4Ud1baIO5LTtj1VCqIkVXbkwuK0AxsjqT0iaco+p7747XUWyxZF8+tjzUu6wFdN7Q=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:15:29 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:15:29 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Brad Love <brad@nextdimension.cc>,
        Michael Ira Krufky <mkrufky@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 47/62] media: em28xx: Fix DualHD disconnect oops
Thread-Topic: [PATCH AUTOSEL 4.9 47/62] media: em28xx: Fix DualHD disconnect
 oops
Thread-Index: AQHUQr706nH/fFVA2UGlNAxEr1Q8hQ==
Date:   Sun, 2 Sep 2018 13:15:02 +0000
Message-ID: <20180902131411.183978-37-alexander.levin@microsoft.com>
References: <20180902131411.183978-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131411.183978-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0741;6:HsA+nHNxw+N9qFX4Jh3aUsyd2fg3FRkviIyr2SNhcDqTno9MTv/guF4N2LzP7Fuqpue3Fb/dVSybh5w4Wgx8J0JQdU1F5jB3yYfHmGTkFvxtOd10uQUDCCHoblQbmGi42wWfhvGn+NlRiay2etg4kWeozfqE/milNs8MujXKamGHX+TOMuYoU9CrtcU87zaePaoONmxsa376rllr5GJBwRZGOA3oXlBX3k29N7MqrtS9pqu1V8695SpRE18tJjOHk62fK0KDVE2CFoCb8o1aNf29PgwDYU0XOt264LV6s7Yhw5TS+4FrDSvcp5wrG50/k07DhG2VPbgplMiuGnEa96ajfTFfF/6r6kKA989XkOWZtuh46BteXSi8fusJ1yvEvBzy3bHPCPTaQ/G1z9x5a1riHX3qsiw0oucLY4EYariTziDvfOKuQHwCmduAIcoDrvN6NebWbF0lm1HQn0iKeQ==;5:BBxYjMnIvxD49BadvnhM0lFabaV76KpwCtMViO+zswvhb35H2VamE19/0WENKJxuw2kGJw7+bXMewpx76Hee3mjMHVQw2xg2k12KoP7a3l8xulgfwqwTRBG1qxpeD45USPWv+kw3wtvgivA3JUrv8UNUDCeWZhMfaMIazlpmBTU=;7:7KZTz4ZpqMUDBMV8uZRi2fF/zTpneYD5Kdb6wv0IE9mt+9ipOV+fLa3BDivvwKsR46etZDs0MMrr73GLQDIqFBSFnlBVQE2W6MKWnRw+fGQVcINOdHNXT/Xnz3jc4yVW3Md6G8+AP8SZr5btblveD/aUv4oGAe1eREYCgc1vJXloYMGsy3UKlPphc4Lx0K+BbV7UWYaVd/MjuItsvGuHxWgVVTaA0t9pFqw4s1JpjYidZZSOVT94XGwA/mqlOeAc
x-ms-office365-filtering-correlation-id: d8fa4008-2457-494f-38a0-08d610d627a0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0741;
x-ms-traffictypediagnostic: CY4PR21MB0741:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0741B76821D9C72803130DEAFB0D0@CY4PR21MB0741.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0741;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0741;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(51234002)(199004)(189003)(97736004)(2906002)(186003)(26005)(256004)(14444005)(102836004)(11346002)(25786009)(476003)(486006)(2616005)(446003)(305945005)(66066001)(5250100002)(2501003)(7736002)(6506007)(8676002)(68736007)(76176011)(6666003)(99286004)(6486002)(39060400002)(105586002)(81156014)(81166006)(53936002)(5660300001)(22452003)(478600001)(6436002)(86362001)(575784001)(14454004)(54906003)(36756003)(106356001)(110136005)(6512007)(4326008)(107886003)(217873002)(3846002)(2900100001)(316002)(8936002)(1076002)(10090500001)(6116002)(72206003)(86612001)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0741;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QAOBCl3oftH+6nYwl6iu8HQ9AGI5LdZU9rBUDnn7xVR+yplk2Hqs1YvtJ1eIM6+v57cChtH+Ew6VU1cvLEOr4XAE56WpLw0qcbytz9SOy6fX8QhcWeJgj60Ss6TiaYsuAC0mdMLryOk/dpfQou+yR8ssq1r8ZX6m143WFpw4iUfTf+HMiDqVFu6gs1n5OS8P2kByk91AtDe++oECv16pZlqRBEVruo545FG6SJ5/63su+c/9kOAOK76topAX+P5JOzmBBjmKWCYR1lZpSqPO63NzBiVU9aqBqgc/j3zqoihL215fEAhQ5HRug8YXhbWkAa9QVnjVXRwfRaWrUuXqDZFXBiFUhjxeo+TnofPGD5s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8fa4008-2457-494f-38a0-08d610d627a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:15:02.0786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brad Love <brad@nextdimension.cc>

[ Upstream commit 20cdcaf903298d54b834daedf65a2ddef70cae0a ]

During the duplication of em28xx state for the second tuner pair
a pointer to alt_max_pkt_size_isoc is copied. During tear down
the second tuner is destroyed first and kfrees alt_max_pkt_size_isoc,
then the first tuner is destroyed and kfrees it again. The property
should only be kfree'd if the tuner is PRIMARY_TS.

[  354.888560] ------------[ cut here ]------------
[  354.888562] kernel BUG at mm/slub.c:296!
[  354.888574] invalid opcode: 0000 [#1] SMP NOPTI
[  354.888869] CPU: 1 PID: 19 Comm: kworker/1:0 Not tainted 4.18.0-rc1+ #20
[  354.889140] Hardware name: MSI MS-7A39/B350M GAMING PRO (MS-7A39), BIOS =
2.G0 04/27/2018
[  354.889408] Workqueue: usb_hub_wq hub_event
[  354.889679] RIP: 0010:__slab_free+0x217/0x370
[  354.889942] Code: bb c0 e8 07 41 38 c7 72 39 48 83 c4 70 5b 41 5a 41 5c =
41 5d 41 5e 41 5f 5d 49 8d 62 f8 c3 f3 90 49 8b 04 24 a8 01 75 f6 eb 82 <0f=
> 0b 44 89 45 80 48 89 4d 88 e8 aa fa ff ff 85 c0 74 cc e9 b7 fe
[  354.890598] RSP: 0018:ffffb84c41a4fad0 EFLAGS: 00010246
[  354.890934] RAX: ffff948646e85150 RBX: ffff948646e85150 RCX: ffff948646e=
85150
[  354.891280] RDX: 00000000820001d9 RSI: fffffa8fd01ba140 RDI: ffff94865e8=
07c00
[  354.891649] RBP: ffffb84c41a4fb70 R08: 0000000000000001 R09: ffffffffc05=
9ce21
[  354.892025] R10: ffff948646e85150 R11: 0000000000000001 R12: fffffa8fd01=
ba140
[  354.892403] R13: ffff948646e85150 R14: ffff94865e807c00 R15: ffff94864c9=
2e0a0
[  354.892780] FS:  0000000000000000(0000) GS:ffff94865ec40000(0000) knlGS:=
0000000000000000
[  354.893150] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  354.893530] CR2: 00007f4e476da950 CR3: 000000040112c000 CR4: 00000000003=
406e0
[  354.893917] Call Trace:
[  354.894315]  ? __dev_printk+0x3c/0x80
[  354.894695]  ? _dev_info+0x64/0x80
[  354.895082]  ? em28xx_free_device+0x41/0x50 [em28xx]
[  354.895464]  kfree+0x17a/0x190
[  354.895852]  ? kfree+0x17a/0x190
[  354.896310]  em28xx_free_device+0x41/0x50 [em28xx]
[  354.896698]  em28xx_usb_disconnect+0xfa/0x110 [em28xx]
[  354.897083]  usb_unbind_interface+0x7a/0x270
[  354.897475]  device_release_driver_internal+0x17c/0x250
[  354.897864]  device_release_driver+0x12/0x20
[  354.898252]  bus_remove_device+0xec/0x160
[  354.898639]  device_del+0x13d/0x320
[  354.899018]  ? usb_remove_ep_devs+0x1f/0x30
[  354.899392]  usb_disable_device+0x9e/0x270
[  354.899772]  usb_disconnect+0x92/0x2a0
[  354.900149]  hub_event+0x98e/0x1650
[  354.900519]  ? sched_clock_cpu+0x11/0xa0
[  354.900890]  process_one_work+0x167/0x3f0
[  354.901251]  worker_thread+0x4d/0x460
[  354.901610]  kthread+0x105/0x140
[  354.901964]  ? rescuer_thread+0x360/0x360
[  354.902318]  ? kthread_associate_blkcg+0xa0/0xa0
[  354.902672]  ret_from_fork+0x22/0x40
[  354.903024] Modules linked in: rc_hauppauge em28xx_rc rc_core si2157 lgd=
t3306a i2c_mux em28xx_dvb dvb_core videobuf2_vmalloc videobuf2_memops video=
buf2_common snd_hda_codec_hdmi nls_iso8859_1 edac_mce_amd kvm crct10dif_pcl=
mul crc32_pclmul ghash_clmulni_intel pcbc snd_hda_intel snd_hda_codec snd_h=
da_core snd_hwdep snd_pcm snd_seq_midi aesni_intel snd_seq_midi_event aes_x=
86_64 snd_rawmidi crypto_simd em28xx cryptd glue_helper asix tveeprom usbne=
t snd_seq v4l2_common mii videodev snd_seq_device media input_leds snd_time=
r joydev ccp k10temp wmi_bmof snd soundcore mac_hid sch_fq_codel parport_pc=
 ppdev lp parport ip_tables x_tables vfio_pci vfio_virqfd irqbypass vfio_io=
mmu_type1 vfio nouveau mxm_wmi video i2c_algo_bit ttm drm_kms_helper syscop=
yarea sysfillrect sysimgblt fb_sys_fops i2c_piix4 drm ahci libahci
[  354.905129]  wmi gpio_amdpt gpio_generic hid_generic usbhid hid
[  354.908140] ---[ end trace c230d02716298c34 ]---
[  354.908145] RIP: 0010:__slab_free+0x217/0x370
[  354.908147] Code: bb c0 e8 07 41 38 c7 72 39 48 83 c4 70 5b 41 5a 41 5c =
41 5d 41 5e 41 5f 5d 49 8d 62 f8 c3 f3 90 49 8b 04 24 a8 01 75 f6 eb 82 <0f=
> 0b 44 89 45 80 48 89 4d 88 e8 aa fa ff ff 85 c0 74 cc e9 b7 fe
[  354.908183] RSP: 0018:ffffb84c41a4fad0 EFLAGS: 00010246
[  354.908186] RAX: ffff948646e85150 RBX: ffff948646e85150 RCX: ffff948646e=
85150
[  354.908189] RDX: 00000000820001d9 RSI: fffffa8fd01ba140 RDI: ffff94865e8=
07c00
[  354.908191] RBP: ffffb84c41a4fb70 R08: 0000000000000001 R09: ffffffffc05=
9ce21
[  354.908193] R10: ffff948646e85150 R11: 0000000000000001 R12: fffffa8fd01=
ba140
[  354.908195] R13: ffff948646e85150 R14: ffff94865e807c00 R15: ffff94864c9=
2e0a0
[  354.908198] FS:  0000000000000000(0000) GS:ffff94865ec40000(0000) knlGS:=
0000000000000000
[  354.908201] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  354.908203] CR2: 00007f4e476da950 CR3: 000000016b20a000 CR4: 00000000003=
406e0

Signed-off-by: Brad Love <brad@nextdimension.cc>
Signed-off-by: Michael Ira Krufky <mkrufky@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/usb/em28xx/em28xx-cards.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/em28xx/em28xx-cards.c b/drivers/media/usb/em=
28xx/em28xx-cards.c
index e397f544f108..d17b1d85fa7c 100644
--- a/drivers/media/usb/em28xx/em28xx-cards.c
+++ b/drivers/media/usb/em28xx/em28xx-cards.c
@@ -3227,7 +3227,9 @@ void em28xx_free_device(struct kref *ref)
 	if (!dev->disconnected)
 		em28xx_release_resources(dev);
=20
-	kfree(dev->alt_max_pkt_size_isoc);
+	if (dev->ts =3D=3D PRIMARY_TS)
+		kfree(dev->alt_max_pkt_size_isoc);
+
 	kfree(dev);
 }
 EXPORT_SYMBOL_GPL(em28xx_free_device);
--=20
2.17.1
