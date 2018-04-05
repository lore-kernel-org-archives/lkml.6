Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751488AbeDERS0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 13:18:26 -0400
Received: from mail-by2nam01on0050.outbound.protection.outlook.com ([104.47.34.50]:22028
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751259AbeDERSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 13:18:23 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
From: Yury Norov <ynorov@caviumnetworks.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Christopher Lameter <cl@linux.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexey Klimov <klimov.linux@gmail.com>
Cc: Yury Norov <ynorov@caviumnetworks.com>,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        kvm-ppc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] smp: don't kick CPUs running idle or nohz_full tasks 
Date: Thu,  5 Apr 2018 20:17:55 +0300
Message-Id: <20180405171800.5648-1-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: VI1PR0202CA0011.eurprd02.prod.outlook.com
 (2603:10a6:803:14::24) To CY4PR07MB2903.namprd07.prod.outlook.com
 (2603:10b6:903:26::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b421be42-be34-48f4-7479-08d59b193ada
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR07MB2903;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2903;3:qQsNvU7LCFlbxmn2Sjlpe38ADa7npVf9JqDPcUOD8yVrrMpWW52A25sUtMku5zIDc9bdYJaSRTC2L/v7mRJwvC+BmnVt6rV2BzaM2/xw43QVtmEWbQCD4d6XJuPOQrN74R8Pdn99hWs1Jv0yzGrnrtI9mwZVcjuwN+n2ykQob54fPzf/dJHPS3g4HbhxKN7kefHiIqmUvVRPsHHvEqyJh1LyKxV/4AHK3cQzg2lC2QMlBpIU02aJq/HBvCTV8via;25:iIRNW+THzXCv+FJTK5nJ9VIOnnbVfcqmoRYD3LBRtE0uOGcDN1fGAAZb9kjrD92OjNRcNYoKKxJHu1v2shR3+Umcz0V2q7X6/Iu3J+VBWIjwy61ajDiHNTidEmVLRSs/56vlKhUspzsYKFSZSQqT5Srdd0CLif8epat6loR4a/TbLqly5bsbP1Vb4p7B+LXoLx/4bahINDxrp/4ngLV9y2fBOeSteyvbCT6t3bQsnet1wJEurgVnX7o+QDUfVWa++a6tVYRtoHBIAFb/HHCdgmGFmnLmIFtw9USBSXmzdD3MOGM/REMd0ItAOqnUeTIhMTK54ovEx/L5fWb3M/Qoiw==;31:EaDWSuUt9wI1iJPDPGZviD8aKqGzNvF8R2RoyexuN9x8YAEVaXGnMfz9TzBVBsNJtE/Jcjs0rJ/4paAdiXSTNeA0rsfXJXlS0hnneW9u2fPD+fcmeGdU/IZXXd/Hn/Lwyis7YiPNNVNBLtHiqieHpUXvw23rkssDHBCCdj/kB3cDmnBzKEPRWhRsTwo/N78wC37bJChrCGJs7+n1NgKmIyU42QHqPOfggxiF/5Tj7uQ=
X-MS-TrafficTypeDiagnostic: CY4PR07MB2903:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2903;20:RsxF/h30mjY9rF7Eritdol5D5KuyBzS6k/iZg2511lywWYxnJy2Ovoxr3MDsutPuGd46Kkq4KeGWWdZDMF/c46JUgzaytz50Jqpdy4aJztIlGkHvgksxl/gs1O/u+ILYtiInrqvVHrI+ykNzZLOe5I4YB+tcZfyl+TwP7iaLxF/mNQhJtAOS2JddObnmZv/icAmDWAmTk7NyhyQrGC8VxxC85gerWZuO/VysaWEEGDLZbNrex7GvvNXEyWNiyNp0FAG6IyD2NUFtx2qvtPMnYRPXCmxo2/nBXxpToGvDGHBfCccqtBGym1S5lSHtAxKkIAd7knUqu3ECTf8ry/tRjtckzP4AVDLHXvqqx4mHBldKKMxXH7HeiQwv2YrPdB03LP1frme8gJFmDe/FK61uMy2+UgdN6uikrXxCrIZTZppolFIpzUwmpIto+N4JYpT5LBNoQ2jsgylxN+tIZnpmbUtSf4oTho8pJiz75fJxs+bV4BdrAPHPEoyW7KQh4xpu4PZuTk+Yx2cd0bn9f5oxWeOTExb3HF2eE+d0fqqwYrk1944zWBnLxpp85GGlu7RIBBTu+jXz74NszXcfGbLPBuQfdyT2l77yWurOuLQKECc=;4:qJB38cvZfTLLxUU5FofWFC0Xj9B6VeEctc7nmXNMENe3AqTfWCMr01gYWL6XVfcVwqfgLvN3FznIjV6NrBOd3q+LkIx/dY1o7le5jhTaF2OScF7tR1QZ7rYhgnHgXhtTdFsFfLhaUu4Mqy7TGsXlTOEBVrYxiK+PW+5J5qD+MPK/VmCJKLw0n0hxzK0Ez9MBAYGVHvcg8cAKLasR8+bGYYtY8UUudxOUowLwGhabSm4PN2Y+uA0kXzTAd9Kmv32D6lyz+rJxpZ/lnt/42WJ9bHaJYl6jYruLmrShSWQRZ4TjCMdUgSo3uQ8+LH5zI2Cy
X-Microsoft-Antispam-PRVS: <CY4PR07MB2903EE78AD20B2227AB7AEE7E3BB0@CY4PR07MB2903.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:CY4PR07MB2903;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB2903;
X-Forefront-PRVS: 06339BAE63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(366004)(346002)(39860400002)(396003)(376002)(39380400002)(199004)(189003)(4326008)(486006)(25786009)(3846002)(97736004)(6116002)(106356001)(53936002)(39060400002)(6306002)(478600001)(966005)(72206003)(6486002)(48376002)(110136005)(50466002)(8936002)(36756003)(16526019)(105586002)(68736007)(76506005)(26005)(42882007)(81156014)(8676002)(81166006)(59450400001)(47776003)(386003)(66066001)(4743002)(50226002)(6496006)(186003)(51416003)(52116002)(6666003)(16586007)(5660300001)(956004)(476003)(316002)(305945005)(2906002)(7736002)(1076002)(2616005)(7416002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB2903;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB2903;23:LMRycNtvdwMYgqzBVdqOUftHLU30lf8/l+AWo1P82?=
 =?us-ascii?Q?3ooYwsRkkL4ond7t28EY/wmlKVQ7Z/kkMy3w/82giQ3j/GQDg1WlTBSjFu7y?=
 =?us-ascii?Q?yRUy+aS/n5wcL+zQFjyiMQW0lWQVEl27flzNjFo+Q03spUlZgCBnFmNsjhwg?=
 =?us-ascii?Q?g4ja2ODu0ocFZMaSrea98h2uAnYIc7tM19QMpv8hTBs0kCcosyVAzVgWhuHW?=
 =?us-ascii?Q?aRpkrhQF+nU53mDFIW/iPWddRedoCpirV3GoXLhFOE37I0IOUEL6nlfiK55p?=
 =?us-ascii?Q?fZ3zfMoLhfxN1l5l9IAx6z0NSvx/KUpLUYeK7/m46o2xdfJbQD9GfClv+rdf?=
 =?us-ascii?Q?mkBU9KhWXOJDNuXjHmMHbm6JYvylcQuc2VoeZb1Kl+GqcjfAk+Q1td5CJlT+?=
 =?us-ascii?Q?LK6JgZvPMTaNiWPjVjRrcp0OSO1t/4DlEpTQDips1GAZ4XvuASnxR5pj5kjG?=
 =?us-ascii?Q?ueCva7TncAErd889SGgCZeNixpNGbkiYiUj9BAH4SThEMMyBIICoaDYygvQj?=
 =?us-ascii?Q?+1IuAuTPr8aIueF2eAKYvKq5UUp1S53BFkIL5LPULcX3sR6zRCq49olRM6aw?=
 =?us-ascii?Q?1mB4sgd3d2RFKDMuAfis/w27gg1vMn/O2VMmgiqBa0KOdTdz+gM+0ogzZOnU?=
 =?us-ascii?Q?bgvwnN/LdiqMtvtpLUCNZM3pVfAXw3w+dNK8aeVtkVMP8bhfHfgib4hl7oBj?=
 =?us-ascii?Q?HuDyICctWD1ZZwQkBvdTadPxqykBz/s8XG45XROGFdkzPghPob8d/dthSp3o?=
 =?us-ascii?Q?nroQxnJIRv9XGa7eaV7j+/d4KX5+AYT6l7/fwOEZ1DbgWdfYKVGWTF+lUyrz?=
 =?us-ascii?Q?ZJ9M3EkGFd4dRtUOlb1Pag4PULGiWbKNCIE/w7dh3DtB/klrG/gV0h5uDNWi?=
 =?us-ascii?Q?xLt/xy10Eg8FuhW2BYUFFKK8fQfAnUVDpPzbGDZUlZQKEIXlBFlP0FSfTOP8?=
 =?us-ascii?Q?k87wW0IKBDUxz4fZMxi0CMbhEAlIBGh/bUfLIi7oUXwnP5O8QVOwZb/DR1b0?=
 =?us-ascii?Q?GQtfBTyIrjLs51iMkMyyiXMdARIUmA76ph/KSQIwUTdmvpBLd7VJVR41EnQV?=
 =?us-ascii?Q?7cS8uTRQe3tfbrCySww/lut3imG/mZb+o6emf604w702q7yNkiuCwxu6v/Uw?=
 =?us-ascii?Q?PuX8Aa9EMwlCsAN/JsEcH4gMR2MsRkvR5C5qkFTUpPFhV8VQRrxW9f8NIiC0?=
 =?us-ascii?Q?Am09DGF0f4B6OJ2s7AT2BAKyui1vaHUfZCFlIWy6jtTSMbOIFzonLmxqe58g?=
 =?us-ascii?Q?HADAuacVfxdcd3cLtKT8BBPcepvvqmUjS1CsmlZPjTKvlxdslcokqZiGmwiq?=
 =?us-ascii?Q?UpuuCmAxmOTuA5nn+vMTnLVIqWUKPqIblGKBLe15YVuwIDJhoQrRNvXVbkHM?=
 =?us-ascii?Q?IwOXA=3D=3D?=
X-Microsoft-Antispam-Message-Info: D6Ty4YnQohdLcBY2jlPrZMHnU5VTDgjkfAFbHpCg5hsutIC4Meem+Rbpi1WpIcKwZLqAfwLCxJJFrdu+m6MjllrT2ZD7VvYzmKnGQMLf1B+mAOb3Nx7t/nb1oztKyWtDs6cBS1NLcHXsnu39biLh6141dKUfFbtmP2k80osjBLmLcF3okyuhqg7WurNGFiYe
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2903;6:S6d3ABED/Zt8pbc9UklGAa6VZ8cjEZHkQXn+t+eZioqBAZybLKOKmhpDDUT4CpUq6aSxXX1CotAKsh/1ToBwkW1Y3A2BQWMnVcOEyqxkud17+spfMX7eHd+vUGPJGfr3P9xveu85yTVSpoPs1I686sLZxTveTmR9xzh3zzg+LIYANNb+E7rettRigqox3Yi73GC9trDDJYhzf9Oqd/AMC85cy/puDj/ExzVFRIzNG6IokkiT2rzcPHEv18oHcM/WVOjauEGAjqoZwy5gG4chZbqZFiMvie70BP6EU5Enqf5X+MxVNC5P6bRV6EnOxHoBZMx7cGpNpjHwryAlEjLTGfmeQ8e4cF5Xy3pv6yG6PHIjdf2ME7pGGyf3DJ1BKXUmFE9P5xFt6MKI5itjD/lFdJljNjAxkItQrVmaYVzQJI6lmneo3iIVzyStfeKaBl98t4yiD6dJjJhWuTbi/mUdQA==;5:6AkO+myW1/sJ70glverjgFh1wO8zI9h0e/SvPjkjq+ewQbB3RB7PkG9mAK+qK1NyKctYK1DBw13y7759cCVn+DLqVREcofZNUq2YZbpujhkSJ9QdrzbnseDX69DULCyidxcZe0JlbWYL9OIIwKPFfhccP5VviWXhR7qXfdimY6g=;24:8wK4Yf0gEhTLgF8tFowO8dtn5y0iajJHUNpN82N5ksA5N3FiPuThutwIPLrMbPefbavICqw7fgKBsdS71DbjD5o43DzCI1I6oTOqcYUJCYg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2903;7:ZrvOO/5VXhZOg+UGHK47UroqHu35qjrNsz3t4P17JW1+X9RbQK0gk0SrVPZYLRGijXLcP6kLzuybCQlbkW7HA967/2DjAIKLzjojWvHtu+KfCAc9B2FuMZ+G+3yNzB3Y+tiqh6tJ0NIPBuEMpbbhGzSxVm2qRiu8ZR84FfX9ejLQZz8+fOMS4KgJOPRsRhDPPBrhLlVlVNtVyTKiwWYZD7uwMCfyaKlSqBQRxxOZgiE37DTTgXebycMdDKfZQjed
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2018 17:18:19.2615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b421be42-be34-48f4-7479-08d59b193ada
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2903
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kick_all_cpus_sync() is used to broadcast IPIs to all online CPUs to force
them synchronize caches, TLB etc. It is called only 3 times - from mm/slab
arm64 and powerpc code.

We can delay synchronization work for CPUs in extended quiescent state
(idle or nohz_full userspace). 

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

v2 is big rework to address comments in v1:
 - rcu_eqs_special() declaration in public header is dropped, it is not
   used in new implementation. Though, I hope Paul will pick it in his
   tree;
 - for arm64, few isb() added to ensure kernel text synchronization
   (patches 1-4);
 - rcu_get_eqs_cpus() introduced and used to mask EQS CPUs before 
   generating broadcast IPIs;
 - RCU_DYNTICK_CTRL_MASK is not touched because memory barrier is
   implicitly issued in EQS exit path;
 - powerpc is not an exception anymore. I think it's safe to delay
   synchronization for it as well, and I didn't get comments from ppc
   community.
v1:
  https://lkml.org/lkml/2018/3/25/109

Based on next-20180405

Yury Norov (5):
  arm64: entry: isb in el1_irq
  arm64: entry: introduce restore_syscall_args macro
  arm64: ISB early at exit from extended quiescent state
  rcu: arm64: add rcu_dynticks_eqs_exit_sync()
  smp: Lazy synchronization for EQS CPUs in kick_all_cpus_sync()

 arch/arm64/kernel/Makefile  |  2 ++
 arch/arm64/kernel/entry.S   | 52 +++++++++++++++++++++++++++++++--------------
 arch/arm64/kernel/process.c |  7 ++++++
 arch/arm64/kernel/rcu.c     |  8 +++++++
 include/linux/rcutiny.h     |  2 ++
 include/linux/rcutree.h     |  1 +
 kernel/rcu/tiny.c           |  9 ++++++++
 kernel/rcu/tree.c           | 27 +++++++++++++++++++++++
 kernel/smp.c                | 21 +++++++++++-------
 9 files changed, 105 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm64/kernel/rcu.c

-- 
2.14.1
