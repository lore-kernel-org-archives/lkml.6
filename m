Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbeBWSNW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 13:13:22 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:49276 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbeBWSNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 13:13:20 -0500
Date: Fri, 23 Feb 2018 13:12:37 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
        "valdis.kletnieks@vt.edu" <valdis.kletnieks@vt.edu>,
        Jon Masters <jcm@jonmasters.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>, Ingo Molnar <mingo@kernel.org>
Subject: Is: RSB Alternative bit in IA32_ARCH_CAPABILITIES Was:Re: [PATCH
 2/2] x86/speculation: Support "Enhanced IBRS" on future CPUs
Message-ID: <20180223181237.GA19321@char.us.oracle.com>
References: <1518776517.7876.21.camel@infradead.org>
 <d61edc94-8a51-62bd-65ed-8068451ca5b5@redhat.com>
 <1518783021.7876.34.camel@infradead.org>
 <4882860e-23c5-75b3-ac02-c700f615156e@jonmasters.org>
 <0575AF4FD06DD142AD198903C74E1CC87A61923C@ORSMSX103.amr.corp.intel.com>
 <10373.1519084385@turing-police.cc.vt.edu>
 <0575AF4FD06DD142AD198903C74E1CC87A619255@ORSMSX103.amr.corp.intel.com>
 <aa3fbaf1-0efc-64b1-4f7b-3d00b0493d48@redhat.com>
 <0575AF4FD06DD142AD198903C74E1CC87A619465@ORSMSX103.amr.corp.intel.com>
 <2159cdc0-c30d-3bf8-1c25-74bff46a1e91@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2159cdc0-c30d-3bf8-1c25-74bff46a1e91@redhat.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8813 signatures=668678
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802230223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1NIDQYS010517

On Tue, Feb 20, 2018 at 03:46:57PM +0100, Paolo Bonzini wrote:
> On 20/02/2018 15:08, Van De Ven, Arjan wrote:
> >>>> For bonus points:  What should happen to a VM that is live migrated
> >>>> from one hypervisor to another, and the hypervisors have different
> >>>> IBRS support?
> >>>
> >>> Doctor Doctor it hurts when I do this....
> >>>
> >>> Migration tends to only work between HV's that are relatively
> >>> homogeneous, that's nothing new...
> >>
> >> No Arjan, this is just wrong.  Well, I suppose it's right in the present
> >> tense with the IBRS mess on Skylake, but it's _not_ been true until last
> >> year.
> > 
> > I meant software wise. You're not going to live migrate from xen to
> > kvm or backwards. or between very radically different versions of the
> > kvm stack.
> 
> Forwards migration to a radically newer version certainly happens.  So
> when the source hypervisor was too old to tell the VM about IBRS_ALL,
> for example, migration should work properly and the VM should perform
> well on the destination hypervisor.

To add a bit more to this, Intel just updated their IA32_ARCH_CAPABILITIES_MSR
to have a new bit to sample to figure out whether you need IBRS or not
during runtime.

See https://software.intel.com/sites/default/files/managed/1d/46/Retpoline-A-Branch-Target-Injection-Mitigation.pdf
in 5.3
Virtual Machine CPU Identification:

"To remedy this situation, an operating system running as a VM can query bit 2 of the IA32_ARCH_CAPABILITIES MSR, known as “RSB Alternate” (RSBA). When RSBA is set, it indicates that the VM may run on a processor vulnerable to exploits of Empty RSB conditions regardless of the processor’s DisplayFamily/DisplayModel signature, and that the operating system should deploy appropriate mitigations. Virtual machine managers (VMM) may set RSBA via MSR interception to indicate that a virtual machine might run at some time in the future on a vulnerable processor."

New bit.. but not mentioned in the:

336996-Speculative-Execution-Side-Channel-Mitigations.pdf

Paolo, is there some form of callback inside of the guest when KVM guests are migrated?
(It exists under Xen, but I don't see it under KVM?)
> 
> Backwards migration to older hypervisors also happens sometimes, but in
> general it creates more userspace than kernel issues.
> 
> Paolo
