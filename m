Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753047AbeBASBg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 13:01:36 -0500
Received: from mail-he1eur01on0112.outbound.protection.outlook.com ([104.47.0.112]:56704
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751708AbeBASAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 13:00:54 -0500
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
Subject: [PATCH 4/5] fs/dcache: Use read_word_at_a_time() in dentry_string_cmp()
Date: Thu,  1 Feb 2018 21:00:51 +0300
Message-Id: <20180201180052.32643-4-aryabinin@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: a598fd77-9070-42c4-4aec-08d5699dbb44
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:HE1PR08MB2827;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2827;3:N22aYDseapggNwPGlTqQon3paPQU4WNdpDsDnj1Qmvgf5BHJ3/2L895rT0Q59TNNZ6qj5ce3NShMs/QTHzYyzYTgB6keVwCYfy6n1PaVKj1H8v0fC15gDwhCXAo9S+GSJUVrZGfEqYA0PGqyc3Cz+m84XULOUWG22VoiOHBmaFytBcG+/tQEbh0hI2xasd6UJIoVvlXhfnEep1QjhWjBY/cKAYp8YYZBIHe+a/0ReDkpPJ4sOEJp68LMPDYm/jZv;25:SAtyJG+giceSfxstQP3S8DR5gS9jhxW74FAdygM5AMqI9/4oo8+M6Rb+29Bp14qtGbCkFWuU/hiSkc71mMbkkVf75RX4mM2LZCXj9FF22oZC6yeQRZuPdXbfQqHVOvLDr+pGiUrPxdUdNZqR9uHyO5IBBdEYR/va8KSv0N8hkmKWKGYEED6pqe7aArHhxWX2KSrXnv6/W5ItJtUHpNCuijH0cMGVIhnCStNf3vUoLvtRCXrvb6noJvbza+fP5HDDixj/WHhLcO3m+ZKu1DRtyzib0oH6Y6uwZcR58CEk0F0SXUiAZaEnt/HSKAFwKJFKUTyJlhKLzXmR+pylUNiC9A==;31:FPhNSh0WYLsVNVgXVCCPz0gN9P0ALQCEbiizafRI5f5wuV6S2OxBOvbQsP25pIan1TjMhlQTDw8Z2Ri4HgVYIB+MX/nvAyZo3zSV7F2sF6lnseKiCaGC5j9o1iGUGEQF2SCk/HqIUPeiSPpuUGDlcBCOzaFSuocMzqbbEnvJWwZ9/8c3WUoTN8KUsXnhNpvcwlRGT1pbeT/IMJkyZ8rdEaN7/deSsjPi29QGailMTWE=
X-MS-TrafficTypeDiagnostic: HE1PR08MB2827:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2827;20:FbjVMaF8vMxTtpyWALmCHSyR2gkJOAYYhxB5ws/P9D8BPqG8I7rlkF4AiEqsnduEdqWew73YOO9e/JcUCvYXd6YReSsaGU7342MXZ0Tj3gRAO0gYnEXjK+rQnLsv/MjYHh99LR89aYNIiS8eHTs89HkjFyxSUiK0k7ZufR+a7qkJft1nWVSoDop37aZ7cFRu74Z+NsE6RLHQ7DLjNHPzoSsu6uLhOJuBXbMQWgs1YLfWURBMLcdUR+FBAiHJXHteXu+MQ+/0Cyz71SEWhg5d680pvaZBckzvGapzmRrK+mIDnaYeVTHBMH44fbudupUWZedvlWvPCyEmAOFozTamjwpLkdMc6uDCVcx07LntL8DeQ0wnGmpyVsHVclCm/4pou7reKRO6LKw4AiysgcwfEHxKUJ8viCICvl24L4p+j/Y=;4:9yEVnuoyN0vmxpVeqXzjedctXbWo76h27+iWw5iT+2P2di43iS/vSC1fjD7z9gh+gzgeV7KWdEjLvir1ApDcWd8xwFPR/vWPoUzngjcDoB8bBrSdkEhVVrnjYosm4USY147NfV+lj4kwrf7sd0eFpPhtnZZZ7uEnjVg73bKfx70jR6R2pzktquL0N/bWP95fbE78bho/WiaB59kOghIvp0wfkl6J2CYUjgbNaK0jyqVJbRBdyCq2zoBYAm3maf5DtihwqdA3cdfOZvE2gDsfMcjjMsp4HtniQCXteCOFKMyJuuadtShjr4wi8gF4/qKG
X-Microsoft-Antispam-PRVS: <HE1PR08MB282785CB89E17B6166074C06B0FA0@HE1PR08MB2827.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231101)(2400082)(944501161)(10201501046)(3002001)(6041288)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR08MB2827;BCL:0;PCL:0;RULEID:;SRVR:HE1PR08MB2827;
X-Forefront-PRVS: 0570F1F193
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(39850400004)(39380400002)(396003)(376002)(366004)(189003)(199004)(386003)(25786009)(6116002)(3846002)(1076002)(7416002)(575784001)(316002)(47776003)(54906003)(48376002)(53936002)(66066001)(6486002)(26005)(106356001)(16586007)(6506007)(55236004)(478600001)(16526019)(4326008)(76506005)(6512007)(50466002)(107886003)(97736004)(8936002)(50226002)(52116002)(81156014)(81166006)(5660300001)(59450400001)(7736002)(53416004)(186003)(69596002)(2906002)(86362001)(6916009)(305945005)(8676002)(68736007)(51416003)(36756003)(76176011)(105586002)(2950100002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR08MB2827;H:localhost.sw.ru;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR08MB2827;23:DK/lrad/eiacB9tzxHvoDwTnQ3NczY8czFuONzfmA?=
 =?us-ascii?Q?3+lK3gFzNzWzjpgwcjDU9Z2vSFgSH7iADQxUvih/W3EBPEYN4fQVn4lIm/it?=
 =?us-ascii?Q?GDcfIhXyYihObawAxfhKbC3CQTfAUTXASOoEUbHlGU5ce1BGDJA29EYF0sSY?=
 =?us-ascii?Q?xakfYG/ZEjZo/o9epM4zuRdHdSqCJvjV5Elx8Jj8PXjE/cc1qV9KtfVXxyJZ?=
 =?us-ascii?Q?1xfxt3CHsGf3pQ4K3PHFn8wsSOxFsEt3bwPFtXtxhXx0hMtOydrfHa0whTBS?=
 =?us-ascii?Q?MchYky2WRRVl9TtDqCUwBHCdl2vVlGwx8fRLubWMoI1cMBcBbuFO8Y8O/wXL?=
 =?us-ascii?Q?/NHmj0ToKBWwBKkenAsX/pztJiIf4NF+sGdyLuTsafF8OtGIl+9pVH/BHPi6?=
 =?us-ascii?Q?WRn7vdtSZBhdrj1agqpstMpr5A8C/UQ5Clwcak6aksxlVTtsGLWZpf3zOHu6?=
 =?us-ascii?Q?Jg95s19n+h9EyUo7Q1m7xrLt+S+x7NAuuoS/j2yDhEaUGVaTcJBP9EjA/LW6?=
 =?us-ascii?Q?mSRJKlgExAhPTLxNmnppyRTZ4wpgBT1noDDt22ccRZIekaeuuMXIB755E2Vv?=
 =?us-ascii?Q?vTciDaKrnVt5QXSxDCGN4sxbtco5HyWIr5bQYJjOq3sbT0z/RzlTM32Q7APW?=
 =?us-ascii?Q?QAh8tPw8iEWGaDCo4hjK4OMwo4X3JivvC6XRux/nmdYGfXFT3q4qQ+HQlpKy?=
 =?us-ascii?Q?+HVg+8Ps5AjE3ZL2ZZ3WS8GVKCHt2sNsyWpgV5IwOY9xnP/uhsG5+AJHpXmg?=
 =?us-ascii?Q?9u8pmcFp9MBgiaRkX3CzvSzeEzecR/tsKLkZ762A2UdYauEA2/ix1Uq/BmzV?=
 =?us-ascii?Q?LZT8CO0E1Y2eW2N6TSdBHKfv6IyV8qf2rs7K4mlk+mu0wsaqDeLoAdqdOJAS?=
 =?us-ascii?Q?qcKJfeaGQ1beGDZjiuw243SkpyqsnoMDZWWzoqXNCc6ozdV7DBXv1IPgr1+Y?=
 =?us-ascii?Q?6ap88P6Q+OJgD0cj+1FwUvItxZK9nvL6OKVcDd9lNZlC/InhlvrmCCSkHMmZ?=
 =?us-ascii?Q?nGTO/mlmbJ209zJfsvTjU6sR+bqppjFfuTUXAxIdk8mS9s9tm9+D/iwU1H36?=
 =?us-ascii?Q?3KVtsFss3jhRuyRs75ZY3QHPbsMWqoqND8EFUT5xiWganE3LJDeBDIl9/kau?=
 =?us-ascii?Q?zpNbl9oXiCqJDr6Y2FWO93Xp1T00y0Bk9LHHzmFVoFv5GWt+42yrnABmvk5F?=
 =?us-ascii?Q?2OYKcTZUvLJ0OR9DpEX6mXAjTAwG1rTg7X8cGq+tXjkc/rFQGUZzsHTnUgMB?=
 =?us-ascii?Q?i6ZGi0bYYmKfwlhF7DEb8PIa5cGb7b2nFxpJ7qHo+rmj9p1vBxAlw6kmbcyK?=
 =?us-ascii?Q?gb9C0I9yVpC+30HbF0beDw=3D?=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2827;6:egGCE+5+oQoxtSs+dLiOxKr53YVz6u6zxH4DvGSBD3jFVSNNb4hd0kfmCC2OdaU+3+MMqRRPOpJF/fEHYSLD4zGnoerMvlCHCguYO6AxsMhyd0k+GZkqKU69qPqOSwJ+RLEHgvG4quCI2EYRopRyqmCsKUtEndwcRiC2az2Mn7Fk0kCg6FfQwNL5gzRByjNKVTLXdwjrP9y48zjAmOWEUKCDiOukGiMEp2SS2teOYjoKmT00lsvJ3XOuBaFpKiFzQomKQSWf/CsxbJYH9zmQCIagY6/iHB9AbADo4wYI6i0FOQ+Hzv28pz0NVYwY6yQ/DcHeC4v3NuUiuh3XcCfXk7lzBOFwpc1iJZXHxbguh0k=;5:hMSGhb9PGNixmp0Of5JGOhgU9I11iPMUrld9EtRav2wIHPmnMSlmzLYvhy++bi/RqV6nBNVUtAQvp1v9ZByaiz8twVTBLdpoGfK6XqJsCUb3mAKSyhGbu5pM5/iPeJDubPabICmTIowKDNTmSqx+/n3e++5UPRsouK8FHO9G6uI=;24:TdB2kwBBKzj1y7qz+cE+Lc8QRrKIYXPl+uJl6CQdvpmnksF9znpQjZZ2Odauha461m2kTUEveaWfFdP+sU5oJs2qwChKMIylQGiX3qwaXHQ=;7:jPSjC0+ZFKXQdtdqgMr40o3yWJet+i/HcXIWuvHfUtOO7eSIN02Pz5shzb7NJSVL9OThrR1Qpqbe6x4ap6um1UG8m5K3gPvpGK52hMIpn5aBB0DUZfXtL2vHTbDoBzMBr34nPtSA3cZw1gD6Vu/tfpkIovwOl5F7RjExdpO/OI+IadN8NVIxLyVxHeCgl3Qyj9Th596lwSEC/KP73L8wJffNlYzJVVbpsXs1ed/bHz8qTqfb1W0d/GVmW1AL7fWA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2827;20:T5FaRnH2OIAmL426yIhmn7OMhopZFT4GUpfFpUoAT2phqWj4oZzz7Esa6++rI5hdxZUUEb3KMEfR9yGrDrdU7GOecHu7lTZh2hK+e8w5sCasnXVPMshC5/XlfaiDp0C1uVMYO/os3/se1XWiQAwmVbXID2AJMy+lSNwiOMs5HmM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2018 18:00:50.1327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a598fd77-9070-42c4-4aec-08d5699dbb44
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2827
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dentry_string_cmp() performs the word-at-a-time reads from 'cs' and may
read slightly more than it was requested in kmallac(). Normally this
would make KASAN to report out-of-bounds access, but this was workarounded
by commit df4c0e36f1b1 ("fs: dcache: manually unpoison dname after
allocation to shut up kasan's reports").

This workaround is not perfect, since it allows out-of-bounds access
to dentry's name for all the code, not just in dentry_string_cmp().

So it would be better to use read_word_at_a_time() instead and
revert commit df4c0e36f1b1.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 fs/dcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index c99812fd54b3..195999c8d1b4 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -193,7 +193,7 @@ static inline int dentry_string_cmp(const unsigned char *cs, const unsigned char
 	unsigned long a,b,mask;
 
 	for (;;) {
-		a = *(unsigned long *)cs;
+		a = read_word_at_a_time(cs);
 		b = load_unaligned_zeropad(ct);
 		if (tcount < sizeof(unsigned long))
 			break;
-- 
2.13.6
