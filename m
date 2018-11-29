Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE8DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 04:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B497220863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 04:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MytmQvKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B497220863
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbeK2PlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 10:41:01 -0500
Received: from mail-eopbgr1300103.outbound.protection.outlook.com ([40.107.130.103]:22674
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727535AbeK2PlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 10:41:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+w8PjLltL2YzIWEf/0lUVHYpNLo0+bHU807VGpinoY=;
 b=MytmQvKNky9lusAn9f6TshE2kh5DR+dw/NFb/eCKJpy+ENwGmVvRJw7VQ/hQbkg066M8sExdaPEr3uPL9EOyTmFbHgwixH5mPMStjNgs+fU5gUVjl2Ast47zfXscuoO8K/YsExD9P3MJTLybVmIuFTaHF/zJFV1Zr6ZfYDFAacM=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0202.APCP153.PROD.OUTLOOK.COM (52.133.192.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.2; Thu, 29 Nov 2018 04:36:44 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3d50:29f2:1244:8b4b]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3d50:29f2:1244:8b4b%8]) with mapi id 15.20.1404.008; Thu, 29 Nov 2018
 04:36:44 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
CC:     Michael Kelley <mikelley@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>
Subject: [PATCH] [repost] Drivers: hv: vmbus: Offload the handling of channels
 to two workqueues
Thread-Topic: [PATCH] [repost] Drivers: hv: vmbus: Offload the handling of
 channels to two workqueues
Thread-Index: AdSHnLf8sFQRqiTYT1imO/A1WbZ3vg==
Date:   Thu, 29 Nov 2018 04:36:43 +0000
Message-ID: <PU1P153MB016946D99D63F9713E32B99ABFD20@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-11-29T04:36:40.3767675Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2601:600:a27f:df20:fca5:5be0:9dc2:f9fc]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0202;6:clQg7Vr08LtJfAn/oFnegqOZeYJC9Li+uHFyJsN2kT3B0e3r55eSZI9RFW/0Xy5xTuEzvyqCZeavsRrNeLH56mH+XkFiKMap4pRxeN18ReqRp6+xdKxZ4guLgftc3X4OTkTNGfbdVaZldSKcg0lwuMF6hADpVO4RgqTNH30tB7mqUmAlHEjVvLsyMUWEy1WsioR0a/S71Ujhm7LG77vh/81+QAT4dJAjITQMvK+vpsGfH0WBEMohiYAO+IU0DXd3SX1Zgn5cNuLEoV5g2hGjwEaqjataoNTXoFEvEiJQ233qWyO6oIx5iyj34qqjFfZQbnY6IshNSfIneIN/SkDKOcSJQYXOaAK3OokOddbWPwV3LvrvR/U1GNN6OKF1hKc36c/L4udvsGpuXhmNZfPCl+QQJ3NX2/brsKgLZ1wV4lIaZFDDUQSScZspwqeZ4HihIEVregn9wGgm8hR3GAroXA==;5:HjjivPI2/o+xKVpZxvoKTKVC24OeMJpDDtQ81Spvb+VVdFTGu3C80fZpOzuFRbqaL6YmKxhePvkU7PMSHnm5QsQ0GxIiviwRiwGXdEc/p9CoZc20sfTYuoDHQfUuFD9iHtq0c2AsA2uTXBbWzUw1XjsxlzGiIUjKETxZ6Zq6ahI=;7:KRGlL3iJ2S9YG5UmivGJ6ssrXS/4aVT/+p7JriB454/emQuBp+7QbbJX0xgW3+8gEQbMU3NIBv1ytPkHS5fWDcZra1XOw4GY0oL1TcIEjjObRKuks5GiIoP84zaRTLOZT/Wf09eJ2fukvky/Lcw7ow==
x-ms-office365-filtering-correlation-id: c0efe759-7f79-4bd7-4529-08d655b44404
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0202;
x-ms-traffictypediagnostic: PU1P153MB0202:
x-ms-exchange-purlcount: -3
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0202B68FBEB4716E32BD952DBFD20@PU1P153MB0202.APCP153.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(8121501046)(5005006)(10201501046)(3231453)(999002)(944501447)(2018427008)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:PU1P153MB0202;BCL:0;PCL:0;RULEID:;SRVR:PU1P153MB0202;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(376002)(366004)(39860400002)(199004)(189003)(22452003)(71200400001)(86612001)(71190400001)(316002)(97736004)(4326008)(6116002)(486006)(54906003)(110136005)(2906002)(46003)(81156014)(8676002)(305945005)(105586002)(8990500004)(5660300001)(8936002)(81166006)(53936002)(14454004)(9686003)(99286004)(14444005)(256004)(10090500001)(1511001)(7696005)(4744004)(74316002)(7736002)(476003)(6506007)(102836004)(68736007)(33656002)(55016002)(478600001)(2501003)(10290500003)(186003)(6436002)(86362001)(2201001)(25786009)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0202;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vOLLEW7ZdT5YjoRmjC/ZNJTgzwce15KyR9hg7hOdqS9DN2/KJ+lctY6XwADx6QzyKo4Ruhu/1xtrFsykalnAqUCPHmL1OZLXsK4rGiUboEQae+22H38N6vW/vi9p6q6GNIGKeCaFWGHGlnLynSKCWJJ3KEewrb0LjVDbO1Skqx+VD2R4wYN3KHznLpoH6G9zYBQf2cgsi/pfCH1awf70sFZz91698CiQJ0uPg+r/ayfdLvO1uenQ8oIjy3ASzqoOR6rUOuZDA2nZjCpOheaNdTNwmafm1L87nIxuKcJILFxEEehlYv2+x2ZnrHe0jXUmlHxnTdtFjDk1qbdPr8grLXTuw9YL9DOXKCy86szwceI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0efe759-7f79-4bd7-4529-08d655b44404
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 04:36:43.8465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0202
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


