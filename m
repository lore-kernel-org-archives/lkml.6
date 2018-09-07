Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A40C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB9D2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="QZDGRiig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB9D2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbeIGFZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:25:49 -0400
Received: from mail-dm3nam03on0102.outbound.protection.outlook.com ([104.47.41.102]:49926
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730484AbeIGFTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NxAfamqKkqJo3kJ4aQkuOKTW/X+FpSrmlLvnMQk+pQ=;
 b=QZDGRiigbpZVx4OXBm3SDhsNg++UQrgzPxhRKi8IcqxTbOVZuR/Ke/kBpS+AOnT0hJBYgOZ0NTqZrmcU5Z4m1gM0BcQqMjO8NBWR4rdjhAV3z/YhxeSn5SWsfRj6/fik+MT5TvEaxiEgOurGM46xIL+YrPeGqikq7/exRLmL5u4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0694.namprd21.prod.outlook.com (10.175.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:41:20 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:41:20 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     vkuznets <vkuznets@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 34/43] xen-netfront: fix queue name setting
Thread-Topic: [PATCH AUTOSEL 4.9 34/43] xen-netfront: fix queue name setting
Thread-Index: AQHURkMgZR1Ws6oFmE6v+LUe+DB6eA==
Date:   Fri, 7 Sep 2018 00:38:42 +0000
Message-ID: <20180907003816.57852-34-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0694;6:nJBPJMilta8XhPhD7DFfheyjIc/NedTngZx9F+JTwMs9Z9qOpwjl8CovORMRa4+rLdcK7aPCZnxY07I2IfUpgbNyp820f1iO9wFdA4fjqkkLSlNNBfxdXj7j1xUCRd7ZkkT16wwtra6C0Ft8CzfVRe4o4+wnFoDQzZm6BIHaKBgviw+D5NafldRyKaIfy5avcGfA0gCdjQV3cbCqeKAlvYE28T2fCRKkLNmWFdlz/GeJcXZgoseQyMXOIemVlJhum8pSPkyhY+5hjYI0mMARk0qlVgFWzBvO5LuTwBjnbuxwERkJqWmDqak8rBJ7KC8dOkW65ecTNS/niJO+LFElwFcKMSHEOetKS0eaH6YJnPcug3urI3qEhw29e5ZTl3UHCzl4NcChJTDFGiiHe7HL1lFRsVDlLtrWdYZxwVI1gvrkmJv817qxPxTxkjVkFZkH3Uxy8YGNZGGxk/dNQBrUQQ==;5:lMwBr56eQMyoONnmzgYyCKe8lU0YVefRU7PoKVUFNY3pMBxgnR/UgCc/VZLHE+sAsGN57TWsOM9AOSOhLryWdkqv0xQsyaW/JKN0QnzQYBguBD56hb7HUo176PFujxV93dN23uMymWHGBTjb4hkI6jFilKGnkoVjf+C18D0aJbo=;7:mq6lhl20YsfChhBMqo6XvnlXgS39pKaF4OXPnwb5nODG+ZfSF/7nykNa/aZUKF8rnTqAONTvPfr2+u3GuSeDBNgDSbsXAYdJPFwlbawM8q127xzDAHzmyDpQrWaBk+Mxay+Pl/9ZfznT0OKlHmqK3rzFV13wi7ptIy+1HWZ707LWA5x+L/JAE1CI9JMPMeLfI4QBuwLmNB3B5CWUbAc/tEimu2mBBGQHLWDvYBYCMxnt3JF0uOJTvtOrxnC4lyIf
x-ms-office365-filtering-correlation-id: 941aa370-cbe0-42d7-55f3-08d6145aa153
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0694;
x-ms-traffictypediagnostic: CY4PR21MB0694:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB0694119A4DBC96EAC8E3941BFB000@CY4PR21MB0694.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(70601490899591);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0694;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0694;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(366004)(136003)(346002)(189003)(199004)(2906002)(575784001)(186003)(86362001)(6666003)(110136005)(107886003)(54906003)(36756003)(25786009)(4326008)(256004)(14444005)(2616005)(6506007)(6486002)(6346003)(6436002)(6512007)(446003)(476003)(11346002)(486006)(86612001)(2900100001)(5660300001)(102836004)(26005)(66066001)(53936002)(68736007)(7736002)(81166006)(81156014)(8676002)(10090500001)(8936002)(6116002)(3846002)(99286004)(105586002)(76176011)(106356001)(5250100002)(22452003)(14454004)(316002)(1076002)(2501003)(305945005)(217873002)(97736004)(10290500003)(72206003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0694;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: jQ2t7a7kMQBjQur9rJ/DoKbEzcCkAzftiebzwA2eH4XhjCRbQdjojuKQRNJsfkOSrGPO+IQQhQnrAPOTPV7uFp/JnuFRpVFlcF7ttnZzj7xFzEjf+6e/ylkmTuHz6Ce3vqStcpgmW0KpjxCu3u/LMW6Sg2KbODAkWKcWVdL//beVvggdtgPHuSWUkdc1tO9qLndJJ2khwB/5eqfvN0l2jB4k+gMeZ/Wi+miCYXB9qwdMcxhlXRS4hmv0LZo9HVtStSGfXZleGr66PhrUUMphJo8/SA7Pg6t/utlvBA0/ViQ7MiNrYnHEFbt2TGjd1PMVlE9DTJZBCQmgAJ9SZxt1gZ4IHa3QYDWO4BvKhBzG3kY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 941aa370-cbe0-42d7-55f3-08d6145aa153
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:42.6743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0694
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
index cd2c6ffdbdde..2cf1b06a2493 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1630,7 +1630,7 @@ static int xennet_init_queue(struct netfront_queue *q=
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
