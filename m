Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFB2C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B292083A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="DKrLShed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B292083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbeHXM2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:28:54 -0400
Received: from mail-eopbgr70131.outbound.protection.outlook.com ([40.107.7.131]:21472
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726510AbeHXM2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HdPJn/MnUsjx2btOGu8UmHiN57KCYoihzIKNufZZF0=;
 b=DKrLShednGpAXdbfy90QGxPsnsN3kmcxRI/RmJjxrIGn1mreR6FGz7AWTlJb/icNrZl2PKCbxTCuQZ7QtUJgfPJk1TdBKJ2tTABAt3GQwsYZTUVYqzsNjv05YbI4WHealSYdBvvHF91bpbuRXwZJJ/hN+d1jIfMW1riXagBN+fY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 AM5PR0201MB2450.eurprd02.prod.outlook.com (2603:10a6:203:35::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.15; Fri, 24 Aug
 2018 08:55:09 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] drm/atmel-hlcdc: revise selection of pixel-clock frequency divider
Date:   Fri, 24 Aug 2018 10:54:59 +0200
Message-Id: <20180824085501.9740-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: VI1PR0701CA0070.eurprd07.prod.outlook.com
 (2603:10a6:800:5f::32) To AM5PR0201MB2450.eurprd02.prod.outlook.com
 (2603:10a6:203:35::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c4410b8-9a87-4984-fa8e-08d6099f4c19
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2450;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2450;3:kzlKqmyPT+2MpA5os6pzQQZ9kE3Lmz6iaG5eOSWqH3lrI0P16pHBfCTsbmLeZhHdrzqYcb1/uHnbqpBaWr4jFTpdXjmd30I0vJqS9VGq+jBm+M2676Q1ITx+z5+b2tLhewDdD9Ocw038rtvlBc4IHmaLJG6SPjov5hj/4oGpduxPQb6Z9KoQaj3thcu5aTnAIQGdIWyyw1NztlfOOnYk7WGYuVLscuCltG5gfScxKyhR0ovJYnWnG7Cfi5bKCHfX;25:8Z+hTYCA/6hasyMdSwwwuIT0wRZHOXkgHKHcddl1RkgCQ1qsr42xfdUGEarDOgtIfkfpRGAoqfjcbIlce2E+9MPZhlv/JyFkRK7B9H5Nj0iUypMtVtUrlOZHU2n5Wh/klTqAUt27zvnQR0JvLlwmIw4vmeRWeCi/pWJw02nmsvdZRsu2mNBr2GTVQ4w9e2QK7jYrnw4o1H3b0Aw0pk904Crwvk/SPRDL7E41Nx32imfEfbesdGrqVvGhqWAuGNB4tnTNHwr/DhjsNrYQNQnESzySAyfQ3aifnJ4W3prKlaUbhaV3Jfc6NyOurVjhoQCHNAGHlR2ONo0yRs/B5H7Qew==;31:qxGyhpRB6NcuFS3CRbchP/bhPiUOfvfi8+QMVDFYzzK+JX6revpeNnnvxReI/pQfn2ZxsugqREEd4GlhHJqDGvDUQymzuMfECkBBIfrpRXow5w7rcQJyYhmd0NVEGWjN/Fx30rTHMtEdW+swzbk6X82x78mLfXoklnunCdpniH/7gqWSwCunUwZIFtp7pFl5OHC2acEibg7CYxFAM/2wSg/V9zNnc5zHBa7nSid5HMY=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2450:
X-Microsoft-Antispam-PRVS: <AM5PR0201MB2450609D8CFAD284E4FB4854BC360@AM5PR0201MB2450.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(217544274631240);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123562045)(2016111802025)(20161123560045)(20161123564045)(20161123558120)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2450;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2450;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2450;4:Q5A7ie78U+XZQD0NB1d0LyoIsDcd7xVbXIjM8aVSEoYBT/pCkxzl36QfoIvlvbDBymcHi0kCDh2n9iPIInb/ga2xQjuu+D+q2h1MWTuZNtye1j0ZkUp/e2D80TeEKFlnBku2FzPI16nae1Hb39bET862pEmRAmpa2aXUzslk1vgr/HjqpXzLVkRNORmINArMKHLf16GSKDmwWbiZTo5HNPKIOFCiahcYFkex8LUtnwLhstLiy2EhObPQEsuWFh+6OeVuQCtCN5Za9E8XT4K7bLZ6psiAXnVM5s77MBKR2amdPb4DXR6Wf9/0zYjiCJhs
X-Forefront-PRVS: 07749F8C42
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(346002)(366004)(396003)(376002)(39830400003)(189003)(199004)(16586007)(5660300001)(8936002)(2351001)(81166006)(81156014)(8676002)(26005)(186003)(50226002)(4326008)(105586002)(16526019)(106356001)(68736007)(478600001)(966005)(2361001)(25786009)(74482002)(6666003)(305945005)(476003)(6486002)(6916009)(36756003)(53936002)(51416003)(2616005)(52116002)(7736002)(66066001)(50466002)(86362001)(956004)(6306002)(486006)(54906003)(6512007)(48376002)(1076002)(316002)(386003)(6506007)(3846002)(2906002)(97736004)(47776003)(6116002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2450;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0201MB2450;23:LJEi4pjGJNTZ6NFFVZBhC4McZympXV3kjrQdmH7?=
 =?us-ascii?Q?Ub1qHpkQtbB+Uw6Ni5jRTnMkccd3rQRJIklqEPdlK0u1DqwgFt1BlFu9qee8?=
 =?us-ascii?Q?RKgay0l8GacJKO/bByLWU0dnnsi4VmvqUhz02rqUQFKMs+ruwII00T0K/Vhv?=
 =?us-ascii?Q?5qUjW4ArW4xebox+FuDfs4rKbVMpl90KmQGnvUrMZOfQQayB0R4rXNWKVJum?=
 =?us-ascii?Q?xHWt9tjlVHK3l4IGKF7HD/jkrHQaBbLAGzd5qYaTJ1Aq8EeXTepDWv+shrH0?=
 =?us-ascii?Q?GE8/IQplErbdwec2xivsr69ukDCQnFR+HAiaO5MXbdvvYGyqyeSYmP3dm2Qd?=
 =?us-ascii?Q?lGFeI/Ik+ZTNNVZSdjAh0hHJ4sZY7BEhP7YTSSRIeoZCbeZyx4/iRJ36lbJR?=
 =?us-ascii?Q?ljAAM4Pdj2FHNK/9eM3fZBZY7FcKV2YshYrRJMZeyN0yf8JHlnESri19d0EI?=
 =?us-ascii?Q?Pc2dNaJni9LmenZrnHrZlO1x6DAGkR4f+3h7/uVnmtgY8gsrN2Q16Cnc6T9N?=
 =?us-ascii?Q?27JcgE6F11HmoiuGAxy8R/CmKEwsaDE/KXpjekfQ7FuUMqsTuDKwWp2WfHdz?=
 =?us-ascii?Q?C3DL92SCEi46kbEX15FkNhPget9tFyWxk5TYQJHd1z5KYW5LZCmbEx+dky0j?=
 =?us-ascii?Q?K0lkdcJPtEntkxTY/jt6Wa5BokwUgw+7FxsB3qXiBOP+doGgDCZL9jrMLzXu?=
 =?us-ascii?Q?c2Ke5rlzC3t8U+JD6H9d5vHzJu2TMkcJt2stc/ksioIcY20nGid2A97zF9OG?=
 =?us-ascii?Q?IXk2xVHloKlonrpFb68SaszHo5+I8xtcJxN4AVLlGtNhKZTxyCClpxUqvwo5?=
 =?us-ascii?Q?prcfXAqW8fyzCMNRxsQb+hALp+mV64bE7+scOTRnQRGxt08H2nJbO+6NHO6P?=
 =?us-ascii?Q?kOKKkmPx+Bw/9wiJWdm8kxuNl4EMu8oMPKPxRSxtsVUIEVd+HXtEsTcNAnQT?=
 =?us-ascii?Q?ZG7kR+9Bidi5snEcpJiWk/xbOQg+wvqUDjLiDnhBHvEwB2HwQi8cd0QAt9m4?=
 =?us-ascii?Q?ouJSr7HW20/Tdvvv/t4zbxpFZVlJ7nOH7KLBaCELfVirmpZ3X4XSOcthz/+I?=
 =?us-ascii?Q?MjahNjdDYzgJBcBXRzC8/eqEdCf/VyiYdcqYC+RKvzJj9MmOmDndnlQFtxUU?=
 =?us-ascii?Q?FxC5R3PFfMklFco2U5ZEe450GuCoUhQXSTr4uppDjA4hmE284WiAWFtLu+Pi?=
 =?us-ascii?Q?vACl+Tm9WJqjCKhhIfTaYt/JEe+8E7RgHPZcQhin5i6wNFWFn+vsqywMrWqo?=
 =?us-ascii?Q?wpQF/wl3MsA3x40HgEPup7au9wnmKt39nTTNHCKIf?=
X-Microsoft-Antispam-Message-Info: a6QNwBaiQfTlFadCbZuyRlDtQ42HnuKwEQdg1Ot3wqyq8vlBcGonWwFYKgeB92L3m04lQkQ5PTGlHilpHh+9DuWvTRhyWair2SUNDX0gw+z7UlaYlVfMnrdYEQgoc7fyqoJG9QuC8qX5aL+5Pr+oZUEkGgk0rg7sTnG0FH4w/hTqBO+pz7xeacHrjGPHykTvlwjx43iKRTMRBOhP/pIl7s3H0hwAuEGk4BRcoyXEm4OCOAeuBONghvIUS73PKfoN1xskG8X1pDdWIube8/DLibwSW0juore+Gk30s+LZwd+QwppAMg9+2DiwP9LbeHQ3gdtbprjzFHUY8SQh2x0YiZ8q1+eLvIZhuonrai0syVY=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2450;6:4DD1HuxK4/APgdZtop0Bp5BGagQShC/W3LPjj5hEym8QgsfEGp4p8uruZUZpI9+57ljNaYCkIdXK2/Lz+JgzJwA8pqeqhZxbDuNc7R3QJLlJ1C0WSvB0qXMiPJKsxDcpi0mcw+MbyzExJHW7uGAf7QR3V5u7b491bhqb161M7SVN/MDQZc/OtMUEYr/edwk2yApguw1G5wE7dKtdupV1aA+TQIctai02F2z5+MR5Xj2LbykFDkF9NVtW6rfomN8tETW1ZvqeDoJYLCprAE1XBqn46FaYX7mHf5C3ZBHbhsuVRugRZZSqNW7ght6mLIuf8CCvFxK/ChnQP3aJra3mFRjkGvdOh8djzjIgNarImNdEzNpE/FX1wgIFG3SAc277U3KPcT4jSFvG1eVKZCL7rAfal9GHYZq/f9SprXXoDB158H0Xev4My3Nzoh5zwTuZ0u1jDbdy8kgKan7NqwlYgQ==;5:E34ZHHeKeHdMTbvmFzA+me8xOEelY2nGmlIfj/JxA3LUfzEDlBx+9h70Zdv0WvfhY/lqnYLdsEOTOXO3Kp4gy+UQuWRm7g7iisK3QrxA00buGbDMNpqdRgJUspWeefRVyuuf8NaCrN8JCo4adcIHoTU9dXR3zRksj/KvPVavqiI=;7:CLCV2OtWd2BcArHn5GxQ8ayQyB38dK2EWvfPfGUj4tFFvEiIB1Eu8ytLE7vRMsm/nOQ1v/3RnUVM3sUWvinbXx+loG6E+5Ut1+J5BMikwUfIFgVWcd8VYO8L58e8xk0FzsN0+0r3+bH3O6u1OBs1JwCduONofQ47H4YWUGMDDLxa7UY+ltoChBp16a5/QswWV/82mMyQyW3dpmeaodwFdfshMM+B+U+EZgSFZMU3IPJvT36LuRNwjHlHoTIjAk6C
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2018 08:55:09.4474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c4410b8-9a87-4984-fa8e-08d6099f4c19
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2450
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Some background can be found here:
https://lists.freedesktop.org/archives/dri-devel/2018-August/187182.html

The "10 times" discriminator in patch 2/2 can certainly be discussed...

Cheers,
Peter

Peter Rosin (2):
  drm/atmel-hlcdc: prefer a higher rate clock as pixel-clock base
  drm/atmel-hlcdc: allow selecting a higher pixel-clock that requested

 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 29 ++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

-- 
2.11.0