vmbus_process_offer() mustn't call channel->sc_creation_callback()
directly for sub-channels, because sc_creation_callback() ->
vmbus_open() may never get the host's response to the
OPEN_CHANNEL message (the host may rescind a channel at any time,
e.g. in the case of hot removing a NIC), and vmbus_onoffer_rescind()
may not wake up the vmbus_open() as it's blocked due to a non-zero
vmbus_connection.offer_in_progress, and finally we have a deadlock.

The above is also true for primary channels, if the related device
drivers use sync probing mode by default.

And, usually the handling of primary channels and sub-channels can
depend on each other, so we should offload them to different
workqueues to avoid possible deadlock, e.g. in sync-probing mode,
NIC1's netvsc_subchan_work() can race with NIC2's netvsc_probe() ->
rtnl_lock(), and causes deadlock: the former gets the rtnl_lock
and waits for all the sub-channels to appear, but the latter
can't get the rtnl_lock and this blocks the handling of sub-channels.

The patch can fix the multiple-NIC deadlock described above for
v3.x kernels (e.g. RHEL 7.x) which don't support async-probing
of devices, and v4.4, v4.9, v4.14 and v4.18 which support async-probing
but don't enable async-probing for Hyper-V drivers (yet).

The patch can also fix the hang issue in sub-channel's handling described
above for all versions of kernels, including v4.19 and v4.20-rc4.

So, actually the patch should be applied to all the existing kernels,
not only the kernels that have 8195b1396ec8.

Fixes: 8195b1396ec8 ("hv_netvsc: fix deadlock on hotplug")
Cc: stable@vger.kernel.org
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---

There is no change in this repost. I just rebased this patch to today's
char-misc's char-misc-next branch. Previously KY posted the patch with his
Signed-off-by (which is kept in this repost), but there was a conflict issu=
e.

Note: the patch can't be cleanly applied to char-misc's char-misc-linus bra=
nch --
to do that, we need to cherry-pick the supporting patch first:
4d3c5c69191f ("Drivers: hv: vmbus: Remove the useless API vmbus_get_outgoin=
g_channel()")

 drivers/hv/channel_mgmt.c | 188 +++++++++++++++++++++++++++++++-----------=
----
 drivers/hv/connection.c   |  24 +++++-
 drivers/hv/hyperv_vmbus.h |   7 ++
 include/linux/hyperv.h    |   7 ++
 4 files changed, 161 insertions(+), 65 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 82e6736..d016890 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -434,60 +434,16 @@ void vmbus_free_channels(void)
 	}
 }
