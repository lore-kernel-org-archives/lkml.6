Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752546AbeDTRUH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 13:20:07 -0400
Received: from mail-bn3nam01on0079.outbound.protection.outlook.com ([104.47.33.79]:47656
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751092AbeDTRUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 13:20:05 -0400
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none
 header.from=caviumnetworks.com;
From: Yury Norov <ynorov@caviumnetworks.com>
To: Fengguang Wu <fengguang.wu@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Clement Courbet <courbet@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, lkp@01.org
Cc: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH] lib: avoid soft lockup in test_find_first_bit()
Date: Fri, 20 Apr 2018 20:19:49 +0300
Message-Id: <20180420171949.15710-1-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [176.59.47.253]
X-ClientProxiedBy: VI1P189CA0019.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::32) To BYAPR07MB4375.namprd07.prod.outlook.com
 (2603:10b6:a02:c0::18)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4375;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4375;3:N0+jwDhLrzhi2t20Wziqun1Zi2UxSZzF6QgA5oDPKIqcmFt54Warn3EssPwdAn7NVPXxF8PM+mfXmhoQZg3uGXxoD+mYzYEOzUM/Q7ZqMWtTe9jriqReTqlNFcqZ0LWmmw23XGOXdCrr070ZwcHcBC1CyTe8Q7p7YHbR2RJ5O9H5p4+La4kKBj/InmimeB5ZKDB4WO0MpA/KDEIpyz5IaFgEWiYfvRR8LIecoom/nLVD5phbb4IUexld4CVMMs0J;25:ErVN2ZtSls1VwHENf0X1xadLg5XyXScy5e9D5d7Si39JyuBdnELvDp9d1oUeZdif+ztoIQ6N0c3yS04ky9cwC8DLsPVH15ArdaEd7CsWHsAd50WzhSVdypPOAsnGhgN1Z4On1mJ28pWoIhObX2Yyz+OJOkeY5dsM1cII4106AAR5VJ6Nx8U95dkELs+qmC8P72VS67cTQUZRtxMKlF1h9XnJO/5q6juPyIckw+KmEc+fDrsisXVtLSjTNfPA0IJ6uJuCHmlz4V5dfVzHlVMCPgi7TTZAW5Qrr8XO2wqkOw+WJMlGziseaTOUbuLFu/FPlDZZFWKbgtayU5cO/NB4/w==;31:nGNWiXgQ5LmZ0Jydq/9xqjbg1t/Af5/jhc9dyXfo71pZgGHT9yQVBd50GQ6DP1t7OgzwSrIHGSOFzDPxyPNKcG7zMi/mSdazSoSk3RKMGdyVFHIDI4OaTF/V3VLuwEjR+tVSUd99OjVZxlAYrun+Icc0Tj1HzwRH2XFxenD3wylECJJoz6JxesWSPuaEiFV9Lyf1BK4VV/LqxKxLm2bWxtOzDV+xyZKafwf87bRKnm0=
