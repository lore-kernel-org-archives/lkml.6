Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78775C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C368208DD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gl/ba8vy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C368208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966186AbeFOToL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 15:44:11 -0400
Received: from mail-db5eur01on0054.outbound.protection.outlook.com ([104.47.2.54]:14776
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964930AbeFOToI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 15:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRImDaBHINEzjUwVgJllDW2glGRPTjNBXrApTBfhNTQ=;
 b=Gl/ba8vyvT3xJlbFJcRDddr60fIQRsBUE6buh5Xj33iOxfk0Kko9/mQVsd5mj3H04RxywWhr9viFg9OmTP/iRLQmfuI37GN0aNFM5krNNz0RUf1Zm0d7Szdq4N8LyAY3vA6ZKoicPkvLKHzymFWquj2agnQSUwIXOgUSv3qa1ZM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM0PR04MB4292.eurprd04.prod.outlook.com (2603:10a6:208:67::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.15; Fri, 15 Jun 2018 19:44:05 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marco Franchi <marcofrk@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] ARM: imx: Make DRM_MXSFB and FB_MXS coexist
Date:   Fri, 15 Jun 2018 22:43:41 +0300
Message-Id: <cover.1529091248.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM5PR0701CA0065.eurprd07.prod.outlook.com
 (2603:10a6:203:2::27) To AM0PR04MB4292.eurprd04.prod.outlook.com
 (2603:10a6:208:67::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4c56cd00-fbd7-415b-35d0-08d5d2f85a89
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4292;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4292;3:GsVGJTrV4val3rwilTpUDBOo+gjV7wWxp/aEFC2lYwtUoMixwp6QBI441QUFb5H49PDUowDWGVEBuPNnAmQrvNLj1EHs+0XhJQ6hLj8KCoeNS1eR7M8b+Yw6rBrkGMBlTRF3KAY0StQ0yaIJYVm3xcobVGM/f5y6iiFsRx3WiDPaZqgnYmTyIUvGlZsZuGTmgmFqXWVTnr3sgJ/1+7Rsel9Lr8wDyeKAcpstdY/W0jWJbg6LpRR698xxh1UET5WQ;25:ummzJPHbBnDhpY2PK4+fMWSJttjIYo4r65nBd6o+NRhgZs/SIWKwiozWih4ATI44aKvdd/2tNfi018Zi7x6scM39ejJDbn+DQMb/z2M8/W5W5MSZr0OxxzrUHtiE69u4npFGLEf2yWmqYfCy/WEdjI2kYWIOJ1meXvQ2uZ2LYLl51ijp2gaKLypVFCsba0dcKH25ntsjEwV59RuLStYxZRMQg7hmAaMM40zWANP4VVLTTJc0pTeZAtd7C58bPQJ7Dl9kjm3/0cFA9nJjngQ6ACesQEYEzFdTw5iGkznWrFJBodMs0ojLqLTFxBNn36uB6GNVGd1trVd38N1vd0Auaw==;31:v4dC/q1OucggLSNa6kvVU3Tq5ev3vrc/JmtHpz97O33/7UfmOvVtwlO6+hbLQY//62+xJVwqBGepLQN+l2ilASW20ukMy4GPsUwBR3oheMeLNbIWKf2iVRXHozUtPlUQ5VyBenuJD0sXYNfTuZe0j2oxTAOaeAh1WUyrEYTBwAT6FagrRWdy5DdrTFN1MEAdgbwcsazCkLQkq1kwcTDLk+grtk3ouS3O66bLfqcRdzk=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4292:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4292;20:SKgWS26DFicdYvsoX8c6q6M6B1AGePkGCiQRvDztW3kKrFPuUQ7aq1Ri6lSvS6ORWnPdYp+XYyy2jD+N29P5TOHpLF8nMXlmUmjZjmU8yzE5n+3s8gXLyfzDIYDvy09KgmUDOjHEPAIEnIXvTI57kyVhwu0MyLzFy0o76sSAeERH7kr9hlD2HRyUvdwmpjMIqs6gbsp9JCgjJOKgghurXNknyL3kkzNT93+GCBFBz4jWVVOBr1T8RVgaczGpfBdBUaMvLKOqGes3gKATmOjPk/OVsaqxValAsaVH6DrrsvC4+/e2T9er/77ep2ssplmbEfjuWmKEXEjkHRsjvoShmuAwsEma59r4eA0lWHNgRzIoPkP30fkTQwzXJ7hg2Xu0CO0jdyhcH2EXMNrNtU/ju0Buwj0IQWe6qYuQlwUTrUuPYQiZPe27xHCku5gmOzS32hI3Ltz7xb5mn5T6R6igE3HySFnHFtKrn65ZaMILQwL3uKajxHJ84Fwv72/uB0mk;4:pYcnszWP+Ho06bRJuunOIGxaT4xw30dHwJtRy9i2ID838JN3qLUDxUWDdQJVTwYph7+oeKIDLZZlev8BwFw4pwuYcASooKYARRgPEj/QCgdbpXn8LKNaGckAPn/ICTQR/dXRvWkKjApQb5CtwaCQ1j7j2kbyhGuo8jXKQjEBmPUiY6BWLosdkGRc0c8/bPEY+LNCtou/r6tg6dj0xyLQ3VCidn7SlmYZqG9dLUC9FZNWzlXHGk7nJEptkMjjVxLzXC3aQkgFI4h8E1ozkufVkA==
X-Microsoft-Antispam-PRVS: <AM0PR04MB42927BA41FAB023863DAC9EDEE7C0@AM0PR04MB4292.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4292;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4292;
X-Forefront-PRVS: 0704670F76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(39380400002)(366004)(346002)(39860400002)(376002)(189003)(199004)(39060400002)(54906003)(110136005)(16586007)(53936002)(106356001)(316002)(36756003)(25786009)(575784001)(6666003)(4326008)(305945005)(66066001)(86362001)(5660300001)(26005)(47776003)(478600001)(97736004)(105586002)(7736002)(16526019)(51416003)(386003)(81156014)(6116002)(3846002)(52116002)(68736007)(8676002)(6506007)(50226002)(81166006)(956004)(59450400001)(8936002)(486006)(48376002)(44832011)(50466002)(6486002)(2906002)(476003)(6512007)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4292;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4292;23:g8CmT4c4zFNx8cfJGQb6mOtq3NKnYwIUJ1zU2o2jI?=
 =?us-ascii?Q?sQIIkp+VriB0D30i6Qei2UenOGJTzYqLps7dBF84CWkQWavVXZ6QtqW6KOpf?=
 =?us-ascii?Q?SMHh2QAM+fR5nLxaRikU8YK9S4q+AE5Hjksfuznl1bRahRWW6gtuccAVgXjs?=
 =?us-ascii?Q?7Np4ao4TCiVyRKWDfl4rzJOFQ8JszXhVioxvfSfBk+k1QZwvnxbKqA5t+5C4?=
 =?us-ascii?Q?lHZSmf7mo1qjs8W9jXLwPbGlJ1lLe2D5mcjkS1xzi1v0La6bAP+Mz7Rc6xZV?=
 =?us-ascii?Q?F1eEDtspp3Crf52izuaY6E6hyzwR25I+OE+3Dp9Up7M0goSiYrmX8dd/25V6?=
 =?us-ascii?Q?ImqcSvExT/ClmEWr5gOt13jV6Qi99lj+d8oNH85vksB3gFtejUmi0263Ilta?=
 =?us-ascii?Q?5LR7Sj6PwB6SGJPsx5OcuFXI9fxFPedqu1gigJNFPINpJVBodqx326CVYsjd?=
 =?us-ascii?Q?IXLfMrS5xKkrO5FrPIfdTXm/KBX+OB5CxCKu5o3JluV1/b3blmAfYZjD8Lzb?=
 =?us-ascii?Q?ZPHTE5Ie3fMTtwlAIan8ta5Vc0zVFJVXrDvtBqv7J0dqZTN8R0Ypx4MnXvke?=
 =?us-ascii?Q?o0qxfp19naLTCDdS0acKufoPPmRG9BVH+Bw5BUJx+qrL9qRcceq/eABi779K?=
 =?us-ascii?Q?uw0HWz1k7I3Urkt0xM1kg8KgZ2v9+LTMgfdoQXSyQZw6bi9MHEul7PF26OCW?=
 =?us-ascii?Q?i0O/xwOqCS6kBglFtbhgjAtnSBrq16X/nqBQOXbv0bfD66WJfXiAwn9dMg9/?=
 =?us-ascii?Q?xjLRBiNUKSdwc3sbB4+Fg3/uifKK5PREhjtVyhq3qHq4Ix7YmURN52/h9ruL?=
 =?us-ascii?Q?g0zxnkijPhxzar6dewcPol7X6LMy8adDk13raY1V8Pqbw47pMh31EylsAphh?=
 =?us-ascii?Q?rCZBPN0F7MStdDnfPSxWc18rUTDuDntb6+U/vPk8LS9o386LcNEH1CcDfUiw?=
 =?us-ascii?Q?O1m4qWqXEkRhDgQGLqPJhqKJKnCWhx/CY4+lLTWnspjJhbPKP+5pcgS0IpKo?=
 =?us-ascii?Q?WJJlpkbvfJQk/eA7JV3Oe5jMVtJ7Wyuz/FPYAVAZz8mc1ly7MUpAvj3K4Wv/?=
 =?us-ascii?Q?7+YUJDOmrTrTRAHy753PG821gegryZUGcoXvkuWZusunwaEu222zvNv5zDAs?=
 =?us-ascii?Q?+kD5v8DifPZsloUpP/V6xVyeW5655oHbkEsWj5nuKXigvYBC2bWtc4fagj4t?=
 =?us-ascii?Q?9V/gSBHbAl3Mf1NglsCeFuuf90azNPWgeKtxIj58XLD1T5WKpEL0P+TKz49S?=
 =?us-ascii?Q?2IE6FfdkrvsOLyOWsk=3D?=
X-Microsoft-Antispam-Message-Info: y+Haq0DDGDhKctjsPkYHtjUrDOgJdKa3FEzW8ZxQf/8Y9JLTOHcWugoT6aSNaxhD8YTPh6fB8GLbuPxvvvVkvJ+41i/89Si6idXrOj0umt2WebD+QoBzXQJ8iKrOTFNctZh4xP9ZZuncwccSTCsXY9Y1cz7CklzLECZKFqwSbAtFNuLIf7foQ96JEIOk0o8G
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4292;6:Cju36Pp20uvvcUqDlx9RBv5sSZ+QCExDeIhS3vk28KDmlENAp8U4WZXtPXbqFLr6svjKTuxuXdjWDhJsFjNvCe1OX+ohqnQbCx/Nt6GWjxpxO8oNq0pqe5p2MAYSrq0GhoyZpwdUgOVzl1z/lNNIm91NOEcci58llW2Dmho0weMNc7llrvmQlH9N0zhsohLAcXeGC7h5aaqXsSJbWFwx2wWcOkcixGf5nuc0j5bF+rOTNi4jsbvR/+Tw4np+T6LSB3O3T/rrV1uX6h25N+KSWb8YqNnw9txh6JeTUoJ5q2BCZE6QIIVKBVbi0cx519lVrNtPZQb6WUemHQOzXu3EpiZKs2kL6drS6uEl+i7D92rhe4520pL+7E4B4Bwe9MIx16uZr7iyPtqg4sBiRk9n/eud9zgcejyqB46aqLpONCouIhHp70oDw5qBzOu7G6DHpy5rnSyJQAGm3Urj0t5bFA==;5:QVix/Q9QGTMnUl+xf8d7BZ8Deo2Sf1kfJ1H9Kuq0A0qW7QfaM4jjQlD6loAm7YNeqL7FETVCZe8gSrv+bpDdFX3GliBJgn7FbNLQ7GiK0kKImp/J3WN1fGFmL15lct1HLD1AAK1i+24jRaiyYzbsPg1oPgIODLhYVAXBXUGI0v0=;24:5c2Ujq0hF6Jjd+bjgLZ7aIhn0p7xRvYjAU6OB8LHa/9lgL/SdM7GLRwQ7hpW/xH/eaoITBRXI2BTzVWGMVx3X1unsjXDRXJHGR9mSBrauJ0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4292;7:ARfWlJ+TkJyL5yfpOv4nHC2UeNWZfP6cVAlKAQggQfnL8PSoXx6VlPGVv3OkCsZX+6bDe2gD4v9UwopaZbCUNss/wepaAvsRdjx9nDCRrvasid/bed64B+79hNhXkQvFHKBpKwdRwQz3SpMx6aeziTu0Q5hcoNanaUHTEAAjzvvHU/26DZNQ2uPcQn6RRUwbXcSBCn+HSDx+aMDDnc7vueIGGuYc4ssGqyR6gV9ry51j8Qq0pS5Ydiucp+ezggEw
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2018 19:44:05.0144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c56cd00-fbd7-415b-35d0-08d5d2f85a89
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4292
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some imx boards have new drm-style bindings for lcdif devices but using
them requires rebuilding the kernel with FB_MXS=n DRM_MXSFB=y.

It is relatively easy to allow both drivers to coexist by renaming
drm/mxsfb to "mxsfb-drm" and making the old fbdev driver return -ENODEV
instead of -ENOENT when it fails to find the display node.

This makes display on imx6sx-sdb "just work" with both styles of
bindings. In order to test the old bindings I locally reverted commit
7caa59e0d40c ("ARM: dts: imx6sx-sdb: Convert from fbdev to drm bindings")

Leonard Crestez (3):
  drm: mxsfb: Change driver.name to mxsfb-drm
  fbdev: mxsfb: Return ENODEV on missing display node
  ARM: imx_v6_v7_defconfig: Enable DRM_MXSFB

 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 drivers/gpu/drm/mxsfb/mxsfb_drv.c    | 2 +-
 drivers/video/fbdev/mxsfb.c          | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.17.1