=20
-/*
- * vmbus_process_offer - Process the offer by creating a channel/device
- * associated with this offer
- */
-static void vmbus_process_offer(struct vmbus_channel *newchannel)
+/* Note: the function can run concurrently for primary/sub channels. */
+static void vmbus_add_channel_work(struct work_struct *work)
 {
-	struct vmbus_channel *channel;
-	bool fnew =3D true;
+	struct vmbus_channel *newchannel =3D
+		container_of(work, struct vmbus_channel, add_channel_work);
+	struct vmbus_channel *primary_channel =3D newchannel->primary_channel;
 	unsigned long flags;
 	u16 dev_type;
 	int ret;
=20
-	/* Make sure this is a new offer */
-	mutex_lock(&vmbus_connection.channel_mutex);
-
-	/*
-	 * Now that we have acquired the channel_mutex,
-	 * we can release the potentially racing rescind thread.
-	 */
-	atomic_dec(&vmbus_connection.offer_in_progress);
-
-	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
-		if (!uuid_le_cmp(channel->offermsg.offer.if_type,
-			newchannel->offermsg.offer.if_type) &&
-			!uuid_le_cmp(channel->offermsg.offer.if_instance,
-				newchannel->offermsg.offer.if_instance)) {
-			fnew =3D false;
-			break;
-		}
-	}
-
-	if (fnew)
-		list_add_tail(&newchannel->listentry,
-			      &vmbus_connection.chn_list);
-
-	mutex_unlock(&vmbus_connection.channel_mutex);
-
-	if (!fnew) {
-		/*
-		 * Check to see if this is a sub-channel.
-		 */
-		if (newchannel->offermsg.offer.sub_channel_index !=3D 0) {
-			/*
-			 * Process the sub-channel.
-			 */
-			newchannel->primary_channel =3D channel;
-			spin_lock_irqsave(&channel->lock, flags);
-			list_add_tail(&newchannel->sc_list, &channel->sc_list);
-			spin_unlock_irqrestore(&channel->lock, flags);
-		} else {
-			goto err_free_chan;
-		}
-	}
-
 	dev_type =3D hv_get_dev_type(newchannel);
=20
 	init_vp_index(newchannel, dev_type);
@@ -505,27 +461,26 @@ static void vmbus_process_offer(struct vmbus_channel =
*newchannel)
 	/*
 	 * This state is used to indicate a successful open
 	 * so that when we do close the channel normally, we
-	 * can cleanup properly
+	 * can cleanup properly.
 	 */
 	newchannel->state =3D CHANNEL_OPEN_STATE;
