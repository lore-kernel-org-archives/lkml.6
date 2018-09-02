Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E08DC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C1220652
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Q/fqbqZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C1220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbeIBRe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:34:57 -0400
Received: from mail-sn1nam01on0115.outbound.protection.outlook.com ([104.47.32.115]:32096
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729300AbeIBRcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mROS/KI6VP/CrKQdrdT+zy280UXV0HPasf02Ws7MVJk=;
 b=Q/fqbqZ341+fwcQlnbXNFH01nrS/rU4rOznByhmg0Iz9m8lWc68ZZBHwr0EXWABGiRwyDGy1dqdCqPZlQEsJjGvho1sXhPzC4EiWbtQ8t99zUxOp5v8upWoEIg+OvUJA1z5Ht8g6h+E7ykEdnblDM07xnJlP9foyApEOBqQYfNk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0167.namprd21.prod.outlook.com (10.173.192.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:16:28 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:16:28 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Brad Love <brad@nextdimension.cc>,
        Michael Ira Krufky <mkrufky@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 33/47] media: em28xx: Fix DualHD disconnect oops
Thread-Topic: [PATCH AUTOSEL 4.4 33/47] media: em28xx: Fix DualHD disconnect
 oops
Thread-Index: AQHUQr8ixLG4cB5G+0mcnN2BMYkHXQ==
Date:   Sun, 2 Sep 2018 13:16:19 +0000
Message-ID: <20180902131533.184092-33-alexander.levin@microsoft.com>
References: <20180902131533.184092-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902131533.184092-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0167;6:+oCq65stOu8yDli7U0JJHOs00jelnT6e3mvDBFz+pJJVVoj0SrL3HHdLag7xkEWufaC1vmAJ/WoI35kY6wr22tE8HqTgt+08sbDhFK9GHdcPPODyJzg+Vj+KItBLNFu7KzqWPrpI44CohcIphchymfApyqdplXQtKJ7mblanKqINcPTxsUu7yJjAHfps4tZVvwjvLohACjem6X612lzLMtW42tNVOG9268x8FjNpNAOzFKJmiH1DZUkfXt3twUh34QYudy4Rjo9ZykN4/msZ8I094LrxxPKt+OJit+jBsWsU9D1fWGyUdjmRU6UqPyotvvaKD9bzz9MsyvFYy9HLRb4RqXDH9p4/JQxRsDMOlyzVlu0NlyyjkTbgghzgmHBLHfB7MRd11kVHEplsDMXDzdba3oUrupX29wvUVn5xoVSIFnxA8HS/W5kltgP9s3plfKRTDoA2DykkWdAb51PSpA==;5:Vg9tVDU0c5rqky3Cvea7L0N3PiboYkA9fhd6NOHILEWLqG+1bsVQ5UX13hlSHP2F9gKlnPNMdBzMTJ+5UMpeZ2o7N5O3FpWPxoL5IIToYw8hFL3d+pV8TuXSAPX8bNiZiIH6Jnxsc9ERC/WgN2smrMV8Bcfkj9ACZDIGhg89z8c=;7:A0N3IpFA1SCGe1BeHbR6m5g5dkYY2ntI+LtTSZ06TOjIiFMFiIG8De6iEr6tQNS8Y1TkFjrLP/kfF0nLiQdp5h4SZcM+HGmZcY/qh8WGx+YYXVgu/uD5TOpq3tLNOpZt1ZAssbzKE5RyeXuRBjkByxAOix5+Pyjv4wPEo3W+XvldWzxRiVERg5h1mHKlr/zEjv2i84h2MoLhcv1EAQiETOWuzzUQsRz3YxvhQtb5oDNtoJYYIKvKR9IgniJf3zJc
x-ms-office365-filtering-correlation-id: 073e2b71-339d-43d6-619a-08d610d64aff
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0167;
x-ms-traffictypediagnostic: CY4PR21MB0167:
x-microsoft-antispam-prvs: <CY4PR21MB0167F9B9AF6FE6A22FD5F456FB0D0@CY4PR21MB0167.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0167;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0167;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(346002)(366004)(396003)(51234002)(199004)(189003)(305945005)(6436002)(7736002)(6486002)(106356001)(105586002)(6512007)(53936002)(8676002)(36756003)(6666003)(6346003)(186003)(476003)(486006)(26005)(2616005)(11346002)(446003)(5660300001)(2501003)(5250100002)(10090500001)(102836004)(97736004)(6506007)(2900100001)(81156014)(316002)(81166006)(66066001)(22452003)(217873002)(2906002)(99286004)(54906003)(1076002)(8936002)(76176011)(68736007)(110136005)(3846002)(10290500003)(4326008)(25786009)(478600001)(6116002)(86612001)(575784001)(86362001)(39060400002)(107886003)(72206003)(14454004)(14444005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0167;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: t74NXPaElYPNwlmV5cxi2tm75Rqe3qr1m48eah3VzcTdQ7HS7FefByYBhe3s59iuxLVHMOOcdsc+zFwVdNN78VoKsrNLkoOsXmnSU6SjRFJWq7YBKj/4LAH0++EZMO9CMLO8UKwQWZV3rRcROkBjJ+lPyD+EVfvJLQ7p/wNJ1abfHKSnydD7BlaA7a0Vk+zzqJBMuLuMw3Up7vQC1JPvpXoVzkyeDOWNHFgaEKN50CbZ6uV1yN5HAXzDfwEeq2OaaAzE56LeMVKz2iZToV0/opTr21bdN8BJmRCntSDZgYJin199yuABu+yCRxIRbVA2vjCzxPoy/TgOMKUO88BVdW8V4p47/IFHXGuPs6m57cQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 073e2b71-339d-43d6-619a-08d610d64aff
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:16:19.2642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0167
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
index 394004607059..c41e93b7828e 100644
--- a/drivers/media/usb/em28xx/em28xx-cards.c
+++ b/drivers/media/usb/em28xx/em28xx-cards.c
@@ -3045,7 +3045,9 @@ void em28xx_free_device(struct kref *ref)
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
