Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB47C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B982083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IlhMseY6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B982083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbeIGFRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:17:34 -0400
Received: from mail-eopbgr710126.outbound.protection.outlook.com ([40.107.71.126]:45789
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729286AbeIGFRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ApkOUeBDSccO68SPU/ByTcV1dvT/2pNphxdCtw9Woo=;
 b=IlhMseY6t8IHvtWIaA4Q6smAL+usxY9yqPRsJiP8g596Jr0FSiUy9YcGKnG9nqwUNS/yYDyJwjLC49LbF3b+cTQDs2GWeDOpopVfH+9AX6gIJhK7NPMaTVwxZcQHD2DhpOiBfzkLFKcdko56uovk6fTBTOc5/BluP7ZaZYAZqU4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:39:05 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:39:05 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     vkuznets <vkuznets@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 54/67] xen-netfront: fix queue name setting
Thread-Topic: [PATCH AUTOSEL 4.14 54/67] xen-netfront: fix queue name setting
Thread-Index: AQHURkMHrjzD+WiQx0iezH8YSpCQXw==
Date:   Fri, 7 Sep 2018 00:38:00 +0000
Message-ID: <20180907003716.57737-54-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:p7Mbzkqygi1K9vkAKdKNT4Mfsc4JU840QpwdFzlbKi/arIIPvdYS0S5pZ7XrCEStcQppistVRIjyBzPWW3aL/bXhqi91M9APYMCQVQqtKma0cNXpgzbKYGEYzQQo3JvcYilXRdYv7vw/9gSGMhgm8cZfF988UUPNoswmghk4KZKSVVbKbdSTAIgxtdVX8VBb/GAiyghuRn4G+Mk7/vGFPiz1dn4nXrtVeptZwLXDNNURshiopXKiXSA7njdC7lfY3aCJ/ha/JE5ygv9i1pp8ztGU0Jc0gkH4+6pVOTjNjp1J1vxRdFyTKiqkiL6FAqDzXSlORrX9lUTuC4+eU8Q2rRldFnmU0fT0/m2PAH80r/EzyvzXolkVQHOEmfcwNQyZmJqV27oon1fVX1cyn5Ns/RtR48gjOzO3eWj3M5IffYjicSb1kUuBuWz5dz1KmU4St2Ct3O5PflEMFwKMBSn/yg==;5:hThQHx5drAyBaDpLhY8vrA8zI33ABhcLQwS5DjrtMqMYU8ktcZNdH8C/2v+YL7UZmSC/WszglocNn0ydm2+s/CmgBDPeLtS3kqgDKomnhDnMqzYXbvSu5c5ycksGBDrOwytwo/Wvdbouq5w1MBONxJt6W/J7bAK8j4SkdaVTWho=;7:r0J0pogFdgzpMUQ84Q2qr0a+OtFAeffVVCVSn2L8p5fljR2mpnZWyKSax8afLhSf/PGZoa1IbI0tzRcv8W13lTStgpu/31Nb9Br2Hwpk9Y9HKUF0K2MHxSByRu2XvApbbJm9g8zlE7CVgO4czsWQdV500NLCzg9UbXdLQuvjmBSZZwaJILTQwsh61tlAvE3aEgMzbQlJImcUMXGyg/L9V8YW+vOXyn3KGLSvBbLX2HdckrkPS4uXKMMyEsXBhYyt
x-ms-office365-filtering-correlation-id: 7d5d5e49-4f5b-4624-39f6-08d6145a5114
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB08395E17D91040350C7FD3DFFB000@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(70601490899591);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(136003)(346002)(39860400002)(189003)(199004)(10290500003)(99286004)(10090500001)(105586002)(106356001)(102836004)(76176011)(97736004)(6512007)(53936002)(2900100001)(6346003)(316002)(54906003)(110136005)(256004)(14444005)(26005)(6436002)(107886003)(2906002)(86362001)(575784001)(186003)(478600001)(5660300001)(6486002)(446003)(476003)(68736007)(7736002)(86612001)(11346002)(8936002)(1076002)(22452003)(25786009)(2501003)(36756003)(2616005)(486006)(81166006)(81156014)(66066001)(6666003)(217873002)(4326008)(6506007)(5250100002)(6116002)(3846002)(305945005)(8676002)(72206003)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: h7WGa1/YLwe7kA7CABA03YjY+3WHcVlmPvqAXIxuvYV4iakwdDoDBKeqXCy1NdLCGlG4zLWOf2iEUYKRHa0MjsfFs2K0e0jaBWvywVIDdHNQjKlMeDhMpk/xK13k0JdDRjoKNLom8GrT1DTSt62FZPeghM9lyaK7oEr0lEaHbdQOeL9j6uDKkEL8dQtY1IYs7ASBKH5T3WujeosRJKgeLKzgB+cCBYwp/8HH2DlFiSUBfMsQmuhd8WCCZoFFnvnHM+fhjtSV7CrCDOLEhBG/k81RZ8+kJ6YH50TyS9fgq32rf4xSSg3lfxFjg12BTSYGSRiAIzQ/deP1gFb6TTn+yuglDD0XbwjjG6DgZ3VC43k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d5d5e49-4f5b-4624-39f6-08d6145a5114
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:00.7780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
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
index d5e790dd589a..00c214348e69 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1611,7 +1611,7 @@ static int xennet_init_queue(struct netfront_queue *q=
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
