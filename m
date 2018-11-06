Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886A7C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 03:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF872084F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 03:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XfZjekG7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BF872084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbeKFND0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 08:03:26 -0500
Received: from mail-eopbgr00065.outbound.protection.outlook.com ([40.107.0.65]:25535
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727049AbeKFND0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 08:03:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rxaHNWcqATOrsWPvLmb4QccA0Yka31ummAM5ZsqrBU=;
 b=XfZjekG7zpFCWj+8Hj8GCYsjONREX3PTnXkBjE8Z5W4QqYpJfFW0HDobIwnkz6VJn3FZYZIEa9qQQkORlm01D9XtI07CyPTRhLyisZzbm1JnaiZX0AIux1q14A+hPm2O96v3w8PfSHU0JkAoIRWXi5DJWK7QBXk/AfDRCWn3SLc=
Received: from DB7PR04MB4538.eurprd04.prod.outlook.com (52.135.138.28) by
 DB7PR04MB5068.eurprd04.prod.outlook.com (20.176.235.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.20; Tue, 6 Nov 2018 03:40:16 +0000
Received: from DB7PR04MB4538.eurprd04.prod.outlook.com
 ([fe80::1d00:effc:853f:267]) by DB7PR04MB4538.eurprd04.prod.outlook.com
 ([fe80::1d00:effc:853f:267%3]) with mapi id 15.20.1294.032; Tue, 6 Nov 2018
 03:40:16 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH v3 0/4] Correct dma pool for imx-sdma
Thread-Topic: [PATCH v3 0/4] Correct dma pool for imx-sdma
Thread-Index: AQHUdYJucz7zxVN5U02w+5UfDam2OA==
Date:   Tue, 6 Nov 2018 03:40:16 +0000
Message-ID: <1541504525-25720-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:203:36::16) To DB7PR04MB4538.eurprd04.prod.outlook.com
 (2603:10a6:5:35::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5068;6:u8DHh4kQpjIls87/o4RoJC+eEN7Km5owd8S0x+VuWtFxnL54OEurRF9Tfbwm+XLppNZMJjvcu215BeEdRq732k23z5IBAKkHekDOuPDaCQZ5sn5/rGOKmLRmypjmsZOotxvMYGtZdMkOKx6prXZV0ISagPvowvqYUYq6qwzkaDNwhMzIMhZrXKWXN3rZrTV9PB2+ode4HI7fjG4HpQUraalsUuiCDY6SnAYvif0AmRY56ZxZEkzvOUZFAJcIiLMRBs20yfjQa50F+M8/66h4DWkKNwkS4lln9MiHCB8f37R4lE7K6e3tjOFlMJ12pKudt+UJEaSFZTG7rPGVh5Kd85U6qRdRprzGQUmO4PU8pGKDifuP49uxdGAKiuvvsnnTr0xIsG+cUZSUiJ6Cv3/UcWnBfF/IbahvVkuxW6uK2RoR+4RQoICKaHKYtUxDnco2/4qc/XHIeI+ou3By4jmsWw==;5:CcWg2BI+fjMBTNrOE2iZT5vQQNfyHol3+Bvb2VvUFd7kL8CafQ/g/cCGgCsu7cS5watBEBE1nzgaC0jPAqxLuOJnPRLWiZx0L0DJObf6Jn8Yo81c4tqBYyKjXDlIhXu3FPL2khtXw+yBE1SwhQBKvIvt6g90/C3VSG8TEqQCkvU=;7:iW/b/AOIoi5B1Inl2SLeLpmUpl55FwipjAQ6DMTxiEHnNrbcGFZkNer/6Kz5LJD+QF+eEGyUFWZAjONs2vUO+D/GeegQXjB95yjStIK9ckdB2evfSf0yuXslxd9k5ig/JtBQMwzqq5GSqRcR4vsL4w==
x-ms-office365-filtering-correlation-id: 2bbfce5a-9153-4b26-30f7-08d64399909d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5068;
x-ms-traffictypediagnostic: DB7PR04MB5068:
x-microsoft-antispam-prvs: <DB7PR04MB5068BCA33EF2D3224F7718F589CB0@DB7PR04MB5068.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5068;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5068;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(376002)(366004)(39860400002)(189003)(199004)(52116002)(7736002)(36756003)(14444005)(305945005)(256004)(8676002)(966005)(6486002)(386003)(68736007)(6116002)(102836004)(97736004)(5660300001)(6306002)(6512007)(66066001)(2501003)(478600001)(3846002)(2900100001)(6436002)(53936002)(2906002)(6506007)(316002)(26005)(14454004)(8936002)(71190400001)(71200400001)(186003)(50226002)(86362001)(99286004)(486006)(25786009)(4326008)(476003)(105586002)(54906003)(110136005)(81156014)(2616005)(106356001)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5068;H:DB7PR04MB4538.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: K1KRTV//h/lbAhcyDLo5GohJ4kTGahaBpKyhlxFlmjI4dPO9SG6UQiUwjpW3qRIb2FU7PRFhxvJ4ohtQryrIPFMKUIylS1fExCWdF2HKorLJiMGfL4ibZLiRMUnJkJCxPNQFIPUNSLhf3Jtn0Xgaje5bn35dENpx3kPF4aJqcAU7ilB9/87TKoAyRel/gOSWBep2N90IxSmBsr2eW2k9rsdQQTJr4Z5KH0aI0ZhtiIDkZEAhoK8/LoW179+5xJIke6bT8OsEa9E+5jyNEKF2MmPTgfebcuRs06yGzrty1kFiCXLBUdz8hBvuznJNdq2fyywLI5Mu0+PiosQd+Ca6Dc6CEsvnQ3spxSRMy1chzxo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbfce5a-9153-4b26-30f7-08d64399909d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 03:40:16.2147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set to correct dma pool used in the commit fe5b85c656bc
("dmaengine: imx-sdma: alloclate bd memory from dma pool")
because all bds should be contiguous in memory in multi bds case
for sdma, but dma pool can't statify it and cause transfer failure
then.Thank Lucas for the making things on the right way.

This patch set is v3 based on Lucas's V1/V2, the main refine:
  --fix the issue I reported in V1 but Lucas workaround it by improper
    way in V2.
  --add vchan_synchronize() to kill tasklet in virt-dma internal.
  --refine name: use sdma_disable_channel_async instead of
    sdma_disable_channel_with_delay since no delay indeed for
    device_terminate_all.
Please refer to below link for more information:
https://patchwork.kernel.org/patch/10601111


Lucas Stach (4):
  Revert "dmaengine: imx-sdma: Use GFP_NOWAIT for dma allocations"
  Revert "dmaengine: imx-sdma: alloclate bd memory from dma pool"
  dmaengine: imx-sdma: implement channel termination via worker
  dmaengine: imx-sdma: use GFP_NOWAIT for dma descriptor allocations

 drivers/dma/imx-sdma.c | 69 ++++++++++++++++++++++++++++++++--------------=
----
 1 file changed, 44 insertions(+), 25 deletions(-)

--=20
2.7.4

