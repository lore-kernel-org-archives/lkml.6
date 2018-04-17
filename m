Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753171AbeDQOdG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:33:06 -0400
Received: from mail-eopbgr40090.outbound.protection.outlook.com ([40.107.4.90]:16258
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752620AbeDQOdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:33:01 -0400
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
Subject: [PATCH 4/4] i2c: mux: pca954x: switch to using .probe_new
Date: Tue, 17 Apr 2018 16:32:33 +0200
Message-Id: <20180417143233.25145-5-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;3:Syv1Dg9XaqXGIdJ15UCuTO6kB3iQ633CgQ1yl/Yn/mJF/+jfLpTpvp2DI1R1jMc6TVd/WoExtQhPlLj1Oev7ZJwaQsXkGdeY7Ibb2jQDAJUxPPRsPTIsZfLhxqG7fmrWBviZ+cQPAopDtVUrBY6i0JFdpRmUXWETLQ5rQueRl3ZGrerjTeYX6FNp4n9demGpvf07raZ4JGl4BNB44vgWOwEMVdFVDX3EoQb+zXCKAFP7W1d0vngOkp2ztDnU7mNV;25:cs1uagekBVAuYAp0YJ6K/Qn52/ZPycjBeoot7nrAYWxAyBhZ6qq9snjXLDnh5lK5edeo/MRJaZ5dOWvmaZTqOBDb+37yQKC/axO2KiAcll2PBlfJay94v66PuhZgu0006jjIOo/OgwEloDLhbCAaqWqZ3ZmDNj4j+AoF20G+WsvTFVR0kcG8u3rBtEu/d+QhAtCXwu9h4j74UmxfXslgZWmfkrMJZLDUMjgVMeXCJYVX/3YLlcUKd05/kOElmHwSpgfbrrAg+S+2LhZjxlpG7/TBR80iklhrKnfS7sBNO+cGIXGtYlDVjYP5wbtDIVVTQaz6XCr4iRGQh/xW5yp9bQ==;31:EtgHuSevzHJaJSl1Hj+5smhqr/sFSihHC0kXvIYur0xKK9D6QkpFArEFz2Zd1t4K2cqGzqzFEj1fNNEtyl+vDC2EtTysut1EQXSNI9w6grMLdLB6QBru3hF4txigyBF+KkY1DVqEL5cz/Lhj5ohDVflTAwRVB/IEae/RtDQ6/A3YKvRPiLLY0zRCiAw1Rn8YKIaT4kaO512AiWOQm0Dng4Zc8dtbb86wf6yPhLIC+hs=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2777:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB27777ECCE7BCFB97B7B03DF0BCB70@HE1PR0202MB2777.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231232)(944501327)(52105095)(6041310)(20161123564045)(20161123560045)(2016111802025)(20161123562045)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2777;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2777;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;4:iMhQYsdKIMlZ9TD0DUT6XjkNPM8OLIy6rc4TVpV8t+zwP5OA8w+sAsvqlEjfmFG9s7TEqEXjLpoShTyZVgSN3XmzDtLgah1UpAIgxn7cD5hYWJXEuwjs5mQqJX62NJtbSiYQOWn081qAZuJ3il6AT6+MjU2SDSkTqjI67K5TH2LSE2srBTdxGcccyUQAeaHKsWgGSaTRr6LbdA92NZMbJSV0G/QlSMBU2muFXaMwucWBeannOanJy8vcUDF2V5law0RoalcgQI8vh7fH7MPFhA==
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(39840400004)(366004)(346002)(189003)(199004)(6486002)(4326008)(1076002)(316002)(186003)(16526019)(53936002)(81156014)(6666003)(47776003)(52116002)(16586007)(105586002)(50226002)(8936002)(106356001)(8676002)(81166006)(48376002)(386003)(97736004)(6506007)(478600001)(74482002)(76176011)(305945005)(50466002)(7736002)(486006)(51416003)(6916009)(6116002)(2906002)(446003)(2361001)(476003)(3846002)(2351001)(25786009)(5660300001)(66066001)(26005)(8666007)(11346002)(2616005)(36756003)(54906003)(956004)(68736007)(86362001)(6512007)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2777;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0202MB2777;23:G+oaKZmBiO76x2CbTHwdK/lDJ5yWC1X4gKXDBLY?=
 =?us-ascii?Q?0VhD5iQV6DR8zw2Yo75fjHU1OBNr8zF5iJw+bltvslDygA6OSASXv0btslOD?=
 =?us-ascii?Q?YciGSW7fXCchbyxjmXh+g1+1iY9hHWVR/Xl8KOP5EsPW13Apg9eIpX8+1sU8?=
 =?us-ascii?Q?BKAa2JPBseRQTMtUOoUJ2cS2TAVcCQ0KhMEKmnyQtfUDOyd4Nfbuj+270Em9?=
 =?us-ascii?Q?7q7xJK59ZcFc1wRB8OgpZsZ0qkhKy2lWEWQUZC9MedVQ0eUmEM7v7crSIPTJ?=
 =?us-ascii?Q?5nsnc3pO/RiIpMJM+yFGlipzTuo3Y6U9Sw4DJFRJOsD0JcDCe3gtTAvOqWET?=
 =?us-ascii?Q?FTWUeo3ClXZz99ks9BIeEvX3RF8HsEEr4SwPqZO5MFUEJSBti6H5u2kX1XEc?=
 =?us-ascii?Q?fcVLbPNTKIBNoHetKgIcXbYVDJ/45XWjYxuVeKjrYEl9Gn3WvhKjchCvKZK9?=
 =?us-ascii?Q?y8PSpeRpp+V3qx6ObVZgVGv9xBPeNBFVu5Z2fOPg8mLjn/4yN28XJwiO8wK4?=
 =?us-ascii?Q?KPew2/HNl5auV0Wx82r9s3GaYJbP4z8/24nbtVJ7JL8xqRG6wfvX4JgSZJmW?=
 =?us-ascii?Q?5pJx/GasK7z4wauo6gKtuOoScNTDHQ2A6hTB9KHBJhWzoSRsxsFxKfEJSYnF?=
 =?us-ascii?Q?6cLChQaJwm95YdoAcolUOs6zO4A5gUC2L6x/3vnhyy5IwbG7XA3/NcA5LRhq?=
 =?us-ascii?Q?oYBgr1ROX1jfg8LSyD1DR0M/QRcgHTiHnOUC2vnAzH5z/JzPsIcE/v5dd5M7?=
 =?us-ascii?Q?CARUkp701ESNZ+JJqVp1+AR6wIm3rIAZUdFiZYVH4t+hgrJkm2atmWcDu7xz?=
 =?us-ascii?Q?MuJW8rkXnCXKinuzI+LdlDzV4sl135MznkulfBVU6kkN83Auh+GC5vBWVmKs?=
 =?us-ascii?Q?WYdEOo4NhvzdkmvSDx5wcHNVMJovn/hMKVg+kCw820FS5J+gN9ucnmlZ+PBQ?=
 =?us-ascii?Q?rbW3W+Yi0e7EqdXS/AqttdRlxFfkfhJiZfCQkpEJyf8XoCGB/UZ+9nFUiHEE?=
 =?us-ascii?Q?aaI98wSGEBwMQ3i4m3Iata2PQAlCyAAsnbI8ZDK6wH9HJjIX4TlDgfeFNKBc?=
 =?us-ascii?Q?lgHInfk7Pt8CYCL2dVBnlBqPpyv7iMPQwkjgpOTejHl+yDFGiSk+uErym60A?=
 =?us-ascii?Q?F7WEY69ncGoCrsIg72T66smYm1ZAFXcTBF0W5YG9U9cQKV9KEJGodmcb9bN1?=
 =?us-ascii?Q?KcTZ0dleUEKCM4W2TxTrcQJUZK8resVSU+G4Y962A5jONJ53heduELMPOwR5?=
 =?us-ascii?Q?ieLHBe0PyxoSRf514I4a1b8MOlKVx7au/rnvg9MF/Kjor3OHuzK8b2WJbSQo?=
 =?us-ascii?Q?5wl6/+dUE3o7a/oGknURjovv3Z2yYgjR4R0hXOehONA2/?=
