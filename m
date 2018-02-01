Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752908AbeBASA5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 13:00:57 -0500
Received: from mail-he1eur01on0112.outbound.protection.outlook.com ([104.47.0.112]:56704
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751913AbeBASAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 13:00:50 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Kees Cook <keescook@chromium.org>, Eryu Guan <eguan@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        Chris Metcalf <metcalf@alum.mit.edu>,
        David Laight <David.Laight@aculab.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH 2/5] compiler.h: Add read_word_at_a_time() function.
Date: Thu,  1 Feb 2018 21:00:49 +0300
Message-Id: <20180201180052.32643-2-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180201180052.32643-1-aryabinin@virtuozzo.com>
References: <20180201180052.32643-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: VI1PR0501CA0009.eurprd05.prod.outlook.com
 (2603:10a6:800:92::19) To HE1PR08MB2827.eurprd08.prod.outlook.com
 (2603:10a6:7:2e::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 384e55c2-968c-4146-3afa-08d5699db92e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:HE1PR08MB2827;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2827;3:ygLbnTd60jjShV6fStQxFZDdm7Nkv2vUc1jMlR7vOJoipYGiDj4o2epbi9xzlShP9m//VLktRLSTzE7BDLGGFVog2c4XxOyUX1dQF8mluNVJd2Mf9GeN9DMtMjzrY4uMV0GfnPT5IwzbyrLFMNeoGSMh3UJS29fxAmvJdPbcJstzJhHfj/OxGaOBY4gphtofsEV0V/K8J9gLjCYrB9ha5Ndsy7TkjSzw+kFkvj2K2HsxK2IgYgPKGbAqahLXj/w3;25:OaIzItKy+VLOTvS0HK0w1C4xKaTLQcGdbMP6/qV7to0dpU1gEYrrHEhr7oOBylj3TsFaxZrcZAFH5XS7WURDS+N9nNn/AMCHG0OyHRYZNfOaAm7OyQtUlabBemhb1x2cuCBi3rem/NLosWYveJIP1sw2zsgrj9w6/a/+8LHUQTBDi0nUm8VV4GSgRlZUFfQnFcwIMbM3DIITVW3MUWoEW84kjObNHso3CJWkwsAJkZ1VO6QwDaNp+p8hAG2+R3jBtNCNMpj2Xzr53BZa3Qj4XYOJMSWT6hGnqKFAfHH5EYOf+DJPY1htJnxwOsTPXQLO4KMcVeGtE3f5GesBEEPpMg==;31:A2GA8jz4apEo0lg2yFVAklTAtKgc/B8P6ygWZj/8uACmtKTLaxiGyNDR/Zbivn2OEqTfrHVpkyHQG8G4MsytwEKHzQxTPhFELBTvpzRo+37D3SutYhQNrv2I18TeAMxc1bH0yLt+nZIkZ8pbhYXZsqprLdaauwB+SYhSyWbk5z5GGoq4idXaQmZfDD79z6A9/dA3VJXBhFgTLGaLOzGRhL88T63oDwfWy1hODV5Sd6I=
X-MS-TrafficTypeDiagnostic: HE1PR08MB2827:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2827;20:ct+wA1KWaFRmDaLTyoA2NxqkauuLx7IeiRIBTXIoXZ47BUXVU23E0QuOWB/lqKP2u9oPvTJra8E0KPkes4dt0f7bjDSaSCy7Z5xeRX7sCe0V4ID3vQbcFLd19jb+fiPqZc4qznyBRrOdh+k7tmNBt74l6UpL0J3P/pfDV9Pcqj6HKUBnDzHPbqv4qtg+QVJU8dEHyE+v0c2aaTe0NUsfT6VYZnbXvtKMssHDWvTa7ecxIqtsp2aKNW/35Sm8iQ8X40fnHQT53tgot0R/PRBl5zV8CRq9UUfz2JoMnatGjKXeESTJSWloS+VXkGhzyEIytDo9g+IO1lkZ7jIYoC/VYpDVwRjbYCG+ok3rSavUFyx+jtZwDcuIFF6qInTZnZnVxUvHlACOpbcCxddFXfKCgQFBaRdnI46ah00LDkzRI7I=;4:Nia2IFCr6Qv5tpOT3twIKa0cw2B/WIVK30Tj7XIpOQDtIrtlJtBml+Vsd5aCxoL6Xclm++8WyMB/jvzRHe9StbKmGdqo+PM7gzTd0AETYIRIYol6GfI2tcwzVcAf2ofQK8ry/aoxbbMzVbp1KMesgWb+1UQm1VT6MZSfO15724E0zwdDMo9G7+bN79PpQo5AAFCLaXxZ//dTnKPBD+JT6CcBW3Y2iHzF4qLpUgSWZeyJIwT5gwtfa+H0rgi89wu1wzU4IRDJ0hVNKn6k8ziO+w==
X-Microsoft-Antispam-PRVS: <HE1PR08MB2827728C4B169909E5DCCF53B0FA0@HE1PR08MB2827.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231101)(2400082)(944501161)(10201501046)(3002001)(6041288)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR08MB2827;BCL:0;PCL:0;RULEID:;SRVR:HE1PR08MB2827;
X-Forefront-PRVS: 0570F1F193
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(39850400004)(39380400002)(396003)(376002)(366004)(189003)(199004)(386003)(25786009)(6116002)(3846002)(1076002)(7416002)(316002)(47776003)(54906003)(48376002)(53936002)(66066001)(6486002)(26005)(106356001)(16586007)(6506007)(55236004)(478600001)(16526019)(4326008)(76506005)(6512007)(50466002)(107886003)(97736004)(8936002)(50226002)(52116002)(81156014)(81166006)(5660300001)(59450400001)(7736002)(53416004)(186003)(69596002)(2906002)(86362001)(6916009)(305945005)(8676002)(68736007)(51416003)(36756003)(76176011)(105586002)(2950100002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR08MB2827;H:localhost.sw.ru;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR08MB2827;23:7mLZozpyVh/RnPGPQzJL2eiOmJXugIF6GGg9HO0SX?=
 =?us-ascii?Q?YJ+rV9c6PimmrAHpusTnB8No3ttt7UJlbt+nNaVR1YyhTFHa/8pIWxYWzPVC?=
 =?us-ascii?Q?dQOGtgRwf1Y8UMX+KOifmCBZfhCWUtPiNliHIFo3+lXdqIhy5wtCf4iihoGh?=
 =?us-ascii?Q?yqkBfYdWZ/b6OeCG4BY5bpgfLx3kUj1XqwACXYncFmeIjFUIyrEcJGEOyrXf?=
 =?us-ascii?Q?YhYWK2yYnfoPaBN/JX+Q4+2UncHUfOwxFCU3Y6cjEtP0Wkq/Pvt4ZeQWAeGi?=
 =?us-ascii?Q?5ZDKsLQVmLWVNvBrRSTrlKt+EDvsniaYqsLjoTrjbuOMonjw6zAzaJBKXKsv?=
 =?us-ascii?Q?tZ4i3qjtqfte4nFwtb1LrfhS8pkhUtkQW9coGz/pR4PkTFzz1a4G7ET/4K2L?=
 =?us-ascii?Q?7th68wrX9EcRnL1ScHzNStU//QBXbu/xDFuLKgZ0XHp2GZQ2Hf0v0t0yUm/7?=
 =?us-ascii?Q?Qabm1Zb2kMlhZbDMpBUhcImXB5jw7OJYuxgxvNR7FSyvpkMnZZM0d/lSy/Ef?=
 =?us-ascii?Q?9YoaOC6lUnVQVWBC92fLKfPCC60IpVx/EcNIr7m49qHzITgEq+8A3X9g24pX?=
 =?us-ascii?Q?d4dtfqcs2zgG3kz3qJDug/jsnCUNswdHeDKVLr1tEaBJJnlfFWkaO3Y9UlvZ?=
 =?us-ascii?Q?Z12nsu8w1jbp6JpJ0Cnbt967gOBbf3s4dox94XJI+BZyrHM+evWHF9sV9PQ2?=
 =?us-ascii?Q?U68LnCn4Alwn/KHmowBVUYrylfy0yTWqeBkLFfGFsFerzVwxLzMqNDLTrK4O?=
 =?us-ascii?Q?w/Vbl3nXgo7R7Fu4Ldd2nryXvlTsHGOjjGtkjEjUAurBUdQMSt11B36Aza/b?=
 =?us-ascii?Q?GIqhrxWCDYndB4S2D944OcPCm/Y8xXzPcvQXBaj7kiK75NN1909NA16TLuHj?=
 =?us-ascii?Q?d8WgvsWdWE+uyLojvzx3HjEZAICKVIlZOFJSi1hfqa6V8tl2cR5O+Tx80hHk?=
 =?us-ascii?Q?NMfj0mi8/a0ynPB5dhPj5qHDhGYA5d2wlp6lxiX2UQSv1xFp1kVtiYzdJE/l?=
 =?us-ascii?Q?Riernpzlc7GnSLlE/+kbAQUp2ttOwFQL6JxAPURtyiXSchaF193JL78/evZc?=
 =?us-ascii?Q?yGTAxIpnssWx/dJs4sdBKcVh7tnUKE1xcIczZbZj0iViw9IvRN64b4K9Qiw7?=
 =?us-ascii?Q?rN9LUmSl72j+rohyliAwvpgIU4kWOvYbJBklMagXV6KVpaJrFH+itrlyLv9r?=
 =?us-ascii?Q?D8Qlx2j80S2ZkDKpEE5SMj0Ma0ASxH9aFEUS+mm9jU9gzK8KFFibJ7S5E/P0?=
 =?us-ascii?Q?1MG/b/YhrDbLxUHlO4M754JcsbAGfIz/i+ZIcKepMv1S1yqnPgBqiFiQaoc2?=
 =?us-ascii?B?UT09?=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2827;6:1Ea9+ZCaj8DAMTTxgksgaiJo9XNWukgj1TIM7eZw/nfDvaQMKBIpKVfPW6e27C6khci5S6NgzOMFZKjpjgcKpwVEJ5SJGHoVPDeBVMpMZT47T+aBLgGE1SxkB3L3umUMw4sUlhnpjN1c1KMGf+vaADZY2LgmuCTvuPmiMG7NpRe8ANjECzezlTcx0pU9jq9SPfof88XOLg8HgAa0YBW6NyrX+jNShe35zlOdZ0xW+AN8AvHv2lo4lhhRG+ZLSfwyKpZ1rDQRVHRYAT3SQiPXuTvgBxpqvZ4lU+B/YptgfJCYQgO8tYhqrgNur2OoZaujRYxTsO8gZAbZatzQw/59/7kXUWB8brtb8k1tPzJtmqY=;5:J4v1wwTTKZKdiXmmf4ZPOCZUn/9ugS7hTyZat6pvgkNvXdvbNac5i0ivcKT+kPfp9FgQKfpU1783y4YpqLYJaJ8eBp6ecJRxq3sgwHxwEyVmSK093X0TW8AcZSYiMpCBhs20C6LuJyFM5OTzgFuubp0maATCnJpxfO7LKGbr4Lk=;24:uC1mumCf4LSTF19H6gXwyat3OYkFSSmJJyQ92C5t1AV5rml6Y9RoBN7mgO9nos9+CldZA3e4geL2aTcgFOSLj2zexCccB+UzSiHGd4I0VWw=;7:4oq902Vd0zqCdf03QjGROCes4YV0hiVrLT4mw8IilMyuqf/kWDnoQ/qpPS3EuYBWJ5ZZwspnCor/Qiea689NX+nj8VJ33N2eVg+vsnHMU+r7HCn21rshSXj9hf3MNQLzK74G2Ckz/W6UrAwfW5jagEnB37FOf6uAYEPdKRwq4jdXRJmmKuaOfBoKYO/3SOJUH2VMJwUVvZdYlNEw5bwOQy622gwHzezAL3qdZPipVXulUA39+Okr8TE/MWF1vZIf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2827;20:18oNEudrqVfML/ZM4KLjIV78HgR15AcDPK153IsrwJ1rcfWE1SJpCyd3uiXgaVkCIov18kNeef3oxZTWF4CjvHZDO2e0rQ0G3t8DhyYhxrV1xPg0PKAhApkxEY5wfWq1VQx1LYK4mb7Vei0E+6mKt0P/vSvuPH7ZNfdiay8EE4w=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2018 18:00:46.6327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 384e55c2-968c-4146-3afa-08d5699db92e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2827
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes we know that it's safe to do potentially out-of-bounds access
because we know it won't cross a page boundary. Still, KASAN will
report this as a bug.

Add read_word_at_a_time() function which is supposed to be used in such
cases. In read_word_at_a_time() KASAN performs relaxed check - only the
first byte of access is validated.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 include/linux/compiler.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index b8414ecf9ba1..0eb5bb0902e9 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -243,6 +243,7 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
  * required ordering.
  */
 #include <asm/barrier.h>
+#include <linux/kasan-checks.h>
 
 #define __READ_ONCE(x, check)						\
 ({									\
@@ -262,6 +263,13 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
  */
 #define READ_ONCE_NOCHECK(x) __READ_ONCE(x, 0)
 
+static __no_kasan_or_inline
+unsigned long read_word_at_a_time(const void *addr)
+{
+	kasan_check_read(addr, 1);
+	return *(unsigned long *)addr;
+}
+
 #define WRITE_ONCE(x, val) \
 ({							\
 	union { typeof(x) __val; char __c[1]; } __u =	\
-- 
2.13.6
