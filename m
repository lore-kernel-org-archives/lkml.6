Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412DDC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB29720663
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sUW2rpKW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB29720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408609AbeKWTSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 14:18:43 -0500
Received: from mail-eopbgr150087.outbound.protection.outlook.com ([40.107.15.87]:63664
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731866AbeKWTSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 14:18:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6nU8AfNmhGNjiP94oxU8US9jGyqqavLEPXxJbXCVlU=;
 b=sUW2rpKWP2YMWJDnpp+FhIIo5xWR+yUYHMxlmaoRdVidu59Kdf5uXCX9Ffhl9cPsAAACMNzLqD1uReoo0NOkj3rLJ/1I16kMzxnkS8lviw2c+EOL8S7NLlaK81lLodV6ITTZK27HD1wMF1SPZl8s/h2LvM2kIKPDsj8YWXYtQvQ=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB5483.eurprd04.prod.outlook.com (20.178.105.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Fri, 23 Nov 2018 08:35:25 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::28ab:d6bc:2c00:a54b]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::28ab:d6bc:2c00:a54b%3]) with mapi id 15.20.1339.029; Fri, 23 Nov 2018
 08:35:25 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V6 0/2] can: flexcan: add can self wakeup support
Thread-Topic: [PATCH V6 0/2] can: flexcan: add can self wakeup support
Thread-Index: AQHUgwd6wXBy9Svf4Uuk1UESPmPUkw==
Date:   Fri, 23 Nov 2018 08:35:25 +0000
Message-ID: <20181123083304.3232-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR04CA0182.apcprd04.prod.outlook.com
 (2603:1096:4:14::20) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5483;6:SoonGTXg3zQ5Rw/117HDFNHqrerM2LWFOlop5RB80kf71j9cMO3qSmxX3rr9YP+YloZwyCwUYmX+Q/pj/KSiYZ6IC2vT4KTTpPfL3JRA5vbDyujKIK1RJqBKVA4gk2iWrOmDd4JNMZQpivg9o/QMUABrOkfJN5VFZhmv47iUVDLOl52tCRJQ/cTX9SQBnOVNyrpQd08F7+mortwOhKo6qJS3QD+SKmjBP2+3cNl8Rbn2uNPU7e2Lxp06RCdLGcptybA7uxJ7jGxdCG9FInWs6MS9imNAxT49qDUtxfi0beeaheYu6Jvt14PLzwgxrag9nzHTuiFeGZfpw4QglAqNuSEzbeUGvpAExuAWzWCcp1kPmb1sQyJ0Q7TdHPXdNTxT0V4qGuVT0PBnfix9cVbVGcNd/UmNPaZkcZTZDtTG84vj9pgvXvi7xJm4csc5OKpK0jGz7A92IwbVeDCNikdP4Q==;5:Lk8BOWiQzCOgJXmK4KCr9bmX1Az73YqHDvrktMGt96MTWPnmy6/bW3oDlSwAYEH2WXXBfY1xwya+4O+8EqWBSIZOfu1oDpf49HV+/BCLnrLoh1uyFgWg4oHJQht6TSblh9jhsweHzYBHJyJK3z0syi/A3QElwUh0eq150z0whhU=;7:FsL+cSRVNkrYC1E05pJoMw8a78HDaLHFXKVqq8PJdwathE4HIWI6qD5iTbm0Kt5dY2b1h0/1psS+zk8COsPq+Zj0JBfNOrrEIQPslUibBE+jxdw/IO+xR9W6CshjFPxXrCtK0AHrN2x9zr2d5320nA==
x-ms-office365-filtering-correlation-id: a947ed6c-d0a4-4501-b4a9-08d6511e9d26
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5483;
x-ms-traffictypediagnostic: DB7PR04MB5483:
x-microsoft-antispam-prvs: <DB7PR04MB5483A441247552A6087FB6B5E6D40@DB7PR04MB5483.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231442)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5483;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5483;
x-forefront-prvs: 086597191B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(396003)(346002)(376002)(199004)(189003)(105586002)(6512007)(3846002)(6116002)(53936002)(106356001)(1076002)(316002)(36756003)(256004)(110136005)(54906003)(71200400001)(4326008)(6506007)(102836004)(8936002)(50226002)(81166006)(71190400001)(5660300001)(66066001)(26005)(186003)(52116002)(81156014)(305945005)(7736002)(68736007)(478600001)(99286004)(25786009)(8676002)(6436002)(2616005)(2900100001)(2906002)(476003)(386003)(6486002)(486006)(97736004)(14454004)(86362001)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5483;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PYOVPQvzK5G6AetHNM8Tq22fWsy4csLaML0czLvxMENy5ZW94YtiG1uI3i1/tOoQFYhcSPBzCXC9W2FhGcL7YKzr91p/6dqWP1y89kZrnR/OmbgyvFVj3lhQGlF643RwC3Z6oSLMjdulEBLaL7Oqj5oFNjvtFfNEXOhs9wLPhxFHs+Pe/1sFxv+GZdF7d9PAIXgHho9xMJikoZxcatLQgvU/thBHuWDtNIsUkdILdoDJsCsW+Flq0PCD1bqhKUzX/syqz3XofdSsnRVJz3K6RKV9/PGWj+T7CsyA17CiC+LuEzcXgQAyD6f70mO8Ts/XKJiqroN1qrbMBF826L5mjRtg8scCOQX3SJb2fvf0Qgg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a947ed6c-d0a4-4501-b4a9-08d6511e9d26
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2018 08:35:25.2088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5483
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series intends to add CAN self wakeup support. The CAN controlle=
r
can parse "fsl,stop-mode" property from device tree to enable self wakeup f=
eature.

Aisheng Dong (2):
  Documentation: can: flexcan: add stop mode property to device tree
  can: flexcan: add self wakeup support

 .../bindings/net/can/fsl-flexcan.txt          |   8 +
 drivers/net/can/flexcan.c                     | 172 +++++++++++++++++-
 2 files changed, 171 insertions(+), 9 deletions(-)

--=20
2.17.1

