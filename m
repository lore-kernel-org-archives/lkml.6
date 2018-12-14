Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D927C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F01A206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="uskJ22Q9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbeLNPaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:30:13 -0500
Received: from mail-eopbgr70043.outbound.protection.outlook.com ([40.107.7.43]:22720
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726418AbeLNPaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ha3GpKHNeK6I2npqRsWf31Jw0l0nbHMZy3kOuhgjvxE=;
 b=uskJ22Q9kpF7mzvZkCHcd8rzPUGRTel9sHrnEwnx2mHd2KKInTLZ285L4UZuf7XDDMfMqjXSKsTGfCEauz4OvcfdKTYy+4L+PFTFtoSaav23ppMq8NNiK+3uzv9yI+uxQhNUumK3wX7nsqTtI6nUmimKQjLWJyPopm6bIdejTtM=
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com (52.134.65.28) by
 DB3PR0402MB3754.eurprd04.prod.outlook.com (52.134.67.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Fri, 14 Dec 2018 15:30:08 +0000
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb]) by DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb%5]) with mapi id 15.20.1425.016; Fri, 14 Dec 2018
 15:30:08 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 0/3] clk: imx: Make all the parent_names arrays be const
 pointers
Thread-Topic: [PATCH 0/3] clk: imx: Make all the parent_names arrays be const
 pointers
Thread-Index: AQHUk8HlzY+WhQB2ck6/TH6/+MaDIg==
Date:   Fri, 14 Dec 2018 15:30:08 +0000
Message-ID: <1544801400-18951-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P190CA0020.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::33) To DB3PR0402MB3658.eurprd04.prod.outlook.com
 (2603:10a6:8:2::28)
x-originating-ip: [95.76.156.53]
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3754;6:yd1MYxtAq4cDsZN/WvFR6BoXTgC2UqkY5q2mBeo6zwRNT0q5jRROpVhwQe7gkPBqxBTwt5sdBZyTi7QkCQKMOjgZaUMe655Cpfoz8QMsCRjWxtnkbIZ18+wSw9z1ZrjoIqzVlkVrxFyJ6VjMp6XbJZ2PFJ8AGE2bNC4n+UQWAkVUpwdw1JYaEjTvpQbYi+S9wV+96nq3CC0iGIQjpmnpcZf38IVl1wMJsNsWiDZB9pzkZ4btl2usnWQHTJqfh7PTJkaSpBw1O02eOpsUJvFeqKLjeQHuIbu2ZLaSaCZhJFO3pPUmbOYqSRSCBYXd5mrCrImqo+53DoobId8QkDHrsuB+qX/lsMTc2upbNQgMyC5xtF/83rif+cfaTAS4uo5dGErZGCa2Tt0FKJDTlpgxJfg8mKf2wyqbgAd1/5H96Gr7dCvs851G/Kjh7bwvGYuqc+DpSOeVMOQLxKC+Q9SBzA==;5:B0r9BcIKQwhRT8+63mCbTiCu3qfJz+K0olOtUcD1slDWBWNSvb2IHfqaN1IaJeFLyShK+cBxIIAko7I4VIJPuj2lQHHP1+vOR0RgXkTLcP0uXrhlXLtKEPMRgct9zfXxcIPPCqbLra7kIiP7YwYt3AQOFVnfUHPIhTD255Gf0ow=;7:aVJI0CEZtamO7Y+g2ddxHWGuD6wUXNKql6BIONpazf2q3bC70CusKnytiaPklyqRx35mlY/dDyfZbB7S4/UB5ZxDZmiJx6HYoQt6hCdSHgubadr0MhPk/SMr5XLPTGrtaGRsEWdwdZrLmHUXgEhozQ==
x-ms-office365-filtering-correlation-id: f402596a-b2a4-45ee-ccb9-08d661d9077b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3754;
x-ms-traffictypediagnostic: DB3PR0402MB3754:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-microsoft-antispam-prvs: <DB3PR0402MB3754F6F4581BB5435D2CC3FCF6A10@DB3PR0402MB3754.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3754;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3754;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(376002)(396003)(136003)(189003)(199004)(2616005)(53936002)(6636002)(8936002)(186003)(66066001)(97736004)(52116002)(68736007)(4326008)(305945005)(36756003)(25786009)(14454004)(2906002)(6512007)(478600001)(5660300001)(386003)(316002)(26005)(99286004)(6486002)(6506007)(71200400001)(105586002)(54906003)(110136005)(81166006)(81156014)(8676002)(486006)(7736002)(3846002)(44832011)(6116002)(6436002)(86362001)(106356001)(71190400001)(102836004)(476003)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3754;H:DB3PR0402MB3658.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YD002cw7RFfUAsSbP3QcjK4dYsAN0cV3Oqu9os2TqNmTFeVxTqlEOlabqu3NDitTca0YV3ync2PW0CaU5iZoC2Agpr2VAv9vlKmR9oquC2I14Bw+pZtOPBdn7h6vQevScMxpOaQ0BWUZbyvR9EY6CivHCcb2klUdFQF9XT5shn5Z3Ayq2Ggg4XtW8B4HvQS/3HbpznOI/qWS159duVimhJZ8nlcz8g/fBcDWXU+2+cdGap9gLSfhVvOoZkgx5i+PNMz05V93Wf9qeNbcVr6B6gAzwu/LDvU+FxncV0zH+cjcpo5fPsYe1Aw0TWwa4tY6
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f402596a-b2a4-45ee-ccb9-08d661d9077b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 15:30:08.3617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3754
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is mainly to shut up the checkpatch.pl script warnings about the
"static const char *" needing to be "static const char * const".

Abel Vesa (3):
  clk: imx: Make parent_names const pointer in composite-8m
  clk: imx: Make parents const pointer in mux wrappers
  clk: imx8mq: Make parent names arrays const pointers

 drivers/clk/imx/clk-composite-8m.c |   2 +-
 drivers/clk/imx/clk-imx8mq.c       | 194 ++++++++++++++++++---------------=
----
 drivers/clk/imx/clk.h              |   5 +-
 3 files changed, 101 insertions(+), 100 deletions(-)

--=20
2.7.4

