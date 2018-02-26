Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753849AbeBZOj1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 09:39:27 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:50416 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753333AbeBZOjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 09:39:25 -0500
Date: Mon, 26 Feb 2018 09:39:12 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>, Wanpeng Li <kernellwp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH] KVM: X86: Allow userspace to define the microcode version
Message-ID: <20180226143912.GC22024@char.us.oracle.com>
References: <CANRm+Cxw2-8Cf+6cg_yZC+SD66uNA5RO+ZaoHHmkpHLzjCih=A@mail.gmail.com>
 <20180226113000.GC4377@pd.tnic>
 <CANRm+CzwY2yzKFXF7r=vfqDaHHoHxC221TSBtSHC2XtvkrQxHA@mail.gmail.com>
 <20180226114409.GD4377@pd.tnic>
 <46cecef2-b0fb-b0c2-bbf3-983328d52763@redhat.com>
 <20180226121509.GE4377@pd.tnic>
 <24cd527d-5287-f0be-ffe8-eab341bf1d94@redhat.com>
 <3866d359-0ef8-6a99-6254-84890be62b93@redhat.com>
 <20180226122205.GG4377@pd.tnic>
 <fb705c01-9bdd-9924-00c6-70d8ee940fb4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb705c01-9bdd-9924-00c6-70d8ee940fb4@redhat.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8815 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802260195
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 01:41:38PM +0100, Paolo Bonzini wrote:
> On 26/02/2018 13:22, Borislav Petkov wrote:
> > On Mon, Feb 26, 2018 at 01:18:07PM +0100, Paolo Bonzini wrote:
> >>> In this context, "host-initiated" write means written by KVM userspace
> >>> with ioctl(KVM_SET_MSR).  It generally happens only on VM startup, reset
> >>> or live migration.
> >>
> >> To be clear, the target of the write is still the vCPU's emulated MSR.
> > 
> > So how am I to imagine this as a user:
> > 
> > qemu-system-x86_64 --microcode-revision=0xdeadbeef...
> 
> More like "-cpu foo,ucode_rev=0xdeadbeef".  But in practice what would
> happen is one of the following:
> 
> 1) "-cpu host" sets ucode_rev to the same value of the host, everyone
> else leaves it to zero as is now.

0x1 you mean.
> 
> 2) Only Amazon uses this feature and we ignore it. :)

And every other vendor.

Perhaps both ideas should be done? The one Boris suggested (See below, not
compile tested yet), and also this one? Keep in mind that other hypervisor
offerings (say Xen, VMWare, etc) may have provided the correct microcode
or not and it would be good for the OS to be comfortable running under them.

>From 36ea81363c38942057b006ccaf2ef26708a894bb Mon Sep 17 00:00:00 2001
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Date: Mon, 26 Feb 2018 09:35:01 -0500
Subject: [PATCH] x86/spectre_v2: Don't check bad microcode versions when
 running under hypervisors.

As:
 1) We know they lie about the env anyhow (host mismatch)
 2) Even if the hypervisor (Xen, KVM, VMWare, etc) provided
    a valid "correct" value, it all gets to be very murky
    when migration happens (do you provide the "new"
    microcode of the machine?).

And in reality the cloud vendors are the ones that should make
sure that the microcode that is running is correct and we should
just sing lalalala and believe them.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/x86/kernel/cpu/intel.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index d19e903214b4..87d044ce837f 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -144,6 +144,13 @@ static bool bad_spectre_microcode(struct cpuinfo_x86 *c)
 {
 	int i;
 
+	/*
+	 * We know that the hypervisor lie to us on the microcode version so
+	 * we may as well trust that it is running the correct version.
+	 */
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		return false;
+
 	for (i = 0; i < ARRAY_SIZE(spectre_bad_microcodes); i++) {
 		if (c->x86_model == spectre_bad_microcodes[i].model &&
 		    c->x86_stepping == spectre_bad_microcodes[i].stepping)
-- 
2.13.4

> 
> Paolo
> 
