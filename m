Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964925AbeCENig (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 08:38:36 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53834 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932954AbeCENi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 08:38:26 -0500
From: Roman Gushchin <guro@fb.com>
To: <linux-mm@kvack.org>
CC: Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: [PATCH 2/3] mm: treat indirectly reclaimable memory as available in MemAvailable
Date: Mon, 5 Mar 2018 13:37:42 +0000
Message-ID: <20180305133743.12746-4-guro@fb.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180305133743.12746-1-guro@fb.com>
References: <20180305133743.12746-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:ec6d]
X-ClientProxiedBy: VI1PR02CA0076.eurprd02.prod.outlook.com
 (2603:10a6:802:14::47) To BL2PR15MB1076.namprd15.prod.outlook.com
 (2603:10b6:201:17::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0de66e3c-1f49-4d44-c301-08d5829e570f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BL2PR15MB1076;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;3:Pn6SVUG7H02kJd67+O6clksHoZkhSbGpvRzhGS7h/eKp//D4ZDFm00dZGP3xYz7Juy34xlHetQ9Z3qNeIqaKKst46wEFscjAZvsAlvCXCC1LLmD1ZbfVpKwOwwlNValRZ1cfZh/u+EO98xE5fladAMp8KcBi4Vo8+tV/kkZb8bxAyXXMlkNhM4JcMs7PctkVSYgNB59OYCnZl0zF445tdy+1o2bvZ0a0bXQejdZzcZVIYMv7OWGMAKKVNwkHffK2;25:Fiv1mr8H20FHG09DYY4WXqTPrpO5vo+mDyDukcEZIM6vWwdIsAMw8kKDmZxxUIlPEDhxI/dJ5lbGNXwQHK/LwHKelv6Ki7NKEkCMrKyBDqoIP5J4DQx1uCkvTJ5mUuZlzU2mYZ37edpd3jxFmdxjldSKepzyqX60+nPV/vQKxdlZBSp1N8sqxF8bZ3w6eLVvlVsl1r1mLnkO6mg85BieLqvmt+brg46ZbHpkcWsGkIRiElqglg6Yy5uwWchnxuhRld28ub6jiTcPep42OMnrihOgJPhK5ahFwy7b0TutgBi/K6tovmslQazSMhU+dOq1NT5VLV/J0uuOWh0HNWFZZw==;31:iqaBl3GPDbGjjpRuZr+8GPc/o5x6tFFE4a4EzOrdjxK+Ulc4rYJpYe8L4EX4EdzrtPx8MY2NVRzcdyEh+Jx7rNyRZYnTGl1jQjyWHDvp5GFQ3gq27ADv9jUiNHtizi3HJ8Q6ibtgYRzJZLyRcp6Q2TWiPd3yN52SIOVy3WfFqyMYXa0rUhkhZ11ShyF+PwkKhXsqH/RuWV6i6SuHz16A4gcz4ADgh24/qIBGlACql5M=
X-MS-TrafficTypeDiagnostic: BL2PR15MB1076:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;20:TDQ/8uP0J4QFwnV84U0EaSSZye8XiRKyy9oUrdDMdXgJP0YCizmhFE2Xz52DL48T/XI7c9SH3W40vYnEjp9cHFiOG1Jn00+t2/AnkqRlUoEZ8B2FyvXUsps11KmW+6mAtk3XS1gtvai0Ai54n5RXQlYH7+4hexOaO42thXkGOWL2huOSPKkwBNn0ECHu2lmiKFMfPyXdNashT+0MF80BKfAhRbUCG9qmkx/ajf3zTyi7rRAB3cKTcXlj6ISZFUjAeIQgoz1Yt9i2J0jQKFcOmwpFvuJBN0g3+vobS5UQNOzTRCWtW/YBXIn9NuL5E6T1l6GUUbOPEHgQquBRkEXFgKtuFJaTQS58ymZ8sE0fiOnPyflGFIUPHcwGFfzedvD36bSqgsiErWuT1XndRdqCI6fYGdFzClEbu0yBZ1XVhPwApO9gfTBdGfIyrv92aLwakXTdy42XV6Py3YmKQNtMS37fRRtajRHpPm9VxK3vfO9aZBvWFJtJKxUFx5nMaSYY;4:YauVVyDybaWocToRGf+5WLrEbN+CfVvRXOWnekcTjStlLlWcb8SpQ1+7q8x3yc3VkfEAkxRvLPpp9h0hN07wzaTtx0kG4QM1cxedb2zY4g2IaSEazngVRAj6d8RaWWiM4bclpV/IlE614cUNauCXq/V0k0ewzIuokYn57VkniviLbi8raVAbGgtKWCMZK3rwgKA9Q/54I01AhgcZl2mHrHlCW/kNW9veTpYJjQ8pDkrBPYo/QZpBMw/CY8HZybR9MwDd1iaMnRHzE5xdUExzWamWz3fSGDSyHSZRSTiPfpND8t29uZXu4pOhDmvR4UaNIuSmvc7td++HbBYUVQwzrc5z4xBPPDH9D1kKe3yJAAE=
X-Microsoft-Antispam-PRVS: <BL2PR15MB1076C99FEE9BF084E5A9F3D8BEDA0@BL2PR15MB1076.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(11241501184)(944501244)(52105095)(10201501046)(3002001)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BL2PR15MB1076;BCL:0;PCL:0;RULEID:;SRVR:BL2PR15MB1076;
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(366004)(346002)(376002)(189003)(199004)(8936002)(47776003)(50466002)(1076002)(50226002)(48376002)(7736002)(16526019)(186003)(4326008)(305945005)(8676002)(81156014)(81166006)(2906002)(6506007)(386003)(2950100002)(5660300001)(2351001)(478600001)(36756003)(106356001)(2361001)(6666003)(6916009)(6116002)(6486002)(16586007)(316002)(97736004)(54906003)(52396003)(76176011)(52116002)(46003)(51416003)(53936002)(6512007)(69596002)(105586002)(25786009)(68736007)(86362001)(53416004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR15MB1076;H:castle.thefacebook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR15MB1076;23:7H0Ift8Y+MbDuCyepBRpQxubIRIJFkAtXxwyxgkdN?=
 =?us-ascii?Q?djt1mobvnD2G6KtNdBhSDKkod5dLzTF5D8YFJ8/TbKvo9TvdgkajcXpZIsAA?=
 =?us-ascii?Q?GWyXTEZnwA9IPe35SjvyIJSDiWeeJrLcxeRymlXpln8HX4TSg9+pCnek7HKW?=
 =?us-ascii?Q?+kdvD78njHxTy7u9YDuE2GlWE/txbeYAoeEow12dquqEO+guG9hyD65UgzZX?=
 =?us-ascii?Q?LR39uHK4+zd4qBwKhSD9GB/jiphvtcpHO0pXCTUokmyiELBLNVi5cboWnZZT?=
 =?us-ascii?Q?tRS19Ou9/4LpB7Pq+D/gANnl6lmhYrVTlQhcLIWf/dq6YdvXumPR94IUU/ip?=
 =?us-ascii?Q?1EvpAUlEM97TRimNQqEl85VpgcMhgomobhartkF7vI/7nu3lEsFL72T4mjJ5?=
 =?us-ascii?Q?+YMi//hzOdepB78GSzYpKUhsk0wFi4ZxmP/gDj7razUr+3r8i43B6GmexBbr?=
 =?us-ascii?Q?YF65qP13UQyTVG37gRDNheyIUdRzmUXg2gOVWNpYkSfjn3IBdlTQ3mliVA0v?=
 =?us-ascii?Q?QfphZYlX6nIe9YRUFrP9l/qyh3DW6PPT+O5N7Jk1bozIWy0NEh1mf9xywVWL?=
 =?us-ascii?Q?XhBAbvwvNwn7k+KaOMlCVnL7fxu2zUsStnoG1XJNh2v7gC5RdLjhXThg0UTI?=
 =?us-ascii?Q?sWXTsUHSDLyYdxn57PBpjACyUnyEjbUq8eEjTeohpuNnjdqCEqYruW0Y2LYz?=
 =?us-ascii?Q?hZDMRpJSt2JuYGuLIxen7Lkmjh7VOrlVE9fCU9Evhw6sROPEBYGa9YTWPu6l?=
 =?us-ascii?Q?/UyHrVNIbe+9jto+MZxufZSrVl2dhdjmQn/zpzjlWOjF+7TfazpxrHeGh1+W?=
 =?us-ascii?Q?I3LNjIYG/SR/nAlHq+OzlHhb/dkvi3Ki1itE4Wh0rQvvHsdUDA6R3pO2MxrJ?=
 =?us-ascii?Q?qE04iCqUVYP5iSGiSr/S7E3oS/vYGNy2OvGUZetFX97//eh9Q6KJefVWjD6M?=
 =?us-ascii?Q?7KdV19xnxqeSzNUUyOjaUhKWcM6MQIkNlPuojVLfQOzmLRIpY1TaJjWbF1ge?=
 =?us-ascii?Q?n2uLy14E0mQOwHi+6b3N0CqYaTu6u+u/snvfT14HpRN3PlqBrB701PagnLoj?=
 =?us-ascii?Q?arxhHZC/iAkWf1NCbzP3hm/CFP7E6KmjJm6tid7H1mxXggFWi/kIDwtWdqOa?=
 =?us-ascii?Q?U3pjoyhV5W4Prg18rE7XMJ70X7WbVG7+CTInCyNqTdOCc0E5PKnw8gOIWKAH?=
 =?us-ascii?Q?XVdmQq8zFJK7GPkHlzVnmmIAIFrM4o/QIYCO2TWx8XlevP32T5dT4d1QQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: MrMptHuYtaGIh5e9N3ZfD6z3aNLQGH7xIaEcNhWEdy0yjC7Mg1ATZYzy1l2Klf81soc94L5VhVRMhZ3i82RIUwMZZiuEfPnEQ4w83NthisAlOhR8VLZD0IrdVFBasarSEJ1PmYtai7eogojzQSf8L5Ea6S7vbIfesGcFbHD+z5yaW70U4vq+kqO9EZHYNIf8
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;6:PIl6s2cqh03DFAG0tis3jA0SVQfrx2kkVff328Tcn4NLA41szewGmJXaHODLduqFVEKMSdGH7pK2WphIUuUewrklXkyfVzATtBeJOGmSm3EX/WMg8zCyaEP1bevV9KMUswF7gZfFbt61suVxvwp0ntAGTMW2igtFwq6hxesOQivReG+A5A8lmwbQ0l8izSNYBbugAqYSaFWDHajZcc90zw18SGystoraCKgt/U4Eenm7KUeSoiSHtnLXVRL8yiXcWXDJfarAX9753JNiaddHPOaEj35gGIlO2eZxPJzHBx5UUUJqo6eY9AREvT37cm+9qKuynxX+AdzvWqeFdO7H9EcyWkmQiLVpfzg+9hUO23E=;5:/IBEFnOPep4WQnj0cmVSrvSz+9JN7vt7BkWtQQoeQQ8QqRbkUq23FysXgkYXX9UKiTDHesljawp+Djt80j3gYifNejtDR9uY1hj3w3C6SVgd/Ewgf264zpHpXigJtrSSEalLNh4Zp6qhe7Ja9ldqr+x6zaF13WwNNYLYGHiN11s=;24:4f54Mtw93BWBAqoclYSs9orlnYA4BqaUZhMWKu89FJWwOWox6wIM1o4REp/UKJN3c/pLQh8l8hrBUN3c4amXkoc3+BjXjk3iClK44v4fBiM=;7:7CUE6Jwo4BMrbgDA00dqczAzWaw/j9/yuKbmyIsm5HmLwgZ7mslFvk8KGIQyR/Huksa7HeKd+LhdhA9YNUOmEJr/ULoj74KoMEBnb6H3rY9gWK8xzTkdZU+Dtpj9x9SdF/bGR/J1QM0DnFCyzefqGfo0RmtTBv+LPFLDHU2EMKlTkFgQUMbndTy6b55dMhsmKk9aCtCIP+ECeh9pVsif4B5wlW4eXOmtdIse+dk9ALWhDVoRJhtKnOxy1cWgf5OH
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1076;20:3tQvQJJXs5Fq7xEy5DLemXjGVAzfrnapz2KZ8XvoqNirqJKIgkjjJGFSPwpPj8B8DpCEBVFQN+ZJ4teEDV+97479a2hD9PnVUTciL1FAWIEg/JKiyRPXHFFug5YXc8J1pMBXjj1sfRwOuRMMdJTqMrDec0enIyMPkxYpOv2wo4U=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 13:38:10.5043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de66e3c-1f49-4d44-c301-08d5829e570f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR15MB1076
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-05_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adjusts /proc/meminfo MemAvailable calculation
by adding the amount of indirectly reclaimable memory
(rounded to the PAGE_SIZE).

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: kernel-team@fb.com
---
 mm/page_alloc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2836bc9e0999..2247cda9e94e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4695,6 +4695,13 @@ long si_mem_available(void)
 		     min(global_node_page_state(NR_SLAB_RECLAIMABLE) / 2,
 			 wmark_low);
 
+	/*
+	 * Part of the kernel memory, which can be released under memory
+	 * pressure.
+	 */
+	available += global_node_page_state(NR_INDIRECTLY_RECLAIMABLE_BYTES) >>
+		PAGE_SHIFT;
+
 	if (available < 0)
 		available = 0;
 	return available;
-- 
2.14.3
