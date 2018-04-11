Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753909AbeDKO7d (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:59:33 -0400
Received: from mail-co1nam03on0070.outbound.protection.outlook.com ([104.47.40.70]:45699
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752916AbeDKO73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:59:29 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
From: Yury Norov <ynorov@caviumnetworks.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Cc: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH] lib: micro-optimization for __bitmap_complement()
Date: Wed, 11 Apr 2018 17:59:14 +0300
Message-Id: <20180411145914.6011-1-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.101.210.115]
X-ClientProxiedBy: PR2P264CA0025.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::13) To CY4PR07MB2904.namprd07.prod.outlook.com
 (2603:10b6:903:26::18)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR07MB2904;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2904;3:Z94o3VwexlzD0tuI70G+N3kQWhN/L89Cx4E67vNaQ+YA6OgG5QI7f5gc7KJFHgKttXnyXm3bL/zbj7WZg9zBjBjOd57HjK6PytoLLryef6hVsgIWxZT7lw36dlx/FewT6eVy+L3ES0R5CEMlrL6zEyAgzdryDiLefMkKuh+nRu0nwbaxUQoq/v3P9z0KTYZeTizZw7BCf2ohM7v65yJwDAj/qGOFnKLVWxPILe7xCZRqjRtmnFl8MRkE0hQrp8U+;25:5UqA4bvy1JPjWPny42fzyx5O0cavDdRQZDXBv99XI6n9KcUIeUH8lhtlisAMgN30KJhGO6VR1183m18s2TpB2WQOWwmL3Nzyjs/ObtBLnhyKUtpPBc6NsKlSLSjHoebC2yMgY72n2fhlMi5WuD8YfkfNNrZBa5yDr7Z9uIal6ritgNbWsLfdg+FXYugifBPlIIbxYhmS/ILEYvXde7ElmlgVVS+AVXgrEO35sTQiTK97bgl0yqu5Hl6GnJRKBWV1Y5RCMT3NBZ5xWYFmHFPJ45xtXEJancK2z94etF84RR+Pg11LkZI5SaBkxgm6yKCyEjrHNPj9tKvIcDqD0W5vHg==;31:IQ4tYvRIazAsUjkVeDVXW4WdjvZXuK2cDLsXkIfUnjrk611hE6rBE/Bb64WojPI20DIE1o3r0KB/t6yV8p+xeAYZbPZpzhCRh6K12feXIE5pAVA8BDq9uFpGiM+3iCjqGqBbS43PTlu++is7mNdPd53VpoYssnB7RQF3L2hP5wz7xzAHHnRIwese/6ni7yOAcLvjnbwR9rnUVQ8xCXq/jfLZ3XMHsfChglJq99IgH+8=
