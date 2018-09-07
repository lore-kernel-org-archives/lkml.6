Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E332C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C107D2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PQT5hQvX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C107D2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbeIGFjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:39:33 -0400
Received: from mail-sn1nam01on0092.outbound.protection.outlook.com ([104.47.32.92]:36128
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728640AbeIGFOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWiTbD37BMIpUbGUS/wo91JWglb6GhHiFZjAwyv7zTI=;
 b=PQT5hQvXWzuh5HDJc+am3Vv85+M9pMkCEQjNANOEFX9POLBxqbnEdxHhP1El4sUMied2nxbQcLC6sPIl3LWtskrVL4T3hykaVkuSsYNL0bWxLce3X7O4TECLao8Lb/c9ylnzGnGTQERmx4LUcPF4zSz3p9I5Z7Ckx/YDed/ocpw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:36:09 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:09 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     John Keeping <john@metanate.com>, Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 25/88] dmaengine: pl330: fix irq race with
 terminate_all
Thread-Topic: [PATCH AUTOSEL 4.18 25/88] dmaengine: pl330: fix irq race with
 terminate_all
Thread-Index: AQHURkLF/4GjTzsUFUOE1HWfTspVag==
Date:   Fri, 7 Sep 2018 00:36:09 +0000
Message-ID: <20180907003547.57567-25-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0824;6:ihQGv6CpQ4ft4SLveV62FtCV4jVckCDLl/R6WlB521vgA5v0Yto1TjThhlS9Rbqd7Y+B3kaMbp/q4r6VGCfXzbcO8e46U+ceBTiZlPyAl3y5xDt1ZUDBLw4QT1cgBl5keJVufjrFgOswwFgMvirwxNjRwKN0MsYxsoa+LNngJuX7HVf8U3VdU8jFhNKJ9Oi6evJWGQj2QrF3jg/CfEVthiP1fCNPzOQlF6xcJE8ZNwKnQQIJOE/TmuLV4rGw0QcTHrYMcuVaiZb5yz32WqUPdLWx6e34umTGVniAv2436m+LpJFyodC2F8njmnjzQKFfCWCyTpiUwZdqfttXOi9Ju/srC1J94QKlEzu6xIuMOpW0tVHnARkaSQV9TNWanpNGIrZKa0X+mL5wENk5w4hvzVWA7wP63cKoQwLLo9jU2yBfppsdH7MGaicaDtkZQP7FSSPBDph7BM6unzj+6FU7ow==;5:zByJzgWF8/Lhql+yyQtGA3AoPWHIZUaJxyzMDVfPyx+GqcrDRslMjeYteERoX1a9tksf+UxNaxLgk/jYXHDXR9dukvzlwlhqnc7lhVbdgHvZzBYP/4cq1kJqXOtf22Hrh1czEW7P0q83w465H45gGyE+JTTSqvmiE2Ivs2BE6Hs=;7:0LwGMTGSSToHls6XSXdFSyabur/l0clsZdbk7HyyLXhNq9NE3JlymDFiVbwh0eQBlEtMro7lIRegba0vXxTpdPAlfzgOXW1PRleJ3nk6oK3uJt5IzZea5OZ5vHdRu6Q1nqk8AwDQu6VP4o42v1yv8cM6Q4cLGRATw/yKzP8P9KNKosv+Ddc/JJmA8AaiU+WLGOAbJpUzBpsVPe3C5pNqz659vvPhIS4hPbDKPAEJTtk1N0QkvVmWW7MMviXToiH9
x-ms-office365-filtering-correlation-id: 029cbf6f-24e2-463d-f830-08d61459e829
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0824;
x-ms-traffictypediagnostic: CY4PR21MB0824:
x-microsoft-antispam-prvs: <CY4PR21MB0824289A631CB7EC3C97BF91FB000@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0824;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0824;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(376002)(346002)(136003)(199004)(189003)(22452003)(14444005)(256004)(102836004)(6506007)(217873002)(10290500003)(186003)(26005)(5660300001)(4326008)(6346003)(81156014)(81166006)(110136005)(54906003)(72206003)(316002)(1076002)(6116002)(3846002)(8936002)(107886003)(14454004)(86612001)(2900100001)(105586002)(106356001)(5250100002)(86362001)(76176011)(2501003)(53936002)(10090500001)(68736007)(66066001)(36756003)(6436002)(99286004)(6512007)(486006)(25786009)(2906002)(6486002)(478600001)(7736002)(305945005)(2616005)(476003)(11346002)(97736004)(8676002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0824;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Vhv2jgr4C4F5cUpaqUMBhsTGfktsachU9J5CjAgB9QgbGTG5ueian7OVYBZDFgYO1Yo4Pdoj99Kr3Co5KDTzvHAtQHCtgNZwpWLDPTgzk2fN77WbrC9x0MQdOIk0vz6UBNl4aOzbxFuHDl9jUWkI6ekl5osDH/M3604t1hx7/MvRDVJyAWG4ptgJKcrw5PvfqIKb6ARtNQ5jY6YiJ9Yw+iJsb45MRWhUhkEJEzQ2Ysd+waq4vZZ1VqKpXXZikKfhBy2RZYlCu63rgEqCYCzgL/t8P5gtQvNADxsT8ek/Uos5MtC9jPhjXZ8OsgoFmpV5/fguWbpT0pVTLt5zCOgGP/H7c7gzSTYbnq7w+QB66eg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 029cbf6f-24e2-463d-f830-08d61459e829
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:09.8022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Keeping <john@metanate.com>

[ Upstream commit e49756544a21f5625b379b3871d27d8500764670 ]

In pl330_update() when checking if a channel has been aborted, the
channel's lock is not taken, only the overall pl330_dmac lock.  But in
pl330_terminate_all() the aborted flag (req_running=3D=3D-1) is set under
the channel lock and not the pl330_dmac lock.

With threaded interrupts, this leads to a potential race:

    pl330_terminate_all	        pl330_update
    -------------------         ------------
    lock channel
                                entry
    lock pl330
    _stop channel
    unlock pl330
                                lock pl330
                                check req_running !=3D -1
    req_running =3D -1
                                _start channel

Signed-off-by: John Keeping <john@metanate.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/dma/pl330.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index de0957fe9668..bb6dfa2e1e8a 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2257,13 +2257,14 @@ static int pl330_terminate_all(struct dma_chan *cha=
n)
=20
 	pm_runtime_get_sync(pl330->ddma.dev);
 	spin_lock_irqsave(&pch->lock, flags);
+
 	spin_lock(&pl330->lock);
 	_stop(pch->thread);
-	spin_unlock(&pl330->lock);
-
 	pch->thread->req[0].desc =3D NULL;
 	pch->thread->req[1].desc =3D NULL;
 	pch->thread->req_running =3D -1;
+	spin_unlock(&pl330->lock);
+
 	power_down =3D pch->active;
 	pch->active =3D false;
=20
--=20
2.17.1
