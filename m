Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752845AbeBASAu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 13:00:50 -0500
Received: from mail-he1eur01on0112.outbound.protection.outlook.com ([104.47.0.112]:56704
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751378AbeBASAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 13:00:48 -0500
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
Subject: [PATCH 1/5] compiler.h, kasan: Avoid duplicating __read_once_size_nocheck()
Date: Thu,  1 Feb 2018 21:00:48 +0300
Message-Id: <20180201180052.32643-1-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: VI1PR0501CA0009.eurprd05.prod.outlook.com
 (2603:10a6:800:92::19) To HE1PR08MB2827.eurprd08.prod.outlook.com
 (2603:10a6:7:2e::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc260802-d073-486c-a99f-08d5699db819
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:HE1PR08MB2827;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2827;3:gKB8xEco6WFMV+eXcQ20e9gz44PT+/3+kiWp9pstRF3JRIux/JCeJGy0qsbuO3aLukKaUXOtstQBnqxL8u/Ba0rDpwG9wx9PyEf25pAI1ZQ+bJEC+/TPp2nUkG9x/+ke0Kif+YE0eYwLrjgGVPYTB8d8FBPp5Ld5FU6L34cpn+Sw5TCX5lRWC8UOC4Rp40EgKpt0q9s/rbVzWIoSkj+/HE9T2X2wm1K1V995f6gAAW8d5lZweOJMTvNg7+Sw2GkH;25:fOBWLXjUqEk0XsW6vy6RlcEk1a6U0k82OQ19ke4m5+r4tItON9jks+/6eMy/dv9XkPIWdC86l7URI/NUZQxZfogqArbq7Yonu2oUtOJ2Rn9l3nhr5zjRlfMdI7MVW4B3S+a4XxBnzCk+taPjriA5bxUV44iYk/Nu+zbWPVdOLat4Xdz393BPG9gr/uEWOh5CrVPt0GwCbLzuciswQs4mZ7eoAuKF7oi/egYgeV6qF+jsJt8+GEMqylYW4XHtzuY/5IXOYnjcEV4a2RK8CFgjR1RizppYZXsKAJX/0e5URhGC8eKXpbdu9/19Z/PH1Z3mxcFWhQ5Iu08HFPbbO3KfxQ==;31:ZHspDrdtqQJFQTyEEFCzvoCIkN8eF8UQqq7vp7kOEa/iw5Us9unb3rj0ysxpHdT8V5X5vMjSqE5QQ9QWIN0QKWtoCGRT/iDtcFEHQK6kEK+1eMYlY1Wxa0C2pozQAHYPI11V8WabwKTXMwr10UeBSr4oUxbab1bdo5VVzXZcEp3YFsUk+rp/IQkIs25FZASKpWmKPr0Xl0QG/RupUivBG9gLatdMU9o0ZYe4djzgCn8=
X-MS-TrafficTypeDiagnostic: HE1PR08MB2827:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2827;20:BIC1/PTTVXcWnMYpYScP19wvkkz0j6dwXMOfTGwinIcpMVGpqzk/ISby1aB5hLUk/tETPCyANlYIXR92K2qdOywTiUWREEkMnpH/vcEGkA/O7/KGOd31oSAG2v12HVTrh/H1O0XWUam/o7NwhfHdG1IRuAoBQ0spopeX/jlkGi/ia2rWAETxTTDrUDZmjbC/em0WhxbzHvHwRTYk0NyY5rAlLyfqzbh/gLycO1KVBLwNVmihMWTtfq2TvwSALC1kmXppewHLbc917a8mWjtN0DKnS2eONfIIVJwDFIxv6dx/NbNYDf14TFmDZlUPwIbw3Tgvb6R1aPOZiusvSZbzmbJZz4V1t6r1HUSZxUxQ25g0fJBmAJRKpigx63G8YxFxig7LbVKfgoT+Hgzaq7uk0vP8NrZYRwUCbFhWAcm8SJE=;4:PIffhVSKBwbOPoPeqO6xHGbDWa0tdHzIcZoEHgHBrBNNTFEaGaXnJbHfudaFE15kNXBQb1w7f44tZ7YLbIIs8DXj2Q0AOq9upeZzJPqJEFJYr8ouX5Y64yHtaPoUGDFYdF9n/izCnjnfoXXdjP2xUsQt/3rxaxCSERB1+hP1ln3RcUxVBkRtAnadyFE1NfpEDeamtLE5QW0eJSjM83odOzWCwrpeMOLcPYv+6X64I03PAnFJzbi0JkGdxhThzj/PaNpknQJjXSREZryvR+E3S1UI4EoZJUwbyyP52QLYWRWNUPLjZ0HhEq4v+ut98+CQlcYL1QHnt2j6VeW0AL8snpedcB6zoBohkx8Skb59uV4=
X-Microsoft-Antispam-PRVS: <HE1PR08MB28271447800949E4851654FAB0FA0@HE1PR08MB2827.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(22074186197030)(183786458502308);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231101)(2400082)(944501161)(10201501046)(3002001)(6041288)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR08MB2827;BCL:0;PCL:0;RULEID:;SRVR:HE1PR08MB2827;
X-Forefront-PRVS: 0570F1F193
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(39850400004)(39380400002)(396003)(376002)(366004)(189003)(199004)(386003)(25786009)(6116002)(3846002)(1076002)(7416002)(316002)(47776003)(54906003)(48376002)(53936002)(6306002)(66066001)(6486002)(26005)(106356001)(16586007)(6506007)(55236004)(478600001)(16526019)(4326008)(76506005)(6512007)(50466002)(107886003)(97736004)(966005)(8936002)(50226002)(52116002)(81156014)(81166006)(5660300001)(59450400001)(7736002)(53416004)(186003)(69596002)(2906002)(86362001)(6916009)(305945005)(8676002)(68736007)(51416003)(36756003)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR08MB2827;H:localhost.sw.ru;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR08MB2827;23:ViGvbwaFxLrGNshBSA8bjbS+b9kSIx8DGy0KEadlC?=
 =?us-ascii?Q?0mvUEuKW50DeA8LmPacJ//UVwz93f0CLvFXk5WbbERxkohHf3CyoYcKPFbq+?=
 =?us-ascii?Q?wE9DXRBI6KB5HjyoosfPkjTZnurve0hThf04aR0oJMzlnlYUFGUTkX3cE443?=
 =?us-ascii?Q?IGrjoV/4NPUiUCAI7VSnf0Repc0iKSduCJT5/PMV/44RvjdtR6Gyz8B33i5u?=
 =?us-ascii?Q?Wbty6DijHkAUS/oYoxESCJmpwekbFKWkCCzS5bqixL+w2XZ0k7rLQ0nOQYVK?=
 =?us-ascii?Q?HCEpvIo/YrzkBbGS8wBibDUZVfJB1ODj57tkv3JKtxvs6v85kEBkRSWPehTJ?=
 =?us-ascii?Q?Dp4P+PWSiC/UgWhViCfLiNtonpsRAo2VuL/9un+hB4cBgVMTaWEjP+mV5zZI?=
 =?us-ascii?Q?V4Io/ygK7uIBoJOAT7ZrUO9XuT9TNBcvrtGjpj8PmCy+JY4GYuV680jIMK0H?=
 =?us-ascii?Q?+g+CRJr6P+Mwef3TraifVsfzsnOvFvRaWiy9Bns/9DK5WPelToOaDuB3e5oZ?=
 =?us-ascii?Q?3vvKNmmz/do2W6YYPB3TJFu95Ky5jjh7Nk9HD+MK0jbyo6VT9398dAZciokn?=
 =?us-ascii?Q?DGx3J0/82/ek+2r+AlGlcND6vwEh1Z0R+f9zzCdZKxzPMQmGrYPnCng1Zh0i?=
 =?us-ascii?Q?dd0PFAYpR1PClbJ/4G48KwvGjuf8BJP2Zsvi2VlHPcCkCljFDaQSch+0rVmR?=
 =?us-ascii?Q?QaQsQNPV4opDPTM2FqJZjcxv3+ByIT5sdC379i3fZXBiVc6SOqBSiZLim4H8?=
 =?us-ascii?Q?HFUm9uwC+RcIO4GSZWkKIL/jgZ5poUpS+jRBXrtccin99D0N8isLUFGdBytO?=
 =?us-ascii?Q?epD47T/JNcDqw8NR17WnXE7QXRZ6z2zlssNERlOLXX+vCB75HGnfLY1RvVdZ?=
 =?us-ascii?Q?gjY64Jt1EJkBsHwwRisIDi+Gd7cXwDLFL2TRdGWK9569pPVSufxkg7rQIqCN?=
 =?us-ascii?Q?6FRlBWBVqhaKGoFBH4N1K2wpU9Ws3FaVcr1/vgvTEyowTD9Tl/957y/S6gUa?=
 =?us-ascii?Q?d+lw1nfznkVb7ApVga6Md3mym7I0pqptL74HR3pl2CocG/QvXpRdHaFObyGR?=
 =?us-ascii?Q?zmIDVv25lNHGOPgdvbvSM008bwTiDH+3pf7r1j53QRlHJdDy78Y8KhaiaTTt?=
 =?us-ascii?Q?la7jKM4GPjH9zqbKmLdyTW0zgtKwlcqG5ijs7YDE+ILztGF/0YnzISW13bzt?=
 =?us-ascii?Q?C6hSBRUOeiUeLO5BkQ3dzho2yNmkqiJ8YcjX7/R4mItf6pwpfGkGrC8AwvcH?=
 =?us-ascii?Q?pEOeceT3/KR0VvNWQcw5CxxK+G5AUhGRtF8/RjWHwiWSJLxbrs0w/CkVQ28D?=
 =?us-ascii?B?QT09?=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2827;6:mjoWdNDRuaQNPgETtQmyRO2m95jMQtqkQ4NA/2pTIQkhBB6Uf0UpQv2gzlwDRh6cSBZ7Uf9kyEGSk70kkLEycH67rtmqmTFkkma4m9PuCo83W9A7wBMIegyra7idXO+UULSapUcoHtCpi1sJqzFSwcsxaEnwKM7brbA08SvRKqz0kv6YWW50WD8NbnTQMKHnydgE7WcPdYPYvv8K0EuqQpFkHPgM5GtSupP6+MxytZMRPo6u3O5FCJWAupA/9Jwq7M2fC1/1AmuBbbTMYPSPF+Q0TCJGhtY8hw5BvIUYkxqcNph3v21LoDRPLJwz5kykmIyYfZirxv+aePZeVvyV6TUha6HDsSqWlo2QkzqJvAo=;5:BLFL+AsKg0NYnznDCZMFG9QBEUIrMXmoLIn9w/gOyd5qpYlXWG2SP5wNLOt0qLrMNQFbnYT2hVjd3s/ldBuQcxz50s/l+KJ28+yJ3tOveluQTSXuOA/4ZRsU06+PH7Fi5JFR0iq/dDAYTgvQ9oKmDG0PGtZGZmKmmIXtMJtbWB0=;24:lIkJfgq6WFwiMZ5Gixjz8jvDqbgxViiUJQdTF0aQGSJyolq51ofg1kQ/dVCHWSvuyX5ly9IEwV+6NGzpGKrSOPgrE7pIIlxmhI8KZQa5WB8=;7:G7T2ADvlrY9hUhWGbtf14pB0yAXBEgeA32MmI6e3h5Uq7F/MOxZJxPbt4piCBWIwbGvbxczmKZitpufJcd7n/9+75RlQxMN8XMos5+RtHkLg72Z1itGrz6qLyYcBBLken213pOVrXYA6IhOuVWd9SwiAglTWgNxbePt+iM87KNztYf8gbvwXDNLi69P9/F9pBQVcRuyHMFGXAYsvyykaiRNuS7EQ5DlSIZpFYTTCDHr9wp7CBROP4oibwjdarbN7
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2827;20:PdEdlIt4CBa2Bpb00PKSYALmIT8hl1LgD/kPgteltQVSxfNhdOFOClkqKnumOhL8NsOSTrZEOJLWpYjq8zWTkpPf90BCFUC7T4ZyHq6KcDr2UdUqiMwM4RHUPJ0lqOkM7hdlUwUCEHoXHIkMXy0jQd2gssYWKsuDiOP6kwJvip8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2018 18:00:44.8202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc260802-d073-486c-a99f-08d5699db819
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2827
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having two identical __read_once_size_nocheck() functions
with different attributes, consolidate all the difference in new macro
__no_kasan_or_inline and use it. No functional changes.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 include/linux/compiler.h | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 97847f2f86cf..b8414ecf9ba1 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -190,23 +190,21 @@ void __read_once_size(const volatile void *p, void *res, int size)
 
 #ifdef CONFIG_KASAN
 /*
- * This function is not 'inline' because __no_sanitize_address confilcts
+ * We can't declare function 'inline' because __no_sanitize_address confilcts
  * with inlining. Attempt to inline it may cause a build failure.
  * 	https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67368
  * '__maybe_unused' allows us to avoid defined-but-not-used warnings.
  */
-static __no_sanitize_address __maybe_unused
-void __read_once_size_nocheck(const volatile void *p, void *res, int size)
-{
-	__READ_ONCE_SIZE;
-}
+# define __no_kasan_or_inline __no_sanitize_address __maybe_unused
 #else
-static __always_inline
+# define __no_kasan_or_inline __always_inline
+#endif
+
+static __no_kasan_or_inline
 void __read_once_size_nocheck(const volatile void *p, void *res, int size)
 {
 	__READ_ONCE_SIZE;
 }
-#endif
 
 static __always_inline void __write_once_size(volatile void *p, void *res, int size)
 {
-- 
2.13.6