X-MS-TrafficTypeDiagnostic: CY4PR07MB2904:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2904;20:7TwBzp15GF8j2L/BphsHajxzpwucxV5zZVpfaZnRiazifn3IBpZITHtcssgPhmpZQCBiWvMuxrZd9X/viUJpB8lG+LzBVC0aOV33DW//65RpiGp53X+vDroKknybN60AZNc0BFfQ3xReI5zs4JtJ7uTzar9rj1lRyPi/Utxv43W5oLCxqlaWE1o5ihkNkVZ4LKsiqhqUR6/2eVywmK15gZlDMS1fgndg63e/DjIFuqJK6O+oIAmhzx7dZtudxA0NlKcq7RByLvLUue7ZOlhCDbXjiCff2Ppt5kxS3tHIgLuU2NztcjiQp40qqcM0keIqh/+ql+kzgA7IvRV+2cRXPZT8GFWKCPQhggijbtTIIRAk1oCTvPRcBsYaEgQ3qmX2ycy0sIW3ooyx1V2SuXY4MGmKCV+M9FfG2/M5y+j9B3XYvvrwnI1RIsoAff2SxXybUi06xJXRIgpGMWvcKL/kHeDFSd5NBPCTxCIaGFWhdwEd6XNn4xE0vt9+LD7bqLGDdl8vSqu2gPJ3Qw/w4+gIL2Um5MIWV7qHC+wjZmmQgxnh0wsslula2Egb0QBO/vrj4EGNvtG0lMwk/hhJWHd2ovJnegnqi0uy7phgN9cEuQQ=;4:jnX5mE7GgUURp5JZUOcTDp6Id7Wk3zeWViu7Dd+XdwbHdQYIh5R3Yc50kScjB1J7mDe5cDc55NwNNR0unCF97TVGMkojN95ccvUzYfu6dkc9l91DZRiHEq3PM9ylYyGzGW4szPFsePsZ8OgyExanEb39WHMbkAv0jGhApqrjE34+GfcfqwyVzefqqm3kjFnEZFAhUy5Ma0Xg1AwxcyZZQwNip83x7/GNmwkSORsBAcZTsnqJe5VJxhje6C1Zco0yjG8+JWX2LaQeNJ8N1qXnDw==
X-Microsoft-Antispam-PRVS: <CY4PR07MB2904A9E14A6BB3E724ED1D65E3BD0@CY4PR07MB2904.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(3002001)(10201501046)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY4PR07MB2904;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB2904;
X-Forefront-PRVS: 0639027A9E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(346002)(376002)(39380400002)(396003)(39860400002)(366004)(199004)(189003)(16526019)(36756003)(26005)(7736002)(16586007)(8936002)(8666007)(106356001)(186003)(386003)(110136005)(59450400001)(68736007)(1076002)(51416003)(52116002)(476003)(6116002)(3846002)(305945005)(316002)(956004)(1857600001)(6486002)(50226002)(25786009)(55236004)(6496006)(81166006)(105586002)(107886003)(76506005)(6666003)(2906002)(72206003)(478600001)(486006)(2616005)(97736004)(81156014)(8676002)(5660300001)(48376002)(42882007)(1511001)(47776003)(4326008)(66066001)(50466002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB2904;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB2904;23:LO230loIOxmE2P+EKnbBQggXPfM/ICOHyoo0KgOL8?=
 =?us-ascii?Q?SYVTqf4nVSqOVRuYVHOk5NPSgsw9VM6QyEpfO7H5cBWQ5m6Kw29BpT0+IFLU?=
 =?us-ascii?Q?/6cVQSxeL6MVvkvdqT2S8tL+MzhFV5GQfgnOaK5vbr3LYjbfAxvhr6fWQpVe?=
 =?us-ascii?Q?Kk/TH7kGeSkAs7mWSl1OE9xbz8SxQ8wRgmP2viXmXfqiKYsfuBrEhvfK5gGn?=
 =?us-ascii?Q?7LTkxTd0QZBpxCVn0u3zFJyBiJywS9ZjeoUg5gmXQqmSd3IJBkT3G9U0tsjZ?=
 =?us-ascii?Q?3JlCLwSF4ngopoyQYY7QJs+qN9UYjkjeD3wIqoUR0KaPYhsR3b6hu1AEBdBa?=
 =?us-ascii?Q?9Li+KxeYXyiwvcqw4RuLWZQ2ePurOlHv3jusUxfBfHAchbdWAZK7+callEau?=
 =?us-ascii?Q?gZ676s+J9kw08Wl6AFWovaRzrMR/O288hB7YklCGK9kpr9aMBEoZMz+un6Jv?=
 =?us-ascii?Q?CrbJwJh9B0iUBjDD0jYQYmPOnDLukT3SZtJVOb/lLheitXDJEFxYfEeYYtwb?=
 =?us-ascii?Q?utggaC2QExZg35b13C6V8uWagiEIG8aYVTeAg/21uK6DMGWtD2jI01wkIKqp?=
 =?us-ascii?Q?++rcdGjAv62CyCdr6JVHr2Kc57232K1R+OY9dMRmRMVremgOqCpPmJlDxAeg?=
 =?us-ascii?Q?F2nuDDdWYRMDlxndOnrthgzYTqH+HC/nLbHJ5Vveb6LUXAUIz7W2ihtpg386?=
 =?us-ascii?Q?4xNZGnTwBBtCI/SzF2EHzl0MsBAibxw5kPqEV2pMQk5ZWvz5Sj3Lc9TPQKX5?=
 =?us-ascii?Q?OInXyIlh1LfVhOVKbfB020SUSFYFuX2ivtdkZJKIiWDnhqR6UURC6d+1T6aP?=
 =?us-ascii?Q?gMtp2KiBtypREydFZI8+WiPvTSfpHZjCMSH1mFNSCCnvgIhpLETLGesn4yVW?=
 =?us-ascii?Q?t8iSIwCJ/jujCmkn7CVGNY+G1XJDgrmIxBZ0bGXhy/cckkhFZt9TUJvict/g?=
 =?us-ascii?Q?U95vQAvYL/gaIRwIFSzYNESU+X9oFK10naTuQPSLOWCNVkXIV+jvybqOSrfA?=
 =?us-ascii?Q?K2k9TX0YjGshnfL6qPnw8ZJnDqwOrlXod7uAP5RpMGaTW4ty5EL7licAr25C?=
 =?us-ascii?Q?GF90dbAsdLeD+BIktHxcRLVYmQf8ybc3k4SjYIXLJJxmocutOrvxM7SMi64d?=
 =?us-ascii?Q?e1GPUlX7LQoQwPQW5nVTfsGtI+zfxe4XXzVneaDVUT/pTnPF4UhHODrIUQXb?=
 =?us-ascii?Q?RNuvBMhs/KMtbTHUVuzrTb1987Xc6ueLqAP5RnzaJCurb2d4LhEdYomQh8RQ?=
 =?us-ascii?Q?tFposOtkcUE9HHjMtSAyAS/rBJsYlXHNM11xA8UZYEcj15NP3sNfkvFyIRVc?=
 =?us-ascii?Q?JhN1gHAdrJZ+eAnx0hCIDI=3D?=
X-Microsoft-Antispam-Message-Info: +RpiXw/mTxfbxXD+ahYvZY6JmWzo5c9v18d8/fHiTZdgNePHQ7feiT+tnWU36eaVTrbhjZ976u5kR8EroH/awR7BbRl3Ar33FomxeAjk5DSTJJFCGBWM2w08avJWWZz812qXtaDCrkWJh59P87dQoHfLXOZbktFcWH5VhQkpWNULAXiAnWu7iu9HEhIV4GWa
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2904;6:gfdeINOmI08Bh6BKG0ytegUuEjiIFtQfhLI0mbLskoXVRF/BZTjVHVxJ8UMvTz0k9X/k5JtcA/MlhH/q+rPlat4SUSCEah9M9pLYZnXVCxmVPvdPc/oKSaekGbQQXF/ZOj/qSRjtjGb5sKxOANpJuPE5czH/SR7NgN3ttIsQJNsm6HrgpcWhad8fcF17sGykyntTfgtrSOs3hAfmwUe6Tz8uTONDnS2kWa+MTv7eGAunhnFa85/19rJ9A00wB6MCABWMyiEvaHgcTtSpqsxVe27LJQy22/0pLYWcXXjYzj7PgegIJFn/CHEB4oPYhK3tNt9RW+h6y5EKtpUZ8YJymC309+NkqkosY11Pl4eRbpe0K6mdx0Ww6FO+2JPR+BJR1yJvk2z2t+FcwVJCquv+YDpPJGkuWVbe7mVvvcCsrBuXYKIm8u+VOK4ICFxldk3nv8y8uvZ9t1VouGi4vIAUDg==;5:oldxID+vJp0AZFugYsuEw6ESbDV6e0us7/+Uu8XxVN7pPRHjPV3Uczed/TuNZFo8Yn/1WGkNL17S+CkhMPUF+FLyiY9GF3go9vdDEB5uCT79NpZ7aCoJn7FW28MLLKzZ8V+m6ZQxO6ktdX1kN+Np5iN6JhKg6WM/7T+I7zBJfKs=;24:B/H56T82BiNQR5wCCVdRbLtHEShF2OM+1HcZmc9L2cZ4fOhzMajwvM1MhLQvsBFM9VplR2MUVIFPKnjksksVA6TQ+OdAOmYp9vcnggjyv5U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2904;7:Iv38BnYtibJgaD+NwoVuT+Rxp5YFZsyio1SVWFRWdh/YsnPrWNYnnoy5fDxO+dZomIJ6d2mo8+5Y3IKgZCfNs4ZTu9CgJ49ejCPxvs+Yy0cXXeYrfhKOqgtoFkMT/4G4JaXTlnLOgFWdXNig5LwsJbV3EcD3NdRLAI2Ki4hcl1CLFtkJnu1RtmqDb7TrwCNcJhZGMPyGw5Kh+6EdJlquS5hbtqXCxkkGXM5QL4xwvZiI2cUqt2i0LWo2uA+E7Oim
X-MS-Office365-Filtering-Correlation-Id: fadff4b4-35cf-4ba4-c795-08d59fbcd25a
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 14:59:26.2907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fadff4b4-35cf-4ba4-c795-08d59fbcd25a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2904
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use BITS_TO_LONGS() macro to avoid calculation of reminder
(bits % BITS_PER_LONG) On ARM64 it saves 5 instruction for function -
16 before and 11 after.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 lib/bitmap.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index c82c61b66e16..7adc10074cff 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -62,12 +62,9 @@ EXPORT_SYMBOL(__bitmap_equal);
 
 void __bitmap_complement(unsigned long *dst, const unsigned long *src, unsigned int bits)
 {
-	unsigned int k, lim = bits/BITS_PER_LONG;
+	unsigned int k, lim = BITS_TO_LONGS(bits);
 	for (k = 0; k < lim; ++k)
 		dst[k] = ~src[k];
-
-	if (bits % BITS_PER_LONG)
-		dst[k] = ~src[k];
 }
 EXPORT_SYMBOL(__bitmap_complement);
 
-- 
2.14.1
