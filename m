Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A86C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465D320870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 16:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UKYNYYix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 465D320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbeLMQgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 11:36:09 -0500
Received: from mail-eopbgr1320099.outbound.protection.outlook.com ([40.107.132.99]:35401
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727579AbeLMQgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 11:36:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THbkvuDf9f37Z7I+vbG1UeR92v1XYke7tVqlNTkxCfE=;
 b=UKYNYYixr3Bk0GdhZZWFZvuIQwBZ/XXCUCNTh1oRuYmKJnjNG1iR5S2nRrDKIhVLIpHMGLfRe8Sg1YgWVpHb5mbAfa/Pswz/WO//06Qfhuy8P9aJloUBYKZKzjGd1NA70dlApwjGWuITrWRj8JEAqecR5ChlWmUA7C5Gr0TbPk4=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0124.APCP153.PROD.OUTLOOK.COM (10.170.188.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.1; Thu, 13 Dec 2018 16:35:44 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::99da:e3db:6b66:c8d4]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::99da:e3db:6b66:c8d4%5]) with mapi id 15.20.1446.010; Thu, 13 Dec 2018
 16:35:44 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'devel@linuxdriverproject.org'" <devel@linuxdriverproject.org>
CC:     Sasha Levin <Alexander.Levin@microsoft.com>,
        "'apw@canonical.com'" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH] Drivers: hv: vmbus: Return -EINVAL for the sys files for
 unopened channels
Thread-Topic: [PATCH] Drivers: hv: vmbus: Return -EINVAL for the sys files for
 unopened channels
Thread-Index: AdSSumYR+EFelO/iSCugbWbDq9Br5w==
Date:   Thu, 13 Dec 2018 16:35:43 +0000
Message-ID: <PU1P153MB0169DDAA2CBC2901505AE692BFA00@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-12-13T08:08:03.3171735Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2601:600:a27f:df20:2973:fa11:e530:c034]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0124;6:HnFQKHInQ7GYDKHP41a3dXVG7MIiyk67WwMf0BxV0ODuE+rUpLXuCfFkuipMrzqmw3qTk+lsWpDHXcu4ybqgihRNv+rEa2cl1MOQiND0nexb0DRujIeeVf+J1pNIdEh2ttHlRplVIIAr3K2j85oOUizYh6ytNEyYUv3PRmdSyMKHv1zezo0Q/qo8ldilBpvm6DfJ3gAK3nhTCq1aqpDw5GKFMAFDIUZb6P9hGcbVddsR3VbQ+beXwgwNeNFx06UTC6DBcQQ0zGIU8legPQ13MwLobXxdhbeLhfRdlBEcWoMFnIodptDP6w+GGPIawOKIpSFeR8sd6Mm9O1pN25lVncWALixQpKKZu6LdLsV0xHEXaPnJWJ6HBvz8OXX4vjcl0q2Z59g1eZYDvh8nAsZnClPnNVG1fXKaW+8d3PP8G3fNSUOCaZLXzyI73ZJbQH5N6AN8E9BHKjaCFU+yOPE/nQ==;5:mUF+eTBgbsfOL1oTsEpQUEbMD3HtlT4KLaZl9VTrCBMC6OmJpo1vxfLGesE3cSfB3K3XW6rFmwMtwi1y43qLgH8d+tmDu0nkUUot/FLnnjHrNkeq4fDWv1Jw5iBb23ohwhl2RBFlSR3QdC/rjnIiMBPdld7oZXyEFvIAFtu/U+Y=;7:eZ0wUAP+cq/hBMI6Y2oYJfm+7CpthYTYZ4nQvxo2OIhH/M3jV2fc4BNJ0RxlpN+4FeVohmXppMfUnXddgUIc+Z669u5lavsjDcA9YSZjo3hyjVEfLz8VhyHiAfmqhPeFkZZRKEqw17HQB1GIlXkF4Q==
x-ms-office365-filtering-correlation-id: 12f1fee3-4ca9-4bb3-b6ae-08d661190725
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0124;
x-ms-traffictypediagnostic: PU1P153MB0124:
x-ms-exchange-purlcount: -3
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0124E22BD472B84A7ACFF152BFA00@PU1P153MB0124.APCP153.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(8220035)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231475)(944501520)(2018427008)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:PU1P153MB0124;BCL:0;PCL:0;RULEID:;SRVR:PU1P153MB0124;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(396003)(376002)(136003)(189003)(199004)(10090500001)(476003)(74316002)(305945005)(5660300001)(71190400001)(71200400001)(8990500004)(33656002)(55016002)(97736004)(107886003)(256004)(7736002)(186003)(486006)(6436002)(110136005)(54906003)(25786009)(316002)(1511001)(14454004)(2906002)(4326008)(22452003)(478600001)(10290500003)(46003)(68736007)(53936002)(6116002)(105586002)(7696005)(81166006)(6506007)(81156014)(102836004)(8676002)(9686003)(106356001)(99286004)(575784001)(86362001)(86612001)(8936002)(491001);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0124;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nnRNNxtxdk/vwZj8D0cUcWky/rZ+7S0SVn2gSHd9DUEREyjyFuBYWeydnafuRiM4MjY17q4pxSeke/dtAi0onKz/L+PiRts6VL7TEKja+2fIHSlUSagGBfA6HnOlYIhrrHo3eqqFQK9i0uXWnUPdKrXJ+xUJ+vlASkDF2zwUUfL+vMkI9EqyzbV+TGibi3YuOsU7DTdWwisYt2AmfDj3xbz1+A9X7mhLK3oWWCt0a28LQEGyXE3pewpUKzz0UIKo4kCslAUB4B/NBZHbtsrO8WiGa/HPXJw4AkxkNILug6pbizR0t+i40rivrwHttXv/
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f1fee3-4ca9-4bb3-b6ae-08d661190725
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 16:35:43.8040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Before 98f4c651762c, we returned zeros for unopened channels.
With 98f4c651762c, we started to return random on-stack values.

