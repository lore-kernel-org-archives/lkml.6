Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF342C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E59A20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EFRnROo7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E59A20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbeIGFQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:16:31 -0400
Received: from mail-by2nam01on0136.outbound.protection.outlook.com ([104.47.34.136]:26290
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729757AbeIGFQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLU/cHz8VJ+BrT5dfvOB3MCs27MoUVOKVTszyASvkho=;
 b=EFRnROo7YpEpDEVYpMAEU/XjL5FeTy7qgewbgf2BeY2fzqUwcOWkSlzOQJ1gldyMmHurZNWZbZLV9crf3ht2lUfFk4HMpuWEpoO1q3x8dSwFu8MCW/UJ9E+wGnlitlPFpUJ2k7vw8nMMMjyPc7aRBK0eV+bQ8O2vG1rgNdstlWA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1143.1; Fri, 7 Sep 2018 00:38:18 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:18 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     John Keeping <john@metanate.com>, Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 17/67] dmaengine: pl330: fix irq race with
 terminate_all
Thread-Topic: [PATCH AUTOSEL 4.14 17/67] dmaengine: pl330: fix irq race with
 terminate_all
Thread-Index: AQHURkL2dGIqN+sU1EqMz8J9vJVCkw==
Date:   Fri, 7 Sep 2018 00:37:32 +0000
Message-ID: <20180907003716.57737-17-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:1YwHMcyUz3+olcWvvmfFsksyj3Ma7i02K4FUoAzvf3bQMTDvB5tBhE8taBvgDG7LnPdvcNnFriz5AEv297Ho4QTy9Il1VQR3fzjduK07SDFQXo05OJhG5eSm3pg/deS6bdEhso7AMWsXgxqOnwnKh0EuxFbytAVQ9fJigmhzdgtEc1edlhK0hzvCekrH5lC0k8lgZ2uy0m7CPfvJYaDXpKvEcxKU/yHjKshKG8pcNa6L0v96ZWCwZinsD40+iujO1J/8ES82rkgwbMdaMY7u+l4qV+MHUhfgpml0IzwdegkgLl0PTwr8owfe0TtryCCEZ4oQzDuhHwDnqSnJqZ61A7ulJzwUyoJUegb5dWOG965sJmJjjaHzwmbKiQGLSXTI0T7osJ/4zjwVJbZkZJn3we9gzxgKZ6TMG1cl3MMFqaeyBl6xFOo1F+TiUwHokzyz5D0osbdKmReUR+innFWeHQ==;5:4NdxMd/TD+D9Ui4r/mWSsiEJuFmhbmalk1u1ofuzNmMrMBLuMIZxfeL0/rLCpzwMm4UBiT0/L7+/Kmyyuzpn0quaEdVc/tdSSUx8yX2OxY8pnn2zeGheFMvNgcBLW78J6kAAtlR9dxy1uQRSfzUZCI2hxy9vkFtYxeLQDeCo0R0=;7:UK1G2+gZ33Ia1eByX4Wq8LNxqMdobWI0efGJzQlcWHFU3WhU62S7NanFcMHJnlyrEUBPiHncbfgHpEhr8PwTlJN1N24tpM6nhMUqFEpHCJANvV3OAM7ye17fi9mjy9XSkIyCDCC+MjJXE/hVEkom15J33+nqbU1dXyv15CiOwjxpDqt6an6cTRuFbSCYU4alEy7A1IXZ8mt6Kd0fSngxu32A2jodRCjbClOP0ePSRV9PNcygE0ddcwshyrQFovI3
x-ms-office365-filtering-correlation-id: 5f2abd3e-0245-45a4-3650-08d6145a34e4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB07572632E746166F7A87B78EFB000@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(8936002)(3846002)(81166006)(86612001)(6666003)(5250100002)(81156014)(486006)(99286004)(6486002)(106356001)(10290500003)(107886003)(256004)(14444005)(26005)(11346002)(14454004)(446003)(76176011)(6346003)(5660300001)(10090500001)(110136005)(2616005)(66066001)(186003)(476003)(72206003)(2501003)(54906003)(316002)(6436002)(86362001)(97736004)(53936002)(22452003)(6506007)(102836004)(8676002)(6512007)(2900100001)(68736007)(305945005)(7736002)(217873002)(6116002)(1076002)(25786009)(2906002)(36756003)(4326008)(105586002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: x/2ONsdYj1SbMVzNfZme/yy/oImSX8EJzWgUMrqJbZzd9hLefeGQ6Aw4BbrnuVIgDbuCWupXqisM+plc0J0oaXUrwuOjbShdaBL2Ma/5V1wVMWLHbJGTedc3nzRpAobll2MG+XLvDNxC2jjcwA8IY9ZDmaltZgiajv9r4B8rKAS7XE5x8ebzgbA+KeCEKO2UeUu+qM2JFU590Kar8HUtEY1QMgh6iVOIECbmpm4BdH1uAqKUdwtVBM9UGBUAgdkqHx25o57R7dBc1+jzieMYjCX65/XPbh8brg8CbPP/fhNijpySpK0cfHwsNFZgwxLHZ4UuGngyZhKdEoBcFJzZqkd4dFq+5amv8VZhPBZzVH4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2abd3e-0245-45a4-3650-08d6145a34e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:32.1024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
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
index d19862f4dc9a..6afd42cfbf5d 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2142,13 +2142,14 @@ static int pl330_terminate_all(struct dma_chan *cha=
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
