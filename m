Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D16CC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD34220664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 20:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WDYRpvNp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD34220664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbeJaFZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 01:25:37 -0400
Received: from mail-ve1eur01on0061.outbound.protection.outlook.com ([104.47.1.61]:31280
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725743AbeJaFZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 01:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bynX3HUNLj8CmuO4jiLx2cBkuvVboXgEQNNb236vow8=;
 b=WDYRpvNpvcADBTSpn4yJtgMYFZs7u3s4S6sPX+CZv9mgW6Ba1ca+yu1GYRvat0wKgOSY1Eq6wxmMtZQ7I6NhdLcU0pRmo1cUcUkoNPvfWTxY5DBFn5KyCBYiBraSMi5X/KY0QxpCzM8PGkfGzRNWXBjJqd5nqo7UK5As3ObXb/w=
Received: from DB6PR0402MB2727.eurprd04.prod.outlook.com (10.172.245.17) by
 DB6PR0402MB2920.eurprd04.prod.outlook.com (10.172.248.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.19; Tue, 30 Oct 2018 20:30:34 +0000
Received: from DB6PR0402MB2727.eurprd04.prod.outlook.com
 ([fe80::e012:b6c0:4c6c:c314]) by DB6PR0402MB2727.eurprd04.prod.outlook.com
 ([fe80::e012:b6c0:4c6c:c314%4]) with mapi id 15.20.1273.027; Tue, 30 Oct 2018
 20:30:34 +0000
From:   Roy Pledge <roy.pledge@nxp.com>
To:     "stuyoder@gmail.com" <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Youri Querry <youri.querry_1@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>
Subject: [PATCH v1 0/2] soc: fsl: dpio: Add support for memory backed QBMan
 portals
Thread-Topic: [PATCH v1 0/2] soc: fsl: dpio: Add support for memory backed
 QBMan portals
Thread-Index: AQHUcI9p2c2OddyF4EeFpGvf1GbrCw==
Date:   Tue, 30 Oct 2018 20:30:34 +0000
Message-ID: <1540931418-10697-1-git-send-email-roy.pledge@nxp.com>
Reply-To: Roy Pledge <roy.pledge@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: BYAPR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::39) To DB6PR0402MB2727.eurprd04.prod.outlook.com
 (2603:10a6:4:94::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [72.142.119.78]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0402MB2920;6:KTP2N4DznOfofnhJHfqn3Nuivn4BhIzSRzS28qIPHu/0nvI/GivjunttnP7JEwp7KFf/9KecZqnn0aFVtQ53/cdJ+4GC/6lcuEh4LgIjrnfYrNydIXLuPb9Imn4ChYhegTl1wZCZ6mwJjSrViaJsJlxMzNV1hIBzR+lGUY96emTk4KkTympaI+ykVOTQluZizTxP5+iTKhKYPG+FmF7xva3O0+KU7EBHNZ9axl89WP/tjurCuE1IV32iKZpjrVsDk7oR83LLsc8LIaZrz61Un//wTh3jy2tbas7hmLg5CNckOh5FNVl0bzJr0yS7jbraqApFMCjvp88ZVmyek/jBUKucD23Q3+JxYvLDoHR5zcPM18Ju573WRV7wcnPZV+HGgXXNcl0p7RKgViDgzR50+eyGjcn5u/LgB4DCgSMphWb66WL4NMVTpVjZJFIx/E1yl6dD0lyDEBbEEav9HFyVkQ==;5:AtiBsz1W8wSUXufEZqv0tKCCGDPm+YguApF4ZiCW28pbxlsoqttxFhrGv4qR3d53TJDrcpKtI+WPRbe7V7a4S7/cC5lOR2Si6l/S25cxfSvNpC2+W8vOsP56x8DQ/muHcPVmvWTIX3RzdxxPsrNK7kX+KGtn3020sN88MsQNico=;7:cn6rwYfTBfWOcO+kzm9S3ncztXfoviLsXw2TIE0rB9GlwuGYnJpkEIj3SEzh9TUAukuNIi3Cn28MKJ/ZmIlvvIcvj4MjpE+ZpgTmmdZOuhusaWVRz2Tw5T2vQxZchKO4cfSgepx9PK+rSwGQgY7VJQ==
x-ms-office365-filtering-correlation-id: ef097334-50c6-4a6e-ca83-08d63ea68b35
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB6PR0402MB2920;
x-ms-traffictypediagnostic: DB6PR0402MB2920:
x-microsoft-antispam-prvs: <DB6PR0402MB29209AF17593CF4B055482DB86CC0@DB6PR0402MB2920.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(227817650892897)(275809806118684);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB6PR0402MB2920;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0402MB2920;
x-forefront-prvs: 08417837C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(39860400002)(396003)(346002)(199004)(189003)(43066004)(7736002)(81156014)(8676002)(99286004)(3450700001)(6486002)(81166006)(2501003)(68736007)(6436002)(97736004)(8936002)(2900100001)(102836004)(305945005)(14454004)(71190400001)(105586002)(53936002)(478600001)(6512007)(52116002)(5250100002)(6506007)(386003)(36756003)(106356001)(71200400001)(186003)(5660300001)(3846002)(50226002)(2616005)(256004)(54906003)(486006)(476003)(110136005)(86362001)(44832011)(66066001)(25786009)(316002)(4326008)(26005)(2201001)(39060400002)(2906002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0402MB2920;H:DB6PR0402MB2727.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wC3TZWzuXsIBlnBBJ3REtBTUwiVZKapwTiuFHbl3cny2amE7M72RUlSKzwowuEv2OXW4bY2DAuIyHT+6HzoXeizO5mxlTuADHzCrbtGvjvj4EQKl7RrY6OrccFXrRR1N3K20VdbOCIqpOWm1S9RyAyo/ot55XA3Lu8IYBW/xBjJT+LC6EFk2n01J/pO42ubVyl9hTCcZGDnhotrjKIHUUdsv7KP0v2bJkYkR9somhoAt4ywjyUnA+hYEY4Rg64Apm1cnskUvtWlhsjMzoCAcIpu/SiiCrMuzRNzivuSYDqQkWPUfCcxhaUQqVv9URPSMjmkUgF+p9M1ClcL0jliDcOYJqyytKcaxTFabir7lkeg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef097334-50c6-4a6e-ca83-08d63ea68b35
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2018 20:30:34.7030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2920
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for QBMan memory backed portals which is
avaialble in devices containing QBMan verion 5.0 and above (for example
NXP's LX2160A SoC).

Memory backed portals can be mapped as normal cacheable/shareable memory wh=
ich
allows the portals to migrate between cores without needing manual cache
manipulations by the CPU.

The patches add support for the new portal attributes in the fsl-mc bus dri=
vers
as well as modifying the QBMan driver to use the new portal read trigger
mechanism.

Roy Pledge (2):
  bus: mc-bus: Add support for mapping shareable portals
  soc: fsl: dpio: Add support for memory backed QBMan portals

 drivers/bus/fsl-mc/dprc.c           |   3 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c     |  14 +++-
 drivers/bus/fsl-mc/fsl-mc-private.h |  17 ++++-
 drivers/soc/fsl/dpio/dpio-driver.c  |  23 ++++--
 drivers/soc/fsl/dpio/qbman-portal.c | 148 ++++++++++++++++++++++++++++++--=
----
 drivers/soc/fsl/dpio/qbman-portal.h |   5 ++
 6 files changed, 172 insertions(+), 38 deletions(-)

--
2.7.4

