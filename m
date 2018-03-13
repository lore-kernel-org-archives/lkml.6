Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932852AbeCMNxl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 09:53:41 -0400
Received: from mail-eopbgr20139.outbound.protection.outlook.com ([40.107.2.139]:45689
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932731AbeCMNxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 09:53:36 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com;
From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v4 0/2] ARM: Implement MODULE_PLT support in FTRACE
Date: Tue, 13 Mar 2018 14:53:12 +0100
Message-Id: <20180313135314.18780-1-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.13.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [131.228.2.20]
X-ClientProxiedBy: HE1PR0202CA0002.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::12) To DB5PR07MB1319.eurprd07.prod.outlook.com
 (2a01:111:e400:599b::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a14802d4-0087-4de0-d8c9-08d588e9cf8b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DB5PR07MB1319;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1319;3:QwM9I+lS6+t7s2873QkddMUniAMNq3Vls/DRyfK5UdSFnoFgdLebt+XlXx9CUnZPDURa+hJU7nNLX6st5E8z05aA3Sn70tS3kc513tNnBOJNIMmDWY3TwrOO/HEQhWl3nwZqFStn+DbHWkb0EFSMDmcHpY1zB9vrfW9T1vTKPDeVONaEOguDIFiO7ea6kO5FGdp6jvVfM8vY9Kjh5FUJTXv6ORIJjWypCclX0cfUXwwaQWcU7soQqIXhRD8z0bt2;25:MC8PNpU4HHir2ZsfEgqnnNhrQozgLLTMdbzFxRFSUdIyuswO7EekA0lBiPo2sJyhxnYr/QOxZ6A3meDcdvJIWnFPAgm4XrcF0L2GRIX4JpDeZzjqFz6KCoaTElR82UMXtoYCyhCba9kFvUieicjncM5Ab3IpHgjOAkk9nQv4zA+9xL8X6A0ho9rZSuxirqRXCLHx9TfBAa6S/9T99SgEe0yeTWK+05/gQWiM+DmJGHTdBlwptrcqAfcIkWelyZv8yNRhbqpxMW9gD8QT05huiYaAZuvVdwZIfSpvdH8hhY4QIvONnCBK5Ui7GamUqV3U85PCC7y95zZCKeaMcrYflQ==;31:uhzQfzr3qBfQsy6wUXmpw529JXmwzmDvafNRAENOp3A0I/SKTHKuZILWQbnRcLhzCRDZdkLrU8IImM8fG3FasCa5YAMgm6MjVvGngFYUl9ipDANsHb+wz/5JwtTagui71Cwtc63wG8FduuoDoGYPuB8zxQ2y5FVtfyzwfI8Nwc1a5HyOm2qfelsvYBCp7tDPgJd4QC+eucrXiY5ZKzyG5Wd6HrWPF84u1IvJXZEiX7E=
X-MS-TrafficTypeDiagnostic: DB5PR07MB1319:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1319;20:fyIAozJuxLaT6HGxJV5l38fr3YDbJdMNE9Pyje55Pssa2/mlOImSC5KgSymLtL3j0TqnA3Y58RrAYsBD1o30btVZmR6zRoMCxYnSf1TY5sTyg4m82Cf65wy3sYvARZzZ2B0ahiwux5vv3MEEQzy8GK6flhcOQ4Yu1VFc3DpMNmjg3HsbXbh+U+BuHa9+YTMwyzA4FCR3BtIcpTy4UNKuMjjjTNJVDOYyL/DetqDloqcv/LGuXquCnksYxEGTNgEcrXPphuCT0Tzj+rF5naW/S9kzhQEgi8jGPcMJ0rlDWczKdVniErgUpHURBf4HSWb2RS0aF4rB3fBEik5ugex4t5h3e/+PWUueoC6ttK6Abjuaah+IvTf8kzuPNbZ2wnc42oLqXkUvrgD7ciJ4x5toInWqYfBpSgEgH7YpCNvvpmJrjnagt4RmREeRJ8N9p6Xr3tzzBG1EhmtGfItsNPvotfyZv+jxZW94SqGxL5OuTm4KNK+7h/7zJ8xOAMuBX7CnNYAJeWjd5HS6k9I1LzI2FHxcQDbe6tNXegpMjxyhiwNqTxUGbedxmtiT0iurzV+rX6fGoggdYqZ5Oe8Sjorgarwvu0Xi0oFtEhxIrmw0Z0c=;4:rCKA976dJqSilNJhxFt370hgAqn+KK/+RZrcv+rno3fF9Q9wF0LUVfKyxlWysy6JHBkza4kCUS9NuC9ib1+rVxpjkDD35bisM9TKhxXcN60gZz8IZw5m5X1dQr2TH0DxXz0RnwTjNR/GyugqKeFA5JmDGkQRI8aCRBRri3kjr5LsUAwPmMvZ0n8R3xL12d6nZa3R9lsJwbP1NnKhLIpfe8v+1D3Iph+YUJ0K7NyL31SsMu4Dkf7DzvGSGZIjDwChCSwN5q3A7cuuY4e8hwbXfQ==
X-Microsoft-Antispam-PRVS: <DB5PR07MB13195F4E871B34CF8DC61DBE88D20@DB5PR07MB1319.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231221)(11241501184)(806099)(944501244)(52105095)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DB5PR07MB1319;BCL:0;PCL:0;RULEID:;SRVR:DB5PR07MB1319;
X-Forefront-PRVS: 0610D16BBE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(39860400002)(396003)(346002)(376002)(54534003)(189003)(199004)(16526019)(53936002)(52116002)(186003)(2361001)(2351001)(47776003)(36756003)(86362001)(54906003)(81156014)(81166006)(8676002)(6916009)(7736002)(6666003)(6486002)(6512007)(97736004)(50226002)(2906002)(105586002)(16586007)(305945005)(48376002)(8936002)(4326008)(5660300001)(25786009)(26005)(59450400001)(106356001)(51416003)(386003)(6506007)(50466002)(478600001)(316002)(1076002)(66066001)(3846002)(68736007)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB5PR07MB1319;H:ulegcpsvdell.emea.nsn-net.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR07MB1319;23:CkLxNHy68YGM5478OfzpaG1DikfjSFR5+9V4LLlyz?=
 =?us-ascii?Q?bcSTm30RjFHtcgovXV5PZbI3g+vYAVacRpA0pJ4EgqI7FK/PufgI80NjDCbV?=
 =?us-ascii?Q?nETpTKqH8vHWPyrm/R7o8KVY0sh9wz2A+ns1/EGgVAGPk+bl7PfZGkgYsa8H?=
 =?us-ascii?Q?MoEbf+pPMzfxtAfk5758MyWo+hG2LxhORf3ICQ5NtNAHevqWiMdc24XDQXKS?=
 =?us-ascii?Q?so5VWfef6flQOB5MUog/fsTvw0lofWbiWr4RjzbB+pH6uCJNaRzUICshj+1z?=
 =?us-ascii?Q?LcyxJhBBnrsQhbYpFXJcfUi6wRCux9MgGoCvrGFH4nysdnA9uAYJV73E/5LI?=
 =?us-ascii?Q?fGkdBF640pga8TwpBGFbv1QEFHA3kiLcih5WrhptAx3YywClrHhSecfr1QNO?=
 =?us-ascii?Q?gSFSr4c0CFxyA/TzWqM9EhBqH0tH/B0B+hrZs6k5elODQV28na7WLKFYDCx6?=
 =?us-ascii?Q?4vxHkeVgjbz4V35b1QTkJ+zC4viQVr/CPaZOHD2wFaHSwRNtKKTCG7bNuzuI?=
 =?us-ascii?Q?gs5dWKOLUFder7jQG9itP7+L/5j+V6WfyZng2H6FBA7Vm5gAXpulbHNt9if9?=
 =?us-ascii?Q?nrZHMYxfjBmsa0gLbYHJkQmDuwU43NQkh0EKju2tWLyrhMYKKGVh5FsUqkZ1?=
 =?us-ascii?Q?9Yq2PRj6JtEAoVihmJDE4N81nVw2gT85/jT4sTuZ7uYVOeWYreHkS//D1H96?=
 =?us-ascii?Q?prArrlQAzPbKjJ5gQEQPQhMc+p8uVIDDHknh53+lFvWN939lsBXrsk9dcHCc?=
 =?us-ascii?Q?nG+B8ExY0MxvchDaH9jd/AI+a+sKybqOaoCBPWz+XF/ldlCgGZurc0F6/r90?=
 =?us-ascii?Q?Cd1UblIsW0BdW2+2bVnfEFDvu+KlakpH4v6WKd0pPSaJ+nt3Yp0r02QqVvXy?=
 =?us-ascii?Q?1sIdqmu4Hc2/oxiIavKNWpkb8roXOHlLA+K7S02JxLFjYrk2mghSZHKK7Nh4?=
 =?us-ascii?Q?ixJs3YMnVjvtNyWmuwn79lEIDQ5Vgs8y/oyD9i2MWGepjlI08HToRh8WJrOc?=
 =?us-ascii?Q?kczgh/WnlcSOcfQ1LFANvbiCQzxfVV4c1fGguDAWCSxoiHxDw1KXPS+BJSSF?=
 =?us-ascii?Q?OBUsxtAcaBuIlbviqtzbmy3tN+JJ8BOlo4SNfuAqr0KD6115iWhXHJ8mrfLM?=
 =?us-ascii?Q?hh04xEdNr3mZ8+SLYptwBuyikAeutv+KyNG5rsU8huLI10zAfSuO+tblIwVB?=
 =?us-ascii?Q?bB2oXtv15k0pEI=3D?=
