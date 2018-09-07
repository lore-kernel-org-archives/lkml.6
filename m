Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A86C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DCF20857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IqmbDqUg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37DCF20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731308AbeIGFU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:20:28 -0400
Received: from mail-by2nam01on0120.outbound.protection.outlook.com ([104.47.34.120]:44004
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727282AbeIGFUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54NGKKjJ2qBGaiZVut7MDAWvFsztU9BIsI+hFMSiMF4=;
 b=IqmbDqUghSyNnY6FKwYRtjSaD6FhpsFEJ04yrmiN2l5acRIUSCN+qCCSKnQnpGvLzuAJGx0fc/Opbvh6VL/CAGaTCzy7s9SPp6k+MmwoC2m59sDOSLHTcixIPFiiZrm9Hg/yBMypHYbxX4f1DXyVrjol7MQ9L9isYvH1ZGr6wh8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:42:05 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:42:05 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     vkuznets <vkuznets@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 25/30] xen-netfront: fix queue name setting
Thread-Topic: [PATCH AUTOSEL 4.4 25/30] xen-netfront: fix queue name setting
Thread-Index: AQHURkM04S2OqTfU50OcRoyZ/nLUig==
Date:   Fri, 7 Sep 2018 00:39:15 +0000
Message-ID: <20180907003853.57942-25-alexander.levin@microsoft.com>
References: <20180907003853.57942-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003853.57942-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:0613065EnL16JX65nLN0ObKipdVjr5X3vxNmxwHCe/MFhYp39em4vPVFmfkDpcmoOuP5sjg14rSAtEqiyRJS73w//sNC0Dk7cAyW5i0fzkkW0nNdJaV94GHkvgk6r5vLZxaX/2clLzhLmAajiD7/j+UlzYhVatvriUYGqNieF1sSqdY07BxT6SjFhjkIzcSr33pyABUZFovxqgJwFwEc/mtShrVAOSiXeXHnw77iFd9yixgXXuWZ8FZuILbIqV/JG0GkhqRbUTeEOOC6SX/g6lMqaYk5CLBpjM4Mw0IQ1Xk8Ad9hBCzWjZhFyBJti5/vUGLXRbi3LaFe5888Hp6mtYDQzvDOqyeYlAUUycBuoePs2old8p0i4Ev879Fw75e/rc0dRkbepu9UMl1mKNxNR2e3GkKbm3S5wNWSnrkQwuDu14tt6XxtUYcWJX2hyraKIbEb1QpQnGLzSOtvVPKjwQ==;5:tGf18YGmU8T0/pFIEY+NA4UTj2l8OIJ/+1a9AcbX1GuFg293KZwT3io/v9HMdSPZ6kHUA2U867FUArKhBWljrwLpWigtn3vBTj3HrdijVpAckWc7B7WoRZqD8vYa84iI/haQ18lOpCWfkAZ5zN1nEXGv4SrMO1ntruR657fAT/c=;7:RnQijWMQgTbr8/L/uCZZW1H2obeWbyOx+7roiZasiXj1xe/jD3/hLGIzA9mmGe5ISq8hUjLmeH3aVIGIzWutzJ0VCJqeziAaAJt1uJmy7klSobIp1Famwo40LXHI8Ztt4qyky/Siw32MUS+0JDMj5Qg5k64XUUueQ6RKlWPtxQr9cdQ6ZLHqLaMrXlTkPxTGuzwMnWsN7mO/tLD9A2FIKn1R1nuPfmJbf2T91OLjll0iafQAeHeXmq/P1YPhICqd
x-ms-office365-filtering-correlation-id: a0136e1f-b956-42cc-3329-08d6145abc09
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB082265E42ED39D07DE9AD042FB000@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(70601490899591);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(6506007)(10290500003)(478600001)(102836004)(81166006)(14454004)(22452003)(6486002)(26005)(53936002)(186003)(6436002)(72206003)(2501003)(5250100002)(110136005)(6666003)(54906003)(3846002)(316002)(6512007)(36756003)(1076002)(97736004)(8676002)(81156014)(6116002)(5660300001)(10090500001)(76176011)(14444005)(2906002)(256004)(8936002)(2900100001)(99286004)(66066001)(305945005)(7736002)(486006)(217873002)(68736007)(4326008)(25786009)(476003)(106356001)(11346002)(107886003)(575784001)(446003)(105586002)(86362001)(86612001)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6FhdsGh+vxAUMwkgztBOMBFB2XroY90i+g3T243KD/FqIsiUEUUt3bj52H724ua+1LhsNX32/eJU31n9WS9JnnQ1czDZ6NcminD5pNrZQJXIAeTB4icJLh8SZdnV3+qQV6AMYKFnCzu6W67bjnFsGFthTHp3JyB1QfAqpDWVrNzjlCv/4R9vDJ9yzlRwEKDBttxvj0nzaq9WoO2jvRuMyGrLMVagW0kMnD8YvGuKKFxg7uOGKE6E8peyTPALGlmvBBUnhn0xDf+3d5Kq47pYUagQEiFUdpxW1vRI8fWtlazHC95jDGrLYk79Ak7C1gAdy/WLH+45/KsKR48YIrQsBgm3JH1vCg3cPHOEHN7ERPc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0136e1f-b956-42cc-3329-08d6145abc09
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:15.7723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
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
index 68d0a5c9d437..2c0db518fe14 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1616,7 +1616,7 @@ static int xennet_init_queue(struct netfront_queue *q=
ueue)
 		    (unsigned long)queue);
=20
 	snprintf(queue->name, sizeof(queue->name), "%s-q%u",
-		 queue->info->netdev->name, queue->id);
+		 queue->info->xbdev->nodename, queue->id);
=20
 	/* Initialise tx_skbs as a free chain containing every entry. */
 	queue->tx_skb_freelist =3D 0;
--=20
2.17.1