X-Microsoft-Antispam-Message-Info: WLGvOIWIf0Z7KsGOB27pcH+EQHDO/3jiasREH0nG57BnjYezdJ8cDiXHfOqZIBsqj83q8Vk2rqiwj8YE8+f6UOWwuDLCulJ+kQYWKe3sKxrNIwFdTbT9Ey3xw2sauECHClZQpc9YAnCBE1GxMDx2HUy1HQmmcGz+fsOVGZi/1r289WBWGg2ifyqDXK0RNXMY
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;6:Sp9govsgBlCGeCZso8MTG9q2kKJXxdnMxfgNMQa8AtbEWXHl/NgpeGR/Pa4oitxMM7bJYsGfQLHCB+Y7I52PPXbkQOj1TW0V3w3VxBy63OA3LVjsfcWGIdXHDjG4/m6jQG3lu5y+1iyquvM8FqC+qPzyD8rdN6UAyAdbofW2KnJJJaeCsY9N1JIvVxdDcyRzFIRee02GB+v1FJI5nP5Qu4EkCjayxXSTCn0Pziuaqxi+C9naU8IUen7DXywbBF9LiECSiUNN/YSpd5fNBalPOMqMEo4ATdsMTj/+yLC4B3bj2syggY2Eo/ZKt1Xd60ivPiONYo29mqKxqE/0gEcdmphAuDn+ZTJngsA6OsFjj6tJeb1r11HKr/bX0dUZ2qZZ3wD5cmH6mmU89KnlGglvG2ulwCSvm23BOw2pcQK/4GI3AMGCs6l6rwyEj1+aU5xqm+gG8+5yQnVgAT2eGPCMlg==;5:lUiN0el5EZ2LDx/i/kN5/qt3AeaCjL8fk6WsEx4hr4VT7DBWaCqimt0vyzbn1zDU8i52Onaj1gKY+1aVYs8kn57AIAbzkQiy6+LwhD/cG0MEa26dLWTb8lapQkkzN1cgvtiIE4Fa06MRnjWv6oFHXBqyXIdEobU+JBbLUteVNo8=;24:BBLZwQgAYDjlOi3iX2Pp5+8DQK7B45cuwGJxmV6duUnu7R5aBGk8u4ShW9Fi5AUYMHBrxDPjFm0N2JxgJDretP7FH4VMfl5d7AZixmSgoxo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;7:ArBCvQ8DOc7fe9dtiBfWAI/OwsyCeyDmDLt0qidqNgaxxRJkCpfTpvlM6m5UbWzSO+QV8J5R2hUHAfZvBCRjp0zIhDPUlAd4VvJsYRT4LFS40faBYOIne64MJ57WOvh1A/EooWevx+LKTP67IGkIAJsVGwur8C/zsJiqHZwDbqvn2MB1/JdFgwC6t+zjl2Y71uEtYhtf5p7syxa8Jj4RsxRTGSetEXuTSa7Eo57A72laHtV/TNuWFjYeg/i7yaNs
X-MS-Office365-Filtering-Correlation-Id: 49d3858e-a22d-488c-8614-08d5a4701daa
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 14:32:57.4581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d3858e-a22d-488c-8614-08d5a4701daa
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2777
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new probe style for i2c drivers.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index fbb84c7ef282..f3f925ea6472 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -337,8 +337,7 @@ static void pca954x_cleanup(struct i2c_mux_core *muxc)
 /*
  * I2C init/probing/exit functions
  */
-static int pca954x_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+static int pca954x_probe(struct i2c_client *client)
 {
 	struct i2c_adapter *adap = to_i2c_adapter(client->dev.parent);
 	struct pca954x_platform_data *pdata = dev_get_platdata(&client->dev);
@@ -382,7 +381,7 @@ static int pca954x_probe(struct i2c_client *client,
 	if (match)
 		data->chip = of_device_get_match_data(&client->dev);
 	else
-		data->chip = &chips[id->driver_data];
+		data->chip = &chips[i2c_match_id(pca954x_id, client)->driver_data];
 
 	data->last_chan = 0;		   /* force the first selection */
 
@@ -466,7 +465,7 @@ static struct i2c_driver pca954x_driver = {
 		.pm	= &pca954x_pm,
 		.of_match_table = of_match_ptr(pca954x_of_match),
 	},
-	.probe		= pca954x_probe,
+	.probe_new	= pca954x_probe,
 	.remove		= pca954x_remove,
 	.id_table	= pca954x_id,
 };
-- 
2.11.0