X-Microsoft-Antispam-Message-Info: LiKPvnwnxtRkfgCuGxQ2nDmHzkQhLGA34Q92+LOQZskTBIgUUGM7BJWB3fy285p1NeHEylJrqvtjRVSS1cCFejGHeqOCoN1Kmhk+yKbsGtGDBJ55VmQRMRY7suISsH9Wg0Hiyt/5r0u9EVoMLiWM//lrI8n5Px5+RNlZa5ymzBfV1g6vO7Fpyz581jcHiS9PwQ8rBWpBjw8N0Am1MPeYEj/8fvzBqVYX5nBpoHwOuXizzniqkfmDxWGZIi7pp918
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1319;6:ZnqvOULLlmZx8T5qCpMZ6Dzs98hRYPZ9V9BfLRJoRmXEK3bYQjRMSJIjpujhHgAjg0nFEnBeoMMDeoPtZ26rcHmP9eJvwZCebI9/3CVzMwv2EMfOonMJkOU8Coa7yYBTSJo4ZPqegybvgc7k78Myh8DxUUlmFCo56dBUaBghW6zEsMrnd+Juyv4WCzdDEGwfvXSzUVuSD+ZABiifcqXVgamGRtqYvS6QdtNBUk9ngp9wdRrqH4pIq2mgbwfCBsTq4RYyIHfC+P8rnnut7vL7Oz2njijbnRiYJ8OxDbOPnhN1GbHjniVOFOlT9nWtXLNPpBxnU8/gxWeWY9SJFp64jDM77y94YaMdyvBIdTyoow8=;5:m/ykAYvFM86a5cjx/CSlTvxSDhxGcZeofSvd0he3pMpH8rWIclMkS2jLBsgL2dYq94wD+6OM5cNc8NWnq4Kw3ATx6w1XS/cMKRwwyvDpyV3T8wN1O3BnFyiGQMgtiEVPNFiY9gAJ6tR/ThlEXaKC9kLGcuxZZZJxcaFWV5fhfSU=;24:o05/dJO5Ob9vxCAmWZqVen0vsu316VNtxEAioWBujh3AwlkNFdiSuIN8qRUTJKRemP9yjhvYKhU2zgyUE8AU9LSXOJDIb3Pr6IXcbVTukIs=;7:S/sIjFDQDHi8m5t4dl0072AmfDAdRxN3BEPdyQoLQOyCUfFbod5eqUVWyaKnAMIDEMCPoSgKiz7OHePwda9zOQnBq6/ZWLUoOE+j/A6dL5rZsnkhpdfQJxzP/LB0DyrLIyJSGJAQYba+LC3tN3Qo2p40lL5YAMD9Yj4rsP+AFLtDoydNQHvPaW2Ql99tl1P4yF24GPPIGyLG1e6yUB3NdCzFsEOXW4R7+zAGp3nrJn+AIp9IGScjVsgoNkNfw4Hr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2018 13:53:32.5982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a14802d4-0087-4de0-d8c9-08d588e9cf8b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB1319
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

Alexander Sverdlin (2):
  ARM: PLT: Move struct plt_entries definition to header
  ARM: ftrace: Add MODULE_PLTS support

 arch/arm/include/asm/ftrace.h |  3 +++
 arch/arm/include/asm/module.h | 10 +++++++
 arch/arm/kernel/ftrace.c      | 62 ++++++++++++++++++++++++++++++++++++-------
 arch/arm/kernel/module-plts.c | 52 ++++++++++++++++++++++++++++--------
 4 files changed, 107 insertions(+), 20 deletions(-)

-- 
2.4.6
