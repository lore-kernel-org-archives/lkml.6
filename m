Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753239AbeBSQMZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 11:12:25 -0500
Received: from mail-ve1eur01on0059.outbound.protection.outlook.com ([104.47.1.59]:39872
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752876AbeBSQLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 11:11:17 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=madalin.bucur@nxp.com;
From: Madalin Bucur <madalin.bucur@nxp.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
        Madalin Bucur <madalin.bucur@nxp.com>
Subject: [PATCH net-next 2/4] dpaa_eth: make sure all Rx errors are counted
Date: Mon, 19 Feb 2018 10:10:42 -0600
Message-Id: <20180219161044.30279-3-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180219161044.30279-1-madalin.bucur@nxp.com>
References: <20180219161044.30279-1-madalin.bucur@nxp.com>
Reply-to: madalin.bucur@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: MWHPR06CA0020.namprd06.prod.outlook.com
 (2603:10b6:301:39::33) To VI1PR04MB3278.eurprd04.prod.outlook.com
 (2603:10a6:802:f::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 262e9670-79c5-48c6-8896-08d577b366b1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:VI1PR04MB3278;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3278;3:VgVhHyujQxRMZU1/I/Tf8ZnJykCj0ya7QQ5KzDxP7dLv0FkU83fkO//MtPRJNV/5jWHMgqwhkIT1TgEBU/Cu4jGdCtZAEgNXM9Z5gcx68LbbLG2iZ+NTXQYHzMkxkvx7T1HxHUsDkzM9NxSZSKugFvmjnHky+uYWIMgJKcNc15LBjlQtWQtDZsB1MzMnIVnNLTNVusiOrJFBc7nzqpCscdblvWJGP8xzEIMPJWafhp4XbbAAtWKnL55DOBR4VG/Y;25:Nzug0rHdr7gUZGk003DsWcum6errfIVZCo4FNzuZnRb3KQyPCJvWkcURkmHjbtl8sdcwKWuFm6wdReKVwRvCsgolBczoMFTOzawMUucJf/oq2fyCU17pdG93uQjLZzh/JyabutGgLOkNVHkdnWX451VJyBW5HODxpxhMZ06UKrIgkWg/0H96AdB8HGh3rOq0XxvVuGLoxUyHoPkgEbAhz6gOvKyZDnUAcjLoTZMMiPV94PuFbzVYeiPkB49FtZzcfjaPMjWOzgykE3/xIh5AxXfl8l8g6M6RketVcko14p5/gOMcAjXIU+fPbpR2ml4/qNnXdIPSiyfra98c/sZfNQ==;31:mUCnxP0L1tMb6RjSc1lR/v++euh9ExqUHEQWysVNMI2DNczc/DwZWixDJ3Tfynjgl6co3uWVZowvjwWcoykiu6xEAVgClLUpDmW35jnLxet1acc8igLIB0ec9b+LPnj5YnokcjrAWfcLCVU6Csdr9pvjGnADpt7wLVvY3c2OIbEGWU8J6VGHeqByyEtRmythuWz17dp3+xtkarJ//cBs2lv+piS5JSklE7ZjmSp4y8I=
X-MS-TrafficTypeDiagnostic: VI1PR04MB3278:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3278;20:nDZiQwH17zO1rZDcFssa0QWyjLJ1wFC/XnxJRmeh6IjeCBwCE+D015qfnAWs9eF1puRnU89kN9GBDykIRvvhSarVg57FoL0ddA4UHauEtnqSxAk7c0lmtBRWP+Hl8MwiJxoEppcj6PlS0jsPmZmGv1hgMsd/kjI8vI/3c9y6kDTPVf4KaE+EwfTjvwQCgzkcKDovKKuIrvCzL4DCNPMHBIpSjpcddgRUWIgXXLLUCFp3wVctemEHV3QB7xigOLtt9l1Z95GI4HtIoiKwqCUIPjhgLetXoS3hWwSyTQ/nsDnbdejWjPZHDEpKeEvUfISv2l/Lxc2wqRDtuCswWcjBxAo9qDBDXe4xjHWfYtQ+jZsN3vcGVSd2MwQpZZqW7ZF1x7F+QWhgJBjmErGSkg7N6ozUz0/acHuvMVBmgY68difFY1sakM3ptzGVGLyVbrQ0t63qa+SAuu9RoIyi6BsMSvMSiNmVDkM3tsjNNckJauBYwpn0Fx1AvlZcOHzDJ6qX;4:WF4QuAIvNRQqqL/WdjkgoDzDxveA7Pww2HrBNdcXFlCGirOuIoTrTXdm+/ZZQwxlEEwV2b3CjrmyUJSTYJTasEWT48L11+gO6D3odgjfj5cwKyxF+v92iVr+6fB6JmgvAMBFMl+VwYZY++2vLv5ONPU1JETVB3x0mWq6CUBYFKnAXGzgXv/Kc/j5APFNo6jAWCp96v4kNmiBN+U4q7HnGIQWu+fAjADhJtY5QiZuB9K/1nJoTbZX4RnxU200Bp2+029WYvex8plFKXfWUmTFk3qetYjw/BPbiDGUaTlr1Du0/6FvHEDMkRRsyDv7UVOrwRdTuWksnX1Vq4xJcdzomqIlafLyPAgOatHnUUZgqtg=
X-Microsoft-Antispam-PRVS: <VI1PR04MB32780C060CC71712E8D2D24CECC80@VI1PR04MB3278.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(275809806118684);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001056)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231101)(944501161)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR04MB3278;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3278;
X-Forefront-PRVS: 0588B2BD96
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(39380400002)(39860400002)(199004)(189003)(68736007)(105586002)(26005)(43066004)(6486002)(16526019)(3846002)(81156014)(81166006)(6116002)(66066001)(8676002)(1076002)(186003)(2906002)(47776003)(86362001)(50226002)(2361001)(3450700001)(2351001)(478600001)(6506007)(386003)(4326008)(7736002)(36756003)(76176011)(52116002)(51416003)(48376002)(50466002)(305945005)(25786009)(6512007)(6916009)(5660300001)(2950100002)(8936002)(6666003)(316002)(106356001)(16586007)(97736004)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3278;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB3278;23:sQgpyrjQfRdF+UG1VkwY9wK6BK7ztnDCkmswlIVQQ?=
 =?us-ascii?Q?2yGgJX0e7jliVoKzrqF+8y6Cwx5YsjofMHPZuCeSsDbXWvq9tHXmApHjTlVz?=
 =?us-ascii?Q?Ukpu62PFxpFV3p0tnH8LPytXxs+ym58eHSMT4GeJ055BL0IRW4awcBl4i8ue?=
 =?us-ascii?Q?V6SFbZie9V8/fcv1Lezd97ZfKqHJKwsw4LjLL2laY+qhiSBA+n7VWJAHl5Lf?=
 =?us-ascii?Q?tJfoaPaz8cIL/4IQx55UU6IpcfwprP9zcqXTyUP2UnS3Kjbk6/IBKjxvmyie?=
 =?us-ascii?Q?oQ8NAph/VT3KQtvzZ9HwCtreKaQriMwYeW5jbspawWPYC1ip2iil77sbYzW+?=
 =?us-ascii?Q?jaJe7svvoHyNeia7MmTS+og4XVmtJLQfarx8tEUpyzbMDsfJwfMfm6GkYUvl?=
 =?us-ascii?Q?F95fGd4egGYaKxITjALSY+LlaNH3OeB23143C79X1gu7IHgjz9mNm26FCBXx?=
 =?us-ascii?Q?tqE3OXr1GAiI1DHfFBtQCZKflo59Paho06bBA6leyJIaiZuqDbPHqLQoqF99?=
 =?us-ascii?Q?Q8tUmmiHPZyaZfQZ63JOOorUbpn69urvyFubm3vqYwKJeZhE2OxVivEL9Az1?=
 =?us-ascii?Q?gAzCWeEdMHwdLmmwaRylskFq0k8W30FNsX6vj9tL6kDvAPbJuXIzNRdLv8/T?=
 =?us-ascii?Q?IEvCIR5FyUj6rID3VS3TqXzKtGdneKlQ8s5RrV8pEQPUF0lkAUxZFq1xkiJl?=
 =?us-ascii?Q?5z3zvvlvyRNHG8IY7R2zFDYGSTE2TTiNGIooKoJi+WjBE0ODu2q2TKVAqZYz?=
 =?us-ascii?Q?M45ndFf8Ad2ZSTz84DVnuxEzOzFc79x4F6CJBoZ374vq678aA12ZfalZkysj?=
 =?us-ascii?Q?6blus6a6jiagG/G2LeftIfg9h3YQRBabTh1NEDy1vUsElpJdIHtZPyQbaSh2?=
 =?us-ascii?Q?wLulvP7O+7j5uDsydtEhWZlcgPtZwuaH2QcBjsISGFyKd+cXRqR4ulBWbo+Q?=
 =?us-ascii?Q?CtYT86WE70avmMM5bn3M6FfUKI3znAXe8iUwKbxDkhSDcMBcvZd2ZiPNE6Kx?=
 =?us-ascii?Q?/5cabKWtCsvTi2uk9iWaZvgsGo4qvKY3FtAPwMHOC15ptUUzLOfPRPQQrTNL?=
 =?us-ascii?Q?czZgfLjMjepo1A2T6FU2rjXe4FibUEHa5Z97MEdCiEAaojeI8M3lRK4ZZFsv?=
 =?us-ascii?Q?4joZq6KInPpo3Qmko9aVXV12JBT9QiCEBkm6VIgFAUWnimYhFwe4XiGmrGgi?=
 =?us-ascii?Q?GQqavIIXcjw+q/ZWf0y/ojsJyR+uVI4aHNi?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3278;6:xk0bNZeNMV3wgqi2ADEW7RrHwWEwUnH/5gW29p1B9AJFcTjD5AEEzAo/rTckejjnMJ/PsOkboDmSCmW1Ut9t94nru/ajvz4T5JL88+cugVXBpxTbkDcYCYlLY8OCeDyIKxRpmhVCsSfOYyqc5n6Nk7GVYFTjrbbKM4881NkWQNV8P1zQWbozqGcc8D6SVwy6Htlz7iQZ3jDAYRmipmLil8EDxG7NzD0Z3J+5CfmO6ghjAAOlPNKU9X7yUe/6eF9l2E70n1YDbSotASAI1iJsJn3KoOn/S97WTo0Fv0fMHq4WDeIvim1xagSSfo3VCbN1qv/+S5AEtYLQV1HZvN2rLaCImr9iWC7TPRwUyAMUnjI=;5:l4BCFBIH0G/nQ7wDVmiZhB+8nyd9cYBtaaj1Yp15kM9eilcys/bPteq9GK49/AIsUpBVYpYquj98pIjDtdgtsScUSVIuuO+x/4RSmGJW1tzXiTGwwB8wN0ewzptKC55s4Es9OOAYumpD9FJvHG+cTDyXFMIgmf+dpl0SKjMogOM=;24:2D+pjgj+howpQMP1bqLGUWWuUR8lpuwkooOMzeK8RTbMZlmQkJ/Dyq6voltEMaoIs7YgLyJFhZqDNdxoLhkyjMvBufQ86QWVmVFdTfr1kw0=;7:e4aVypVHUaZj/bla9G1mWtwyaJi2hy8FJfXZ2WeiZj+WDmuJMl6B/l3qQJs87eslP0NFl6A8FKmrRbuf8LOgGN2CfUPCUjAF+nuel6vn2qyBD3t7yUmgq+hZ7VNeVnzVm1yfj644wjE8Y4SRte0WuaBTcomrbXCLlGReKV8fjClzdWmBybGKeXrYNhdrZN86vqTgou/YsL6iNGpBV6KAhJMzSDhE5bJWBrGCGahizjByQQPltAkiO0P9i5jDPKea
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2018 16:11:13.5899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 262e9670-79c5-48c6-8896-08d577b366b1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3278
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the code and avoid some Rx errors not being
accounted.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index a5afa60..5e43840 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2204,14 +2204,8 @@ static enum qman_cb_dqrr_result rx_error_dqrr(struct qman_portal *portal,
 	if (dpaa_eth_napi_schedule(percpu_priv, portal))
 		return qman_cb_dqrr_stop;
 
-	if (dpaa_eth_refill_bpools(priv))
-		/* Unable to refill the buffer pool due to insufficient
-		 * system memory. Just release the frame back into the pool,
-		 * otherwise we'll soon end up with an empty buffer pool.
-		 */
-		dpaa_fd_release(net_dev, &dq->fd);
-	else
-		dpaa_rx_error(net_dev, priv, percpu_priv, &dq->fd, fq->fqid);
+	dpaa_eth_refill_bpools(priv);
+	dpaa_rx_error(net_dev, priv, percpu_priv, &dq->fd, fq->fqid);
 
 	return qman_cb_dqrr_consume;
 }
-- 
2.1.0