We'd better return -EINVAL instead.

Fixes: 98f4c651762c ("hv: move ringbuffer bus attributes to dev_groups")
Cc: stable@vger.kernel.org
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 283d184..d0ff656 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -316,6 +316,8 @@ static ssize_t out_intr_mask_show(struct device *dev,
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state !=3D CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
 	return sprintf(buf, "%d\n", outbound.current_interrupt_mask);
 }
@@ -329,6 +331,8 @@ static ssize_t out_read_index_show(struct device *dev,
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state !=3D CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
 	return sprintf(buf, "%d\n", outbound.current_read_index);
 }
@@ -343,6 +347,8 @@ static ssize_t out_write_index_show(struct device *dev,
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state !=3D CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
 	return sprintf(buf, "%d\n", outbound.current_write_index);
 }
@@ -357,6 +363,8 @@ static ssize_t out_read_bytes_avail_show(struct device =
*dev,
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state !=3D CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
 	return sprintf(buf, "%d\n", outbound.bytes_avail_toread);
 }
@@ -371,6 +379,8 @@ static ssize_t out_write_bytes_avail_show(struct device=
 *dev,
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state !=3D CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
 	return sprintf(buf, "%d\n", outbound.bytes_avail_towrite);
 }
@@ -384,6 +394,8 @@ static ssize_t in_intr_mask_show(struct device *dev,
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state !=3D CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
 	return sprintf(buf, "%d\n", inbound.current_interrupt_mask);
 }
@@ -397,6 +409,8 @@ static ssize_t in_read_index_show(struct device *dev,
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state !=3D CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
 	return sprintf(buf, "%d\n", inbound.current_read_index);
 }
@@ -410,6 +424,8 @@ static ssize_t in_write_index_show(struct device *dev,
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state !=3D CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
 	return sprintf(buf, "%d\n", inbound.current_write_index);
 }
@@ -424,6 +440,8 @@ static ssize_t in_read_bytes_avail_show(struct device *=
dev,
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state !=3D CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
 	return sprintf(buf, "%d\n", inbound.bytes_avail_toread);
 }
@@ -438,6 +456,8 @@ static ssize_t in_write_bytes_avail_show(struct device =
*dev,
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
+	if (hv_dev->channel->state !=3D CHANNEL_OPENED_STATE)
+		return -EINVAL;
 	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
 	return sprintf(buf, "%d\n", inbound.bytes_avail_towrite);
 }
--=20
2.7.4

