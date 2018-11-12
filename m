Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D931C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396C62087F
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l68BqOpw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 396C62087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbeKLLnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 06:43:55 -0500
Received: from mail-eopbgr70085.outbound.protection.outlook.com ([40.107.7.85]:33952
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729780AbeKLLnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 06:43:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpX6TsKN/URuJtx0kGIC6lcSK9+u6LGRG+J9dfoKKv0=;
 b=l68BqOpw5bcdLxoufBS+nOIg4jPfUCyLDej1cwGn8AKZXSHbUdF9qCNHmSkIFUK5fIwoM/2WuXjFjyg0EwDXtB8zydl98x4Hn6rk2udvpobV2kHv2TN0/V1oEy4H6UoCvKcZSkY+ML+R5N7YKKoTnWCavnx5cp4YJwWJPk4fzdc=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB5033.eurprd04.prod.outlook.com (20.176.234.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Mon, 12 Nov 2018 01:53:00 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9%5]) with mapi id 15.20.1294.044; Mon, 12 Nov 2018
 01:53:00 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V3 0/1] can: flexcan: Add CAN self wakeup support
Thread-Topic: [PATCH V3 0/1] can: flexcan: Add CAN self wakeup support
Thread-Index: AQHUeipw/iPsnAY/lU6fAaKNWjQA9w==
Date:   Mon, 12 Nov 2018 01:53:00 +0000
Message-ID: <20181112015047.4252-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR0401CA0013.apcprd04.prod.outlook.com
 (2603:1096:3:1::23) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5033;6:61do9oVhRdP0qGTaq/+GFeghY2KMoZrzeqYe4SDRQp3w1EKLlcMiu8P+dm3deemiFYOzI3GPWSVjewLv5ICcJzrKQ7HiyepX/lj8B5+HLNkh2UqbMkv/GQq2IBB1YlFhPF4YAJamIaf5UvAX3sZlXBLTBl9vrmUycsDFuw85WFcZMOYf5BuRTi9USQ+hrZ3KnM8T3NRyfeS3rRZbofi+DyRxVtvz3jEikkXNcQ4BrPxt98zHLu/Y8Q+QOs4P7N8Xtexr32dyIyZj9tFk/+V8qnCLPtfRGbvpGGSWbVBnv7VcrKoqovKaJjrz3giQFiV040kStzcLBinLlDlD+Af10CuuwREQHmXDyTHqUR+c4TV17a3TAViiXIbhoKB262P4oMpEfDhu/NH9stBYBZlOwBfUG/+2HEQE46RG+oRZvw2d2AwB2pT+SwM++2qQPYx8QUiwyjL4RCNMWjMUDSA9yg==;5:hJPXc3Nlf8JZuW6oEHGaryS9xBffifEmSwh1lcYIs9l/pEO5Ut8wCiDAVUgnraPjbpPWvmmE/Dnho6qZBdCFQ0CZlh5seYZrCN0r1aDvXSXbTuXl9b0WyyWNJczz2ZOuM/YZZx+kmjL9EEVBq5bNH4K9l/rJvHEqPNfHu2ZneFE=;7:v8B2iWC0lYuhIphJ33oFO3xHfgpDmYLtlzlCCPSeKngqpx8M8IQ6wWKI3qXNmm1wBGzw9sIh0b7CbhAA5n+UY2HM8gpqcXZuGvGxYH8WaYAOtrV9IM0BzzsOokb+ihcQxq5qWY4rvIfryUMtjmSacw==
x-ms-office365-filtering-correlation-id: a48e17b8-d357-4b41-5672-08d648419307
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5033;
x-ms-traffictypediagnostic: DB7PR04MB5033:
x-microsoft-antispam-prvs: <DB7PR04MB50339A272F622E980D461969E6C10@DB7PR04MB5033.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231382)(944501410)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5033;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5033;
x-forefront-prvs: 0854128AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(136003)(346002)(396003)(199004)(189003)(54534003)(110136005)(99286004)(256004)(14444005)(36756003)(54906003)(476003)(71190400001)(486006)(53936002)(6512007)(71200400001)(2616005)(52116002)(2900100001)(26005)(6506007)(386003)(186003)(316002)(6486002)(68736007)(6436002)(102836004)(1076002)(3846002)(6116002)(305945005)(106356001)(25786009)(4326008)(7736002)(14454004)(2501003)(97736004)(86362001)(50226002)(105586002)(478600001)(66066001)(81156014)(8676002)(81166006)(8936002)(2906002)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5033;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GYrN88TV8JXY8QczueNiL7GAvTGAgMpbCVb78qn06XW4LjV9A79EDBFf0mygb1iHIjP8dC19SSTAINtNzGHjuz2PBQnDeIOA2QNqZHRwlXZwdsvb0OBCn9HIwMl7sR26lewgYNaS0YF9ofEVrkMZVAZ3NfL5JYJ+X+hL7TqfA7UIuOk7BebedS328/DXJD5EF7Q3b2i3u/pdhpGmokLdMTYbZJHkDnUPtjg+uprUXsffWAUWpCC4YjCQA+kgC5VlSKlQYVnTA5JosE9uT9NM9yTMEWv1IjZAT4ed5sMH5+mXh+5Vxq/wChR95EdMFImO04vhCXh9pNf/S5EE1wkX5GXLq6/GJkRKOfTKa/xkK40=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a48e17b8-d357-4b41-5672-08d648419307
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2018 01:53:00.3634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5033
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series intends to add CAN self wakeup support. The CAN controlle=
r
can parse stop mode property from device tree to enable self wakeup feature=
.

There is a issue in V2 is that the system can be wakeuped only when system
is totally suspend, V3 has fixed this issue.

ChangeLog:
V1->V2:
	*add a vendor prefix in property (stop-mode -> fsl,stop-mode).
V2->V3:
	*add FLEXCAN_QUIRK_SETUP_STOP_MODE quirk.
	*rename function.
	*fix system can't be wakeuped during suspend.

Dong Aisheng (1):
  can: flexcan: Add self wakeup support

 drivers/net/can/flexcan.c | 175 +++++++++++++++++++++++++++++++++++---
 1 file changed, 163 insertions(+), 12 deletions(-)

--=20
2.17.1

