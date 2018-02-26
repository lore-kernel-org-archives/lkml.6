Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751815AbeBZVax (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:30:53 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:51646 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751165AbeBZVav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:30:51 -0500
Date: Mon, 26 Feb 2018 16:30:19 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Borislav Petkov <bp@alien8.de>, x86@kernel.org, mingo@redhat.com,
        tglx@linutronix.de
Cc: Paolo Bonzini <pbonzini@redhat.com>, Wanpeng Li <kernellwp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH] KVM: X86: Allow userspace to define the microcode version
Message-ID: <20180226213019.GE9497@char.us.oracle.com>
References: <20180226114409.GD4377@pd.tnic>
 <46cecef2-b0fb-b0c2-bbf3-983328d52763@redhat.com>
 <20180226121509.GE4377@pd.tnic>
 <24cd527d-5287-f0be-ffe8-eab341bf1d94@redhat.com>
 <3866d359-0ef8-6a99-6254-84890be62b93@redhat.com>
 <20180226122205.GG4377@pd.tnic>
 <fb705c01-9bdd-9924-00c6-70d8ee940fb4@redhat.com>
 <20180226143912.GC22024@char.us.oracle.com>
 <20180226193711.GS4377@pd.tnic>
 <20180226205130.GZ22024@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226205130.GZ22024@char.us.oracle.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8816 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802260269
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 03:51:30PM -0500, Konrad Rzeszutek Wilk wrote:
> On Mon, Feb 26, 2018 at 08:37:11PM +0100, Borislav Petkov wrote:
> > On Mon, Feb 26, 2018 at 09:39:12AM -0500, Konrad Rzeszutek Wilk wrote:
> > > diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> > > index d19e903214b4..87d044ce837f 100644
> > > --- a/arch/x86/kernel/cpu/intel.c
> > > +++ b/arch/x86/kernel/cpu/intel.c
> > > @@ -144,6 +144,13 @@ static bool bad_spectre_microcode(struct cpuinfo_x86 *c)
> > >  {
> > >  	int i;
> > >  
> > > +	/*
> > > +	 * We know that the hypervisor lie to us on the microcode version so
> > > +	 * we may as well trust that it is running the correct version.
> > > +	 */
> > > +	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
> > 
> > I guess
> > 
> > 	cpu_has(c, X86_FEATURE_HYPERVISOR)
> > 
> > since we're passing a ptr to the current CPU.
> 
> Ah yes. Let me fix it up and repost.

I've posted it (but I can't seem to find it on LKML). Here it is in this
thread. Also adding ingo + tglrx

>From 6abac2ccf105d57d60c094950e32139e435cbefe Mon Sep 17 00:00:00 2001
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Date: Mon, 26 Feb 2018 09:35:01 -0500
Subject: [PATCH v2] x86/spectre_v2: Don't check bad microcode versions when
 running under hypervisors.

As:
 1) We know they lie about the env anyhow (host mismatch)
 2) Even if the hypervisor (Xen, KVM, VMWare, etc) provided
    a valid "correct" value, it all gets to be very murky
    when migration happens (do you provide the "new"
    microcode of the machine?).

And in reality the cloud vendors are the ones that should make
sure that the microcode that is running is correct and we should
just sing lalalala and trust them.

CC: stable@vger.kernel.org
CC: Ingo Molnar <mingo@redhat.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: x86@kernel.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

---
v2: Change comments to be more in line with the state of the world.
v3: Use cpu_has instead of boot_cpu_has per Borislav's review.
---
 arch/x86/kernel/cpu/intel.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index d19e903214b4..4aa9fd379390 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -144,6 +144,13 @@ static bool bad_spectre_microcode(struct cpuinfo_x86 *c)
 {
 	int i;
 
+	/*
+	 * We know that the hypervisor lie to us on the microcode version so
+	 * we may as well hope that it is running the correct version.
+	 */
+	if (cpu_has(c, X86_FEATURE_HYPERVISOR))
+		return false;
+
 	for (i = 0; i < ARRAY_SIZE(spectre_bad_microcodes); i++) {
 		if (c->x86_model == spectre_bad_microcodes[i].model &&
 		    c->x86_stepping == spectre_bad_microcodes[i].stepping)
-- 
2.13.4
