Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753857AbeCYRub (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 13:50:31 -0400
Received: from mail-sn1nam01on0065.outbound.protection.outlook.com ([104.47.32.65]:36592
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751750AbeCYRu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 13:50:29 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
From: Yury Norov <ynorov@caviumnetworks.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Christopher Lameter <cl@linux.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: Yury Norov <ynorov@caviumnetworks.com>,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        kvm-ppc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] smp: don't kick CPUs running idle or nohz_full tasks 
Date: Sun, 25 Mar 2018 20:50:02 +0300
Message-Id: <20180325175004.28162-1-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [36.84.65.149]
X-ClientProxiedBy: AM4PR0701CA0037.eurprd07.prod.outlook.com
 (2603:10a6:200:42::47) To DM5PR07MB2906.namprd07.prod.outlook.com
 (2603:10b6:3:9::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0707dbe5-30e8-4b7f-4f49-08d59278e357
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB2906;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2906;3:ZS8gJm58npSwSrIGk/XbljrKH5jt3lZ8XLlDHj2wtAxSM/hdymY102ZdMmj+wjLV1RYcJJdQROMJ9TdKGnUGyjHtzstVIAKx97gpN0aFMaYUV0dde/g9IAfVQPqUoxCKGvX2lCmmTmZeE0tlw8Xc3ysK3Rg7jqe7S9f8k11VuUCE2Tx/Xik6bsm9U+5RF5v4V+i92oqvVGH+8+0utEH6kz5KmE+YCrncG72AlLNophcgKGcJLdL8x5EGcc1dlOOW;25:PDVg2nyrEGVYZi/hQvRBjhitiJg7jaaST8t0WyU7beVrr0nAzUywIIf1KpePwZejM6+GONsIVHqCjuxQKcL3UxW2yeh0M/HSTnLw8fjVs555KJ0F8up2OJkv404IFH8gIpmrGRJAuaJcobHNDDNGEb3wcJc3U6wBbVJxFui+F4HfT/7Bvb0mwctcBhqwB6BoxR3ycy8dlgsnsedOjeI6vrdRPD4k7dodY78GnYgjGTbiGDa5LWhEPOCQD3ByD+TS9wAxrHnqiUki8x8YyeClBnwxDx9KYo+ghq2NXiyvY3jnI6he34R1CyXt3dghjpnyZX/aWfve8mE1TlrUzSo9cg==;31:5AqX6X9V8NgmBLZpf7M2xYGtH9haWt0pXimfVSawiQSt64nwbHXjBld4kwsmzRDsaA0LkOSmLvpFcDOmPJVDKWFToh3JyEYbJWpiM4+sMrqbuGchp5Mrcm7DFhdweek1+ZIAiWotyKQTCs+rlqUaRUv56gD0vy+TC64JN8i0jObJvSbQ+hfcQe3dLvpfON1nh/DWHOfeM7BD+eIW/FeaQ1pn6frAruEpjLa8SnQbhRg=
X-MS-TrafficTypeDiagnostic: DM5PR07MB2906:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2906;20:w7szMTZIIYMIXr/JVu6B2fKb4wImTi2PrlXlLXwp5TZA5wQkwb2bF0Zg+KdLHsa3C8asc2FzSDdt29hRizxmC+AHug+LalcdV2gsPU4bUh7XHL27ZO1W75tDEFYBv3JKTnOXr3zvzvtc1DbxT4DhaHdKxaVNSQQVBtXorQN1DQF+ESqZfmKP2bdzh2EoXC8qqyHLM6/Tlg8e0fZEhQP68eG5fPMzZJzd7i5jm2TWbY52OSrE1VcB5rPSY62kMFbbjXGt2YRydYljszOj0OSrDY+V62W9cdcpf8ydpsDYZQ0hWsPqns7ntuZRkRBCwcaDqXlt49YfRAzpEd7ghMu3+kX6KHaMJnIbT/dTkU+30GKrynen6AsE2TCkAVFpG5XjhDXvLK6Q5O6cOYiV3yNxhN39UuOFiCnc2jOpvLW99QdUNvPiTjl1kN10XWHc6ovkbd389VSqrVywBVZFoGUGKUH1AeTbVCWRjmMd/6i4KT/g+AS9iTvnBrbMe8mxtuoVSIchutUxV/+0mwEv/kWJ0f/s5srxnkhUGTz5aiB/crzFRI0ftht1X+MsSHS9xyJWmTMssn+m6pk+n6EMo4E+QL2rGMCLuldGQxI/HCVoQaI=;4:vdw3rw/lcmvO47rZY4O5IlyohaCP8HT7DKlSZauq/rKSUjbBw+NHWR082vBKdKfVm491e5N/Dm7kFYugP2bBQH+izp7d7mIVtqQi/tlRc4zqZ7dEPHvmWhaO8tYBKBpHgfZmN/6qYzeKdiZGlrlQQhTOWIM7CQ/nLGfBCQVEX8uBLojGqk6rL1Z34zW5prwEAj/fdrwavSpxiHrcTunbPzGpy+i6UibVZgb3fZEvuVZGLLx7ARIrt+wwIX5LviahoSkKavF50ymm3qiVji8L+oyCL21U0WKKkOnw9No6ri4XxXFjDQ69gAsW7+XC6jYv
X-Microsoft-Antispam-PRVS: <DM5PR07MB2906615BCCFE143606925E00E3AE0@DM5PR07MB2906.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR07MB2906;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB2906;
X-Forefront-PRVS: 0622A98CD5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(39380400002)(39850400004)(376002)(346002)(366004)(199004)(189003)(42882007)(53936002)(48376002)(16586007)(26005)(76506005)(51416003)(25786009)(52116002)(6496006)(386003)(4743002)(186003)(110136005)(55236004)(106356001)(105586002)(956004)(2616005)(1076002)(6486002)(97736004)(16526019)(8676002)(2906002)(8936002)(7736002)(47776003)(81156014)(68736007)(81166006)(72206003)(7416002)(50226002)(50466002)(316002)(66066001)(478600001)(305945005)(36756003)(3846002)(6116002)(6666003)(5660300001)(4326008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB2906;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB2906;23:CqdOyLHJ8eIUpc2uTh++3wMUm6YNwCaMX1Icb8jdW?=
 =?us-ascii?Q?g3xSiZXtoe2sc2vvW4/VsvKksei31dSUHECdHueh4ptxNwzSPt9DXI3PrU8w?=
 =?us-ascii?Q?oufvZf/p2OuBOkJgsRv026wS8fY89T4eBv5tOm2256mj14nWB/C+bjs/1Z5l?=
 =?us-ascii?Q?rDq+IqHE/nawyt1p7Nhd3YSNoifaBc8td2OsN52umL/t2xq+9J3Cou1+znWA?=
 =?us-ascii?Q?hJphQN19r/k9jy7NoKW1G6Sxve7qFhYJzoq7plxiWz9ZxfneWl8/E58mS7GM?=
 =?us-ascii?Q?jDYD1JSa5HbjNlkTZ5GdttwWKvEExiKayY+fzjm9Kuw7kIayUKP4YdXNPC2B?=
 =?us-ascii?Q?/oCUDZT+vJctoj3KAYcRnxJM49rWY3c0ZM3k5l8IEyCUWfINFsP87hwxuurs?=
 =?us-ascii?Q?QJg5WhVkpBMJWEBoNLaO65Ruj/W9a/ijI91cdVsVSZfLliwVj1uCJjFfuwiZ?=
 =?us-ascii?Q?g3MIi3w3hhE0qpE0U0CEaWZc1SZhiUgXxtt/3WFusSXwLGoum5TIvTotQUV6?=
 =?us-ascii?Q?HT4nVuZtREI6ke/9O8jO2h3XP8qhruEhov6VOe6HZkO91CEemqLmYSnoOza9?=
 =?us-ascii?Q?K4Jiqm/26Fm5BqimvnkarouIIL0JfyhSRTw7qyVOK01PT2PBTRhNlQloQpI0?=
 =?us-ascii?Q?/2L/bKm0qISKYYtOycoHAftgSXNd5HopPLK9WoQyHIywPmhWy2+MnyLtHHIj?=
 =?us-ascii?Q?jjkGNwGBR/bYdBGqT/staBL6n+9Swhzyptj3dz/YddRLfPrNp/XINRc99YWm?=
 =?us-ascii?Q?X2znl/jANP4jx0UXzbsSXgaJlk5cP+uGoauVkwO4e8kwtcq6o1qz5g/h/C66?=
 =?us-ascii?Q?yJS7puh3tDHKvqD3QBQ+nyMioED7HprgMx4xkoc4buyiCDIImnLsUZS526m8?=
 =?us-ascii?Q?3QdbZe8jiqDdTBnLQvuRKFg1s+KpxAm0ZAGlW9w0/S3UTv4DlTH1cI3bLOx4?=
 =?us-ascii?Q?nrjdCMgkcIEQ18GP20dPMwr4lS2QBIE/XC55WrXcCBI/vMJroPN+cNQ8Z4d7?=
 =?us-ascii?Q?az9AInfLt0TsLA4paR5HySBFL4Xkw73JGa5DpTXVt424ZJvA7+riyaZLhYbn?=
 =?us-ascii?Q?ldQ9F9+R79aVizq6LSn9FbIJO3jqwQ28ECAswFBH0aG/ck69BkK3PXSwfJFg?=
 =?us-ascii?Q?b5tZwpB+ytIWT4ZzOUTVRZYct0aFnwDs9NE3acO7VlQsLk+bXRDnWIRtuj9E?=
 =?us-ascii?Q?mqH6P2lLDPxA8RszuV77wre8VdrqclEMMdBgfwSS0btK54paMqt3dzvmggF4?=
 =?us-ascii?Q?EFThIQ7p9kDItstnlY=3D?=
X-Microsoft-Antispam-Message-Info: Pcie6aUudw9oVsUWTNHzKecxTtXimmjVS4UYDZ5TIFZBuD25XleEWCxieKkfBUx0R5raw162t2bFyry352K85mmzJTLgaZEt0uJz6z11a0+F/WmR4viBv+j3iWVksMn9QpbIJeXnnCfc7isjEhEK0BHvgdBxudk4GM7C8t/KahlwXSTXYL2865ujN0gx6i8C
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2906;6:CWeSrtyafDUApftrqpE9h6+/OTVL88ACh8BP5AAqXeooU/Y8EOZMjVlaaSizTjbjqwmN3IMQrVXIAemyjJrCOSsHqb4kBEgNcxU+v6Y+9fCa/GBpH7bb5GOqFglQP7tRpP+SEq8qBsSlDDPwDFnujareLuDMJA5FQzNxGobwaeGr3dR/y+DhfwmL9P+QxkRFUW9prjxmIWDPsaD3vTIrnvq3NWAjq8St2woVwhVo2AaHyQaXAbYPSsJg9mCz1LdjRHLcYwj6kx/f/vHdsIoMdvJT3wY+FrJ5TNUpsb9CfdBlTSCnNotlJMg/CsFRgE+GI4DYBw9Kf8VakMI7wnCF/knCvM7toZM93MsjsQ2IKss2ZvCw+Ulyt/9uc45WPneYJmfa/d1n4R0vO7s2NCSVq/d6ixEL2MfdiIrJkJO12UjZs0KDqMUQG5cuSBSGLCVsFPBA+wI51jgjoHv6N+wn4g==;5:PamMTs44GVJuNnK4gcZ6QRhHaT8mm1mHlJfA4WBVw9lnbkNB3oAF0OAbHu8TzF8gA3Mr58wpwQSc6a9kPvunvBvE4FYFPYcb6WjGAo6+hY+/bNu/ZETXlaujLeSvyc9qMpNf6qcHkIEyYjgXh92UIzW7YaALfLcxbzx2Hqvubb8=;24:HtOkzc1itinauGVSTy/aN2bmipzjTIDSvIoucH5tDBRNhg6X9VYHjQSXw9Ujs4AdN7Nwi9yvnnMRHgElLROh0g9eQeLxvYeCyEVV5yyEQ4o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2906;7:1BNo5KXKnV5x+vyF6Ejn9m02xHRPKAQSJH0F0Tuu+ybobnPea3wk5sVxuYXXRjtlhbqT/iFxRTB9LLRIYKV6iniNysMlkyFQ2QRvNx7OQAm7hL8wZfkSWNgRimHTQre+16k4+wnGI3dhUW7VCCHDm01bTdEBhUAi8YRB3gs0NzRPqAal9pq4uwVLRn1ypt38Jr9myRBzRD3H3pDy/le3unkOPy7lvi4RX2sYpYZiMhdo91jpwMaT3thg09od3uav
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2018 17:50:24.1454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0707dbe5-30e8-4b7f-4f49-08d59278e357
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB2906
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kick_all_cpus_sync() is used to broadcast IPIs to all online CPUs to force
them sync caches, TLB etc. It is is called only 3 times - from mm/slab,
arm64 and powerpc code.

With framework introduced in patch b8c17e6664c46 ("rcu: Maintain special
bits at bottom of ->dynticks counter") we can delay synchrosization work
for CPUs in extended quiescent state (idle or nohz_full userspace). 

As Paul E. McKenney wrote: 

--

Currently, IPIs are used to force other CPUs to invalidate their TLBs
in response to a kernel virtual-memory mapping change.  This works, but 
degrades both battery lifetime (for idle CPUs) and real-time response
(for nohz_full CPUs), and in addition results in unnecessary IPIs due to
the fact that CPUs executing in usermode are unaffected by stale kernel
mappings.  It would be better to cause a CPU executing in usermode to
wait until it is entering kernel mode to do the flush, first to avoid
interrupting usemode tasks and second to handle multiple flush requests
with a single flush in the case of a long-running user task.

--

For mm/slab and arm64 it looks safe to delay synchronization. This is done
in patch #2 by introducing kick_active_cpus_sync() function. For powerpc -
I'm not sure, and I'd like to ask powerpc people, is it safe to do same
also for that code? If so, we can completely drop kick_all_cpus_sync().

Yury Norov (2):
  rcu: declare rcu_eqs_special_set() in public header
  smp: introduce kick_active_cpus_sync()

 arch/arm64/kernel/insn.c |  2 +-
 include/linux/rcutree.h  |  1 +
 include/linux/smp.h      |  2 ++
 kernel/smp.c             | 24 ++++++++++++++++++++++++
 mm/slab.c                |  2 +-
 5 files changed, 29 insertions(+), 2 deletions(-)

-- 
2.14.1
