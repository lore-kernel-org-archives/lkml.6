Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3706EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA2C206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WVJwMH1Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389417AbeLQUQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 15:16:39 -0500
Received: from mail-eopbgr1300117.outbound.protection.outlook.com ([40.107.130.117]:40423
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387922AbeLQUQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 15:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJVjXhnthKb7lvYw29FfZlZc4Lu9kz2tPStc8LEna24=;
 b=WVJwMH1ZOO7sAfdYGjB4QxtgdnCeit18Dab8qtTqr3qBPKa8oBZV9CpU7Im9reZVWLnt3prYmSgcXIPRNwSYGTL3F7VEe4VJ+0SzGL1qUUCAxqk08Vb2bkgMcwDUYkv5P7qbXz6Xin3HbIBu40TKcaJi5SMrXhVlUSCD4l9SVEc=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0153.APCP153.PROD.OUTLOOK.COM (10.170.188.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.4; Mon, 17 Dec 2018 20:16:10 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::99da:e3db:6b66:c8d4]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::99da:e3db:6b66:c8d4%6]) with mapi id 15.20.1471.004; Mon, 17 Dec 2018
 20:16:10 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
CC:     Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'devel@linuxdriverproject.org'" <devel@linuxdriverproject.org>,
        vkuznets <vkuznets@redhat.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>
Subject: [PATCH] Drivers: hv: vmbus: Check for ring when getting debug info
Thread-Topic: [PATCH] Drivers: hv: vmbus: Check for ring when getting debug
 info
Thread-Index: AdSWRMWuPYpn4vLTQoGSu72XmS6qRQ==
Date:   Mon, 17 Dec 2018 20:16:09 +0000
Message-ID: <PU1P153MB016995B94393BB024F6DE7F8BFBC0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-12-17T20:16:05.8893155Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:80e8:2:3cb9:7d38:c591:f3ce]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0153;6:7ntN97NtlMhRHhZv1h4u5AUNG+BqgiVTV51RGO9K+Te8luo0bwKiGPHsNW5WJabQy/UK7ZzSzWRMQ2EJnx9Yw+5Lv7y5+l12AxvNr2ce234QMYjjLYJ1m1ADoUux/zTzVIJziCu5cuTN3sw2X2OKptb1uFzws6kSeWvHy9fTiuIK028RPvk2jCQ7uPDsJpquNkNemr1sSYOI6H76qzMBnpCS+aaYCZin5dBz/pFl+YxFBrbB8Eq/MS5JRXPjxmWo+GW6aM0o3js2l7GjLPPoMFEcug4RtLoegcAEYxpx3bxcbYiy2+hkxx/hojGSW/tcx4Buk7XfLQFCRecsvS8LLKAwNIKHZzE5CWRSEO4xkYI6kfFzS5ST9dg0vGY07a5Pnjk711IyqWwTYllo8HEvaulwA3QoqdS4Cj+JvFg/20TFPYg/lhvDYXidFN7lx9jrIzdOwz7VQlqrSnEb2BW/Jw==;5:+Znwb8v4PHd3u9GrmS83IsIzB025gUQg5FO+9/npUWhK6jUyVfN1iRrmgiwdFhJBuewYVPkQKWMMOxHe5xp7lC/87BH5MN/W3Lta7w0ZdAWG9g/JULmJZ8B9tpmgqn7coPB/LBTX8qZOLZ1HFHJ+imXu5SPdjg2f2Xq6SXbdSRs=;7:KicHIEZkfzIf2HpNSCZ1Wxqwq1X7SDQFtLEP8QUubI+k4ww7G4DalHyR9hfpgJ6x9t/Yj86LWcJmy1UMvzKApQF4lVS7a5ZJguhdpERQLcrTAeSqbpwGZOrFa52EJ9lHUitgI3n8hDl61tAmYNzfmA==
x-ms-office365-filtering-correlation-id: c7728ce3-32a3-4fb5-b258-08d6645c7c26
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0153;
x-ms-traffictypediagnostic: PU1P153MB0153:
x-ms-exchange-purlcount: -3
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB015354747FA5A3DE90343D29BFBC0@PU1P153MB0153.APCP153.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(8220035)(2401047)(8121501046)(10201501046)(3002001)(3231475)(944501520)(2018427008)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:PU1P153MB0153;BCL:0;PCL:0;RULEID:;SRVR:PU1P153MB0153;
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39860400002)(376002)(366004)(199004)(189003)(305945005)(106356001)(7736002)(6436002)(105586002)(55016002)(53936002)(68736007)(9686003)(74316002)(97736004)(2906002)(6116002)(6636002)(10290500003)(71190400001)(86362001)(575784001)(46003)(71200400001)(86612001)(476003)(486006)(14454004)(478600001)(25786009)(7696005)(99286004)(4326008)(1511001)(10090500001)(256004)(8990500004)(33656002)(102836004)(186003)(316002)(22452003)(5660300001)(54906003)(6506007)(110136005)(14444005)(8936002)(8676002)(81156014)(81166006)(491001);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0153;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KbG87+mnY4xRLXT+tND41TkcCOzDQUmzjpuRyhFJzLEi7FQ2Z1wha8+KW+3bQAJjRUezGPgaOt4+fSSZ6aScqnIjwwd6Xpw3giwjESZzBVPYxGDWNQ8Eb2hwbXAhG1gi7j8sqpzHlMJt0+6yNOzFTNTcp2+l1LNGUvK8jouRs5QG7px8ZVvAvbGU1KCiJYhUdFm34pMh81r3TicnX10rRPQLkiZJBVlYYioRwOIequ426Dbtx/JK8L7p2gbwY/EELDQdoR364exv3ZBAqXTJDp6/OdHCFcBEFwN7wNppiGS+69OKJdwluYzXL7v1JVQr
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7728ce3-32a3-4fb5-b258-08d6645c7c26
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 20:16:09.5949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


