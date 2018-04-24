Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932827AbeDXDPC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 23:15:02 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45592 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932776AbeDXDO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 23:14:58 -0400
Date: Mon, 23 Apr 2018 23:14:00 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Eduardo Habkost <ehabkost@redhat.com>, Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH] KVM: X86: Allow userspace to define the microcode version
Message-ID: <20180424031400.GA22608@char.us.oracle.com>
References: <24cd527d-5287-f0be-ffe8-eab341bf1d94@redhat.com>
 <3866d359-0ef8-6a99-6254-84890be62b93@redhat.com>
 <20180226122205.GG4377@pd.tnic>
 <fb705c01-9bdd-9924-00c6-70d8ee940fb4@redhat.com>
 <CANRm+CyyL2jjjn7nZtLJvP+t1pN9ndAGhijmbX4LJh15=O+dvQ@mail.gmail.com>
 <20180417202417.GA29865@localhost.localdomain>
 <CANRm+CwA22VmpA5cfQg8mF_Xke_hXtP+_ui5xU+LV8v0JNj=3Q@mail.gmail.com>
 <20180418090329.GJ29865@localhost.localdomain>
 <de059c45-d706-ff70-9063-92ac0a807e26@redhat.com>
 <CANRm+CzxG5cm8ECopzGYpF3E3RTjvFGD3_7o8S=tffFxnvYoiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANRm+CzxG5cm8ECopzGYpF3E3RTjvFGD3_7o8S=tffFxnvYoiA@mail.gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8872 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804240027
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3O3F6X6030805

On Tue, Apr 24, 2018 at 10:59:04AM +0800, Wanpeng Li wrote:
> 2018-04-18 18:36 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
> > On 18/04/2018 11:03, Eduardo Habkost wrote:
> >>>> QEMU setting ucode_rev automatically using the host value when
> >>>> using "-cpu host" (with no need for explicit ucode_rev option)
> >>>> makes sense to me.
> >>> QEMU can't get the host value by rdmsr MSR_IA32_UCODE_REV directly
> >>> since rdmsr will #GP when ring !=0, any idea?
> >> By looking at kvm_get_msr_feature(), it looks like
> >> ioctl(system_fd, KVM_GET_MSRS) would return the host MSR value
> >> for us.
> >
> > Yes, that's exactly what it was introduced for (together with other MSRs
> > including VMX capabilities).
> 
> How about the live migration? What will happen if the source and
> destination machines have different microcode version?

You would need to include the microcode version in the migration stream.

But this brings another point - what if we want to manifest certain
new CPUID bits?

For example, see:
https://software.intel.com/sites/default/files/managed/1d/46/Retpoline-A-Branch-Target-Injection-Mitigation.pdf

5.3:
"To remedy this situation, an operating system running as a VM can query bit 2 of the
IA32_ARCH_CAPABILITIES MSR, known as “RSB Alternate” (RSBA). When RSBA is set, it
indicates that the VM may run on a processor vulnerable to exploits of Empty RSB
conditions regardless of the processor’s DisplayFamily/DisplayModel signature, and
that the operating system should deploy appropriate mitigations. Virtual machine
managers (VMM) may set RSBA via MSR interception to indicate that a virtual machine
might run at some time in the future on a vulnerable processor."

Perhaps the guest should do a bit of sampling of various CPUIDs as the migration
has been done? Is there a nice KVM hook inside of the guest to do this?

> 
> Regards,
> Wanpeng Li
