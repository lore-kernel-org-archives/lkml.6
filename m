Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF0BC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463A12075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HmrxPoWG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463A12075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937477AbeFSI6I (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:58:08 -0400
Received: from mail-he1eur01on0087.outbound.protection.outlook.com ([104.47.0.87]:3242
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756206AbeFSI54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUXcBCW8p0zor36njuD5mAW6Uvw479EexcsZkRU7cTs=;
 b=HmrxPoWGtY456z422+OyPmkcJlIbFU8sgA/XNJAYDBtwtWXlnDtn7AqjGvYc6JBGzTcaAoJzn1gcHz8OPyLYbqBVsg3CcCUNjSDBCeZqfSTtFcjEWHOxdZIlb9SauPgwCytSbJYWIq1T6nRHaRngqW/sT9zxGQvCvB9/VgQkCuw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR04MB3231.eurprd04.prod.outlook.com (2603:10a6:802:6::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Tue, 19 Jun 2018 08:57:48 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de,
        dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     linux-serial@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Subject: [PATCH v5 0/7] add virt-dma support for imx-sdma
Date:   Wed, 20 Jun 2018 00:56:57 +0800
Message-Id: <1529427424-12321-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0073.apcprd03.prod.outlook.com
 (2603:1096:203:72::13) To VI1PR04MB3231.eurprd04.prod.outlook.com
 (2603:10a6:802:6::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b31a4a43-c999-48d2-d03e-08d5d5c2bd5a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3231;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;3:PfUGK8HRlzqXmsDGVozfONkHYEUlDQl+XI0la+9iFZBXZ2MGRAe0GTm+c7VtF6YUt44yqWzazPBd80TSbnCX0EBkmcHkZyqqpb1UpnJuneqtuNiYESSCjacxUC2qr6Q+x8Zn5G7Fhw+znAFCHLL8KbepkpVUo51ct5jOqI3CpSzyUQh1SI4W2CMGU/idCZZAcprADle328YQUqO2BBU2IoN2mTZwkrbZDYrtcN28SEpRlceWpwUcsifWOB2UPopv;25:a/obr89QJieJQZLUC1KSvrztfadJGGRy2HMjpKziYqa/KQIAJPsilyWL9y47TSyJHMtGHXy3z+mJ0FQclJwpzCSp4HnqbH2IGmFws6Rx+WVVxRxllSimlLpyVCaZtrLO+2LM4XVKYw1ub2zx0Tao5z5Ih18vawBdmHvTgLdcAWauUD7iuSMFVQPsbw4iOu1NLjXp75Jj1pR+cp91MBSoaheEiYpL881ji89Bh5d8vyZrGR1NaN4MpIXccHR3GJ7BXnzWjJSPC1qSh29w4mSRPIOBKBau+c7oZjV8yr/OXWXTAi1R6vDWcV+KAJlnEw1zEfjbNJ1O3KciPl6KeUm37A==;31:6gjufXZkLjnyogTB0QEbis3k65JGHKehZhk0FQZgRDVN/GzWHIfCKTLGGky8abxjzLQT7D0JqADxHcuyTZakOZf/Rh69yRMK8Bl76c+HfbgJBODJx2c96zj5CsDg4SIeEigxNSsDSyN1z82O76j7AK1tJdZHlj0TuJoJC/WdMPLXYPfVTeTPHJTBkXI1XenSQkqu0Ng/yd64CnxzbcXtfmtVl0r1QOliJ0Jbb84pO6s=
X-MS-TrafficTypeDiagnostic: VI1PR04MB3231:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;20:fw3M2LnMjkjN4ausr4Xg8pe3wUjQ2+g+I1QKkl1WFio/IMEwy4DsWZ9BnsNj1CcQIu3tQxVZF2Vj6fu1NnLePeYCaW6k1JOP9LIuq83hE0HFfwWQ7CmVr6/8e/KbNVtI2I9DDCOCDOy/Yzkx8j2R6Ue8R/Q2ApiiW6vlQEx/Yrd1zt55ihw6HwIHHkVFluz3iovrXIcdQmuKMZAj8o5Tn10bAjzQCLyfAd8bp1MaBC6mWJsUJ50tqOQs+QaW3+hbPcEvyZIbfx+RiJuRqWZ19DnLALVa39NaGr9bVlC06Ap+f9/8R0GG08u/FX8oiNUvj8+PWiPgmaTYcCzT2+f8Wc4gksECtgAZ62ZB6e5JwlWzilNEwZPLBfpscCE0AlvzxYxk0x62pLn41FlEn6qk1H8AlD7BngOSWoMpPuUZSwVdHwymbaHGiOZXS0J+mSYUd9cy5HqLJRLaA6vn17mJwZqKujnS98zMyGVZaa3N8gE/lWnh3aj8XVVFGMuCpJcQ;4:DTAl8U5plalr0kuJb4tAvQpkkJ9lXiBEitWUDo+iC9khF6sqtzSIVBT3SBE8oprK8HshdZPlh/znpnIpSSyrvpvTe39n6YCDaye6feozbgAxXvZcpn+qlpqghrSLlAfyCiOH/bp1J0XjhNk8Knc+wG8pXPqUY8rHpey4AOViAdjU1jCb6vV/mLtlaskj3lrHDyIVAVBP+n4dYFXhCb+nAEbm942nNLOtLIog/RmqkzZjp4UaGQ/5ULnTgDeKBEW2zc3IsnyoAl5PWWkJ1oe/fg==
X-Microsoft-Antispam-PRVS: <VI1PR04MB32310146BAF5BE44FE03C56C89700@VI1PR04MB3231.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB3231;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3231;
X-Forefront-PRVS: 07083FF734
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(376002)(396003)(366004)(199004)(189003)(53936002)(6512007)(5660300001)(478600001)(386003)(6506007)(59450400001)(26005)(52116002)(4326008)(25786009)(97736004)(51416003)(68736007)(47776003)(86362001)(66066001)(7416002)(6666003)(105586002)(36756003)(50466002)(6486002)(48376002)(106356001)(316002)(476003)(186003)(16526019)(2616005)(956004)(486006)(81156014)(8936002)(2906002)(3846002)(305945005)(6116002)(50226002)(7736002)(8676002)(16586007)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3231;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB3231;23:r0Sgkf3f0xAQ2q1Cjlt3PjIMmqCTYRBGycTDQoeTY?=
 =?us-ascii?Q?RP+A+KXxP6CfYoE30gwxUGAh3y42uKcbUmHrhBHQ/7/FmQ64sotMjo3m5s9s?=
 =?us-ascii?Q?Cehw5N+W42SRVj+xkDg9xDADHygLGZPRcUcr9PMJmJk1ELV+9kEJBHUOKh+8?=
 =?us-ascii?Q?AwU61JH2rRcdCQKZzA9TxBRZLInDj7Pl+BVHAuMrldK5gMSjOsPwwa87/29p?=
 =?us-ascii?Q?+jKfVcN2kbvDkBZ4BPLzJfehJT9A5mVwLwitMGnWlDVp4T+/0OpZUzmVTLiV?=
 =?us-ascii?Q?8DChVtqaXbvLo/s3gIQcMX7F0DJRoD7sdvUlSQe7cNqz+J69fv0rNXh4NhhF?=
 =?us-ascii?Q?bVR8ssw0MZvIC/He/iytxZwU5QvMQwuVOT/q3aO6qBZmPG4+el7Nb0JAfDYU?=
 =?us-ascii?Q?N/YagFiVSqjFpoaESQvNabqd6s1+kWO78x0gyqk7fBrPE5jSFdoHFrxWvxAY?=
 =?us-ascii?Q?EqUYhlVxLtHABnbZy4j55P5bIwwNbxIxUSPXRtpWl0M1tosGbiApo8Xa5vqz?=
 =?us-ascii?Q?4T0zi4Zitx1qhvJ6HZCbBtP8tX1T82XltFfr/YwSk8U2DjVH2UHJiuDdFg94?=
 =?us-ascii?Q?c0spXGza4730nsXVI6Z9M6tCRRmj8Cb5y3/q3Spi/FkviWGJoFqVgKlxZKqb?=
 =?us-ascii?Q?BYLKIHBKStU5FGO1PrF+D2QW4FpHT0cMZjG3VEvib/ZwRz+q9fqERcmFkn6I?=
 =?us-ascii?Q?OYz+2/xR3o/6/2CF/maGf40OanzDu7oM5IsUi/7eTccBhoDTl0ZtDXBW/spG?=
 =?us-ascii?Q?6AzKti03vkVGmeK2ud5alnhKDCtU/veTJDL+1WVBNK1syaJH8lEJt3BycGEm?=
 =?us-ascii?Q?apbYMedCeO/n/XXY6y67oZFpZM8/lFRok9ahS2GvMqd0zhDgmCBczmYAkGYQ?=
 =?us-ascii?Q?TnKMRD22WpgVDcSIYrzEQGeFlFniWhcpjkmHxU+G8vPJl5xLokc55O4wrdfg?=
 =?us-ascii?Q?MVts2e9Mr/VT2wk+ag8Sw5ZtVMNXgikxvlnCMpWHNU+JqBDKy53ju8deVnon?=
 =?us-ascii?Q?4oJd68pczPlMmB3grtAEYIZu1Ez9EaGFtISWsmA36MzQ2NT/nCUXtVg9lt8X?=
 =?us-ascii?Q?WqbcuhAlg0CuK72MZmFuiMIU0TTywuG6r/9JcTa8Jllol5t2bJNeT7sumjCy?=
 =?us-ascii?Q?OksoSJPOGKoTsjV7VH0f+NzWxZzHBcl?=
X-Microsoft-Antispam-Message-Info: OScKl1VL3Jl/ICuTfbs1H+J5NiI37hbCQ8vy7wAIXcVmPaUfUi+9Mmbq4HLGS0ZT4aWv28nYWi4F2GGm7TVOQk70d4G9vBGSUj4YwkiZaOAoNyIzP71cF3JgOQEn1ardQ9MsYzI6xfM6LpFsbbetdYmRxsFHAvHDI2z8/uF21R/s9CC8eVMzGcLlX3ifWSv91WcP7MFg/J/jJB40Qlsq8pHgQ4W/Njui0BHrKXndM9ghual7V080MeqIC27RIWwZxD9a+wHcyWx6SVqWweUKt/1CJkHLEsiB87xN+dt9qQnow+t6Zm1uoLDb5WviOOio
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;6:dmOtKg1ofj95dnSU+HkOxf1mbMaz9iIJ6MBVAk8CnE5S4mCW8vYUULo5XqU3Ne8gsmzM7LbBfBF3p8P3CnDWB3Hf9LpsTrBsL3tsiUeUW5hx3tYRLn3UzNWngXZNF5uQWISj9VLAACwkvWmlFsA8PZ+na1FJwMRhDEl5Jz+YlxIERLFYlUNcf/bSsHUd/Btzj9UkT2MaHa67OYxZEJu3hWEeVidmu+8UJ6UL6SIVjpjKxSGmymqpCeyvFet5jcRoPVsBSj2UI6XUhiCW4JxPDSpScJsMHhXASTM8BGH2YmOrpt7xZ0PMsxzWVfQ5YFC/T+OA9J4FwNlfduyRnfvbUQwAWb8fuQxXYa86YC+1kuqnckMF7gIYT5N0f1nsGxUccQTfQPSX2zVcg6g4A6UVnm2AVdwRyA7ycaJgzMFb0Jkmuh/3Anm945G/LeUtamU+y4CHofQN9d1eEGqxTTWzWQ==;5:dOvn1ygvCE4tM5uJmIwQvU8hiufYslJSjB+rDKhhHwME+Phg3moKv/Z35k2f83Jwa0e2EehveCIMVmDK/LhNUxq+5FXebq+H9Qvmb0YA91yJAQ3qdcEdNbb0D4gYgQM76eLYSO27X93Aq/yj9nhX+GKGlhl5L550z7SAz6pS5sI=;24:cT7QYeTiyWs42Upp/kWSH051QeAv+SMqslMJQ3hi3c122Axr3/1548TegHtpzKW10/tQzubQj2Um7jBfJXQHNwSyjSFjx+dQ1Qhz0gWS+Mk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3231;7:5gN99nANpuMrmIA1cr4rb/JzUWysdt6VeN/VC7HLekDhwdmhk2N40C5q/WfRgh3m4UuuXQtVYS/+16NQ1E8fU5VUwD9R9oTkmu7fXlqwShJT/muq+DS7KPhCD2WLm5WYw6sDwtOZMX/isP8AYYUm13Uu0hJh/Yia0lVK1EagQFulVYX4ByHUOkitZk3lspan1EibPhUAO9+lFxcLzYadlxCVrGkPysL/s/Sz6HASYgTR9IBM9OFXAQz2gycCDouw
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2018 08:57:48.2783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b31a4a43-c999-48d2-d03e-08d5d5c2bd5a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3231
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The legacy sdma driver has below limitations or drawbacks:
  1. Hardcode the max BDs number as "PAGE_SIZE / sizeof(*)", and alloc
     one page size for one channel regardless of only few BDs needed
     most time. But in few cases, the max PAGE_SIZE maybe not enough.
  2. One SDMA channel can't stop immediatley once channel disabled which
     means SDMA interrupt may come in after this channel terminated.There
     are some patches for this corner case such as commit "2746e2c389f9",
     but not cover non-cyclic.

The common virt-dma overcomes the above limitations. It can alloc bd
dynamically and free bd once this tx transfer done. No memory wasted or
maximum limititation here, only depends on how many memory can be requested
from kernel. For No.2, such issue can be workaround by checking if there
is available descript("sdmac->desc") now once the unwanted interrupt
coming. At last the common virt-dma is easier for sdma driver maintain.

Change from v4:
  1. identify lockdep issue which caused by allocate memory with
     'GFP_KERNEL', change to 'GFP_NOWAIT' instead so that lockdep
     ignore check. That also make sense since Audio/uart driver may
     call dma function after spin_lock_irqsave()...
  2. use dma pool instead for bd description allocated,since audio
     driver may call dma_terminate_all in irq. Please refer to 7/7.
  3. remove 7/7 serial patch in v4, since lockdep issued fixed by No.1 

Change from v3:
  1. add two uart patches which impacted by this patchset.
  2. unlock 'vc.lock' before cyclic dma callback and lock again after
     it because some driver such as uart will call dmaengine_tx_status
     which will acquire 'vc.lock' again and dead lock comes out.
  3. remove 'Revert commit' stuff since that patch is not wrong and
     combine two patch into one patch as Sascha's comment.

Change from v2:
  1. include Sascha's patch to make the main patch easier to review.
     Thanks Sacha.
  2. remove useless 'desc'/'chan' in struct sdma_channe.

Change from v1:
  1. split v1 patch into 5 patches.
  2. remove some unnecessary condition check.
  3. remove unnecessary 'pending' list.

Robin Gong (6):
  tty: serial: imx: correct dma cookie status
  dmaengine: imx-sdma: add virt-dma support
  dmaengine: imx-sdma: remove useless 'lock' and 'enabled' in 'struct
    sdma_channel'
  dmaengine: imx-sdma: remove the maximum limitation for bd numbers
  dmaengine: imx-sdma: add sdma_transfer_init to decrease code overlap
  dmaengine: imx-sdma: alloclate bd memory from dma pool

Sascha Hauer (1):
  dmaengine: imx-sdma: factor out a struct sdma_desc from struct
    sdma_channel

 drivers/dma/Kconfig      |   1 +
 drivers/dma/imx-sdma.c   | 400 +++++++++++++++++++++++++++--------------------
 drivers/tty/serial/imx.c |   2 +-
 3 files changed, 235 insertions(+), 168 deletions(-)

-- 
2.7.4