X-MS-TrafficTypeDiagnostic: BYAPR07MB4375:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4375;20:AnzsMjfUK5oo+/9Okrzlzaf3E+UDlMkdMQ5VKhxChxDOn+U+8quufvo8yHf5XT6r+DxK97KDEJgSgBf9v0sOwyKm9aPGgMwqcl5zNtXHSkTugt9BjU7dLFuXqjlY6yGjiRRy8EI7z+6G2CG+LkN5Fy4GL9TtmWgeb76pH/kQAz9Vy9jcNeG65/LBU+Bq/9hTyaby8rF9GxWY/rwtxHOOle8uDTsnMZ13cCrBDM2t+jqnAckhaxZEWyYjlatF+O+NiIvuiXO+sP/NGBaUc4RXef+iYsoxetHP3YO8ZpuchMqeqbRNDigHRw9lCgKn0eK8VGNGn20re5251p+iAyjOGNxq7b29n6DUCDOtcgE9RpCrXFpdaVa1v9I9U9tu8cvg/7FX4yOLOjK26Ysvmc9J/GXZl2HMXc+QC2nP7CdfNNVIPgFGPt1hmtKIKQqnUx5IHZOPUsD7vWjyTvY6VKdfTqsYFrsB7ptI7MfqGyg2dNWkxnn0ZJn6lLVgbUCFi0QXqgnIgGVeCsiasIru75qC4b5cQK6iwo1LCf9oTUf+o3D3/iXPJkAstgdr/yQwT0+K3tcP2pRfbFh25Y144RpuJb+tb1m0hoyFL9vuZTDnUQU=;4:+djsp33b0z7tTjLMVfFthYmgrjq+YAHKmrbQBg/emY+ZJSy4LFt2T6yof4SkQzVP2yrF+6EvfwU+GiuS/xn4XFFFZ6eM1o5H+LTMsnP6utwXcnHLHCMVD5W96Pjo8LNlE35IaAyakTOAM7/r1PaBiSGB43AR4Li8n5g5bKuG72gNZXkrxae+ICA1PG8SjhoIxX9hm35YtM6UjEopB7bsNPpw9GTidfUBSGGhPD6w3CroSY9f62aKN9Tk2/uTfeqGFP3ZP3J/P8osbTXAGIX14N2Nuexcj9ip1Qfx1Nlh38iSgozXHOC95HbtX1U6Q3Uk
X-Microsoft-Antispam-PRVS: <BYAPR07MB4375E4F48B1073EA35BA895BE3B40@BYAPR07MB4375.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(228905959029699);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231232)(944501396)(52105095)(93006095)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:BYAPR07MB4375;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4375;
X-Forefront-PRVS: 0648FCFFA8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(346002)(39850400004)(366004)(376002)(396003)(6486002)(53936002)(3846002)(107886003)(76506005)(8936002)(186003)(42882007)(16526019)(50226002)(5660300001)(72206003)(1857600001)(66066001)(81166006)(8676002)(6116002)(50466002)(478600001)(48376002)(26005)(1076002)(4326008)(7736002)(575784001)(305945005)(59450400001)(6666003)(6496006)(2906002)(386003)(25786009)(316002)(47776003)(110136005)(16586007)(956004)(2616005)(36756003)(52116002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4375;H:localhost;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB4375;23:bNoW6nNf2Lt5PzqJLchrcEkG12sjjv6OtmiOrRM0j?=
 =?us-ascii?Q?NBxPV2/7pN8dulw1dLCw21u+CvtPmwXLmzRXR5BHBkprWRfEQ0P4dHixLaDc?=
 =?us-ascii?Q?FM2hyR1yaOsErmS+oIXwzpN3kB5KZJQI1kpAEC2pJYyo4ImfKYowC3fFnxMG?=
 =?us-ascii?Q?fOi1JwYhNQKG2qeYsQ6sYIPQg278P3YrgA6YhuVwX8lT9nmbLfh9I6DjRyfF?=
 =?us-ascii?Q?gPRWbGyCpwYCz8IuIHvmDDIfBW2XmoBurxwEQhkXIE91vDpk0RlyBXgpy9xO?=
 =?us-ascii?Q?cqz7I357oHzCJREUUZA+83MPGDIsVIK+nuDBRlsQt84LQEQx4MWJcA9WZ65f?=
 =?us-ascii?Q?1L/IS1T2EuuwyufcqUBYN1BFrV5VudcN3Mxtg3DVxZAgZXll0qm1x7dIG9/E?=
 =?us-ascii?Q?NEqnis3aGWjGO/QVa+gM/l914t8Mn2QVeDQQe/t8Q5K9w1JrfEZbgU8Enzoz?=
 =?us-ascii?Q?fHRaCgGaYNBguGwHvquuudZtq+F40iiUhns7GOqOsQYLzgRTkJzIGRsgjw9M?=
 =?us-ascii?Q?JX/04Q2qAdUBjCKysEZ4PUANRGAfFC2qjnvqMQtKTCDOhWMOSaFmMKjNt73M?=
 =?us-ascii?Q?fAbJ8SpYqQXCzBgIoWbE5A9jpJno2zv1gI7SsYgEhhvXTArJYjxFp3EdHKB0?=
 =?us-ascii?Q?KRQN1jzbtMRu7Uk6C0u1DnFu2mN66QNRQAQUIVaGk2NulYlCypW6oqh0qd2X?=
 =?us-ascii?Q?4a1iFp518CyPzmFS6tnFr+RbPpHJgkYval3wp+G5QLxlsNw26D8TePGdmO8u?=
 =?us-ascii?Q?d1+oT6oSHdbMsiS8l/oygG5P+PFjSP1xWs+loXFoRelQSDGjkUXtgAixLqy5?=
 =?us-ascii?Q?5jwqe2S7FK9fjexxOdHlpW6wSLU5Mng28uAuwAlKV3QwgsxkH5gcvMQGX8Ni?=
 =?us-ascii?Q?rtBQOdRGq3e8as58AtnSeqcJ7uATnmE8+GAhay8xkeU0zrg9D006GW/ONWJs?=
 =?us-ascii?Q?Cn1tnqdCGkn4FR6hXONF6jaJ4AeKakpzkPfyGxXDdVqCf9UwOxH3kfmGevA5?=
 =?us-ascii?Q?gDTyVKZtjND/LcV+Mgj6bbFSp3bSYoagOD/OxseoFUfICNG9hDhyublviKZz?=
 =?us-ascii?Q?J+CyM/NpeH2itaAI5IalF+/hN1X?=
X-Microsoft-Antispam-Message-Info: rBnUcLEKrraZcPlCgvkPPrNsnrzN5aPGkKWLbyPok8IokmtXCErmhscWU5kMhWWzuPBtQ837fJGmB3TeKegT7D2WgXRoJ4WvwqFb+roqtmhLUcKE5kuDXWa3mIMFaIA6+ATQdGISjOX2ZovurFaHehZ7hYRLLDNneYNaPyMZ306yBtPnAwM/OfcCTniuQcpw
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4375;6:eJEtdl1RSOd95B3cWhLM1db5jmx+fKbuaSfxQaL4rPln+FMRv9iR/wAJ0A/hZugAlpPNOxQw+PBTcsr+QsCy4vnxB7F/EJgcYVO9k44LxLetbUeTXBzkCfFRdux0252Dp5MgrYeDfldnKJ+Ok9PVL1aWe4SRH98Q/QwzubeSIwDmSR8qTjLWBfvUd9SEWErd2ZFknadoBcTDti2iHQkcZPaN+XSUyr6tunYL9F6yyQna1B642ZWPCNglvKYLTyJ2b8DNwldMEGXsFFCGdHUcOSeuf1v5WbmkFU8U6kj45eUmwi80lTBbZZK5Z6QqzQPl5b97sRjQsTpAckgU1ePTFOUgodP02Zw90QGl9BWaVzN4iFyq89Tj61hLpcdb2/eEVc7LdMJUhawtCW3sA/UQvLx2XbqFftHO9fIhKIoWUrTdISa2+W4/tCSvpi6zSGBhbEhWHDQUlx8gkuuvRM45jw==;5:gid5Ljm8HFLSutUZrRKgYFRg7mQTIW3SfgJoizecmZbZJdJFrrNZUg/l/lGT+oppU7DJ4Ep57OEYmXpxyHB0t6caGbkbSMMcwOFYf8rGlJ/pV5PBIqxBXlHpD3fRngTnBnumbLmJBx5CgF1SutGqP400GXAA06wLjH8Nf0CiaPs=;24:0MeVrt2mg3fs0jASmtC5QkGKflSP/uU64z7/ItI9QX75lyn8+BfwbbGV38mKc9uIZZhQn4n8kj87lhvS2h7eNuFbGveSIc4ObwRK9beP89M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4375;7:f3nHF4iTdXKGXIo7pmnATMG3ewoLmcw8R86H1JRfXtFRLvE1RLK+20t/HpU0m0+zukQ7R9VypaEbt1EiTthjIEC8uKDl0KeObJFGLxjEWz9FZNWdMbt7jRVZbEc2EaDMWbwlu9McLCPZy8H76wxd359AztLyHbmI4QZwP/FO0GK5PNLXNO5Fz/3bUcqbvz1ewVJLmT1x+HYnTpKOq9uEK1f5ka3Qd8EXyJ40/3bOyXJfm28mTWF9ijzUPGNnBe15
X-MS-Office365-Filtering-Correlation-Id: fb007330-a060-405d-c6c3-08d5a6e2f39e
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2018 17:20:01.6788 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb007330-a060-405d-c6c3-08d5a6e2f39e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4375
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

test_find_first_bit() is intentionally sub-optimal,
and may cause soft lockup due to long time of run on some systems.
So decrease length of bitmap to traverse to avoid lockup.

With the change below, time of test execution doesn't exceed 0.2
seconds on my testing system.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Fixes: 4441fca0a27f5 ("lib: test module for find_*_bit() functions")
---
 lib/find_bit_benchmark.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/find_bit_benchmark.c b/lib/find_bit_benchmark.c
index 5985a25e6cbc..5367ffa5c18f 100644
--- a/lib/find_bit_benchmark.c
+++ b/lib/find_bit_benchmark.c
@@ -132,7 +132,12 @@ static int __init find_bit_test(void)
 	test_find_next_bit(bitmap, BITMAP_LEN);
 	test_find_next_zero_bit(bitmap, BITMAP_LEN);
 	test_find_last_bit(bitmap, BITMAP_LEN);
-	test_find_first_bit(bitmap, BITMAP_LEN);
+
+	/*
+	 * test_find_first_bit() may take some time, so
+	 * traverse only part of bitmap to avoid soft lockup.
+	 */
+	test_find_first_bit(bitmap, BITMAP_LEN / 10);
 	test_find_next_and_bit(bitmap, bitmap2, BITMAP_LEN);
 
 	pr_err("\nStart testing find_bit() with sparse bitmap\n");
-- 
2.14.1
