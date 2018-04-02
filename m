Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754564AbeDBKk2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 06:40:28 -0400
Received: from mail-cys01nam02on0053.outbound.protection.outlook.com ([104.47.37.53]:12797
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754332AbeDBKj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 06:39:28 -0400
From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To: <vinod.koul@intel.com>, <dan.j.williams@intel.com>,
        <michal.simek@xilinx.com>, <appana.durga.rao@xilinx.com>,
        <radheys@xilinx.com>, <lars@metafoo.de>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC 6/6] dmaengine: xilinx_dma: Use tasklet_hi_schedule for timing critical usecase
Date: Mon, 2 Apr 2018 16:09:06 +0530
Message-ID: <1522665546-10035-7-git-send-email-radheys@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
References: <1522665546-10035-1-git-send-email-radheys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(39380400002)(376002)(2980300002)(438002)(199004)(189003)(54906003)(2616005)(90966002)(336012)(486005)(426003)(26005)(11346002)(4326008)(52956003)(110136005)(186003)(486005)(36386004)(36756003)(478600001)(2906002)(106002)(2201001)(476003)(103686004)(126002)(47776003)(6266002)(76176011)(5660300001)(446003)(51416003)(48376002)(316002)(16586007)(81166006)(42186006)(50466002)(106466001)(50226002)(8676002)(63266004)(81156014)(59450400001)(305945005)(356003)(8936002)(6346003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2258;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT051;1:gWcgMhMW4MOslzFETT6LXW+qOUZQE/ndnDmM4As2UGUCjmKdA0x+YnNOGEsjjOUk5xuTzqYrK26hAZZ+6AB1FfixBniscNglN9z1O0Kggl5fTXg+PnxLCSzdBlpvHL95
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9db8597b-1fce-48de-4993-08d5988600c6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BN6PR02MB2258;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2258;3:oidr+hWPyIqWNK1M70OeZtpImnD2Szy2pBtRQmkbCrAocXkmRWQ55EMsHZvvtOQlcD08md3vcpNFvScGiYDEFcHNIE0un3quX8e/fAbFQ4x2XxxOgRRByhA8zY7YOCarG4BX1mkuegWjOHMxZK2/wE4GEOi1l0wyK7pE0HDIpExsLEQJr1HidGqvaWY9/qIsSV318B+DrQE4rpDXiZTmRkpFt1ZLWBfF4GVy2C8IwahXKYFewvnJhewcX2YnR3W2NNn01VVfqDui+N9tKaPAw3THInYiYDx5peMNye3uY8+s1E1abwNe95EBuzoiIGcDkJa6Sqv5S/w//p3kPuTVxvRqwR1k9Wv6HeqVlJpcq0s=;25:Snat3KV/X4uyqM/SQO3iwvvtqdwyW4fbxGaafuXVjflHaoKKmzb0WT7dsvQjt0I9taReC5o3sBB/kwvaHc+rOgvzi5hvX++ocSZBa1MXiOFMD3cQ3cxXCaCfokOetT2yox35vDP/RUznJe89LOYiBfDz2EO7ftDrH7aTkFwPXnoVgKTsX2xJGcO60kM5rgrGK8D7LwWimnn4Vq0Iczri7v1b4wwLp+2iHya6aSTKNF13SXIqq+f93DU227SZWsHUA+8NqJgf0833mZj//7VQ6Tfqs9Ro3G/tGyv6WXMGwiexvqNebDSlFtbfEACEnzzgJ3dZNje1cdO/R1uRuM5jBg==
X-MS-TrafficTypeDiagnostic: BN6PR02MB2258:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2258;31:MjL709Vaj1E23O39xuMETFMnHeJIyBdqQ9x6708YeyeOIBdTberGM9YoO0AqZipqJfXgM/rLdhLCLW6ADzBPEQtR7KfAv4/GfpaElsl2cJvCbHEELk/eg8ietsltOpvf7hQBuQNzUdyXJq6imoNj3fa+w0nxaTyhQzHaKkP6sWHbAcht58+dZTVVkAtf8glm9zklJQdkklrbCTNSmNitOG9mpjqebv/nKg0CN6bFicQ=;20:mVTbkVH2lki3Lj1agOhPOOvWK7aC9V0qzOz4qIygbKc1exskYNWXyna/7NY/IxlUHHJiLp1T9Fzrb6hKF74ZpDljD1VebQbVDd3xFp+Id+Y/M7C7w7Ol0PxO8RA+WwdUyhh28rs3Tr2Bi2gFGm3h31Ngw174SR5iaYNAe33suaYj2F0Ks760fIuYsaNJl6pwtnWwcfdNetBSImkrjlf+sSuPVrD/7iDyqlF/6hPx+IxJcsXEXd730hwdz+M+GCDqVesL4JWIsYQ5jvOzXFjZNfwWBKrNQE7+5kdR6IMnmjfFA0whMgdk8ny8syCChgGluhkLRxwPIXk9Nmbt54ms+9C0BY+YAZ6peJunbNTsMDth5k6HTZux/l9YLAg9PH1wuUD69gd30S8Av+QmhzAF3pQBW5UzbhpPWG3jKuPUCfwMyrTFlB/WliT0+c9taIP2UgJG74cqKeA7qqd3RpBCZMm0DDOPYzn85c4BuP1DqkOr82VtLcYYHm3KTtG+TqUn
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN6PR02MB22588BE3FF1FC65149ADFE64C7A60@BN6PR02MB2258.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:BN6PR02MB2258;BCL:0;PCL:0;RULEID:;SRVR:BN6PR02MB2258;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2258;4:A5KL/B6WKEryLt21DiO3L0zoVXDXk5DzwgeS4b31Ac+2YgV6F+WlFrGJLRqnYpsvjfjEA2otizzLFsdpycpM4w9FqKU2kAlsxUPvKAJhiDaR08bX4fmEuoa1D6bQ18S5Th/RVPpv7WZz+sSj+wHLTT6yzGhhW06nHXeGuVXtAywDbP14kxGc8tofK9VCcuuBbuXFJ6ka4KvnozOzkATJP3BICCTk9id3jJ9O1fDaztfgcPFLynRdic/WobpPpb1m50ir5pKds1oBP6Sq5Du73h4nPtAfSnVdQ64aRCdnSXqa0Dp6FNez7CFuaM6N3eNZ
X-Forefront-PRVS: 0630013541
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR02MB2258;23:UEtjpcTSrSxZe8+uv+zr8fCyl1ONYMEdS6FDd4qEe?=
 =?us-ascii?Q?PbYDmIp18+vCVJXXoN79Kfe3q1O2Ya5HJqXp6VyOjnDqzeD1e5a6y8HJhDIO?=
 =?us-ascii?Q?gYlabEj9+1vzJevKRIerbVCFhrPu+frNG78rTA1kqi58QfjntUqaXZA4N//C?=
 =?us-ascii?Q?HfK/TrgVex7ogxD+00tARsEAChJI7lQMkaRJlvxEN8bD6bupxUDVuwxz2D0C?=
 =?us-ascii?Q?nNprjzISz3IZ0d+6lK0ewb9YJbs/AviwOnvO6CnpTumf+Lg5royZGpIR3DMt?=
 =?us-ascii?Q?nPyb5syOpFE0Dn0yb4YJy37IRTF15PXTtQIKZDjU1p5km+Yix7EANiuiiRqU?=
 =?us-ascii?Q?ltgL+X38+/5tLIgK1++etEctQinmjV3kwlgeN9YO9oRFuIIhDP+shA6EwpmQ?=
 =?us-ascii?Q?kEcDlA4ENwTs9Fjlf9HYzSUbLjZMSvgtPDb/4pUPAswST/mRZSYX7nCi1df8?=
 =?us-ascii?Q?zggRWIiklalqcEiEOVpsHBocjbLhQOP3Ohvbdhgue6c/s1kcuIEucuFNcVIz?=
 =?us-ascii?Q?7FdnV/3CCnH3ntrIrkci0HISzNu0o0ELvEgtaM0MAvDa1kVmX5yUyaXkPSGS?=
 =?us-ascii?Q?AeSA0mWJWvWMeyjsiT5P0tlmM/5hS+0/DTHHSPyRKN6klb1Yl8vwikAWQHQ2?=
 =?us-ascii?Q?T7b5tU8uCGdjvLgOoJ8H3xqovbhwmq469lLRUQSKDIlGOJytSICBNerkuy8f?=
 =?us-ascii?Q?oE/2YSYd4lHy3OC0cGyBjFLucyyy5I2BNp7CbD4KlEZAzG9m+zvDf+zMjN2b?=
 =?us-ascii?Q?G1TjzGcjxPscJjpbPWiKmb5uh1FA6+Z1T5Ub+YGYrZLS8VkzIZlXMKm2fuqE?=
 =?us-ascii?Q?K2tslSbp1nMwObYQ0rvOcZb6qdJU47A+2NHXqj2nQcUApgNujkpccNEsEm+8?=
 =?us-ascii?Q?DLZS+r0Otvh3N6ZRZta01HtiE615HmfAixtwd1BF+2/c/f+k7cEx1kvs5QUP?=
 =?us-ascii?Q?gpTCpKN8SQ8yEOM7F9z/B8kSgyEArScMRKnsogEORk47RRTWfPlTh6OoIYWz?=
 =?us-ascii?Q?4Iv6TAlgQBRgnlp2ca0JWa0FyCc1T+MPQEhQ8WeAWp62OJop+eccnPvBnRoT?=
 =?us-ascii?Q?p6qaTrGN91UbFcIBDnLk9vcrxMYqsgc3TGqb0tGCnpoETL8RDvn7mzzGjodN?=
 =?us-ascii?Q?70MqPT8fb8M6lQE9NQq6HbMTWjwCt01EEsxvt/Y5ZelxUFM3Y+b27DqpdqpN?=
 =?us-ascii?Q?L+8WkGIJ7LZItdjR5J2Oixj2jhULMJ//qaS?=
X-Microsoft-Antispam-Message-Info: s6x2OgY/73FlPglA1C4fQnqgroPN04/ytRvF5iMwCZjeBcQTWvf05sYfPdgeLxVpf2n/RJUKrV5+v7r/tTNP5qxZzCbWVFrAQrGI40qs5p6b6UmSdhw/2rKxJyK1oSEtZPBXt/7aI4c8g0H71ql3g9VoDuSve6w0CuIt5f7HMxPbFIwq/rMmQgqBKcdyk88D
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2258;6:9WgJS/GaOHpVIia0kEQ/mDbE6wr1x67/oSuS+Jr7UIXjh+DqSXFuWYfoOXvsg8xYXg5Wvd/zxa7dUeKL6/vmvhkjqtRu+aW+HeJQor66v4npc7SEAuClDuoKEX0cUoXJWsk5z+cuYxU5zClGaJ0N6vkiNrtcnhLxl+Y0vtCy3i0X2+hVSmAJWZqDApsnVWAb6IY2HsMES40YlYAQtEUq29GWpCF7hrYvlEtHL0NrCZ2z/E+pQ5cGcOrJAiLhd/4vGRYDhGnaIQWwDj8JgcNUO7YIAUlDX0RdFArtSiaDGXeDpdTj+tF1RtQY9rJZFOrwVNj6E53LTvSbNtPiZzoLydBBi7zHeh9W84D8lqYmxvDRG7Pne6JrZXRwi2TqzlKXx9VIrgNB4PYadoC9yYDWG3mquhW/9xRA7QYuMs6oh/5pORKNMZnUEX+VU++jJ1EAGVBoXUjrafft6xexTrEaFw==;5:UVd7AOfjqtn8irdfCho74oKmlWfDUYAzPImHbosdIvdK+chEpzR4yB498vgUqj6Hn0hmP+iNAdbue8pPjA43g+ZG7F1L5pl9H7MU9qHHiiRxI2a/GZl4VgeYExCQqAwAGOi8UolopqvETJGm5L9Dodmllec8hFaCpUcYq9c+SjI=;24:KOFDSnTDfjua3jmF/W3mdA0sPnPR3Cobo9puwSQ7hu9U53bdGANgOMRen+/0J/RIjeldHc6iRcF0m5+pQXNghn2no+KLTts26usW2+DBtIs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2258;7:yZO/Y8riBrVW76hg4WcgY//zKgOplifEcQGWUUwxcvZzsEaZs+dgH0waOd3+oV2hd6BAXtQCEZUMxj9q7MGLXRH+E2lLFi9kTTN12PgBa6opWibNpCwnV/701aZt4tdZL4VViT44PfuMDJa8ZhN/T2M8u2BY3aPKD51VDYZwkrFyvNCuPLDEs65ydJy///9cOpHnIGBk98OD4x3zTyhNizvy2YhwArhjdzmgsDraHx6vUKgnG38oHfdUkMf1RvfW
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2018 10:39:24.6952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db8597b-1fce-48de-4993-08d5988600c6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2258
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Schedule tasklet with high priority to ensure that callback processing
is prioritized. It improves throughput for netdev dma clients.

Signed-off-by: Radhey Shyam Pandey <radheys@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index ab8f1b0..d45224d 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1536,7 +1536,7 @@ static irqreturn_t xilinx_dma_irq_handler(int irq, void *data)
 		spin_unlock(&chan->lock);
 	}
 
-	tasklet_schedule(&chan->tasklet);
+	tasklet_hi_schedule(&chan->tasklet);
 	return IRQ_HANDLED;
 }
 
-- 
1.7.1