=20
-	if (!fnew) {
-		struct hv_device *dev
-			=3D newchannel->primary_channel->device_obj;
+	if (primary_channel !=3D NULL) {
+		/* newchannel is a sub-channel. */
+		struct hv_device *dev =3D primary_channel->device_obj;
=20
 		if (vmbus_add_channel_kobj(dev, newchannel))
-			goto err_free_chan;
+			goto err_deq_chan;
+
+		if (primary_channel->sc_creation_callback !=3D NULL)
+			primary_channel->sc_creation_callback(newchannel);
=20
-		if (channel->sc_creation_callback !=3D NULL)
-			channel->sc_creation_callback(newchannel);
 		newchannel->probe_done =3D true;
 		return;
 	}
=20
 	/*
-	 * Start the process of binding this offer to the driver
-	 * We need to set the DeviceObject field before calling
-	 * vmbus_child_dev_add()
+	 * Start the process of binding the primary channel to the driver
 	 */
 	newchannel->device_obj =3D vmbus_device_create(
 		&newchannel->offermsg.offer.if_type,
@@ -554,13 +509,28 @@ static void vmbus_process_offer(struct vmbus_channel =
*newchannel)
=20
 err_deq_chan:
 	mutex_lock(&vmbus_connection.channel_mutex);
-	list_del(&newchannel->listentry);
+
+	/*
+	 * We need to set the flag, otherwise
+	 * vmbus_onoffer_rescind() can be blocked.
+	 */
+	newchannel->probe_done =3D true;
+
+	if (primary_channel =3D=3D NULL) {
+		list_del(&newchannel->listentry);
+	} else {
+		spin_lock_irqsave(&primary_channel->lock, flags);
+		list_del(&newchannel->sc_list);
+		spin_unlock_irqrestore(&primary_channel->lock, flags);
+	}
+
 	mutex_unlock(&vmbus_connection.channel_mutex);
=20
 	if (newchannel->target_cpu !=3D get_cpu()) {
 		put_cpu();
 		smp_call_function_single(newchannel->target_cpu,
-					 percpu_channel_deq, newchannel, true);
+					 percpu_channel_deq,
+					 newchannel, true);
 	} else {
 		percpu_channel_deq(newchannel);
 		put_cpu();
@@ -568,14 +538,104 @@ static void vmbus_process_offer(struct vmbus_channel=
 *newchannel)
=20
 	vmbus_release_relid(newchannel->offermsg.child_relid);
=20
-err_free_chan:
 	free_channel(newchannel);
 }
=20
 /*
+ * vmbus_process_offer - Process the offer by creating a channel/device
+ * associated with this offer
+ */
+static void vmbus_process_offer(struct vmbus_channel *newchannel)
+{
+	struct vmbus_channel *channel;
+	struct workqueue_struct *wq;
+	unsigned long flags;
+	bool fnew =3D true;
+
+	mutex_lock(&vmbus_connection.channel_mutex);
+
+	/*
+	 * Now that we have acquired the channel_mutex,
+	 * we can release the potentially racing rescind thread.
+	 */
+	atomic_dec(&vmbus_connection.offer_in_progress);
+
+	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
+		if (!uuid_le_cmp(channel->offermsg.offer.if_type,
+				 newchannel->offermsg.offer.if_type) &&
+		    !uuid_le_cmp(channel->offermsg.offer.if_instance,
+				 newchannel->offermsg.offer.if_instance)) {
+			fnew =3D false;
+			break;
+		}
+	}
+
+	if (fnew)
+		list_add_tail(&newchannel->listentry,
+			      &vmbus_connection.chn_list);
+	else {
+		/*
+		 * Check to see if this is a valid sub-channel.
+		 */
+		if (newchannel->offermsg.offer.sub_channel_index =3D=3D 0) {
+			mutex_unlock(&vmbus_connection.channel_mutex);
+			/*
+			 * Don't call free_channel(), because newchannel->kobj
+			 * is not initialized yet.
+			 */
+			kfree(newchannel);
+			WARN_ON_ONCE(1);
+			return;
+		}
+		/*
+		 * Process the sub-channel.
+		 */
+		newchannel->primary_channel =3D channel;
+		spin_lock_irqsave(&channel->lock, flags);
+		list_add_tail(&newchannel->sc_list, &channel->sc_list);
+		spin_unlock_irqrestore(&channel->lock, flags);
+	}
+
+	mutex_unlock(&vmbus_connection.channel_mutex);
+
+	/*
+	 * vmbus_process_offer() mustn't call channel->sc_creation_callback()
+	 * directly for sub-channels, because sc_creation_callback() ->
+	 * vmbus_open() may never get the host's response to the
+	 * OPEN_CHANNEL message (the host may rescind a channel at any time,
+	 * e.g. in the case of hot removing a NIC), and vmbus_onoffer_rescind()
+	 * may not wake up the vmbus_open() as it's blocked due to a non-zero
+	 * vmbus_connection.offer_in_progress, and finally we have a deadlock.
+	 *
+	 * The above is also true for primary channels, if the related device
+	 * drivers use sync probing mode by default.
+	 *
+	 * And, usually the handling of primary channels and sub-channels can
+	 * depend on each other, so we should offload them to different
+	 * workqueues to avoid possible deadlock, e.g. in sync-probing mode,
+	 * NIC1's netvsc_subchan_work() can race with NIC2's netvsc_probe() ->
+	 * rtnl_lock(), and causes deadlock: the former gets the rtnl_lock
+	 * and waits for all the sub-channels to appear, but the latter
+	 * can't get the rtnl_lock and this blocks the handling of
+	 * sub-channels.
+	 */
+	INIT_WORK(&newchannel->add_channel_work, vmbus_add_channel_work);
+	wq =3D fnew ? vmbus_connection.handle_primary_chan_wq :
+		    vmbus_connection.handle_sub_chan_wq;
+	queue_work(wq, &newchannel->add_channel_work);
+}
+
+/*
  * We use this state to statically distribute the channel interrupt load.
  */
 static int next_numa_node_id;
