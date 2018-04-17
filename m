Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753162AbeDQOc7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:32:59 -0400
Received: from mail-eopbgr40128.outbound.protection.outlook.com ([40.107.4.128]:54756
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752620AbeDQOcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:32:54 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Michael Shych <michaelsh@mellanox.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org
Subject: [PATCH 2/4] i2c: mux: mlxcpld: switch to using .probe_new
Date: Tue, 17 Apr 2018 16:32:31 +0200
Message-Id: <20180417143233.25145-3-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180417143233.25145-1-peda@axentia.se>
References: <20180417143233.25145-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB6PR0301CA0039.eurprd03.prod.outlook.com
 (2603:10a6:4:3e::49) To HE1PR0202MB2777.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2777;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;3:ekvH9vM5csuqORmKPC5qSvV4jnPN2UBO4Y8QodQXg0uDIFGulDry2IEa1TBghe2fbc9InHFMwa03djOSYCAd6PAYFJZFoRDEmsjn0khoExs07D/ZXC2lfnnP4AYyt+FSmu6/bqqIIwEIJEkz2R0aX+ocq9UFWwqKKOavK0HtFIqyDnCOUQ27J3OLD3XX+rbNvSgaDdiLbGcblYRZZ7lIzqcyykB/+WGIF0uJmoX8Twiw2IDFNA8WMm7ztIxl4CFB;25:CH/lUWR5rDnFzmUf2PumUE1s18iiaEEBVtkLSuDsPSaiUem57r9QwmuApus2fzt6ZWY6M1pVsMnUoxAoEMM4OYdGhCE70E5kO2Tu3eCZbZ7tcwPhwZeDkkUHMoYLPDsctMukoQMM5G2R+PwAmFxH4Ul0H1WYuJMSnqlQEV20nYp5YTutW3+YqaqQ6aouPBdc7vcnLr1pU+O7PIA9WvpglJbYOg4iBF9XBhg+ctC3gG9jOWGywNftfGLyVJ0zf8uCQR9bHzSBTfKk5kDKaqGIRDZlVyGK467OR6BpeeJTolrk1gekLi3lsvtVWkpjKgXnFYj7t3ncX9BPqYSH7N5W6A==;31:1STeKU0sgEicEyyBZgIjirEvCnokHbq2Iwrz3JfuH/08ZjpRVIzIZry4nRJ/gpffaxFFUOr6dXAkzCFhSTeX6/C1OHQFBXc1LCMBihI0dcxRD6wZ6uX3OD/7weManCvry/qxYMTxBODaUNRPn/CyIyh8Te9I+FAhzcsYKlywU9aW0oDpTzfQ7kyxRY33itqOGACqWt/82qipSGpcvGu1LGl7lBdAfuEFmcwz90I76N0=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2777:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB277708BB1607653F9AD73422BCB70@HE1PR0202MB2777.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231232)(944501327)(52105095)(6041310)(20161123564045)(20161123560045)(2016111802025)(20161123562045)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2777;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2777;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;4:Sa/qsIMuGkUAcfleQmtmRA4SqoIXMhffjou0wa7+XtCSyWVJ5XC+7XqeXUazYqP5WVXJXwY/PoRICLKu+00hZbv6tg3PJHU1FSfrRPmLiyqWwUIObxgMlYC6pSrU/75HSpNhJ8vVvKrKg7pacLsVO5j3Eg3shf0c4ZMtiPNMbWHAfe89RznXxEI7aV9V40lOwiWAusJsft7wjK6IT1uKt+johXZztf7VevK2EXM/bZgEjJASbJK+5V1Wsosinyorxwzz0tK62O9JVQ9q7tCQDg==
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(376002)(396003)(39380400002)(39840400004)(366004)(346002)(189003)(199004)(6486002)(4326008)(1076002)(316002)(186003)(16526019)(53936002)(81156014)(6666003)(47776003)(52116002)(16586007)(105586002)(50226002)(8936002)(106356001)(8676002)(81166006)(48376002)(386003)(97736004)(6506007)(478600001)(74482002)(76176011)(305945005)(50466002)(7736002)(486006)(51416003)(6916009)(6116002)(2906002)(446003)(2361001)(476003)(3846002)(2351001)(25786009)(5660300001)(66066001)(26005)(8666007)(11346002)(2616005)(36756003)(54906003)(956004)(68736007)(86362001)(6512007)(133343001)(142923001)(42262002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2777;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0202MB2777;23:vokJynaWQJuvIT7o+T2MYWNz0wpcuCSawYksXtI?=
 =?us-ascii?Q?n24aF+8OBKMketYDc200pY+CkAQkSr/l8CfsjBeW2mLTQWJD7sCujDO1NYJg?=
 =?us-ascii?Q?Fs4R6Oxbu5CbgwD4KN06Be85q1e9WbzlV7eB4R9Ntkpbkt0bwkX8jqyRjDWL?=
 =?us-ascii?Q?lhtRqONVGLhGo+0QkKSCi2jyatnRh8v1KsjRuJollfhsq5VwBmlgMGakRDwA?=
 =?us-ascii?Q?9/zxpcMXhoRkJ3rd/d2mJdi4xexqM6MadUY9iq7HHzgHi9iy28nHfxbgVPbC?=
 =?us-ascii?Q?5VRLMl8pMLTrfFs7TEsIOrWKslwQvIhgrNG7i4NBYrtyzjngM5rpL7vJD/oD?=
 =?us-ascii?Q?rEfM9u883OK5+X1zKArLsX2T6ptURO3CE4LN4nSx3o+T/IzJZ/Nx9SCc/Jyb?=
 =?us-ascii?Q?3h4GpSnEzgyzvo3SlWCndUDBdwYEPA2r5DzydAAIJI8yEr+2lnG/OdEYs+9o?=
 =?us-ascii?Q?YvLgRFvOqeUPaVBy3JmoBikQ1+A6GHbjk18ecabEYGL1nhpBlqqGgj5rcDCZ?=
 =?us-ascii?Q?tBNaiBLMMT2SuYmZXgQLeAQ/qaScYrlQo6A6hvyNEE2q1fRx3oZTXKvrRbQp?=
 =?us-ascii?Q?++z5xV9X8RK/msH4pSOmtquHsK8V713MKPu9Y5n2bh+jZcZIUdNli07PFsci?=
 =?us-ascii?Q?HzlVjyu99/PLqfnoXxRYQh5WZ7AaxuXsFU4klkuo3wIrSfnzXoFbt9y75HVC?=
 =?us-ascii?Q?Y+Qoxdt3pam/VQw6C8dNMkOr2/lJkwl/BsF9AUzlX3HR1TbIqRCMt0/Bldbg?=
 =?us-ascii?Q?TMkMMHlhO6bMLgMmeoRb3aTTRzRMVQU9/7oS4xnnO1Vt7n2kWhPNv2PefZfb?=
 =?us-ascii?Q?ErOpd8Z3875AakAZ8U7rpkI0iaBNyJ41DGcs+/J59N3r+fWa6/2YUh51bHQl?=
 =?us-ascii?Q?Iivvs8d6vAfLRHPFLBAttl4x7Rh0QPWTslZ7Xxh0sjBDef3Ygr+YW++1+cAL?=
 =?us-ascii?Q?Z9Btze/ecJkyOWVZO8hJJT58Ju/8Sx08n0hqRyMc0szAlwrLNYWSzyknTH6c?=
 =?us-ascii?Q?3RPH1pIFvb0i27Xauvlp6FxEHlpzaGGOXRxhZ6NCVncW1Rrt8XaiBmhEvVQE?=
 =?us-ascii?Q?iNGSChq9m3hOWbFOKdQE9gtND+pDbsqbyU/QW5daFy5hfuS1TPoH/s2HSMGf?=
 =?us-ascii?Q?KnIuzc1nQel+e9k8KPcesGzPzbazikshsBTnx6vcojL7WQy/Bs4O2aD0w4XL?=
 =?us-ascii?Q?JyaRhqMq4bhzYFI6WrJ0fiAgXc+/YTgNEEoineVwxUHJkS2TrCn8viSPEfnH?=
 =?us-ascii?Q?qfsqQm1D+CfgAbTY8TYGSA0Ev48R0HD6rWqzqVpG6ksR1XmGUsQUPXeiLPSD?=
 =?us-ascii?Q?gwxC8IS+uxJmrm+89ZbVL/Fdqbo6oENFdgCamaNMBbdKJXd0CqLftXoWBS9i?=
 =?us-ascii?Q?RQYBlrTOCOIaTLMv8CWjkWpw6Pe/RnUTun8nJ4eMI7cmfACDgLFMz8TCmODm?=
 =?us-ascii?Q?fzyYdjf2BedXzynvJeaDi3pIRa1IzY8uWmj9Oalgm4yYBwV+TxXma?=
X-Microsoft-Antispam-Message-Info: IpBneugEvFVTTqRhD12+B+3NCh09Y04NJmwnQTTVomKiR367+31aVODymsgD5lObdMbkFl547dxFDK0lASv5ghxqfggbs7QdYv44nsovhHc0IGEoHREeDnVgXLm51YpQQbDCC6DMAbreI0hQedeo4xwtB8FWJOFBaEqg6+6tibUgOXtKSF0svHAfQnl+y840
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;6:PVwUdme+RUAf7hiNnKcB9+pmAkz90IxHj0w94j2j0rerm1JgUCS/H0x8hOTATlG+DxCw/xAYjIBN59oyeYtgoei5NaSxhMxFPyil1L3qYDCAv0c/KNtdRwcd46GHHcmWw2Bi030VSXx0cDig/iBnjjS099rc9G+Q/o7yvJns3RRchhWlXQspUuoVYBKZMDH33jcOezGgRq/PCVza+250K8qTLuDA/3yfi77V2q9vUF1sAYESTxIPtx1RCpfOHFDh327EGnV5767owO7YjLx9q5Vqf16TEEiTjdE5wjRX93qkxsLyzI54CwM71TjfIoOBaj9kQYQV15dVTOVYZnCGxDU+Feb4OZVikyY+jLRiVCFSLmUpEPKd/jLJBN4H2nawde6ACybDXW/hXVfytvnEW7CkBhyrLuqM6ksz8aVVr6cCbHfnPcJIxS4fGDykLLqjsWUVJ76k2DwZRHQGTXHIaQ==;5:qtXXP6TFA0ev3mGtffqRLSMCxOe6jiEq/VJYM4nuDO1Dcchv09BiqdyKCJaTA0t+EiplgPbg4DZEAULZgYU/5Hsmnibxa546HucWPQVHoTNj3LGD6h6R4pBufcsSy4DiFdqlka/0+SoGDiHTaDIHIqQM2kexgb3+aZRNPeQaQ7Y=;24:iahezpQklEe1felC9u+TGWHvlSTn1iDp1De4pKsqxI++cQi8yBChnKqPihq31rrSDRitUbUy11uLIDkvjLjus/CB4Y+lnGlGq8F5/1UcLXs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;7:s3+dAQlMjDMp1QCc8kOgNLky8/WAo+0Y/8DtLVI7b7dBKUuwCMNljK+1XKlT47PkBM42Xt/+V8WgDjzPmR+xdME/i/VbLns59RRRHcXaQMYTrWnV1QtTrmYHR6AfHFPM/EsdFRHqi/T1h6otaadzJ+JTACbACaYJDaNU2YMv381/tEM73L/7cAVBNyt2z9KHW5W1nhHAqJHzwcPxiC3B0XtOESIJatcWR/9qAOEfwfy+F8aaCKULwqqklGkov/J1
X-MS-Office365-Filtering-Correlation-Id: 5ac55b49-39a5-4946-a3f6-08d5a4701998
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 14:32:50.6144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac55b49-39a5-4946-a3f6-08d5a4701998
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2777
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new probe style for i2c drivers.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-mlxcpld.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-mlxcpld.c b/drivers/i2c/muxes/i2c-mux-mlxcpld.c
index 12ad8d65faf6..2fe86cc81da9 100644
--- a/drivers/i2c/muxes/i2c-mux-mlxcpld.c
+++ b/drivers/i2c/muxes/i2c-mux-mlxcpld.c
@@ -149,8 +149,7 @@ static int mlxcpld_mux_deselect(struct i2c_mux_core *muxc, u32 chan)
 }
 
 /* Probe/reomove functions */
-static int mlxcpld_mux_probe(struct i2c_client *client,
-			     const struct i2c_device_id *id)
+static int mlxcpld_mux_probe(struct i2c_client *client)
 {
 	struct i2c_adapter *adap = to_i2c_adapter(client->dev.parent);
 	struct mlxcpld_mux_plat_data *pdata = dev_get_platdata(&client->dev);
@@ -208,7 +207,7 @@ static struct i2c_driver mlxcpld_mux_driver = {
 	.driver		= {
 		.name	= "mlxcpld-mux",
 	},
-	.probe		= mlxcpld_mux_probe,
+	.probe_new	= mlxcpld_mux_probe,
 	.remove		= mlxcpld_mux_remove,
 	.id_table	= mlxcpld_mux_id,
 };
-- 
2.11.0
