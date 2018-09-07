Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB4AC43143
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF2B2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HwadlWfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF2B2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbeIGF1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:27:54 -0400
Received: from mail-sn1nam01on0098.outbound.protection.outlook.com ([104.47.32.98]:26944
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730005AbeIGFSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRBdlJDqtj6xGOJYJ+rh2OEKBC7GHjYgZXCLk4utiqU=;
 b=HwadlWfLs49Ir0w9wW3/JXMFWZem0F9ZVFzSFZAEqlCx4lDysA79oInRcQMrBjElib+61XTfHxFXou6/zE54vJV8hnh1UNuTmLQ4/f4g0vy9IejC9bJv1EVBOslAPRlFE9sti09ABCj3ixC57LGJZ6AHKCR4jnSeM0KEYWKpfgY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.7; Fri, 7 Sep 2018 00:40:40 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:40:40 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     John Keeping <john@metanate.com>, Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 11/43] dmaengine: pl330: fix irq race with
 terminate_all
Thread-Topic: [PATCH AUTOSEL 4.9 11/43] dmaengine: pl330: fix irq race with
 terminate_all
Thread-Index: AQHURkMXuFsKRCMTNEGHTxvC4fPLhg==
Date:   Fri, 7 Sep 2018 00:38:26 +0000
Message-ID: <20180907003816.57852-11-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:gVwq2Kfj/v85ocsV+2qCJVU4be6f+ze7hk60d+nQb7KUE2/FOn+hu+n88h3Ukgm2GWefSik7liLFYr+chhclTWw/PgxJusqJ/Suyv3q3dJh4BKbvOx0Yq82BpcE7/wIuMHs1LkpLnFeZRpHPp5iWdNEV/jcqp8UJGnzJeJk1EGtAPVQY9v5hz5qrPXaBOZYSQVsvvR4yxe0ZutYE+CliQqPqjD96b/lOZ7kWQ/wyNvhn6Xh2lpytjCDriww9vG1PqYl8iWNovDOFHk6ZiyNWURutQgzYLRHF8VVjh8ZYE0RIC5JeEXT5Yf1ZkOwspO++ztncImH8/deIlDc1vvFCOjorF2rcj6eG8nt19Lv6m/SevcLKTpvB9yvC/+Tw7Fb3R3BTNvorTDoO3EEfKdwU75Ivqi/hurPY/UpYroi/t3yPg5VlznlhtoAF70XDCqqzWutiC6pcrr6+gtQw6nYPVg==;5:GQp7Bm+DAsdnF+SNSrqnhGUKodDruSagIpCeiEqCVu+m+PGw9w6fcUhHOqBvhWeZpYyLyK2RWF8FJ4KMWByIYNeWDaaJbhwHOy55LzhgwHbjqidVnXCVHWn+Ab2VmmbMv01kIo/UCzFdeUMXposbEcE1YSvh4U0ueJdPNO5YJEY=;7:JGBV2HLTIfSrzybHlZ3LolJCuOAW4rSH/JYoTIW6qzgPJxZfXhMYRr0n+CKYTcuLcxcgCvMYBEMu08SgXi6VQsNZ2d8J/fpCd7s4I9hJ2MYNf5vhfMgiSApyG7E8T/ckJQOAkB18GBnjyczMZsgwD6eQqv1/nCJtwIZARzSTgNS0OfMxQkmgB6Lf4qQcWhWPE+yk2SLVL/TjXGHiIuhgzCohfau8IDeTjixkPuiu1pXbdlG9b7QpmhRTWkDjhn2F
x-ms-office365-filtering-correlation-id: 2dba4453-c984-4dd1-5dbe-08d6145a89b8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
x-microsoft-antispam-prvs: <CY4PR21MB0149E25277D1F7D1BDE32CBFFB000@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39860400002)(396003)(136003)(189003)(199004)(476003)(2616005)(105586002)(76176011)(446003)(486006)(14444005)(6666003)(2900100001)(256004)(217873002)(66066001)(22452003)(1076002)(6346003)(316002)(86362001)(25786009)(4326008)(26005)(110136005)(102836004)(54906003)(86612001)(107886003)(6116002)(11346002)(5660300001)(6506007)(2501003)(6486002)(5250100002)(14454004)(7736002)(8936002)(68736007)(3846002)(53936002)(97736004)(6436002)(10090500001)(6512007)(305945005)(478600001)(99286004)(106356001)(81156014)(2906002)(10290500003)(36756003)(81166006)(186003)(8676002)(72206003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: AM6TlhSZF+HBbCAPnCGV3EwQJK79TdbzZZ5/iJGZseKEwAoLc7utLZTFjjz8lQz2Wok37hPADDQLiXod1aKVo5/hAXYPlXgK3YFpk1qhzUvpncJ3FbqVZKRSWXwAcIRwlAGYQeqrdi0R/u0+4wXSpEkGpryI3Fs6cIDhB2mTw/OAL6JymAXyrpXC8duwwXCJmTqSiAPbuYkXWYuB6qOEdr0s4vzdbBH4oRWLJ8W6TrXlSMNT6wssBNlFgEuASl9Fb/+zxJ7C7O+YhJtiZ5s7Np8Tl5k86omqTK+ECdyWAlMdzpUBVIjZjwTgrM8wyX0kdooKZdvVJh19xP1qdvp4zsSVpDsroaC37R3WxjnEUaY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dba4453-c984-4dd1-5dbe-08d6145a89b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:26.3767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
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
index b9dad4e40bb8..6d7e3cd4aba4 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2167,13 +2167,14 @@ static int pl330_terminate_all(struct dma_chan *cha=
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
