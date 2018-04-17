Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753183AbeDQOdZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:33:25 -0400
Received: from mail-eopbgr40134.outbound.protection.outlook.com ([40.107.4.134]:10113
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752732AbeDQOc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:32:58 -0400
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
Subject: [PATCH 3/4] i2c: mux: pca9541: switch to using .probe_new
Date: Tue, 17 Apr 2018 16:32:32 +0200
Message-Id: <20180417143233.25145-4-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;3:ZkOcWhLXVGTEvSUcHQbZhHTigeqGdtoBXDKmmySKGWALx63x+c7ZLmznqo66a/gpnEVB+VwcXbnM1y36mGoX+r2CQN4Dfz+G62i2m8bokrmNWsI1+0SvxnGVUUZtp8XDYNjAKXzf7bs3cJ5OShY74zf6ZVSf03Box3oai3KlfZkOQqDxS00g2uXyvYkAiocJ+EddE+8u2ZwEew8FiohVr1I7nZh9yEmzH8dvybujEbF8TylJaa1ekWMy3WufPvpg;25:HZvlagPnUbSu6BZZSg0I9eM6Le4Hff0YKsX9vzIxthAU1iHWFf+QLVfJ+VyEENnOYdkuljkZq0SBlKhNdwnyL8xsRAnoCyRdBJm69f+QOMlfmewS/pvKK2LCQQXnXe7sp0nNtkL6GBwtCHdV6MBsMZNU6VxU1qN7u2hV+uY64mbiKoTfNpsIpliC0QFPAxzgGChMrvrnfO5e2d5ETznXPWr7xMkCSUNmfJmBesMcHhRkGSwiNlGHiLboA/Nj03xAlqfv5lqzKUZEzzka2QvlJV9O+veCuAAp+6aTiC3Mdgi9juNVBP/o7k2uLQMLkTGb5MyHBCakg784qH9jO9nQnA==;31:QwUinYZ41lKqpnNXHdt8790NUjuRXyoeZkYgo7HFYv2jMNs7hzm9uIcEchWkiYS//OWbqucoon2sEZwtUrJXgs/8x+KM5C+fcFsKbTba8SWDU/My+evAZBWiDouGnehZGFxjDUnnQeBn8QiQ7Ed9lglhwcY5KoPwWepHv3+GkflR5PPjCWqNK6BRtYMCpIzFU2DNaJlP8a/Kcp0l6qxO1bLj0DgEF1Dv1pdBkh+Anz0=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2777:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2777A0694B089D0D23AC0321BCB70@HE1PR0202MB2777.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231232)(944501327)(52105095)(6041310)(20161123564045)(20161123560045)(2016111802025)(20161123562045)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2777;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2777;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;4:Ak650WAvd3adDl04kn9aeVdA5O53OvbBm4cEj4fS/CriZr6R2h2wLF2E7pgNMVn42l8zi5OUiWb1ewaLw7KijJxP4FfSpoTuDU1xx+lZUOMGgrYrDmwNR1QWRW5FnY0eUVlmVM1967ODtotPXg7FPmhg+UMlbtEFGYomCaWB/KaQmBLWnhg08dZAeRGUt6NhcvRmeowTHD0HB5/9v+xg2qVBcS6I0GhS5JvJSm9bdHUuakf/Nh9K4kon6J948OoDMqrONjEKtyO3eYPB0r0f/g==
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(39840400004)(366004)(346002)(189003)(199004)(6486002)(4326008)(1076002)(316002)(186003)(16526019)(53936002)(81156014)(6666003)(47776003)(52116002)(16586007)(105586002)(50226002)(8936002)(106356001)(8676002)(81166006)(48376002)(386003)(97736004)(6506007)(478600001)(74482002)(76176011)(305945005)(50466002)(7736002)(486006)(51416003)(6916009)(6116002)(2906002)(446003)(2361001)(476003)(3846002)(2351001)(25786009)(5660300001)(66066001)(26005)(8666007)(11346002)(2616005)(36756003)(54906003)(956004)(68736007)(86362001)(6512007)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2777;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0202MB2777;23:9OA0z2LREB+nww8x6q3ZjukZQAnQ6PN1QQa8nZ8?=
 =?us-ascii?Q?dKqdb4XXZww3MhQ5QbLCPLYsDLHrzEZmvsUFdEOdDJHiFCeUoPeq3QQftBL+?=
 =?us-ascii?Q?xDIIjJqKm2Zw7toJVkgUEepYtqt+FyGfV+K5cxT85Kf8SIMkL0ByhQQNb8lW?=
 =?us-ascii?Q?NxhE8bT/o7wXJr19DAQalyfG/iOILQ7DiWJ7Z9RpuNsaC/QPaKXDPOIQVjgz?=
 =?us-ascii?Q?eDFc/E0mKVUjquJ4A+od4guajiW4af9F8sf6oRiUA5OxsGoqlgnXR1cZWnG+?=
 =?us-ascii?Q?fQCpa99r4jJkveWq311phXOo2zMhUQayd1sOemPkUUOrjWuUXFoFZdVXguRq?=
 =?us-ascii?Q?FbCmZKQgIjsie3/XL8vE8WeD9GV8JJd/cFYgjNQwfGf805L7IrQTRUJ3OV9p?=
 =?us-ascii?Q?35S0Dvy5ascKMvvRIQwznznrDSdW1jWmVy7pliFLbSyWJ7apEBn4d3914Pkp?=
 =?us-ascii?Q?PChSY10lqvWzM2k/Qm4vVvswK5BbuBHrCrgswZsHF+LWJB/ziKub6OoDDDIY?=
 =?us-ascii?Q?IaXF0c9NbzTh6iyHUZ101goyoLfYcwu5QNxYYidn1tboh/9HVHoidLTYKorv?=
 =?us-ascii?Q?wRdVbou5RDi3LcEG2Qc6fxTlH+VTBDdvt4RdO8EJdDgq25IlomRWERWcm8Lh?=
 =?us-ascii?Q?b1lt3ZqG+uL/A/j1AT0hSxgdPdBw9DPQ+UkWK/x6ZZtBzGL05GnWKIAnHyc7?=
 =?us-ascii?Q?PHAHFM2PBIXO053bkE5VOnUYI30bjLbQkwLVtonlchHH+OHXXHu+ZRZNZast?=
 =?us-ascii?Q?jNFKObYKyx2/42ZIGWwXupgskN0Tdv4KAlBkqtxDu7mXSgSQ4nVT3H9qNBGy?=
 =?us-ascii?Q?ehytUqLCRaXXX2z4gosC12MR0aEuOnntlnrzEdLBIV97C8JkBEh8YlYLr4DD?=
 =?us-ascii?Q?gvc9YA00md1ObpyQDxWqYPAvS+QChctHe+4ZAf0xog+upOc+d1z+TgSscQhG?=
 =?us-ascii?Q?BWqQtHTB1EUFGoy7sW8mYR2rpgzREwKes8AbzRPQS1WL4K0pGNMHjmtiFk90?=
 =?us-ascii?Q?LDLb5Qy0ZLpG+3Dlpb1V4IpUjXafb66K1H0ZRaqehYotZN86oCdMN3xQuVX3?=
 =?us-ascii?Q?01RK5cW7XgCSV/Egd1R4yUkfjydXbhqjv0AkxC70W1xg+vVdLdkbHzVzLm/X?=
 =?us-ascii?Q?QpLMo8KWjE5T/fXggMkIYI7XpNZKMMwxSjZBAKinvCwLlstUx8giJi7AYdYU?=
 =?us-ascii?Q?CV4E93ztR6HBzKQhzqAzBtVS2Bit91S/fE9teI0WhA6VrgG2yAEj7Wqo74T/?=
 =?us-ascii?Q?ZX0mFs3F0ohYajkjaucEtkYxKXobsHQpkARhzaY2/8Ts1gEKxSbVGG1oEJF1?=
 =?us-ascii?Q?BqIslr9QS9IqbAexPg5F/kUa8iQqb9YPupxuXeUSJJs8a?=
X-Microsoft-Antispam-Message-Info: PsnmXOzATKWEr3L5M2l9BiD6F1Y/Nbha9oGj3BDQZvSHgGI1+Nj8oKlHjFzK3ODqVSAAbFKPkKDevby+4eO65vvsrLvCQMHLMLBrBa+Zc4bnNkmo7EslvEtUUt/X9FUH7szL2ejcLs+T+tcOAMl6DnNtJEnBmkgmkXCBSl4xiTvMqkwcYTC3FQFcpj4VqFrE
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;6:LUjIxWlB7BWwrAkPHZA9mPcN5DaLJI5h832kqtIHeSJjm4HX8MABJxwC6fcS6RnmkG6zSlvEER5jIRfkiMrsvLJE0TWj45eFdZCxSZxMqMaE3pDavbEXAU43NhbwQQ8zuxr92NbWqoFlV4Fu1CmqxM32qi5lpoeAubxjC/xcjKxYhxDz5974hKGMeQXXkUyBLUM7beVQPMBg99fcKUrHH3/i+Fd2bymvVU+YIVQa0Vrl4zkTC8FJwZAwiGOTfxfwb29jbFahiE2ex2W1b+acNGIisvbUrkIzj4DEv9r6pAyQ+tB1zQl0BG5yslcvRK3VKJjFgINYg2qtLsNlbsKJT4tIIyGjUuCGrKDoVTfZckKzo90CL4mzCLZSW+WVl+ls1jC00E7L5Hx1trnSwGs2JAfnLyF/ylQgplfVFWmKh0n79WK0JX/yPwmdQKXf7w0dF45qS0YkVzVIlA3FqlneVQ==;5:WvpQedl4kr+Fyrb8wovNw5NesunkX8GUACZC4uvus7mTtO2WI9kwbheyeE1sDcNcwFL0pw3pl9046OL7fczd2wHslXVFc6pzgwZvsqkIaTW3ujZjGvRCyxmQcSwn+/cvsuGC1Z6k0zyO/DSaiL+1757/8q/7XfbetXkIq2YyZKw=;24:tNZqSjcQYlk6cN3akTuh/nd3peGxjjU8wfYkYorN0NM1Gvj5xXQPECTTf0aFYwdlSdhvODIJjGg00Q3ZBI3zY+9utgwntTGMbCQ1r/6pL0s=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2777;7:C1VajGNMp26m+RprCxYf/SIljT6UfbJZrxVBjFAEvoJ5u+BbEYiyRRZsEQV1EGlBMh9a0uyu2ngq9e4sT6MRt8M2jNwU1dZjOmnVwM4Mm3TZt1IvNCgyxJfCU9Uo6zwg4hKMb6oBPPp5Lni1LnJfNv9LpGUkKxB8VJroanAUgpgJbOoJBbhv4691C+ihqeHbl/UJ+Mb4FEvs3lxNK0MJPBUXiYOIoxElHbAv4dXClo6uAbzeLlvAGPZ7N2rO/bHF
X-MS-Office365-Filtering-Correlation-Id: dd942864-9954-49c1-8ae4-08d5a4701ba7
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 14:32:54.0831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd942864-9954-49c1-8ae4-08d5a4701ba7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2777
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new probe style for i2c drivers.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-pca9541.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
index 6a39adaf433f..f61c5de29e2f 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -330,8 +330,7 @@ static int pca9541_release_chan(struct i2c_mux_core *muxc, u32 chan)
 /*
  * I2C init/probing/exit functions
  */
-static int pca9541_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+static int pca9541_probe(struct i2c_client *client)
 {
 	struct i2c_adapter *adap = client->adapter;
 	struct pca954x_platform_data *pdata = dev_get_platdata(&client->dev);
@@ -390,7 +389,7 @@ static struct i2c_driver pca9541_driver = {
 		   .name = "pca9541",
 		   .of_match_table = of_match_ptr(pca9541_of_match),
 		   },
-	.probe = pca9541_probe,
+	.probe_new = pca9541_probe,
 	.remove = pca9541_remove,
 	.id_table = pca9541_id,
 };
-- 
2.11.0