+/*
+ * init_vp_index() accesses global variables like next_numa_node_id, and
+ * it can run concurrently for primary channels and sub-channels: see
+ * vmbus_process_offer(), so we need the lock to protect the global
+ * variables.
+ */
+static DEFINE_SPINLOCK(bind_channel_to_cpu_lock);
=20
 /*
  * Starting with Win8, we can statically distribute the incoming
@@ -611,6 +671,8 @@ static void init_vp_index(struct vmbus_channel *channel=
, u16 dev_type)
 		return;
 	}
=20
+	spin_lock(&bind_channel_to_cpu_lock);
+
 	/*
 	 * Based on the channel affinity policy, we will assign the NUMA
 	 * nodes.
@@ -693,6 +755,8 @@ static void init_vp_index(struct vmbus_channel *channel=
, u16 dev_type)
 	channel->target_cpu =3D cur_cpu;
 	channel->target_vp =3D hv_cpu_number_to_vp_number(cur_cpu);
=20
+	spin_unlock(&bind_channel_to_cpu_lock);
+
 	free_cpumask_var(available_mask);
 }
=20
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index f4d08c8..4fe117b7 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -190,6 +190,20 @@ int vmbus_connect(void)
 		goto cleanup;
 	}
=20
+	vmbus_connection.handle_primary_chan_wq =3D
+		create_workqueue("hv_pri_chan");
+	if (!vmbus_connection.handle_primary_chan_wq) {
+		ret =3D -ENOMEM;
+		goto cleanup;
+	}
+
+	vmbus_connection.handle_sub_chan_wq =3D
+		create_workqueue("hv_sub_chan");
+	if (!vmbus_connection.handle_sub_chan_wq) {
+		ret =3D -ENOMEM;
+		goto cleanup;
+	}
+
 	INIT_LIST_HEAD(&vmbus_connection.chn_msg_list);
 	spin_lock_init(&vmbus_connection.channelmsg_lock);
=20
@@ -280,10 +294,14 @@ void vmbus_disconnect(void)
 	 */
 	vmbus_initiate_unload(false);
=20
-	if (vmbus_connection.work_queue) {
-		drain_workqueue(vmbus_connection.work_queue);
+	if (vmbus_connection.handle_sub_chan_wq)
+		destroy_workqueue(vmbus_connection.handle_sub_chan_wq);
+
+	if (vmbus_connection.handle_primary_chan_wq)
+		destroy_workqueue(vmbus_connection.handle_primary_chan_wq);
+
+	if (vmbus_connection.work_queue)
 		destroy_workqueue(vmbus_connection.work_queue);
-	}
=20
 	if (vmbus_connection.int_page) {
 		free_pages((unsigned long)vmbus_connection.int_page, 0);
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index f17c06a5..313a07f 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -333,7 +333,14 @@ struct vmbus_connection {
 	struct list_head chn_list;
 	struct mutex channel_mutex;
=20
+	/*
+	 * An offer message is handled first on the work_queue, and then
+	 * is further handled on handle_primary_chan_wq or
+	 * handle_sub_chan_wq.
+	 */
 	struct workqueue_struct *work_queue;
+	struct workqueue_struct *handle_primary_chan_wq;
+	struct workqueue_struct *handle_sub_chan_wq;
 };
=20
=20
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 07a367f..f0885cc 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -896,6 +896,13 @@ struct vmbus_channel {
=20
 	bool probe_done;
=20
+	/*
+	 * We must offload the handling of the primary/sub channels
+	 * from the single-threaded vmbus_connection.work_queue to
+	 * two different workqueue, otherwise we can block
+	 * vmbus_connection.work_queue and hang: see vmbus_process_offer().
+	 */
+	struct work_struct add_channel_work;
 };
=20
 static inline bool is_hvsock_channel(const struct vmbus_channel *c)
--=20
2.7.4