fc96df16a1ce is good and can already fix the "return stack garbage" issue,
but let's also improve hv_ringbuffer_get_debuginfo(), which would silently
return stack garbage, if people forget to check channel->state or
ring_info->ring_buffer, when using the function in the future.

Having an error check in the function would eliminate the potential risk.

Add a Fixes tag to indicate the patch depdendency.

Fixes: fc96df16a1ce ("Drivers: hv: vmbus: Return -EINVAL for the sys files =
for unopened channels")
Cc: stable@vger.kernel.org
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

*NOTE*: the patch is based on char-misc's char-misc-linus branch.

 drivers/hv/ring_buffer.c | 31 ++++++++---------
 drivers/hv/vmbus_drv.c   | 91 ++++++++++++++++++++++++++++++++------------=
----
 include/linux/hyperv.h   |  5 +--
 3 files changed, 79 insertions(+), 48 deletions(-)

diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 64d0c85..1f1a55e 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -164,26 +164,25 @@ hv_get_ringbuffer_availbytes(const struct hv_ring_buf=
fer_info *rbi,
 }
=20
 /* Get various debug metrics for the specified ring buffer. */
-void hv_ringbuffer_get_debuginfo(const struct hv_ring_buffer_info *ring_in=
fo,
-				 struct hv_ring_buffer_debug_info *debug_info)
+int hv_ringbuffer_get_debuginfo(const struct hv_ring_buffer_info *ring_inf=
o,
+				struct hv_ring_buffer_debug_info *debug_info)
 {
 	u32 bytes_avail_towrite;
 	u32 bytes_avail_toread;
=20
-	if (ring_info->ring_buffer) {
-		hv_get_ringbuffer_availbytes(ring_info,
-					&bytes_avail_toread,
-					&bytes_avail_towrite);
-
-		debug_info->bytes_avail_toread =3D bytes_avail_toread;
-		debug_info->bytes_avail_towrite =3D bytes_avail_towrite;
-		debug_info->current_read_index =3D
-			ring_info->ring_buffer->read_index;
-		debug_info->current_write_index =3D
-			ring_info->ring_buffer->write_index;
-		debug_info->current_interrupt_mask =3D
-			ring_info->ring_buffer->interrupt_mask;
-	}
+	if (!ring_info->ring_buffer)
+		return -EINVAL;
+
+	hv_get_ringbuffer_availbytes(ring_info,
+				     &bytes_avail_toread,
+				     &bytes_avail_towrite);
+	debug_info->bytes_avail_toread =3D bytes_avail_toread;
+	debug_info->bytes_avail_towrite =3D bytes_avail_towrite;
+	debug_info->current_read_index =3D ring_info->ring_buffer->read_index;
+	debug_info->current_write_index =3D ring_info->ring_buffer->write_index;
+	debug_info->current_interrupt_mask
+		=3D ring_info->ring_buffer->interrupt_mask;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(hv_ringbuffer_get_debuginfo);
=20
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index d0ff656..403fee0 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -313,12 +313,16 @@ static ssize_t out_intr_mask_show(struct device *dev,
 {
 	struct hv_device *hv_dev =3D device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info outbound;
+	int ret;
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
-	if (hv_dev->channel->state !=3D CHANNEL_OPENED_STATE)
-		return -EINVAL;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
+
+	ret =3D hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound,
+					  &outbound);
+	if (ret < 0)
+		return ret;
+
 	return sprintf(buf, "%d\n", outbound.current_interrupt_mask);
 }
 static DEVICE_ATTR_RO(out_intr_mask);
@@ -328,12 +332,15 @@ static ssize_t out_read_index_show(struct device *dev=
,
 {
 	struct hv_device *hv_dev =3D device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info outbound;
+	int ret;
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
-	if (hv_dev->channel->state !=3D CHANNEL_OPENED_STATE)
-		return -EINVAL;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
+
+	ret =3D hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound,
+					  &outbound);
+	if (ret < 0)
+		return ret;
 	return sprintf(buf, "%d\n", outbound.current_read_index);
 }
 static DEVICE_ATTR_RO(out_read_index);
@@ -344,12 +351,15 @@ static ssize_t out_write_index_show(struct device *de=
v,
 {
 	struct hv_device *hv_dev =3D device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info outbound;
+	int ret;
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
-	if (hv_dev->channel->state !=3D CHANNEL_OPENED_STATE)
-		return -EINVAL;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
+
+	ret =3D hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound,
+					  &outbound);
+	if (ret < 0)
+		return ret;
 	return sprintf(buf, "%d\n", outbound.current_write_index);
 }
 static DEVICE_ATTR_RO(out_write_index);
@@ -360,12 +370,15 @@ static ssize_t out_read_bytes_avail_show(struct devic=
e *dev,
 {
 	struct hv_device *hv_dev =3D device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info outbound;
+	int ret;
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
-	if (hv_dev->channel->state !=3D CHANNEL_OPENED_STATE)
-		return -EINVAL;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
+
+	ret =3D hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound,
+					  &outbound);
+	if (ret < 0)
+		return ret;
 	return sprintf(buf, "%d\n", outbound.bytes_avail_toread);
 }
 static DEVICE_ATTR_RO(out_read_bytes_avail);
@@ -376,12 +389,15 @@ static ssize_t out_write_bytes_avail_show(struct devi=
ce *dev,
 {
 	struct hv_device *hv_dev =3D device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info outbound;
+	int ret;
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
-	if (hv_dev->channel->state !=3D CHANNEL_OPENED_STATE)
-		return -EINVAL;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
+
+	ret =3D hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound,
+					  &outbound);
+	if (ret < 0)
+		return ret;
 	return sprintf(buf, "%d\n", outbound.bytes_avail_towrite);
 }
 static DEVICE_ATTR_RO(out_write_bytes_avail);
@@ -391,12 +407,15 @@ static ssize_t in_intr_mask_show(struct device *dev,
 {
 	struct hv_device *hv_dev =3D device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info inbound;
+	int ret;
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
-	if (hv_dev->channel->state !=3D CHANNEL_OPENED_STATE)
-		return -EINVAL;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+
+	ret =3D hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+	if (ret < 0)
+		return ret;
+
 	return sprintf(buf, "%d\n", inbound.current_interrupt_mask);
 }
 static DEVICE_ATTR_RO(in_intr_mask);
@@ -406,12 +425,15 @@ static ssize_t in_read_index_show(struct device *dev,
 {
 	struct hv_device *hv_dev =3D device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info inbound;
+	int ret;
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
-	if (hv_dev->channel->state !=3D CHANNEL_OPENED_STATE)
-		return -EINVAL;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+
+	ret =3D hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+	if (ret < 0)
+		return ret;
+
 	return sprintf(buf, "%d\n", inbound.current_read_index);
 }
 static DEVICE_ATTR_RO(in_read_index);
@@ -421,12 +443,15 @@ static ssize_t in_write_index_show(struct device *dev=
,
 {
 	struct hv_device *hv_dev =3D device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info inbound;
+	int ret;
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
-	if (hv_dev->channel->state !=3D CHANNEL_OPENED_STATE)
-		return -EINVAL;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+
+	ret =3D hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+	if (ret < 0)
+		return ret;
+
 	return sprintf(buf, "%d\n", inbound.current_write_index);
 }
 static DEVICE_ATTR_RO(in_write_index);
@@ -437,12 +462,15 @@ static ssize_t in_read_bytes_avail_show(struct device=
 *dev,
 {
 	struct hv_device *hv_dev =3D device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info inbound;
+	int ret;
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
-	if (hv_dev->channel->state !=3D CHANNEL_OPENED_STATE)
-		return -EINVAL;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+
+	ret =3D hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+	if (ret < 0)
+		return ret;
+
 	return sprintf(buf, "%d\n", inbound.bytes_avail_toread);
 }
 static DEVICE_ATTR_RO(in_read_bytes_avail);
@@ -453,12 +481,15 @@ static ssize_t in_write_bytes_avail_show(struct devic=
e *dev,
 {
 	struct hv_device *hv_dev =3D device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info inbound;
+	int ret;
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
-	if (hv_dev->channel->state !=3D CHANNEL_OPENED_STATE)
-		return -EINVAL;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+
+	ret =3D hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+	if (ret < 0)
+		return ret;
+
 	return sprintf(buf, "%d\n", inbound.bytes_avail_towrite);
 }
 static DEVICE_ATTR_RO(in_write_bytes_avail);
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 14131b6..ed74888 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1176,8 +1176,9 @@ struct hv_ring_buffer_debug_info {
 	u32 bytes_avail_towrite;
 };
=20
-void hv_ringbuffer_get_debuginfo(const struct hv_ring_buffer_info *ring_in=
fo,
-			    struct hv_ring_buffer_debug_info *debug_info);
+
+int hv_ringbuffer_get_debuginfo(const struct hv_ring_buffer_info *ring_inf=
o,
+				struct hv_ring_buffer_debug_info *debug_info);
=20
 /* Vmbus interface */
 #define vmbus_driver_register(driver)	\
--=20
2.7.4

