Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40727C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E835C20871
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SlNj4YRY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E835C20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754085AbeGJIYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 04:24:22 -0400
Received: from mail-eopbgr30041.outbound.protection.outlook.com ([40.107.3.41]:3616
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751210AbeGJIYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 04:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bi0rPpjCU4+ya8xhlnG8oQkqE/5rcfae3BSLGyyjuyM=;
 b=SlNj4YRY8/poj/gN11cCSbvUIjFMT6z5KhGeOx2nSMdgOmUlYiI404nhy2crkxgw/ulN/6yq2pIxdOhfK6daMpZEDaM1TQhm5JjLptkxd2hIhH0gaBzbioGc3UzX52NxLzFwh6sxS2bT88GK1kAyGg3F6jb5RifbaqKudmbteLE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB6PR04MB3221.eurprd04.prod.outlook.com (2603:10a6:6:6::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Tue, 10 Jul 2018 08:24:12 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, fabio.estevam@nxp.com,
        linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH v1 0/4] add memcpy support for sdma
Date:   Wed, 11 Jul 2018 00:23:09 +0800
Message-Id: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::20) To DB6PR04MB3221.eurprd04.prod.outlook.com
 (2603:10a6:6:6::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e5155aa-278b-4b50-3d35-08d5e63e867d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3221;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3221;3:WUuFCkqpN25nMPzZeRn1DHNwgBtx6TsFv61wSVEoKRClI4M8RPmf0KJvhnJeqk7UgOqq3bpSu2Z5AJ0kQGxw09dc1eAse5Gagnm6PXIQPePYEmyrKKZlfeiEDabTY/yFbAZyIzdXemKW+L/zm6iWp3pxpBlxslqA2zOPgOQB7yeNgq7Hi2MtfhgrJQw9TEecen6xMuy4l1rjSwjx8Y2HH21Bd/SF2Nz5cbX2Kev74gJLyPLniZpgEWQg+N6JFBvX;25:QcfqTEE/NFkU0t4vIa2efC/YBybppe0JjH4BLoBXxDqSOsl0ZccNS2o/R+uNYCrUyoLjTmRSUJHP0WBWfnfBsKD7yLi4Vz5bYLgYd/RArpLlonLcYOj4CpRtaI8XOkYWMMJWIAOXXbRYrgEutXlZ+zAJlq1NwDZCTLwlGbH3txQA6mdgvJkztVfcJ2N7ZoW9h6FNg+siaKXKY07FY4v6YtwRLrAEvkXSi1lF0vhEyrtVlqng6rriybntUrL4XTXTLCn4+3RcZXzg7Ue0ihfzpKN1jzifar9LOcgHSR4LlcyAH4b3R9Bsi2jkDgq37OfQPBnzIEXCE/4nHGIy9nnIbQ==;31:gfdtsYL7JTmWrxohnbiW7pJ6ddfzCGfF1C7odV6m3l61cOdAXcR+alJMmbwFm9tEVmewLHsPW94Hu3aLfEXHMw7HZfX0P35e3Qt31E8+oYOOD40VOB9td9dZyEbBE4CvRN7LrRmLcg8o1ts1uCOkvwAhkTa2RzqR53t+Npx3BA8xi0zgcJBInny/heoKbDkOwyRYMy+QBYB47CLSAEdRR1YRrSgf1GkaOse/Dw332LU=
X-MS-TrafficTypeDiagnostic: DB6PR04MB3221:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3221;20:9qOINjpUq7/JpSi65jrDW6Z0V78DR5X9B58RpjVCRlH+L86AFw9R8TVvkzRJtt5LILBANNe/WYW4u7+VKT4SxiDK79ikVjWJJjoIMb01OOqfpZftUfpCu/2RdHWuCmeeRJCUPOfC4eJmxaFaTqz2qoRl6rhgE3lIpyeuFM9UesqUK2D5FmFHmXWUWv3Ub2J0B7us5ehl4gctB7P4uciygKdj+BldPNE9e52f+mYvfiMgZ+vgyYCcYYu6Hl+iX7tSrHs+1tE9B3l1huMT/+w0TKfR+POklGj8AkXZt1FTw9+vPB64OCBMwuToMgX0uu4SjNSu2d/7tl/cJLBfkOY9pYYimXK2a/t685j+ivBC/rons1dJN90MCvkKT/eazQmlsjDqkANUYAgrwF6YvSdYOWt8pEGjkSBS0LeexEk/fzVqlU6HsV0Nkp19CY1vgOFDvMQ5LDs+Y8Z0d/BEDoDJg1C0OFwXgAbAT/9BT5ewAepavk+ixdD25Fy65vsXL5HC;4:1HZYIbwCHzm4KzSxLhnSR8gikybm6Yl5dRy1l3kysD5VX5LGJolGLAH2vybIGZ0STKC6FiluedL8bxhe+QN4O9ZlrWsfW85Elw8hKZGY3cSfAl2//MeHfmuLEewGRBCqQdHaDYzyRdBrrh9dyywHO6vDw/NS2yFqVXlqGCk8xDa6AaI6y7NPkFNpkCpwN+/1+KgXzS6sckoKndMyYLfwFzCcRkbN3VS0R97YSy4BjzYyDNf0Hw4Uc7ZmoYhzMAz8x0f9GywyhBaV46/cla8UaQ==
X-Microsoft-Antispam-PRVS: <DB6PR04MB3221EE179EFB90AB6A4BAAF9895B0@DB6PR04MB3221.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3221;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3221;
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(346002)(136003)(199004)(189003)(53936002)(36756003)(5660300001)(50466002)(50226002)(6116002)(6666003)(106356001)(97736004)(8936002)(52116002)(51416003)(3846002)(6486002)(47776003)(68736007)(478600001)(86362001)(66066001)(25786009)(48376002)(4326008)(105586002)(2906002)(6512007)(476003)(2616005)(486006)(956004)(305945005)(8676002)(7736002)(26005)(81156014)(16526019)(186003)(316002)(81166006)(6506007)(386003)(16586007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3221;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR04MB3221;23:7boE/z3AVNjaFFp7tUsTL/siFI15VsnVVtAAtau1q?=
 =?us-ascii?Q?WbrIug0obRfVJR+1SyN9/SfK/zvyS9H337xy2ZBzDbnc/5nFvFtumLLQkkcQ?=
 =?us-ascii?Q?huENrNuOObPcKtZwUo/5smktxPVCFCs4YuvO1hhxrXWOlxSr2ajppxdNGCiC?=
 =?us-ascii?Q?WgmbFZvoVyDIxGireVmdxZNMbn7GRGvwQZMH1fMUbn+d0lgUNWhhUQ+jyMfp?=
 =?us-ascii?Q?bNP9xbefZBHgE+sLnbAiF9wmHk6fQq5C/vVBxT0qJte62VX6Dn0v9u6M9S0C?=
 =?us-ascii?Q?pLQmV8v+E1RSB7d8Cf1zRjB16xypRtCv0fXSgeMn+kOxx/7KXjAPY4xRFn4l?=
 =?us-ascii?Q?+yqBx06mjJSmqSHhg6ODlvl+KwJieFfvExcar1uPEAR20mMul2VBwMihhnUi?=
 =?us-ascii?Q?UxcT2DfNj6DJNPXREsS5WBJZUfhotAJ4cQlYup4Ee05ckID2wZFFKGLwwC9I?=
 =?us-ascii?Q?TsoTTXlaxGJx0tfyWdyk7OyRCdUPpOJXVN0mp9WlvEgMWK6sAfyxPQZtNooo?=
 =?us-ascii?Q?IgPfGdUAUue52xaUgHNDzgIFKD5GdZa6MwK2xoM64N1rh4jwCSsceTiGjOom?=
 =?us-ascii?Q?+mFgmOb2/slyNGXDy7fftBEmew8s+HYVas0IjGvn7gxTuZ8ylwNwctCYl+vj?=
 =?us-ascii?Q?7p8q9vhxPi2AIwu9LqjwgRojP7xLwVFMXVLEW+qtrZh9g0P0zpdLmVjG0s98?=
 =?us-ascii?Q?9lFvlH1EMhqyZPb2UrzgYKvq3tgcYfTpyiBWRlD1Br4Gh2oMTcS/7L4NcWK0?=
 =?us-ascii?Q?/DAaJnn74qlpsd7lyImFdgDEyWAgsQddJm0s4nwHXbsPZRGiB3Zjz/whPfEt?=
 =?us-ascii?Q?KLDRHltwIXsgdspovBS8RiKU3ZjFVN/+OtLInkVGRFLfD5YCAZIc1qydEKBJ?=
 =?us-ascii?Q?asUq7dd+cxsvAjdusDz7r+qiFiETM91MsxXYp2fm6Jk9dWVBBA25PQRg+n7e?=
 =?us-ascii?Q?Aq/umt615oN17GrOjpq3rj510Y2Lu+wawb+wkPBVQiAoRm5XVul14NHH/40x?=
 =?us-ascii?Q?LC8fdQnCcwSQqJlD2WsA26nJphzwe8miAWlosA9cRl7ZUnbju1tXe6SsVGW/?=
 =?us-ascii?Q?kYhjhmUmoICTdyjfV4MzSD1a6r8wpPWM/P5lvSz+ges1WwGcw=3D=3D?=
X-Microsoft-Antispam-Message-Info: +Lk+Oui7/Bj3l5HJ0s81Bjp8zBn+GwGG38nkAYX9ew7KT8E6DERu6k9GuVkz57LkZzShERNtjDwtm8K+5edpnT1FobvxlKNg6vq+KBvABm+k7gtINjjBiYkN3cfWXXqf3a+JypY+sC25az7rMBbPGt969BSlqckM+Gm7XfAKh07gZPR4/vRqTgyb37PuWeLEW6e+WKKDlNqUfhuEfcnpl3d1mB8kdNvs43lcLlRwl07u9yZMUUhQU0enwixs8RpwyL53esWt2p4WGk3pwdaBG4DrZvjyMpeBkzXSd4SwBVkpEc4Gevs9dGAci+Vj02yMMeo5MWniPq4CPARdcXyl6rImWwTYVNTgLJMbI09/7Rk=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3221;6:eqTlbexRAYeli5f1LoIsLQLefiyMoMXxs/fvxhPhwoO09gFeVTpaBYfFJlWQ0AckaR/F8L+HePYrXp4AfMCqMW6sKwT1AzPUW9EPzXektnLC/4nK5KN1KxtTyFzVNoCzGzzG2Ds9AirLjC76LWOQt0Asnj6marKkW2DBoDTlKhaLbyRXlNWWpkp/sE1RdmbB5esA/8TgNa1W3ZIwQnGrqEu249cusN/nmcKW+TI1Gw4wwW2ut3HS5y58sMvpuhLKub0Ik9G8wZtr22h19BM4VNstwXl5UAyeiAP4z9Czn6GMYYbzOmgmtHI8RXzFr5RmgIvLtYo2OIPQ3+Z9wwH2xS1RcVELs8Xyt7rZREQt8ZTpJmqfQ5H4LyWy5avXqPmMyXdMlH3TGSdAwtsPm3UoOt94wcoGzVBH0Ud4DFg9UqDmsKG5KEL5d4dkRkZMNLAezGBM/DUPUQt9PAZk2GYfcg==;5:fLCLJZOi+DITKWSvAC+RNh+LPCxKTLUWSaZK0PGAOYVJjT5lcXZmz3AuSFyCz0iJaAry7icJSrAtciNhWtY5aqSYMs3d74fdsj2Wg2+PCApfGLJdbVWq503/ZeDAznh5/5ji262+en791011nhdcSfC2WijgXrnnLazoEAkbYb8=;24:MksMARzv4DnCbav7qWTiUaCFG86hxxstKAZ9QEE0VW1zcVZPaSEFbN6y0VC6tVpG0kg2naUGefsOa6tbGkDYqdmd0wxZZLwZiVzOAY+NTmk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3221;7:1goSH2Jjbl/QvlhH8G+ODPx8RqD2hHeUHoXoGDARrfDo4iHB7mPmpiff5wSZkOtsWJSh++yAswy44HMeHkPoJrumJL9h+NVu2Y687m31xUQW3F9TxK6bH9KZfhoGW7c3SWpGec9DeLd0SyhAkrz3oq2zg9VF8RAEpEw+TQ894Dsnpm47rywTpZ/vazqQ6qgu63hjL0nnycIbWLxZZv4RA7Ia8AWsvfVXQzOfFHhF8D5Wxq2MTuh/fhXDqofUscVq
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 08:24:12.3371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5155aa-278b-4b50-3d35-08d5e63e867d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3221
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is to add memcpy interface for imx-sdma, besides,to
support dmatest and enable config related, so that easily test dma
without any other device support such as uart/audio/spi...

Robin Gong (4):
  dmaengine: imx-sdma: add memcpy interface
  dmaengine: imx-sdma: add check_bd_buswidth() to kill the dulicated
    code
  dmaengine: imx-sdma: support dmatest
  ARM: configs: imx_v6_v7_defconfig: add DMATEST support

 arch/arm/configs/imx_v6_v7_defconfig |   3 +-
 drivers/dma/imx-sdma.c               | 172 ++++++++++++++++++++++++++++-------
 2 files changed, 139 insertions(+), 36 deletions(-)

-- 
2.7.4

