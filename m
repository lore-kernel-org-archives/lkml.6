Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757472AbeD0AWF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 20:22:05 -0400
Received: from mail-he1eur01on0139.outbound.protection.outlook.com ([104.47.0.139]:29146
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754672AbeD0AWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 20:22:01 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jane.wan@nokia.com;
From: Jane Wan <Jane.Wan@nokia.com>
To: dwmw2@infradead.org, computersforpeace@gmail.com
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        ties.bos@nokia.com, Jane Wan <Jane.Wan@nokia.com>
Subject: [PATCH 2/2] Use bit-wise majority to recover the contents of ONFI parameter
Date: Thu, 26 Apr 2018 17:19:56 -0700
Message-Id: <1524788396-32380-3-git-send-email-Jane.Wan@nokia.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1524788396-32380-1-git-send-email-Jane.Wan@nokia.com>
References: <1524788396-32380-1-git-send-email-Jane.Wan@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [131.228.32.160]
X-ClientProxiedBy: HE1PR09CA0086.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::30) To DB5PR07MB1608.eurprd07.prod.outlook.com
 (2603:10a6:0:11::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DB5PR07MB1608;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1608;3:1XsjlFzvFZyvFwUTZc7kmCEJue7ii2xMuYgz0OM3HZlsmOs9SqFEpLgApv0aypjc1CW2Nm6O91OYcnWhZ6UW/0WgzasfT8kKNUMugO3prj4elpu5jkumTPYDLE8N5FAXQGrhRvQciqdwcI8vfEma4N0jwB1DNnHdSO4L55bwiqsx1YQKgEAGoN1pJpaW7oaUn0rtmEYRYSLbT89Viyxejt6g3irOc2bG5GmzEKGS0jShAzn0uUqv5GoXzPhdOD0N;25:IJd47h9taN1EZBChvVrABQ7gIQAg/ayWBecqYLFD+IJxe+OjasN1e+6QWcMhj89uDhVepCJZhTs9JOPdW4qA5IcHnJjW+5yiRV+BeKhjxlCWxIqoKCm38lobW4JJ3HdebCTKK3HSRL1iaiLe2WYwFeCZNcfj70EuacjsN7CUsKDCqdelSEjzgstDypgUbj8FaiwK+SqB/bpGDcLhxDPN50s/+Uw7yYK1hk4CmS66d+da7UoJVv/ODHREAlTe8OORCWNLCSplUQBWoBLFiUlHcvxqBfbvWFQxP9RPgyhP5tsPwlFdAxOWNSGRC6RD41pG+B9iDd6BAT/W1Q8ePhsf+A==;31:4EBfH1unc0CVpDluHCHQna5J+BWT/CZXhV14rPFdTCEUT1U+jY7hv/taZ2TyLQYPFVMgw5mW0b/qspEet6gn99doMSDDOt92/u0d/lCO3wt38xn+jFwfRfcPw8JJZ3KvsHOcJ0jsOs33DNiUqufolSwq4fMiraRijpCqjP6Ic3FE1OBkGWXGgxY44DwPozgOQRICXi3F0op1N2fbu+QY2z6AGdk5IcX4VSKVFJCbaOI=
X-MS-TrafficTypeDiagnostic: DB5PR07MB1608:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1608;20:ZFxZiOxj/i+x70ulSJ3MR46FzxY9wke6Rl+inBTBzX3/SJbMVMHxYagByWkkxgQjRUHIJokfvXjAJssoPUqwZ5AALcilUExJ/RZhfDdjV8k9hXOmES/av8zk/FtQ6uxInl7wSWAWTl+EHYPxJdbhd1KdI7B8C4nioVgo8yNQ5IkeyPF6wLYo36M+rnOJL1oRiXYIrbM3RZZxZvjHm/+UAXWMny3sFW4Si+Wpg5vB069z896KPOzn+J33j4O4ffQp9BGy/CqQ/p6KUiFsRLe28py7iAE+udELRcGN9AZk2cvx9/fZUkl4u1UG5672RclcgAJtY8vP28l/twQf7RnD5sARpFWv8K4PYyqJBAWE7o1AlTb+8oZciS0Is/S3ppIRtMklE3lOSJgve1nuP4NrIin1b53pgRRqg17c2OhVIcwBSmlSquBbm94FbxZXh72iif0Dn/IlPgxIaxrHYwzz6CLwG6MOGMEJdvQsWliSdyO7LlGY3CjRDO2xwhDSrieB;4:MRaqQBHmO700fVqA/xjN1kRuPstLFb8iE87qt8jVjWZPI0R9gweii5LnxmQZbJtY/06kRozfvFpphwLhqXFW3xyFzUCDftaE+CB7aNfcY5SXMNP2UiYyzLlUbtrqJ5z4WcFTfmxXShAYwTiCgvm76Ssek1nHHdZ6kLZAteSO1OgneFXTONg9kUDRweqbZ1ruQRWkx4+cDW2cmDZy+hftj39bs5OUmjnILYQ7nRJnUZYI4CTgRTCuyxPDun6OV73hAwFVIatyeI4J9gTVANF2gsir4gUW3lpyCZ+3dVmuo57pu/Rlslctbii2OVdKsPMt
X-Microsoft-Antispam-PRVS: <DB5PR07MB1608AF48C228F193BC9237EF818D0@DB5PR07MB1608.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(11241501184)(806099)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DB5PR07MB1608;BCL:0;PCL:0;RULEID:;SRVR:DB5PR07MB1608;
X-Forefront-PRVS: 0655F9F006
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(346002)(39380400002)(39860400002)(199004)(189003)(8936002)(316002)(446003)(16586007)(956004)(6512007)(476003)(106356001)(105586002)(2616005)(48376002)(50466002)(39060400002)(107886003)(16526019)(6506007)(86362001)(11346002)(59450400001)(26005)(186003)(486006)(52116002)(51416003)(5660300001)(478600001)(25786009)(386003)(68736007)(81166006)(8676002)(66066001)(47776003)(7736002)(4326008)(81156014)(97736004)(305945005)(76176011)(2906002)(50226002)(36756003)(6116002)(6486002)(3846002)(4720700003)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB5PR07MB1608;H:cobuntu-jwan.gainspeed.nsn-rdnet.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR07MB1608;23:AJOOlkqPpt2dH91O6iIi4dnDaoeLwxJgMoXuocD43?=
 =?us-ascii?Q?7TgqXgifZ8dnxYKVIU3Ja7p6xctxB4c119DgtYTSJJlDwfFF6kb27SdlHa9y?=
 =?us-ascii?Q?/YWhbqzRWwDQt+6CtIYpBWQMMapLIVoVm8u95KDWkFdesjCceOsTB1ag8Os9?=
 =?us-ascii?Q?VhOux3122soHiDUdgbwCQ7gxfboUcf1kXtLp68v0YugeC/pi9LkTkZHWCcUt?=
 =?us-ascii?Q?KqjG8mV4czmItwZl0Vrw5QyCc0E5oWDldNun0p4uWqzMOCYhy3EJ4vQXLF/m?=
 =?us-ascii?Q?rGy73vo1HpMRtWfloRstAJEIcZBHYpDfU3+rZLECSnVU+mM0Xro4VXCIggNi?=
 =?us-ascii?Q?yjNSReAeIAJaJGYpecv4Ue5HZtocVfux+ukNr25gWOHgU9hmDmMOrYh2yb3p?=
 =?us-ascii?Q?3xA9u35WLU9nrrGCYY578c7HAt9cwa2hPHrCg/OYpvxe9rdX1G4xdv7DfXeL?=
 =?us-ascii?Q?Bxa3DZFJYJqBi+YjaMSOejGdNGqSjEG1H8j0QuyyJm02fQpcTDCrMhFwMi62?=
 =?us-ascii?Q?S2hxvviYTD34tGdB7+K7q/vvjmOacd1rHLH4uQ0xsQHKFyEMcpYvp7nu2RJ/?=
 =?us-ascii?Q?f6UkQysr7G7FpozPm1H6Qr4dnVEHdonVx4nJ6EEkp82P/VH9h1NIAU0JYYkv?=
 =?us-ascii?Q?wWgvX+qUy+hbHEa0uv54odK9QbHaZKi1wJgKyrOSOMyv3VFeWcsmuMyKcsDA?=
 =?us-ascii?Q?yMRgx9sR4mLTX9mg+tDwkJ3jfQdThaqiZJocCjDvkLXKhAak86RFKlcq7Q6u?=
 =?us-ascii?Q?7KVuCw9ns4nSPTirxGawtZEfAkzEuXfY9AJi3Qys5GQ6+PClN1AQFNOH/ILg?=
 =?us-ascii?Q?3dOnrR3HfZolT00L9NUhDOlF/qtw6t+9IIBJem97zmgm0qh33YhVhsr25yb7?=
 =?us-ascii?Q?pXbgB2BUpn0DiQK+q5X7LdsaxgZe+SujlST1wBD0Wodktywb2cOLJYTAPmHf?=
 =?us-ascii?Q?ycCSznN6aITtoyX19lgJGTsxtoGsegEPzhq0SOmDq98g7Yt11evoKRegjMLt?=
 =?us-ascii?Q?TN2aumjBtyjxyyNEvZt3LXGQrlSVbRqOeF6CXJ6Xsbt3+1Ub09UOmG9hSuif?=
 =?us-ascii?Q?xP51ToWpxgtv6mCO9vfTxAB2uROHldKEaCcJqmTx0WGd4ih6JT5vO7PFGAsm?=
 =?us-ascii?Q?N50OHOrkQXkFyk9DSAXywddJZbFh0sMIpMaKhz5yv6NvUxWetZ5WMOOJ3eAs?=
 =?us-ascii?Q?fDsz08zOOLrZSgkKIFKl6fg7lMkcHqsEJh5hzsiiX9U8cy6mW8UUmWQZNdAL?=
 =?us-ascii?Q?IX2sUEH3kCksGEdzKo=3D?=
X-Microsoft-Antispam-Message-Info: n5zTMnXOg+5XPmFvuo+mTBZ3O3mdTwHbqZyOkFn/2X1/mApJsypmhpOP5wCBucVL/2GdS2bdhlL2Tz1THe6J1BH0cD6wATfZhPnW8DYG8x1A8OvC8EG2SWM44i9DxosZ8rrTX2f1RioWzcsOB92Lr3+oqY948AvVMN70keH3prpXu46PnZ6AwPSIoZBz6GV6/540J3kLLzRhJwWdGp70F83ALtDXZIwrpdYA6G8Vjjw=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1608;6:mkLLGX/ABJqiRjOgppRJlUWhm7BN9ejgEMaMpxk1TfLqib0jNf3KOeU/LEP+t5gzZXv0qkHou4j3Zoi7PZ3TZD7rRN8aIEOitiJ5EBpwj+3Yx4Njn0HoFdCXlCODCOaJj6lwdsGir6Ejl3ajO5XSwAmVxWnYgqeR3K8kKCjcLsdAWbJS0q9j00KNhjaDEeAW70N3dpuvYU3oeu7Ufs1keJyywHMABndwHY5kkY5Yafklmdo/Nzymqpvb02gRQ6FarM3wka3UMOJxUXd0ob1mYX0L3qTiCV+o5jk3hvTp4vedgtM9v4d/7bs/fGSMllLZycD9nmT81waQBO/Ggig3v08eNZgiRrEnanm4MXrL2iCR0xldaJyAelmGRAhGjAFzik9JO9VdQlkzgtn8/Pe+avW3fliLplSQiZr9Q8P1l3wV32baFWPA/qeN+7ZNNu0Na9tuRTnxT1K43jqySgkvdg==;5:AYE2+3g60HF9xurgI860sizJjxSfZlUi9OqAgEqVpUKpwjWdllIv64folojVZP3Dgiiw14dSkcaJCQf2hZ+5qkse2WTjuNrp7PeexJL5bpFN+AIf3JBIz3NHsldVy11lo8vsnV7XT+D/8wWvzWsx8rOsyuyu9E/qp+xDOE47+l0=;24:f23mPqrL3onzzT6+PHaT6OkXWOYcQb3i0DKrqwsw7aCnl6fgVqhJHEWKESV9ZgW+Ya1Ta6uHOMV8WcUAFxWK48+Shd9xsZeTlAgiTJKsHus=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1608;7:PcxrcciCNTr8DCpGE4RVsy5Fl1s95KYHUOUA2Sq36rrOYvDBahr4Mhh/dcq6ba24wbl7pwwSiMfE+TIAaw4F6/lvH2HgRSiGmuYr2+63ZovNSGJvWT0xJFCMUBRN70QEYS6X7gat9kiToyQL8wn6MwKZTXzjzU6G0eoOdgh+yDB5JXsqvOEwpBtpAKmV9rZ0PkErztUmenBgOmVhtcHSri7lj8EcsRdra86g1W4wJMlbNP8xMZDlhPcAITp7BcTW
X-MS-Office365-Filtering-Correlation-Id: 61623474-7f68-4bc3-03ca-08d5abd4e398
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 00:21:56.3380 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61623474-7f68-4bc3-03ca-08d5abd4e398
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB1608
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jane Wan <Jane.Wan@nokia.com>
---
 drivers/mtd/nand/nand_base.c |   35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index c2e1232..161b523 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -3153,8 +3153,10 @@ static int nand_flash_detect_onfi(struct mtd_info *mtd, struct nand_chip *chip,
 					int *busw)
 {
 	struct nand_onfi_params *p = &chip->onfi_params;
-	int i, j;
-	int val;
+	int i, j, k, len, val;
+	uint8_t copy[3][256], v8;
+
+	len = (sizeof(*p) > 256) ? 256 : sizeof(*p);
 
 	/* Try ONFI for unknown chip or LP */
 	chip->cmdfunc(mtd, NAND_CMD_READID, 0x20, -1);
@@ -3170,11 +3172,36 @@ static int nand_flash_detect_onfi(struct mtd_info *mtd, struct nand_chip *chip,
 				le16_to_cpu(p->crc)) {
 			break;
 		}
+		pr_err("CRC of parameter page %d is not valid\n", i);
+		for (j = 0; j < len; j++)
+			copy[i][j] = ((uint8_t *)p)[j];
 	}
 
 	if (i == 3) {
-		pr_err("Could not find valid ONFI parameter page; aborting\n");
-		return 0;
+		pr_err("Could not find valid ONFI parameter page\n");
+		pr_info("Recover ONFI parameters with bit-wise majority\n");
+		for (j = 0; j < len; j++) {
+			if (copy[0][j] == copy[1][j] ||
+			    copy[0][j] == copy[2][j]) {
+				((uint8_t *)p)[j] = copy[0][j];
+			} else if (copy[1][j] == copy[2][j]) {
+				((uint8_t *)p)[j] = copy[1][j];
+			} else {
+				((uint8_t *)p)[j] = 0;
+				for (k = 0; k < 8; k++) {
+					v8 = (copy[0][j] >> k) & 0x1;
+					v8 += (copy[1][j] >> k) & 0x1;
+					v8 += (copy[2][j] >> k) & 0x1;
+					if (v8 > 1)
+						((uint8_t *)p)[j] |= (1 << k);
+				}
+			}
+		}
+		if (onfi_crc16(ONFI_CRC_BASE, (uint8_t *)p, 254) !=
+		    le16_to_cpu(p->crc)) {
+			pr_err("ONFI parameter recovery failed, aborting\n");
+			return 0;
+		}
 	}
 
 	/* Check version */
-- 
1.7.9.5
