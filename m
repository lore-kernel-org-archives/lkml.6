Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDA1C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28B120844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EczAnGhW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B28B120844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeIGFPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:45 -0400
Received: from mail-sn1nam02on0135.outbound.protection.outlook.com ([104.47.36.135]:30237
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729381AbeIGFPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZBKjeaE9FFNkH3N5IFhsfKfpr3pUoNiMEqcciZXgfI=;
 b=EczAnGhWq6afN+IiztS8IwIO48zD1zglS22moVCIXR2caZS+R92hH1G/7ga/Dkq9aBezBgssDaVAOe8/s6Kbz+H2ErHjaG5VhqX/z7H/CkVRUeEJNekHuYkjkPU2Swk39gjrjSLH24Vsl2VZSZbLCeQQdtJFnDkZs2f+lVFKPlI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0118.namprd21.prod.outlook.com (10.173.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:37:33 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:37:33 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     vkuznets <vkuznets@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 69/88] xen-netfront: fix queue name setting
Thread-Topic: [PATCH AUTOSEL 4.18 69/88] xen-netfront: fix queue name setting
Thread-Index: AQHURkLY+K2w4GlTsE6LaL1MANj2OA==
Date:   Fri, 7 Sep 2018 00:36:41 +0000
Message-ID: <20180907003547.57567-69-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0118;6:eAlQ7ktCTJYkALXEII1RH3LhpfSfCVV+Ms8M0d/xmyUtRkWi0npPcyYm5WFS/uupaRISURnDbkOy6wT7jewA0y0Asa/xgKNfR93/gEJoEhn9Peub4HV2ggkJlBtJzpYfCMJTN5LDwZC7S5432BS/XiEGl3JndZh//9WxU9o8iwwkwWBS+weaqlHvWx/ZS96YWx1E5rF5wQym2xyOBvjHxuIUS4jXIjMoXTqnerxLG+1PvvXRRpxNKJtaH7tkyG6BPN+V3GPR9zzfzWtfzwYga6kTd5JT1xUwM4GfNjOT9o4wE/gjH65bLEgXox7bMMdtSHodFY1o9YyFXz5UW5cZ4R4ED+Fjhhu26Q+S/xVd8+h8H9EG00CJbd4ryY83b0paip+m3lxh+AFdPQm2Bi5ejulkBN/4U/V/z7WU1uflqg8DV/Dw8ZDyQ9opyWnp48WCX8caQe4qpNU8SS827uGVQA==;5:6JGGqlsvmWiz4qIr2Fl6CxBKaLaUGhad4XzKi2YeWFxIGD+wZQFG7mFezT6zMBp5iQLYcDwQEDqCagDOncaX1CbRwa6f8y7wLutrrj/hCOJ1nFdc5A/vN4X3Le9piphFYQ/Mf6VOkyvzdxCLxS2mMZxfvAl9XFf+E9EQIYaySeU=;7:+MG4OkTGfsm5VrXhsTLY0jBxUNKJfGly850604LH2raRhf8JiJZMp6jYunktdPR3EgsO34V6QkHUkTt7FWn+SFFns/JAKOj+gZo/IN/p7TIs5O6uJNhN9lnlOeXzb+QwDT3SE8Kr0kCM4Y4eBQxkwO3QIzu7rGtl6JVn2uQ6QQGTWTpkyq4SmfP+Spgsmp2knRM/JHafqn52LxrTBIQ3Ac88KjlP4U1L5I8vGIJejov+Blob8NIGJAhbjK4dpOiC
x-ms-office365-filtering-correlation-id: b5e45a61-8a14-456c-ce5f-08d6145a1a1d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0118;
x-ms-traffictypediagnostic: CY4PR21MB0118:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB0118697FA73A024F6218F3B8FB000@CY4PR21MB0118.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(70601490899591);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0118;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0118;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(136003)(366004)(189003)(199004)(97736004)(2900100001)(53936002)(316002)(86612001)(25786009)(86362001)(575784001)(2906002)(6512007)(68736007)(110136005)(54906003)(107886003)(4326008)(10290500003)(14454004)(81156014)(81166006)(66066001)(8936002)(8676002)(478600001)(6116002)(3846002)(72206003)(305945005)(7736002)(1076002)(106356001)(105586002)(36756003)(99286004)(186003)(26005)(5250100002)(14444005)(446003)(6666003)(256004)(217873002)(10090500001)(76176011)(5660300001)(6436002)(11346002)(6486002)(6506007)(102836004)(2501003)(22452003)(476003)(486006)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0118;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vMBZSPZNNp6VVPgM9/L3nXQv9kNZwWQNqiYP5fgRcR1Y6kIgDqR7FYWuRGK4+bqF/+8O9FgAZAI7n6AQeKL984S97wyEUVqel0Z8IOhgcmwSMNmfwUwwlEFHxUC7wGeqFf15/3DPsk+0oDGaJb6iNsKl2i37VrXkg22bxKHD622CpcV1nwDcIltdKjXUFZWgtJ96/u+2dG6OnYdJFSq6do9B5IORIZoTMQAHYHvRiGWRUf6mDVtevjDMso01peTFViMbe7QLSBSXeWy/G9H67qQ/wrxxJ/UiDIfQ8DffYdGWSKsDPBGVCPqqrd4XyGNVIH9UFLOGcKu01zfnMih8Pi+WlGChXoxZAgJ/53qMwtU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e45a61-8a14-456c-ce5f-08d6145a1a1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:41.2553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>

[ Upstream commit 2d408c0d4574b01b9ed45e02516888bf925e11a9 ]

Commit f599c64fdf7d ("xen-netfront: Fix race between device setup and
open") changed the initialization order: xennet_create_queues() now
happens before we do register_netdev() so using netdev->name in
xennet_init_queue() is incorrect, we end up with the following in
/proc/interrupts:

 60:        139          0   xen-dyn    -event     eth%d-q0-tx
 61:        265          0   xen-dyn    -event     eth%d-q0-rx
 62:        234          0   xen-dyn    -event     eth%d-q1-tx
 63:          1          0   xen-dyn    -event     eth%d-q1-rx

and this looks ugly. Actually, using early netdev name (even when it's
already set) is also not ideal: nowadays we tend to rename eth devices
and queue name may end up not corresponding to the netdev name.

Use nodename from xenbus device for queue naming: this can't change in VM's
lifetime. Now /proc/interrupts looks like

 62:        202          0   xen-dyn    -event     device/vif/0-q0-tx
 63:        317          0   xen-dyn    -event     device/vif/0-q0-rx
 64:        262          0   xen-dyn    -event     device/vif/0-q1-tx
 65:         17          0   xen-dyn    -event     device/vif/0-q1-rx

Fixes: f599c64fdf7d ("xen-netfront: Fix race between device setup and open"=
)
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/xen-netfront.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 9dd2ca62d84a..5a14b917eee2 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1610,7 +1610,7 @@ static int xennet_init_queue(struct netfront_queue *q=
ueue)
 	timer_setup(&queue->rx_refill_timer, rx_refill_timeout, 0);
=20
 	snprintf(queue->name, sizeof(queue->name), "%s-q%u",
-		 queue->info->netdev->name, queue->id);
+		 queue->info->xbdev->nodename, queue->id);
=20
 	/* Initialise tx_skbs as a free chain containing every entry. */
 	queue->tx_skb_freelist =3D 0;
--=20
2.17.1
