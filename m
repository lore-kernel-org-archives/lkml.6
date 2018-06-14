Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 599EEC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F4052208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bX1XM65i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F4052208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752877AbeFNGEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:04:16 -0400
Received: from mail-ve1eur01on0066.outbound.protection.outlook.com ([104.47.1.66]:26731
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752707AbeFNGEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuOr+/lAF+pp7lYOi3KFSvyQ6VBjf0al83Kp++cy0Q8=;
 b=bX1XM65iKVPsRWPloKrGoEpGuOXBJMxXf80V1vgAuyWWpqqVsxbBQtH56BeeJ3unjQoWrp9kYZJOzB1icSDGypAqO/sl7VI+en4Pl/9hu1bZwP7qEdMHUzD007wqCbS9g9QAufmJLLVbz6usAyjfRIQV8CwiW2WbuCS9p40Dyi8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM5PR04MB3219.eurprd04.prod.outlook.com (2603:10a6:206:7::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Thu, 14 Jun 2018 06:04:05 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de,
        dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     linux-serial@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Subject: [PATCH v4 0/7] add virt-dma support for imx-sdma
Date:   Thu, 14 Jun 2018 22:02:55 +0800
Message-Id: <1528984982-5074-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0014.apcprd03.prod.outlook.com
 (2603:1096:203:2e::26) To AM5PR04MB3219.eurprd04.prod.outlook.com
 (2603:10a6:206:7::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 68cb294e-2bdf-4008-e35d-08d5d1bca465
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR04MB3219;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;3:d8oWjN5DBaRqC+Ivq5dmDmdKFrCCRaHzysTHo3JgMjl5M2VWe8T1SEa3H5jjyfErZgUsYNgezS598xOVNdHJRD3StuMYj2RGYoc4P9YK3Tx8nZNmQftcY47u3cIHrcF6KT1OPY/P25WlYcJR0ONmkTgSsjyhnlBZfn+uT7cDwyGZJE4wkc1ZnjFsS0Hioph9Wl6tKWCK5Ub3KO1Ck5TibAZ/5A5fcTthk55X33ziSN/tEBdFncymWweGS5Hr5aE3;25:XiJhKC9RdAQlEFivhmrK8hsxtjkD74Ayefz7x/fEz89MSg57UO/MeG3Yyt+sK7XwyghCt8LROd68/6l0/TvK3iv+s98nga0DE8nGcgWk9+vrdlJZKx7q7T97S3FWGD2hvNPZvBGohdn2UnKT3aue9UHJBPoaR0tYfcpR4SI+6TDwPg/INVGUgj//6v8Q6PjlYVbnktRznpoVwwcEfbJVw66dCyVJVKbam+musdmZniIKTtEY15PBwhCQhdgxsOeJ8zgPdJ684NS149tQ+4VHrFITyMscHTY2CLKFfrP75kvijwWO2Sr0iHqmMZ8yX5O+1KcannAB9Ppm3Mel62BRBw==;31:YjUKjDad7FnX5Q+Mm4wNCZJEQuDad8p0wJOPXX+9DUSkUtCcD6vOsa2WQ3p5A0oQYyjdemJfP5VoPXymT5FCE5BzfrT4QGP8gRF3kwSl5XbDElc0jRAMaU28Xib9aKuClP3LVNObsHMJqCLnjjCq45p3Aak3dEoo3OJNNB4zcb4lTxFD+dcHKQBWNcHnZtsbLpfutugH6JtBt5BW/qDFiAi8GBmU740xO185L8GKTXU=
X-MS-TrafficTypeDiagnostic: AM5PR04MB3219:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;20:hlxRbDem/y2YGk/spU84mCeJjITec21HwUNAqnFNmHfJvFJW8vs/P63NHt9JTWbygPtGVSfuvvWOrbedrXdgwQ0mws89hkdwbqEjZ/MLZpBXxqVu2cuIx9q01BTVoESlK7/7Inb/2ld2mHzD1uxRBB8Ww8HX45KPxTHc8S16PXiljbhBf4pT1S1VMipT7SBGrrkv59fx8YJf2K9SDweepy1mbte6FM8PIh0nDdXJ6p5n0/ibhTgotTlPQzMQMeew4r93fHpUHNr5tTZKZZwJoMmPvNgrKg8BNdXfFarQy/Rqu66y0V2oAyOLEzYbGcMYMmgOF8qX/PPVMmU/0k7ZssT5fl+aeDwdQM1IM+GZxNhOH9sNgjD9Mx8cBhg1FNMqooNaEj7EBvutXo0gFcY6BxIr99FYu9a9+kyNk9eXxANOnbsMhIA7Z/csjXyY1jR+KRq24cMKR19vPi5+GYmvWtFaI808I1/IYgUiU8hC8CW06b/TDvHqAemnoao69tWA;4:su2xwUmGE1NdlievZD0qdP0vxP+uD1+lHQElHlLp6DCTu3wsTwEWh8Zqa3dnIYFH1UTGQmHwI17eIc/+mjO03hcIJsZQh3RBkuVPbngKuRlDs9RW5Wo/+J9hyVNmzi+f2zhqGK2eHCK1rU5udVbULSrzWRGKnYENraU/atwISQHElkEWeG0H+LLn/jat52b0nHZp7bjH78HZzpjGWlKgtXNmtWX5+RpmbDfh4FNIzOBiQjCL+ufNbEob5OFHgHWlfZ79bv2MFuhiYnZPqbE0sw==
X-Microsoft-Antispam-PRVS: <AM5PR04MB3219062FFFCD69B41C48E8A7897D0@AM5PR04MB3219.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM5PR04MB3219;BCL:0;PCL:0;RULEID:;SRVR:AM5PR04MB3219;
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(39380400002)(39860400002)(199004)(189003)(68736007)(59450400001)(478600001)(7736002)(8936002)(305945005)(66066001)(50226002)(7416002)(86362001)(6512007)(3846002)(6116002)(47776003)(316002)(16586007)(8676002)(81166006)(16526019)(26005)(186003)(81156014)(386003)(6506007)(2906002)(52116002)(51416003)(36756003)(6486002)(5660300001)(4326008)(50466002)(106356001)(25786009)(48376002)(105586002)(97736004)(6666003)(486006)(476003)(53936002)(2616005)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3219;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR04MB3219;23:D0n8giORmxCuxXD3HKaR6H8T+gntHMbI8Uf32RmdR?=
 =?us-ascii?Q?lxcCV+cXPYtFgkA2RjUsJ2Lq0EwemgOhJjlzQBXZpRZYwEzAfLZgBq9y7ktB?=
 =?us-ascii?Q?9uKwq3eB5VqXwt8wcM1IX8+W4ATKJrN9SQDpDpGvIMf4UXDsKbWZ6wPXvvQ7?=
 =?us-ascii?Q?YzZjvlOAVGOzsUy9kIwOLlkkVruX2VsaabzdBcmipPJDCGZ3gw1ardST2pAc?=
 =?us-ascii?Q?VbJCvbwESiF1MvsFUmimGdW4JiBVsKvhexMYoQmUbDWuSSlRfv88G8dA4/qa?=
 =?us-ascii?Q?Zi1DNNn2kjGihJS7u6TfaO20IfdYh8KYLMPq4cpR0lxYQH8x3OzZoM/zHQXN?=
 =?us-ascii?Q?YKBVfh7dOuEPv1M26qnJZiaMMNnaH8xzBGmFH0F1miCEmMIlSFtfKwciwVt6?=
 =?us-ascii?Q?hqtzROBTU/OfIN4pw9xZJWK2NEWKdGfYmvPSlNkHd69U0llVMjgQoxCgZ/iO?=
 =?us-ascii?Q?bEZcOdPOV9KMiPsUxKA7r15V0Dw4tbYvElfQ1zSvminvjZNBOHzjElg1etbp?=
 =?us-ascii?Q?GJbkcWrUo61Zzb/Hc9lJIaNwVbKxJzm/EFi03g+8Eu4JDQXqYhbv29gqf50m?=
 =?us-ascii?Q?Rhbk2tzBWg6K2qfOGSL1Ea+1hkbB4HsWAJV83BZ4B1S48VuaPUpC/uI8SmBy?=
 =?us-ascii?Q?AXVqrHH8bZzxs+Rjj7bxBb826mG65QKkkrg9D1vk7tqC9VmcCPOyB+JYdSnO?=
 =?us-ascii?Q?FprowtuToj/4yCiLZarV0inYcNopU4gyGDspZZjrMJ88m76Qts+OzeoWWc8H?=
 =?us-ascii?Q?S+VxybJJWTJN2PXbMq+bigHf7dfZoYGe8mOgbKh8SuldRR4IlwReabNArqI6?=
 =?us-ascii?Q?0K+7AIGVSltjwFrIwbjUbfPn6ZFLEfUlWkQ5jsz+otX07GbIHeUlhlBhQSis?=
 =?us-ascii?Q?jgr/PeecEiVb+22YaVJei6JgrlZ/CUUAcFOj/F1KHgJ6Qwb4dmdOV0EpEc+w?=
 =?us-ascii?Q?1t43eQSBucPo2BkmYS+XutDnGg76ytmwQanRn/tOmBOoRqe4ioLwnzFIwKSV?=
 =?us-ascii?Q?w3xehB9I9mywxVI1g0YGFBJMHe0ZmNdN/LnFrQuRNa4k0/UXpouvYxSmG1QQ?=
 =?us-ascii?Q?5Tg5HqGimFUMcIRqVHnzT9f/8Ma1RfJcrj3DCiIYH3pBFWB6A7bYdq5BdS5P?=
 =?us-ascii?Q?Fu9spG/+b8i2qlzZaOzMroJA7b25JbR?=
X-Microsoft-Antispam-Message-Info: 8aDcdO/CldP+IQlcJRBbfOWbJ+n1Pw+L1gwVSROWSYG4HGydI7Iv3bY2M+Ni/ZGEN+6lbbLW/OrS+8WUtc7f5OwnllWgmICEPROwqJmc/8Es+zHxF3tLtxoEwNrLA9c93/ftiD6PMEcSgjaj5qqdknk1NAIMzWYi4ScUloSXSP48QKnCbFwbH5jmIG7AZX0V
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;6:jNnEIr5nKcrSC8S2975GF4vgVjG9p6foemBqt1Loa0/II+vFdv6EdCWndQbjXHYQy6mHES4GStZ/pTrFjWruTX4z8haPZifZHOJ2mJrVxqh1arhqfJOYxpE+Ern9EBLBrrdzTYgZMv7UfJdvY7YnAVhQAyNgtoC7o19pSgdHyBLmUa83qO4NGbuF+sd+T33EUbfxriP7VwsSGTvQoJ+ce5MRJLl7MobLx2UsMhCB5q4ZsG02s90fZuvHR8TrUpx93O4AmjzNSqIsyTQLMg0gSigS2mhGFMsC9mUnSSVJCa1GgnkPaqU1ougqGp2jB3wSSG8yy4GoQx6NP/OUK95GroY2F2LV+juUk7+N5fTGdYmM3Sf0hGyQ8NWNp1Wv9IxYHPH5zgtLV8o8D15GIPKJM8kbTSrSrjG+MNW8gaXJuj3UP7MbxHppkzhutYSnqNSVFczPeSJSpnZ8Ltx3ymp+/Q==;5:juZ8HozBFYBWZRgKgxy3x5hx6SG9bgnNqHLJsXtd6TGbuhwschLiD7a7BfWBiu4+qYsbKd2Q9+H6CjloAo8P8Fz2IhIWCogKrFGkZcl2VriNgIeRfv4q12fOneRyHAZ5p4lw5eY38QPLOfDL9QGCY06jrciy0Fj91eCesw7G5CY=;24:/Kx/Fo+paSrPqL4DJIBsFn7lIddGETHeyyB3mCvnWr+O/6VCYz1YwHE4If8Mf0TZuYJ9FvtrZ5HbMYKlonc3DrpVnBlhQX7Kbgpt0Uors4I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;7:S+lWHDzLE+u+eBeLvmaGGj1GLSzrAKSs4LvcGK6ksJowZGn6j3gtu97XBT/3CU8RiXO8sy1eO4V8bDsiOV8fM57b7PGvzEaNdb88dTFRQcrnL69dzHQhP7A24ESjYkutDmV6vmrat8h0wBBb4qIGNsaRM4TZCYOaP/PcT8JznKiewp+H0SOxzOV4mLutycoxf2ThfoWJq2pZXpO5ebpjEEK5UY6Qcq+CVr/K0G7522HgmqUtxkpw76bng6RbMFQg
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 06:04:05.2137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68cb294e-2bdf-4008-e35d-08d5d1bca465
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3219
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
  tty: serial: imx: split all dma setup operations out of 'port.lock'
    protector

Sascha Hauer (1):
  dmaengine: imx-sdma: factor out a struct sdma_desc from struct
    sdma_channel

 drivers/dma/Kconfig      |   1 +
 drivers/dma/imx-sdma.c   | 394 +++++++++++++++++++++++++++--------------------
 drivers/tty/serial/imx.c |  99 ++++++------
 3 files changed, 282 insertions(+), 212 deletions(-)

-- 
2.7.4

