Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA791ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFA02147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Sy6gXxv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFA02147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbeIQIZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:25:31 -0400
Received: from mail-eopbgr710124.outbound.protection.outlook.com ([40.107.71.124]:62784
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728249AbeIQIZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVu5Twqq8v6HHGa6+8qqorDvW59ogy6Em7efJ+BRGsk=;
 b=Sy6gXxv4H70VkgIcKw/Gu4TUd5i8KJkFCdtBEkdBEGIKPoazJ0TQQFXPWA8qlXWYQUAi8h6A3CQ020OBRQDpRRM1IU2VnxBhbY+PjMj309ig4GpQpAFczj6dXxvQhI3rLAUxYEqYj4Wd4orcgvTAzXPTRT9iA55pi8+TiWHOnHw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0134.namprd21.prod.outlook.com (10.173.189.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:00:13 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:00:13 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 004/136] misc: ibmvmc: Use GFP_ATOMIC under spin
 lock
Thread-Topic: [PATCH AUTOSEL 4.18 004/136] misc: ibmvmc: Use GFP_ATOMIC under
 spin lock
Thread-Index: AQHUTjKNWJnEwc/ivkuXptovYTVuTQ==
Date:   Mon, 17 Sep 2018 03:00:13 +0000
Message-ID: <20180917030006.245495-4-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0134;6:obzKyMJ1TCqVhgPAImyUmv6zgeyhgI0cdKE9f3vhxN/rifWyCm6JnbZ0PQZWkTZS7mZTOGbZeHc3IXhqzWvYpfX+6q/8GBs3JIOhaVUsDYj9zY7or38ZWEmEAN9TP90OA0MkVup/O54iqb8q47aCW/3bDU4fTX9n9hdBU1TpGppSSc1m8ziYCmMpEPi7x6ArfhJ3iByV1dWBiPr1JJeDE3J5umd6E3GAAnocL613l+kKMolbAeFtquW4Ff3a4rqldW6gHG9bYyWJ7/Btk7o2JAUqFn1ZRqZj53+u1ZCo1wITweIhb8WcNBBRIiHZ6IQCGyCcUU+U9yF2J8tSZ0YrAJAhovbdJqM4sxRunuAgtrK7ga38UXFvZeqBTNqLtTU3TB3GocfpMSEsRpyKGRTeHRHhzFu2yinQZLP2Qs6xoSl+2awbHc4LAEZVoAJMcJXbvtHw+sbHnlxhjE+X+y9faw==;5:+Sq684vsGMSViA4l4RczES4RXBVdIct+JORg7AZXwqM1MOdjgFkV1tDeMYvVgmTqpXMni7dPZgkl2yanTa7rC+DYYnm3WL+q7WDzxhyWPH6t7ykFwwAiK4X5K2KNHFMxDvGL+g8f0X0W74abmS4w5UuPRy8tkycAAJdlTX8kLes=;7:3sZLQ2QySpTmyfsYWomsm+H8n9Mvc9pjCNGEkXa6Js0WVxJFNUVHCWZP9+f08kQ2Igs6kpXxoNrdD4sdx/g/kIfX9qyPLYkG0lPRZHkrlkCwe+xxQ0hwTcH1kIPUYoNYs/4EcMeGwzbPLWqkVlq/m+lMl6H2VdOb/DdEeBiVOjJQE1PSaqqsDUL2b6ffvkSCvO99+S4flD5j244tW7HicDY8bB/i4LVOmeOQ5wRZjvZekg6EBH/3T5UDbF0Md94v
x-ms-office365-filtering-correlation-id: b29b4b8b-9e7e-4126-6334-08d61c49b02c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0134;
x-ms-traffictypediagnostic: CY4PR21MB0134:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01340254B9B0352BA07AF787FB1E0@CY4PR21MB0134.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(50582790962513)(104084551191319)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0134;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0134;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(136003)(199004)(189003)(6506007)(10090500001)(14454004)(99286004)(76176011)(68736007)(6512007)(4326008)(25786009)(217873002)(107886003)(72206003)(22452003)(256004)(14444005)(36756003)(54906003)(110136005)(8676002)(6486002)(97736004)(10290500003)(6116002)(11346002)(26005)(7736002)(86612001)(5660300001)(86362001)(53936002)(316002)(486006)(476003)(2900100001)(5250100002)(105586002)(102836004)(305945005)(106356001)(66066001)(81166006)(81156014)(1076002)(2501003)(2906002)(6436002)(8936002)(446003)(478600001)(2616005)(186003)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0134;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MpGDGJJEwReHjZG+yTq/V+LHMNQsMipel/XtPauGxQpEqmh08heEzuF/CaJ95RFVAFmqJuVyjjdvsAXTYmpUAJ2Xhj/zsotISuRgcq74ED30iqfnjMjQzmpoEGaJMLlWbafx1ui2paYNTniJ5eBOcVQ+X7Ikh6oeKx9mo4W2T+I29mHlx3BzI6MFn4Iqh/4Jm8RIpFuuivLFML4rtTfZkUq82RUp8gJ+VrJXqWM+vxAIEbwaRU4LiADJ9Rh/aZG5zCdf1nQJnfVQOLX5CN/LfbSMLB1CZLyuqa0zX9KGql00xb5+4HA0KANifvz/2WPvj8Y5+F7+1LOGbD6cxnUL/gcGmeNP3hPEq2bm/D8Y6G4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b29b4b8b-9e7e-4126-6334-08d61c49b02c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:13.2455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit 97b715b62e5b4c6edb75d023f556fd09a46cb4e1 ]

The function alloc_dma_buffer() is called from ibmvmc_add_buffer(),
in which a spin lock be held here, so we should use GFP_ATOMIC when
a lock is held.

Fixes: 0eca353e7ae7 ("misc: IBM Virtual Management Channel Driver (VMC)")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/misc/ibmvmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/ibmvmc.c b/drivers/misc/ibmvmc.c
index fb83d1375638..8f82bb9d11e2 100644
--- a/drivers/misc/ibmvmc.c
+++ b/drivers/misc/ibmvmc.c
@@ -273,7 +273,7 @@ static void *alloc_dma_buffer(struct vio_dev *vdev, siz=
e_t size,
 			      dma_addr_t *dma_handle)
 {
 	/* allocate memory */
-	void *buffer =3D kzalloc(size, GFP_KERNEL);
+	void *buffer =3D kzalloc(size, GFP_ATOMIC);
=20
 	if (!buffer) {
 		*dma_handle =3D 0;
--=20
2.17.1
