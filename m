Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751575AbeBZRYo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 12:24:44 -0500
Received: from mail-db5eur01on0063.outbound.protection.outlook.com ([104.47.2.63]:4820
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751018AbeBZRYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 12:24:38 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=madalin.bucur@nxp.com;
From: Madalin Bucur <madalin.bucur@nxp.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Madalin Bucur <madalin.bucur@nxp.com>
Subject: [net-next v2 2/4] dpaa_eth: make sure all Rx errors are counted
Date: Mon, 26 Feb 2018 11:24:02 -0600
Message-Id: <20180226172404.25584-3-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180226172404.25584-1-madalin.bucur@nxp.com>
References: <20180226172404.25584-1-madalin.bucur@nxp.com>
Reply-to: madalin.bucur@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.49]
X-ClientProxiedBy: CY4PR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:910:4d::30) To DB6PR04MB3271.eurprd04.prod.outlook.com
 (2603:10a6:6:11::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5d2db4d2-3653-4787-1856-08d57d3dcec4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DB6PR04MB3271;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3271;3:rSzjAOUxE/lpaOc6fNCBqfzxu0RKrVRww4e6awzx58At2z2zg3QoCdOvq5qLq7B09KT8/jzcu9KUhkFvLqmqF8bMgMCfxofwP4IfMRn5LFcH/N5mneB2UV0k9s3jeCv0IdYawKofToYjNxKX9IRQncuCTl1g8W/1zQPjRwyvPEUXndA085BDRiJWu+/dAl96uWcZV9njVq3TSab2Bnuu/VgLxVfNBV7o3kAKwvJ9M7Bb2/m01yI5MtVvo3U6LSWB;25:ebbrlCLvEIMVlXNYfusVMDkRWpLxcVbSjVQd4N9xS4jxcwTRp5Uzp2cYIrNMVSVgCNxmWMUsdJ4abjBTukf1EeY+cWUUc4QVQdIl7UDkBpzTpPCdurdDnMJsltk1sbbEZmCn3WXDxLBoG9SzoRKRjdstaWv54NLnh5JKeYWdSfACQtYF5YLGJ0O0w4scf81dyuoL3oeU83S9rT2kc2ArxNpdnlfKvXvZydzEXNYZt+1yLxAMuV1dfNDx8jqNQsd8HS3j6MiicWjd0TeDYYVO7o6fKs6c5bOq0iRF9XOC0ZDEsd2l+6zu/0C3sZ/liV7M2H/NK+cGGhnh6paN3aIj7g==;31:aeCsIMBA3UZoYcREF3H/a79OC3+TCDMf4gDbUJOydLMEcKpbUJRdUDtp43mKsuAWf9Nd+Tby/zSWnODjLHY2Dgc6t+teSWqBrIUYlUJqjd+N98mzCvbt6UBcVdazKxfnsyUu5k4iJMy5qZ64hPDcwhjdR1iouyMoH/leEaQWnC1kaCkIGB2n1wiIxlK8jZDcohxJajpphOTsg9YxIuzDH2qEgeif/GXUJpl8rxw/beM=
X-MS-TrafficTypeDiagnostic: DB6PR04MB3271:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3271;20:gUJ+Xe1CnBrBvt3cVNZxSgA7kSrrDsntSe3TpagdhhcSztgdoz1AcXp5AIsG5cAAA4wS5DOSZojGNHExvhpgFxRgab/vCX0PAwd8ln6tzmzVc42qlO7wwnprjwtBAwGTCOeCcMepEWuUwPIV0XNGAFWLwgE/MDH0fVlc1kR9Dz6ogQotzrCnjf0ZZKcN5ruoXSc6GryWYN0XJt/ZCJ0jayKloo7GNfzT8D2QFVOhbXFPgLZ1nQSA7lfKYKyXNzAyDjNpHK3C7q4f580NtxnPnKkSHCDPnuC5sbKtpmAHtJQZVF7m2ztgC0tZqiaZAbY/bTn8icBtS/+3ArLH+dq84CZXAqMHLfPbesm/WV/tCgV+LKxDt3L5CwcLlylaojXcC8OwdIuZiGR9Pj7YXX4eoArSRrSG2ish4l2HsvdoZTSI0QuHetXbzDZkL/n5Vb5zFxGX9uZGVp5sRrP++bSodNKANLtWcfLc0sbAEMFDMWQE4i2Arl+AQsGNZDjktxrN;4:Qodl3qnK5lXjTAxwXjiLddrScNQ6iu3wQTHEtz/kZAQ+UqnTXF+l99YXEjr4l2dw6/LAiKGsLZfsRES52UAWtpVJc83fKDqNH2/txeNeDxgtWlPlLUuNrbOwCYKUo1o4HditPiO+6iJNpGAqh9NcUT0KxC2xGr08VM+pcKEAcwphOqtf/7hGm++4ptQ9dPNSTbUCwdKklb6E5xqdu8s/m4PIPu1ozFtdQIja/iD8X7Aet0wh0vDc5zxAPXFe/Kn7ZEtq/0CWO5FNHPhoQ0eaELO8hTvUcUVdJZfiRUQMZwZFgpBFJyFcU0Bu0KwxYJBV3PT2oSunZlCb5pv1Hyi11gvmjxLM8zT6mLIlQ4tytUc=
X-Microsoft-Antispam-PRVS: <DB6PR04MB32712DA3E5822C52D461476AECC10@DB6PR04MB3271.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(275809806118684);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501161)(52105095)(3002001)(6055026)(6041288)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB6PR04MB3271;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3271;
X-Forefront-PRVS: 05954A7C45
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(39380400002)(366004)(199004)(189003)(478600001)(8676002)(81156014)(66066001)(76176011)(81166006)(68736007)(7736002)(305945005)(386003)(316002)(2351001)(50226002)(106356001)(16586007)(47776003)(25786009)(26005)(4326008)(51416003)(8936002)(52116002)(6506007)(16526019)(97736004)(43066004)(2361001)(53936002)(6486002)(6116002)(3846002)(6916009)(2950100002)(6666003)(186003)(5660300001)(50466002)(105586002)(2906002)(3450700001)(36756003)(86362001)(1076002)(48376002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3271;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR04MB3271;23:+6prXbMzIKmXo+eZK11TSFx2S0UTjmza81VjSPaxd?=
 =?us-ascii?Q?XQ8YCS+hxQZukUaUnM6zVFDbV2Tg9E+C5jIkO/f3RRu41xybXI4ydX6oOPF0?=
 =?us-ascii?Q?45b7XG4LoFzNl/WZJyMOAYrBfh2Mrb43miNukNxvs0OBF9pTnVvLiAbAR5HW?=
 =?us-ascii?Q?LbmTa7mJsNe2z+1ARdu4qjAAQvuWb8dgQ3adGmHaRemLA0YsxWn1Cou3niPf?=
 =?us-ascii?Q?AMQ16aOL/Xo6coawvip1e1y8HfFq+4OCa7k2IObKru0dRwTg2cfggFlgMJZf?=
 =?us-ascii?Q?jz7lXsHV5m2RE1xyQfETAZ9KlrxjSxvQPX/pfkzeihqPFKwx+4KXuVzju1wl?=
 =?us-ascii?Q?ZqTFtnNSKb1P6Z0D8/2cQyUdX7ZPims11OFnsD8BzhkdH2foBpsLxDSbX8Do?=
 =?us-ascii?Q?OcUEr55kCFJIBdWTWHrCe+FLGPwfpfbH3oF9aVFqg+VP7wwIFpTYuM8c35wZ?=
 =?us-ascii?Q?Oa7EuT0iiMTBHM6AmxitY7L4tJ/9EEpA0vUMFrZ6tPO6uk2o9UdJmwvSxGJ+?=
 =?us-ascii?Q?C2Sd6H4gtzFhnCRgm4sHV7u7+tmts7SzP8lWVJwiRtXZyxooRdWEMNBxp7kP?=
 =?us-ascii?Q?P7rCGr0WAwgGOI8BuL4Tdzf3p0ArACcfC2JiWlilhTwLCwj0YOBZiSQM4wJq?=
 =?us-ascii?Q?nq5lZPCQyf6zZRto4C40QdzaTlLrIoPFVsW+2of7pW/3boLhVsxH+qaBHW3i?=
 =?us-ascii?Q?8KnUHihNn6jXJU0o3JtcbohgehQVZxTWop0SjkQ2ieyqXPnOLMfI8ujbm3n8?=
 =?us-ascii?Q?UHqDANR6jgxW6dsH70rj53bcL6BYxpEJzdqSfRxxNmwj2SFqXPQEz0N8VSVH?=
 =?us-ascii?Q?5n3ai0naUf7nsVTqcD2lZxxxJ7jdFcXf2omU3RI7xbvF/fPF0vwUjHmLhiL9?=
 =?us-ascii?Q?qeuab/Ud2rX/647VIjNqAggy0TZtu1pHgrhOeyryinAxflr3AGhxTgJQXDNb?=
 =?us-ascii?Q?DGyjHtjTdPsN/nzYZipjKCLYtCf8cVXH6s7Dmkk53yj/l5wHYVk+sE8O3jkX?=
 =?us-ascii?Q?eE3LCvA6ijJCT8GnyViJcKyXjt5iljZASjdAWfgPIbTzJXMCJTdjMfE809Vo?=
 =?us-ascii?Q?yEiHYeosvP1V3raben0wlr4Zss+vyHmpkm9AqRZPdCPpuVHpEBJ2qYgX4Vdr?=
 =?us-ascii?Q?KgaqWKG16qThcpQSkeyq3DNVfpeeVRhkzjYfXpkhnvl+Ubc6k5ieA3HF3H9F?=
 =?us-ascii?Q?u81EWBk48tpSuvHlVw/bEEHqEsRQYYXyK89?=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3271;6:5h8Lpd6YUvrPTY6wxa/PhPxPOBbnZDgUPMD+U+tzr9tysr829o2FpNysYmWzRJJz/Ksm6Sjuqn3BPuAv7o0SVN+LE9SutQD8swbg1pthT7t0B0fQM5lsZo3OLK2VXV98Ctaaz5HaZvIOEush0GJr/lzyf7eTweokqNlXAxjONb00QOPef8hRRW2hd+e84gJcabkqNwPOMZA+JWYB7M4qHCzHZWNBs15S1JFk6S2npKd2NyecUBigGoLjKlpEYRWFqUz9kB4+uCig+bP+KAOH8TtNPIqL3sOcwZ6MRTpjxStMVbn3FfBqh5rtXyB4Izi0emdiD0IxRBlwQcP/F4bk4rxTx4xTJsTDha4yZb+lUlw=;5:UDE6kbFiuh4HPwk+tH4u/2+4r0BrgptpkchvAbTsnTwO68GYPSM3c0VYYzG7venTaX6jap2XtjQSYsHYAH+uCQOBk85j/QOtzzBbAmwvwDL8GJ4ZCwACcO/K6fd1wcA7OetfZLdtAw0F4P0ayZH1M2XHVh6uZWoBrFL5IBCij2w=;24:vwc1DLQOx8PLbUfcmMHc5oeuPzSZ+V23Ymj/sm6hE03A+qm+18J2cVKRxz8AAFLzqDXuF1STVmssxjXGw9ujuU6vWX1xLgshmstbsLjUNMU=;7:qQRODSLenx5zVtoBctwK2KAt1pWmLkA8h9FtVw0LudUoShONNf8QG9YxwKo4500/YylBLYGfAVKkBVixp6eIzvaCmwJc82+ROBMIxsBZW71c0DsN2w0lYbK9AEfkbGApZUJLl+rtZ5PLP2EtfRF/hy4uYBdwHcHPpAnhkP118iDq5wEbwFp0N5zVC3X12Vss5ecCkeIJXTVWl0gbXlNxBveNu7MVepn23g78FZg9awiqYgUWSUjEZlQMfjJocUU3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 17:24:34.8071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2db4d2-3653-4787-1856-08d57d3dcec4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3271
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
index ff110e6..bdf57fe 100644
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
