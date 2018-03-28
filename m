Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752216AbeC1K6c (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 06:58:32 -0400
Received: from mail-by2nam03on0072.outbound.protection.outlook.com ([104.47.42.72]:18272
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751209AbeC1K63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 06:58:29 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
Date: Wed, 28 Mar 2018 13:58:13 +0300
From: Yury Norov <ynorov@caviumnetworks.com>
To: Will Deacon <will.deacon@arm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Christopher Lameter <cl@linux.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
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
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        kvm-ppc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] smp: introduce kick_active_cpus_sync()
Message-ID: <20180328105813.arilhcxi6hawd34n@yury-thinkpad>
References: <20180325175004.28162-1-ynorov@caviumnetworks.com>
 <20180325175004.28162-3-ynorov@caviumnetworks.com>
 <20180327102116.GA2464@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327102116.GA2464@arm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Originating-IP: [171.101.210.188]
X-ClientProxiedBy: AM4PR0701CA0034.eurprd07.prod.outlook.com
 (2603:10a6:200:42::44) To CY4PR07MB2903.namprd07.prod.outlook.com
 (2603:10b6:903:26::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 555592dc-6803-4765-5c53-08d5949ad56c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR07MB2903;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2903;3:tBbrYcy1KCmJdqZaELmSh9lZJHggYPv9En/FnNUjj7VTDnSJoAlpThbAHPjc2ZKKferv07y2yn9nX4m5YalUA4QyFMVaI2S+VG9P9yp0Coaa5JfXS0aO449KZyJnYZdMwcZVuQk4nbOF5AylrQPs7C/0fPqvXH/FXZfpEghFSssFK5KslDc+DtYTbbqZLsWAi2V7iI3pe+QXGFJntsJffoBT/3VaOkdFVv0V2ySpmk/BLFzdOHg74Heut4l8f0YV;25:4vsqfFa3EKgSQTudL14l2ZkG3oW3ZfZj8QK80WK5Kfr5mAhZNfA94FRmjhKRMRjVnZ8TndQZLnClDwaw5enoan7ZxpmAb1hE+wTSR5QwbdiObhg6KZwoqZjr1gbf2dDNNfSiW9U+LisDf+DFwydUTJGA/CeAqJDdLdnh3ZmniLrT5wx5bv8Ykz9VmMYr6D1zPTZ3uUkOHsPtectvSOT4bh498BTPBiz3owe9dqPkLAqmITVbjt9eX9KX3MlGYd54lpQaVDgaJxjD/QSOjSo5GQpDMjEovVFvt6gzJ4t8fuQ43FAcb4En+KMitbu8S5ybbgVaN+dKu3fB2+C2iAAB4g==;31:Rlw5jdh1FFFndx8Rjny7gNZ4ZptaB9PXnY2TAVr96xWu5IFVR1eMrC+WCxS5erazV+LxyETzDJsluFfXZfcdbPhgbYp/YIqi6ElYvdp0CnqWYV+Uu6OKICspAy1LkBSCjNZ+ELVbVtRycZbzK2+rHHRULE/ZfY8pikZ6BMG76DPervZHP1qmeH7Z1pOcGTw9Mx8QRiL9TjoQe1JxndtFLQi3uqnl+/gKbfPCa4uTFBY=
X-MS-TrafficTypeDiagnostic: CY4PR07MB2903:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2903;20:4z7l3eAsM1NaK1QyRrNG4j8A3RdGQrat0G83FSg0rEq5b26q/lPlg+7GG2bI/QILwlsnEUW7Kb1dIepuKMr7dZdb8zEQ0ILUApIfpNPstttIXhe5qSupyZeX9OMjhkqfiONRnG2FNXu0Ov+WXbsXq1oI0t7ePmySwjn1FyWVhqfJxkncjSLXUbtnvQ8vn1l63mFPGmZ5SgmvCaTPC8qHwUfQCHOBZaDnUQentMdweP28tG4UGlyMkcfT5mvcEzkZcvqztmUXgof6/QBuuyS2hC252Ml+Pu7/3b+x05IMR6JHtrBEDmROC9VbkRgGNoJcpbF891wCCZnQ9B+ZibXvn/2QQnnLOnyaTEsdJJuvx9KAYNSkX2WdDjlDx7aJKOiSfcADk9DScuehr1f75MrFGJbEZ4KTjJXemtL6Y9fGtT3j0tfsQmQeH9/AyS3W8J2F7OTe5C85HjQcqeUhkXYLqeTbNyReH+pnJIp5N4WklZBb1Bw3hNHp5op1fn7hRzpOUqgNjYznCFR/zFZ87QyU5DcTsbGbUEXYKH4L852gYsEzaHC+UcCY07dgzSlRYRmkZXnQDkiTdAiH7j/RDeKq+3ZyovUSjCLV7RrOdEUR4zE=;4:k/4k7lvweYe0L2OnKfKKYVR/NRwWWwurFuqc7a+YWOgk2cWSm7nl8h8/YDHX0sXSafpZryYg240kRV1nCf0K8RdvYyQ3wMVJz0pU8nxty/94tHEhue1ISm/aTUu4MFd/9wUaaLjVg72kdcgH0DERuwZARiGeX4MGxiJNBeka6vqSyeej+POO0FqWg3HUhBgjWTK59aQ3FYmKis1ctNNrEegzdKOifl9+i4p8UOwNrgG7dsRMRLNsF6mdUU8PueDLkclFEiL4Qv2lS9gkQAEwBw==
X-Microsoft-Antispam-PRVS: <CY4PR07MB2903ACBC6543C52C684D4B8DE3A30@CY4PR07MB2903.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(3002001)(10201501046)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY4PR07MB2903;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB2903;
X-Forefront-PRVS: 06259BA5A2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(39380400002)(346002)(376002)(396003)(366004)(39860400002)(199004)(189003)(58126008)(1076002)(6116002)(106356001)(3846002)(23726003)(25786009)(229853002)(11346002)(26005)(97736004)(5660300001)(55236004)(4326008)(446003)(7416002)(305945005)(8936002)(7736002)(6916009)(6666003)(68736007)(16586007)(81156014)(81166006)(2906002)(8676002)(316002)(53936002)(6306002)(33716001)(9686003)(50466002)(478600001)(66066001)(72206003)(6246003)(54906003)(76176011)(33896004)(6496006)(52116002)(6486002)(386003)(47776003)(42882007)(105586002)(486005)(16526019)(186003)(76506005)(956004)(486005)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB2903;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB2903;23:dYm+Xb1qUhml4dtVhPhPVUivJg/4A7eHYXIhiDnUa?=
 =?us-ascii?Q?fxffs7aQ8rZyFKT006d45TnPvyer+K2+5nMwGGRQtJ/B+eAQvruAY0ZFNoXe?=
 =?us-ascii?Q?OPUYO7iR/ZLCgsgFwmbxNc5AMKd36+QtZuJAPGhiHL91wiTV/nh1ADgIcGm7?=
 =?us-ascii?Q?34MBcBNleihnKpVYDR4GUC90wv3LQeiEXq3LhQbNicM+h1cEapjKLV8ZG6FW?=
 =?us-ascii?Q?BLCBCgTM2vcTxz2UrZeY1tmwMbefnC9+yrRUoSoqIJsGhWsZmfbXAMvjMbQ5?=
 =?us-ascii?Q?Cp59G0TXO8tXK1ttdlH8+eiBWvCJHRrdfOFF/yHmqiGXRQdVP5LZip/rrJ8L?=
 =?us-ascii?Q?veSGIMF8Z4dFfiqZcgSrNUJcZyhOQ0AYwV+MLYUfkEzPJ3ioFl3NnL4YDV1/?=
 =?us-ascii?Q?hZzL1AydFiDFJyZUW2mtGtzp11nGM/hjgDojPWoTqsp+VgiEqwAqLa7SlySM?=
 =?us-ascii?Q?G70duyThAXbNvauwlTcqMG8f8gU6rU/Bw48kxb3rreOl5P8lVxBUP3ilTjF/?=
 =?us-ascii?Q?yLqmcGOekM6xYcgTVtUxwDi71qdQG9p8pJM8WQSuWaL84IPLLpjPO0PLK3yv?=
 =?us-ascii?Q?3RvQ6irOpUa99nx4ws8rW9JcyyHVs0x156k2VoHy1WHiK/sa5dcGnxi2vQgP?=
 =?us-ascii?Q?jraRog418jrKIus1a4HAYP7kneJcL7NR1stK6B/8Y9l59qQUSN5GEOW5CTtB?=
 =?us-ascii?Q?YFRdGxlP+Q6CPMfshhLd5p+QmDPPbe8ZufMl8XhF2B6Ni+W3VFP7sAqOwJKP?=
 =?us-ascii?Q?C+tG+cmXMUNbIFnJDvmFPsKZrRsnT7HhHteLHGFpSEGp02BIA9li7bYYZDtw?=
 =?us-ascii?Q?WHRp5nyNdxVQx1f/MQiMUirtiAujypNRgA19kR9sYdzzGtCpr7PX2AA57v0O?=
 =?us-ascii?Q?Lv6l5nBKIaHCbVHtEGul5E+Ar0ntAd4RVHzEStYqNomLaf3FoWBPxCtEys1W?=
 =?us-ascii?Q?1CAeCIX0HhQyrV47iDBElQIzRXNv5zvvjkOlpt/ZKGM4fe7n7u+SJXc3a8Hy?=
 =?us-ascii?Q?Mdyc77g3KOg42XEyV2HaHjE5ke/JKOgmDs50tjRo9NRqDjy59IgYW2NQfL4R?=
 =?us-ascii?Q?fZ5qIK2f9MSLj5GXXoBS1fGXz2WZJQa4CNNhQS7+wNLPk089KFVrNcnfELJ2?=
 =?us-ascii?Q?rC4Xtlr+cA4/e6NW47O0qRLKkOfA0lkw0dCTWuOg1WD2zyecvpjedf98aBkq?=
 =?us-ascii?Q?X79nuM32otp+BdGQvQv45romqjbwM9lsBdJBy56NNVtBIPohbrIKTbLKfBuN?=
 =?us-ascii?Q?wqxo0iErWljboua7vSVS6W4Fi6uafGwvPfBrqhLOQOuLTTqanxhuUK4brjRz?=
 =?us-ascii?Q?UoxP0/w38MQFIiYBxi6ezJve1plVAHGLEoDYyWtoKfkUVqS3QuqIRwM2nlgd?=
 =?us-ascii?Q?752RKBRYmmcvwa8F+EsAQCtvIBmyARvkOZuhG+o4LW4sVte?=
X-Microsoft-Antispam-Message-Info: TTm+BqJpJOgHVJGjmpJKmzpTFEQJ1AxwO8OWBG/ZKfl0+mvZ9BBPCPCTr3V2FPqpWX8tDevFbH50HbAq5re/yLthD9IgJEUsRm00Y7djmjTnskSbZoBtfcP0sVCwcXDzVOrufigX9cLWVVyM8C1N/YQ8RdqEPwoxhVwsDUzcV9LU4KNYqZWL8JcnyQQwiOoQ
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2903;6:YRXQwPY0bsXzNhZKCr3GvCEXhQvBD+4mlfJk/1Zmz67glTEp/8BenSAytM9Q5ekQoYuQCDonj4nviY9TRJGstQ/hSBXgX3YDN9WMyyitAZFW1fUZgoreLMQLfNgdOLALmkHhT6UKfoXbRN+9Y+BptnfR4UvHCEfrhFb473ygnZ0fdxuO03ifiD+OoMWMrpTrKrgIy80aClaDMcOPLZfNQ5QSISyTU7vnR8/nwdQ9CWhSdnDGGYzJOzAyxczl22K8ni4/RX1yqyeZj7YaWkrvnS9eTwJC03tfcb4NHKPry5Dp1vEA+J6oNTLbTAtpoWWVu9nrSTOaiY8JXwsYZPIdK2ZY/JCQBO4yk4Z+sd6BZxt+8Xke43oVrr0TMxgbUlg8oOFWvtHtfksFDPy7ESulknGOodljCUSXMnmw3NYILpEhgRg/ssVG1P9lihT/H1gAy+H75bOjJCzPfTeQKP2MZw==;5:IL/cjnihrqT0zwIzyE8jSoP4zicVEpFj5uNM+f4YyYVQyUJYhRl8c0M4MIgEuibaEdlsIjpV8CGDKQTXDfUqcGX/gNXNTpdZXAiqOX/BQ4QSMx6AMwsjm8BzsqFhky96M4lRFHVRiCNGGPwkI8rNIQedHhkefzz8J96tjcYnumM=;24:EOzPYrllRW8K6nTtLuK4kfWLM9U8/euEjM+LGwDWPIIgEusIbOPo3wHl7OWXRrAzEVjLOPMPrVnjYP2v2wX4XTJJH2Samm7RCBBuiznNrQo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB2903;7:zxKga6vJU/n7I8cCUj3L5Tw7Qkw+oYCjz9AhA7FgMldATZjx6H6cT35gaTM/oaZlZYrmUzX3cIAL+MhWmnwO7Wy2wPL1jU8d9ppAFvpkqU3ygjZnEtUfbha94FXqeJPHsnyNRpPMnsmAo6STu/Vx7fKUb+davZGbhiecXuzCj9HJd5cthxUEAcRiC7/sK3YZnRMFe/zDtiZCSmqXUJRrpGjIL8rSEj5XWlV0gVSHFioORiUR/iFkAcs8JRJkDdw+
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2018 10:58:26.1191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 555592dc-6803-4765-5c53-08d5949ad56c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2903
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 11:21:17AM +0100, Will Deacon wrote:
> On Sun, Mar 25, 2018 at 08:50:04PM +0300, Yury Norov wrote:
> > kick_all_cpus_sync() forces all CPUs to sync caches by sending broadcast IPI.
> > If CPU is in extended quiescent state (idle task or nohz_full userspace), this
> > work may be done at the exit of this state. Delaying synchronization helps to
> > save power if CPU is in idle state and decrease latency for real-time tasks.
> > 
> > This patch introduces kick_active_cpus_sync() and uses it in mm/slab and arm64
> > code to delay syncronization.
> > 
> > For task isolation (https://lkml.org/lkml/2017/11/3/589), IPI to the CPU running
> > isolated task would be fatal, as it breaks isolation. The approach with delaying
> > of synchronization work helps to maintain isolated state.
> > 
> > I've tested it with test from task isolation series on ThunderX2 for more than
> > 10 hours (10k giga-ticks) without breaking isolation.
> > 
> > Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> > ---
> >  arch/arm64/kernel/insn.c |  2 +-
> >  include/linux/smp.h      |  2 ++
> >  kernel/smp.c             | 24 ++++++++++++++++++++++++
> >  mm/slab.c                |  2 +-
> >  4 files changed, 28 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
> > index 2718a77da165..9d7c492e920e 100644
> > --- a/arch/arm64/kernel/insn.c
> > +++ b/arch/arm64/kernel/insn.c
> > @@ -291,7 +291,7 @@ int __kprobes aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt)
> >  			 * synchronization.
> >  			 */
> >  			ret = aarch64_insn_patch_text_nosync(addrs[0], insns[0]);
> > -			kick_all_cpus_sync();
> > +			kick_active_cpus_sync();
> >  			return ret;
> >  		}
> >  	}
> 
> I think this means that runtime modifications to the kernel text might not
> be picked up by CPUs coming out of idle. Shouldn't we add an ISB on that
> path to avoid executing stale instructions?

Thanks, Will, for the hint. I'll do that.

Yury
