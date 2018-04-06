Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756006AbeDFOkT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 10:40:19 -0400
Received: from mail-he1eur01on0094.outbound.protection.outlook.com ([104.47.0.94]:45366
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755967AbeDFOkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 10:40:16 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com;
From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v5 0/3] ARM: Implement MODULE_PLT support in FTRACE
Date: Fri,  6 Apr 2018 16:39:36 +0200
Message-Id: <20180406143939.14642-1-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.13.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [131.228.2.20]
X-ClientProxiedBy: MAXPR0101CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::28) To HE1PR0701MB2473.eurprd07.prod.outlook.com
 (2603:10a6:3:71::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1f12a494-9167-4002-7a17-08d59bcc4e93
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:HE1PR0701MB2473;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB2473;3:yvHF/TTIOTiq8m5qj+Koj88VUDaGYViCEjyXqpqezd/xvlDPKa1ssQljLMt5eyIn6Z3NXvR1acLCUD4s0ep4TGpXtIlAyDLdKWM7PoyyBWoOafzJRp+ZqggHUVuTHXqtKeQZwqeDBekTlhQcdJU4yAXHMIKtNWoK3xoNWi3JqFuDlsJT5t6TtPmhiab/33RZ9cFqm02XCisXRLBDtVtk3fDwOKhRNm9Sp5r37C7Yn9u8v4ojaP3w+DQewg5LwvNE;25:L5Odm8d1S4tXMjZ3umNUrgrqsK4Am6KQSruOL/Kf2xkrVhsFCMHCBTFOkixoT0AK1OoA5RzhUfAWG8kS/PhOaVQu85/w809Hgh1Fqrr8IEtXjWWMs8nh7abThaJ2yKDzX1N05RbBeVksHnXxVNK2MUMGqzPW8ij6PQJfgUhjovNkVaU06uLfO10k3cYK6STGJ49Z21aJJVOVGfODWx5nRm5hm407bw/pAhu/LCztyI5gX9wBv6bZrevgN3PANog95qASRPKHy3yHR3nwIgEMZ86Pm4rOOESuUahWkMUiJFDG5puQ2SGsIXH7sX7t5H5BRyP2Kpx+i4so9jeo2nmjWQ==;31:Ceph8NYWhZIaRr6MKw5MHw77hYJfG37Xrp9LEFa4IwsoLk5vUIuSnCKvDrE1bbGadLLW4Jf94+T7l+PU76BDxgZm8S1s1Y/6kHfraq6euJB6M8dazJqsjJcU7/EpN6AR3YcZUQgSmt9FP26GoGF9REpiwacXSk0+dTasCrkNdsU6GWDcb1L0Q4F4O+SF+kH2dDJV6U6UjuRUYzuLnFqwvf5H9I0jRmSdHlPrvRjPYl0=
X-MS-TrafficTypeDiagnostic: HE1PR0701MB2473:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB2473;20:EmTxqlOZLhkOw81yMBYGQ8uCl2V5tQdgCpZ9SO/dyzGr1uvnvkMQPHiT03Il4ImkK5N3u5Cd4Mr7sGt55/uS6hs5rpCCY0xAREq1oedNVdkIhJZYkYD6plpEmSnu+ZOG7FsvGVghY6igrwCzo5KJZVl/zWV8F95mNa7MdGJQFMWM5ZvmZmTDKtzk8SmaWJCdwJf918v0ptni6ajngg5zapMFdOJP/J3t4FXgi7dsh1kVrQVifxGAeRxnV7biboWLV42h2capmG8zzGhe4TzDRpExceLxWpMpuotfWHdB7+Nt5pUSckwVEqo/uek/bRsXSOOGyGLhKbnuUlhqr/s7F4PSvxemPX69q0F9bBoXCl3K50NkFyH8K6aJSCpmB0HWYboWuC8uggCCra3ALLEKS/UCmn3dlr1krAgpWh6gavXgEJZeoSYa1wjz3H4Zq0Ryj9+RCfRjEuzMTjFNT417ROWa08t6vyEsLoXjde807Um1SMKaf+IQbiSjLth3Lg9HKH8QgXapTmkxjduYnY/APH2ahhfTUyQbg8IogEPAcAfvKjKyPt75mt++22TQwPLRmXacM5KYa0UDPq8Lu2kVH6GePyH2o+xYWPOo/zkkmeU=;4:u1FJSZ6/lGJJMPNPgF4nGKnwNM8et/1EgMGcAT7RWkvt7aoiH/XVy2Xy8NHLj3Kd3412mSE464Gj4jbbsNgrMPYz8U/rAckDcSMD+II04z1QoWUK0trW9io84rl+uBIokN7ZLXpOaUxMsmNYAyId6gjV3b7H+eF3FKlhzeAuvxaVrRwAVujznFsmRoNxyrDspsWYQGXBxSCAgxl8UavAu/br0+8lULciPkqEw55/vGDJ24nln2vDonigLV1frGeP1JHkq46iQo+b81gsu8UOhg==
X-Microsoft-Antispam-PRVS: <HE1PR0701MB2473416FAAFEF59628C49A9188BA0@HE1PR0701MB2473.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231221)(11241501184)(806099)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR0701MB2473;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0701MB2473;
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(346002)(376002)(39380400002)(54534003)(189003)(199004)(25786009)(4326008)(956004)(97736004)(2616005)(476003)(26005)(186003)(16526019)(6666003)(47776003)(6916009)(2361001)(66066001)(7736002)(305945005)(5660300001)(486006)(8936002)(50226002)(81166006)(53936002)(3846002)(6116002)(8676002)(81156014)(106356001)(6512007)(105586002)(16586007)(316002)(6486002)(52116002)(51416003)(2906002)(36756003)(68736007)(1076002)(86362001)(54906003)(2351001)(48376002)(6506007)(50466002)(386003)(478600001)(59450400001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0701MB2473;H:ulegcpsvdell.emea.nsn-net.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0701MB2473;23:RxXnTsXYrKXEe0ONgOgOIzSwPPvGh7n67hewH3o?=
 =?us-ascii?Q?T5omj/9NNPJOOgwNfAwuQj7uGDS2DNx73wQ9pVUKRw6R4OZXS+p01pYlkBwx?=
 =?us-ascii?Q?B39O/6WPhmnhHjb/cQ74KW7TpJyaq8CTvJZn7AONCO3xIx+QUEzPr9HoQgwx?=
 =?us-ascii?Q?nHvh/h433l3ZFykefPMPWFAhP0RVLOOhcUz+nShCZyjs2YHlr7GS/spTGW7S?=
 =?us-ascii?Q?KoFS13kaNOCMH1UTr8psWEde8pv43+vINCye1Qq56pcOus9/vv8g09Bn/JqJ?=
 =?us-ascii?Q?GcycBbscX2ZcaJRzypLTcmjk3jXXBk1+yXmJ5x7PkHX8dptmAQtBG8v/hQT5?=
 =?us-ascii?Q?6Ozlop5oadLlHu/xe3Jn76JjRMHtbZdWx6LRrEIqC+xxe8N85niz1Tr5wbh1?=
 =?us-ascii?Q?CEVWq9m7xsdWVCIM+Nil47HWSfrYc+5u5XvCfe10DeoAqfqzFQq5TRuBwObF?=
 =?us-ascii?Q?uZckUK9B22cL/wAaRX/xml8Px0DV+dRCmr6ONxLFqG18oKaDYHlAwrKLXxkv?=
 =?us-ascii?Q?40Tvsw4M+3CZwTUB7ZNtUbxfGRb2ZLXZd8s3aiJOKRD/w735HJFM3XncPSeA?=
 =?us-ascii?Q?l0yNfbTD2dni3iKaTTk9eWPNkARZhhAj8qakKe9zRCA3NUdkCYBl+iSskJvo?=
 =?us-ascii?Q?Qo5j/r2yaQEAam8Ico1y/drvbxp/KeUSq6+LKWXamtesGVEQlcXkhvLU0IDJ?=
 =?us-ascii?Q?0hg+WNfiHc/Z/AY6YIgKmpE2hKx3CzkP3XURVGllSjDHmvly+77rahHJ7qkj?=
 =?us-ascii?Q?loAX5d9N/U2PI5FVyNLRVGMSdCxDAh1ENR/ia12MpLpQshslgwKrpvhM1x29?=
 =?us-ascii?Q?ZoGzQouZlovKiAj6X8kKHD7JdT/EDHdUE3r9zu0HpiC2OL9ANfGOL34uAKhF?=
 =?us-ascii?Q?8h51ASGCxKFd5uLDuV/k5HRv5pxwEG0ptrdMdjU09/16DlXUskNegd3yF2F2?=
 =?us-ascii?Q?fnlN2uxkISf8+3dPwJZtg3CQBjvBSn36LbroJSvCii5USwtsRrirsdBCjPlu?=
 =?us-ascii?Q?/915RHvVQ9flwnEY4lDgMiHq5t1mYnS656I7ubwRgZOcc7Kt384RJ2wI9ITS?=
 =?us-ascii?Q?RMuPPgToZPutYAYK0E5LDL0eeTkc0TsoqrsVFr5mX3fzCtuEzyYYs1VKyw9O?=
 =?us-ascii?Q?OLhfM0KMFBrLyoFjz/l5+NkoJRiSlebt+Fg+q7rFYzVCUEkLvXiZGIdUmJTZ?=
 =?us-ascii?Q?rBBvk7wJt1rBDWUcbEeEADwD1OjCwnl+Jk8O3OXPS9RhdGwOqDJ/mnABKxfC?=
 =?us-ascii?Q?+uGUfWS9d09bg4MDowPo=3D?=
X-Microsoft-Antispam-Message-Info: eRDE1Ditrp+wDVvmTDQAhQ5jfrisHt74xw3bU5Un+kjW5CClWtbY5FfwM/+lPuADQEG4XU5FcQW+2vN06XlrczRY36ZaCCxA01cY0qfGaRtKIkOxluxs8lBF3Be2yyLkcV3MUJxVbAh78QupELaCM0s/iBntf3sHpBnRZEFUIe4gKQ/WOwqeM1+A1Q7QVsiYe988fdDM4qld37nFqOkjBYwZ8zD/x3Jnxju0wj7nmWTvwbGNCFiEbPphCX2Bv5bj
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB2473;6:WEyjxewyFGPqU0rdQRh0rlAnWU1pegOcez4iqfDNQzx3ka+Fj/PxfwE/mOlxyfjzdtDSzGLI27OulKUkJhN1Ip4I1mb1W0u6uA2wNNPuPjdKK166E3fA7++gVcUGPu/PxQfhAkNsskOUFFx03us+0qceDzOpa1qcCuYUKy7Jl77eN/vjKQFn6r2Pn0P0yfj6hjRW+DLU1Y1zs/FpI7PqUkQcsUe6syA0pSpFWbrR/psigm/bIyvJKLurADE4dAmp1ZeLcY5AwL/qLTfNcl+amEjWh6TSKDZ5jPN0YpJeIXf7nOyLswvloNqpEiA+gQQPSi4cu9+E1wiXZvgOFBrUWOaxwJseCiVKC8oiijl343zd2L0p+uDL8ElUVcFj3o6c7NrBveB6DXfx+N55cjS+xz2977iU3S6KBeEjxhjik1mNauO4m1pqAcZd6CHAhPtbpoeqhLtYQSIyacmapyZdtw==;5:0Iz6UjIKQTej3wdlYb+L3KjJI09C5fRREXByLdydHl4TKeVUiD0b8E/vISeY4YkUXL1TFLE/8i+9YhxjNrsT7AfvsTkF210fBaJaM+yH1IRjMN03MENKF7NUTqwAyJCTTBzTSVjlFH9y+Q4bgafSOkNi6E1o75ocQpC7C8eLtyk=;24:0bmHYUjgOMMsHMSuBnLJjg+oOtOlZswFXekdIxfDNKid6LdTL+YigvVsbiE+4F25QE4OOTBbaPVqjE8eO/YC557ESZptVS2JIEK9jDffp+Y=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB2473;7:u11wLoazyPe52wvNCBlAQXEEYQ1JvRe/NMGaoIITYXu5GSYxrN4QboJJsx3UFmgMY0bjqEl6QKz6vNmLOvjmaaW5KAPhQI8abQHGPHg/Qdqprk2AnM+0JBeogCKAfvh40R4rPfhZGSpa6W6/usPjfkX22OM+LRZ+hwDO4q9ioB6yjX2ctCSWko70ZNHvjnYM/aEbdr+IqoZ+UrkL7yrVVJas1mevZPXdo0qMEA+heLS2TJc9c9y77F56m20v1wpy
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 14:40:10.4538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f12a494-9167-4002-7a17-08d59bcc4e93
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2473
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FTRACE's function tracer currently doesn't always work on ARM with
MODULE_PLT option enabled. If the module is loaded too far, FTRACE's
code modifier cannot cope with introduced veneers and turns the
function tracer off globally.

ARM64 already has a solution for the problem, refer to the following
patches:

arm64: ftrace: emit ftrace-mod.o contents through code
arm64: module-plts: factor out PLT generation code for ftrace
arm64: ftrace: fix !CONFIG_ARM64_MODULE_PLTS kernels
arm64: ftrace: fix building without CONFIG_MODULES
arm64: ftrace: add support for far branches to dynamic ftrace
arm64: ftrace: don't validate branch via PLT in ftrace_make_nop()

But the presented ARM variant has just a half of the footprint in terms of
the changed LoCs. It also retains the code validation-before-modification
instead of switching it off.

Changelog:
v5:
* BUILD_BUG_ON() ensures fixed_plts[] always fits one PLT block
* use "for" loop instead of "while"
* scripts/recordmcount is filtering reloc types
v4:
* Fixed build without CONFIG_FUNCTION_TRACER
* Reorganized pre-allocated PLTs handling in get_module_plt(),
  now compiler eliminates the whole FTRACE-related handling code
  if ARRAY_SIZE(fixed_plts) == 0
v3:
* Only extend struct dyn_arch_ftrace when ARM_MODULE_PLTS is enabled
v2:
* As suggested by Steven Rostedt, refrain from tree-wide API modification,
  save module pointer in struct dyn_arch_ftrace instead (PowerPC way)

Alexander Sverdlin (3):
  ARM: PLT: Move struct plt_entries definition to header
  ARM: ftrace/recordmcount: filter relocation types
  ARM: ftrace: Add MODULE_PLTS support

 arch/arm/include/asm/ftrace.h |  3 +++
 arch/arm/include/asm/module.h | 10 +++++++
 arch/arm/kernel/ftrace.c      | 62 ++++++++++++++++++++++++++++++++++++-------
 arch/arm/kernel/module-plts.c | 53 ++++++++++++++++++++++++++++--------
 scripts/recordmcount.c        | 17 ++++++++++++
 5 files changed, 125 insertions(+), 20 deletions(-)

-- 
2.4.6
