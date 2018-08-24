Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385E3C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C97820684
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="EMVNePAe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C97820684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbeHXM7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:59:05 -0400
Received: from mail-db5eur01on0092.outbound.protection.outlook.com ([104.47.2.92]:25191
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726353AbeHXM7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MY0XLlJ4peSym4LLxqDBedCD9x/R+Z+dXz1JzFqFzEA=;
 b=EMVNePAezwBKyACuT+uQv7SI3TMa9vxhNxDyKR4KLejUDheHVTYN6WKTIf05H+jkgmg2p0Fnhg/0K56DowVNDp6Uc3Ci4NnvlaaHGZ4Bm5BSF7wkVMCB+cXnrZXahxLMAghPeybwOKg733PVOHQCOsxnJ+UTnmc3LlXjbdw7KeA=
Received: from orc.pedanet (85.226.244.23) by
 HE1PR0201MB2458.eurprd02.prod.outlook.com (2603:10a6:3:81::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.22; Fri, 24 Aug 2018 09:25:10 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/2] drm/atmel-hlcdc: revise selection of pixel-clock frequency divider
Date:   Fri, 24 Aug 2018 11:24:56 +0200
Message-Id: <20180824092458.13165-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: VI1PR0701CA0045.eurprd07.prod.outlook.com
 (2603:10a6:800:90::31) To HE1PR0201MB2458.eurprd02.prod.outlook.com
 (2603:10a6:3:81::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4df1790b-ea3c-41a3-0d0a-08d609a37dba
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2458;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2458;3:ZaisQhPFj3Ah9D92h7es+gYV3iACuBPqENPLCN7f6KN8/XIs275al3vVrrzShHIqDQp0X/gW/fkhHB4g8NQtZ+2JqMqMDm/Nps5jY5IiaXEBkklu3BEEmtRteevnShVuSrhVnkRMjfAaqaY65kvZ+wQD+6oll+KK2gucdCmZ816bmEZwvdmA9SdTujB8BQUqmh7c+UaQw7mP8VUti+DwECW2WNR2iG3WG3gg+m4w9FyW1+FJJ4CydN+SENiNDSOj;25:XyKFHJr5L9eYoy7IkLSXF6g5d/1+Ne+v4Nh2wnyMPtzVpX+rs1G5Kig+M/fGN9ggxea3rpqbskMrsAs3L3YQ34Y09qoPv0gwuGEf4+/wJOObaOq5miuywqXd2EnqJdNU3NY3Oz+c/cLtPyYqgMWIbwf4gO3HGWkxijLMIrItIbWqVV/FEGTN8XWcsgDU8HaU3pjsTpVgpCq7zGuotnoO+XCTw4nYEdsEAet/npgqO44X/aZvcgAX2proxd4PIHxB+jJy5jAsWS7TxcqgYzkK7YIJtKtGCyk/ecojW48zV4T8NZwzFqAORPuggE9RtTQ8bFiDQHGsCvhCk7cSUm6Krw==;31:7JJM5VWlbexnuZ82/MGgANIDpdD6iG1aU6vjgO/wXobPEBBr2RJ4IA5iVuof46anwHX+qnPUAlrRXmit5FMqsvqS/pA3akvitTDpuOYpwPN/R1EJobOqPx3rPsEduSG2jvs0wI3jVsonBG8Ko1sj7D5xVZTPtd/wc73D25qefAjKXeqYxhsupTEPFLZBWoEuwzwn1WApr97VSJFDF//hpzXxyFiPJG9mawHUBFtttk4=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2458:
X-Microsoft-Antispam-PRVS: <HE1PR0201MB24585081BF452E0846A4F2F6BC360@HE1PR0201MB2458.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(217544274631240);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123560045)(2016111802025)(20161123564045)(20161123562045)(20161123558120)(6043046)(201708071742011)(7699016);SRVR:HE1PR0201MB2458;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2458;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2458;4:i/pbngqNg7ajheHAtpiLc9xrWCwa3biowjgK25Q9yblNshiIm+U39VxEmbhXj1saczuizsNTnfAv/Rnsu5WTYqp2B835CEZpiiaM9wB/8ChMkBdLTZdPuCIU8GwaEFcD+cz4ipogn6mr6zzNeeon3o8CQc8J+x/2yA8L1ZPD33NzmdUlYQeHngy+T5E5yqz858WX/l2BAIQQiijJ65y1Xu51iSkrCfTCyk7nrI81Uh+AnNDpkrnLxd+CG217bKCONzdqVJ1xV7bZTMtZVJlF9iYv28uqRPDSLTEJhjkyJqebPUJlrvJ+xIOTqyl3AmYe
X-Forefront-PRVS: 07749F8C42
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(39830400003)(396003)(136003)(366004)(346002)(189003)(199004)(386003)(16526019)(186003)(1076002)(316002)(956004)(2616005)(25786009)(52116002)(476003)(51416003)(36756003)(26005)(6346003)(6506007)(6916009)(6666003)(8936002)(4326008)(50226002)(54906003)(16586007)(68736007)(3846002)(2361001)(6116002)(6306002)(5660300001)(86362001)(6512007)(6486002)(105586002)(53936002)(106356001)(48376002)(74482002)(2351001)(966005)(50466002)(81166006)(7736002)(47776003)(66066001)(8676002)(2906002)(81156014)(478600001)(486006)(97736004)(305945005)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2458;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0201MB2458;23:u19J4ij+fF2NUEN3Q1SGPF8RZESgr+5HGJQfC5V?=
 =?us-ascii?Q?7E5CGgWBi3rAgDxp3pFj3fOGwbpLm5X9i6VzEaMs1s65fsth6UPOwsQe7947?=
 =?us-ascii?Q?7fI9asRrGoR7KYnFuzDQdAftytBKRxETU8MtDfP2GxTw8EnAMEmc9ie5+5rr?=
 =?us-ascii?Q?VdtUVWc6fG796w2IfILRpg2SYeEZfdg4udrRz6RHJIZKM2jtkx/UtZTPDyoV?=
 =?us-ascii?Q?CdoFYXAcoOB5ln6ESfnOWkRSvMSY10xZpWVmQZHw5Z3jgsQoWgnjEPdgympu?=
 =?us-ascii?Q?6+Fg8vwRQZliUD7cLJzA+tsZm8z032nvVzhG3gl4PXU5C8CoUYsvMAT3Ukob?=
 =?us-ascii?Q?yR215B928m8rXDSxeWe1wI3etI+P2rjUtM0rcBhLR/LKWD/ss+bg7lCMmIj9?=
 =?us-ascii?Q?e7K5ZI0s8m6S1WPHwfWrudAVMr9VXe6bIxTMyC5xPKJaUkZ5j47t2LI7qS+z?=
 =?us-ascii?Q?RFB6fDYfwGKNuUAd25IzdhNsxi6wA+ZPcVDXPhOKHVQfZohHM4CQsV4GtLpV?=
 =?us-ascii?Q?qq+ayS4ZbMw82UkLkmRvlxKLRBwbhnB2Znl17B2kIHjSfwdWKCdkAEbo61Hg?=
 =?us-ascii?Q?ZaYrCvVLdQxnqYCvRCn0B5euNAyJjFWYAaOPP7Z6HQEVwOYFXRk6bMhSSXob?=
 =?us-ascii?Q?66ZllgQ4JjqcaDhL+8Na1COM7I0ZGaqLyKDxIUYnennr+0Kv9eyJrdG4xfCH?=
 =?us-ascii?Q?YRsVZ5LY8F+vqu9aeEmC898TS0tfnCUpANhHRJKam57401oIVG0LDFN50CL4?=
 =?us-ascii?Q?Tr20uhGkDcwahign8KXQOREujSF2l6dB5w7FCrhESWJdNrJy3NLetwxrtpoG?=
 =?us-ascii?Q?c/G4+SepSxASrcpKrNBv3eKLZayoXuKkpSqkexYFkxHAhu4PICSy71sdNLiq?=
 =?us-ascii?Q?nN+a9KZftC5UKJeH+IcqOEB9kYr66yhThSNcS8ZeT4yTE/XRimvCNx/e0ORO?=
 =?us-ascii?Q?0o40E2h83R4LQJvLLZRK84mCnrrixt0CQ/m1eYn+AYMIt86SDlmRjm3NZ+LX?=
 =?us-ascii?Q?Xkstzqtrkqm8BV1IUXLrN2bUDAx1DlyKaEGfHCAYtt6QGG1tpwrYz8R3QZFo?=
 =?us-ascii?Q?MSEj2hR+AMrUDKE5UX40KxnermfEEJeE8lM6rcLhR/3D3zBmH8gr9GBp0rUI?=
 =?us-ascii?Q?2aKe3tA3E77wKQmj5tOzCiGGWCFKcUSrzu5I7br5HTBX06MtsqaDboiEWVxd?=
 =?us-ascii?Q?tZeILRYjCTRNJMJJC8oAtsqkhhj9UzQI0j58kz9CSpIkIjRon5O84C2fDJU9?=
 =?us-ascii?Q?azWy7w/aKTsbUl9cjkOqgNgkeRUXEzbp6IK/M4gnYFxSYW0go9ZlQc1bNXY4?=
 =?us-ascii?Q?XQw=3D=3D?=
X-Microsoft-Antispam-Message-Info: Wxx3qO3j57IXPj2+xoRyIV0PFGB21rFbAeiC2gaELmOXTL5SeDlZOxaKz+epyquTrEWrv6LJixh92+QpmwzBVvv8D1KZv8zaXAhN5MNH084SdeAoX6lrczhqzZH+ldVEvK19AG8Y+phW2TZOvPelyLy72PEopgP+KyGVo1t4zI3lTEjuiYPOGeIxHHX7BuvLKyEho3E/Xe1/zyXfknFkKkZQWhVeRmHD2cFgh/BsQbMwJzTCMQJmvCD7JxJir5UKOhfF0P72u4weODTaxUNTcqUxsDmlj4SYKlmDojL0aV6JV2HplzX8bhUoxKHLJ8dldzF9Yb98qtdQsZRc5T117kmEHcBSyXUQTedVi2ChfKc=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2458;6:oopS/JwVjKOlkngyWgpeiJXy6l+jynZu/uIL37BlhYZ8LIx1DxtXp4VubVnrZW4LFb4Zw3IkpzdKBcTChcXqNZsq6dVjU2eg05Ll24f8k3TONgjCuLpgh92UJzRfv1xvL8JU4WUXGYNxxiMNvnPBk/RTYQ5Sj/HlfS5pNPu3lcIZT0vImuL2haITGBQQ/fbVFllc+PgvLm+NlzmUsjp4Sr8DYmAtTwUasLGJi95eqb1QBIVUAGpWUB5EX5A/Utzox1+T9aiKvgUR0E/nexdvnLDvCazJNwx5qdlVOEO96T3QxHKvHwGxaFTocLUH//I9mBeeangyleIxXfeYsI4knBaw3Ta6VvfXLXIhFdh6aGPSbgH02OylFq5GfEPa0kYqmticXCs+mjY13DZQM2Rm2lj2up4vXlwM1nR7cfyvfNai+sBpGUGf7pqIQcEQtcd22iXhiyf6IyDXcdZjILlqjA==;5:+IVQKtGLGTG3WCsOcjBj/AHYe3QHWv+W82FKv3I4oSOsI+XwhP2Xiz4g2RDxM5sXO4HB7xrMiWiycAyT6STQwSEb7MgMmY58atA51JHALcTcqBCsGgRCnvHzAqeVi5EVfQv5FPOsHo36+cBCezZI0bueH61rJjkjO+gKciP5Joc=;7:ICxFfDJ6EGMBZZId17K2L5w8/Nhw7e9RtZLxmca9eKTGSYPyX+c+vn8/SNJpv39Q9crcSXt+gKTdcgkUfkmChR6ousG+vnXB6hbgJsQLCxHXYP9rKw6l9Z2537s9Zxqgd9rZnTLxth5gbi2cVxrNqIFAa6tXxjQ+VHxNzFwvARiZCa+FUXrEK/RKuuVClST0yqQfDPa7vfUFuUXE9s64VwPBMyQNBl5Our/vLjufj916uXx+5rBuJwjAwqOarWsy
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2018 09:25:10.5221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df1790b-ea3c-41a3-0d0a-08d609a37dba
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2458
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

Changes since v1    https://lkml.org/lkml/2018/8/24/187

- added {} to an if body for symmetry
- reformatted comments a little bit
- spelling/grammar fixes

Peter Rosin (2):
  drm/atmel-hlcdc: prefer a higher rate clock as pixel-clock base
  drm/atmel-hlcdc: allow selecting a higher pixel-clock than requested

 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 30 ++++++++++++++++++++------
 1 file changed, 23 insertions(+), 7 deletions(-)

-- 
2.11.0

