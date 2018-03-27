Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752495AbeC0JKl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 05:10:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38282 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752469AbeC0JKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 05:10:37 -0400
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/2] KVM: VMX: Add Force Emulation Prefix for "emulate the
 next instruction"
From: Nikita Leshenko <nikita.leshchenko@oracle.com>
In-Reply-To: <d34c1d3c-324e-4645-9d48-09c94212aa5e@default>
Date: Tue, 27 Mar 2018 12:05:25 +0300
Cc: pbonzini@redhat.com, kernellwp@gmail.com, rkrcmar@redhat.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Message-Id: <95B06D42-EFDF-4750-AD03-98D6C78378D5@oracle.com>
References: <d34c1d3c-324e-4645-9d48-09c94212aa5e@default>
To: Liran Alon <liran.alon@oracle.com>
X-Mailer: Apple Mail (2.3273)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8844 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803270095
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2R9Akqo027568

What you are essentially trying to do is create a PV interface to access
the x86 emulator.
Why not use a simple hypercall (VMCALL) to accomplish this instead of
inventing yet another PV method?

Something like “KVM_HC_EMULATE_NEXT_INSTRUCTION” in kvm_emulate_hypercall
should do the trick (however it needs to be placed before the check for
CPL>0 so that user mode code can test the emulator too).

Nikita

> On 27 Mar 2018, at 11:26, Liran Alon <liran.alon@oracle.com> wrote:
> 
> 
> ----- pbonzini@redhat.com wrote:
> 
>> On 27/03/2018 09:52, Liran Alon wrote:
>>> In addition, I think this module parameter should be in kvm module
>>> (not kvm_intel) and you should add similar logic to kvm_amd module
>> (SVM)
>> 
>> If you can move handle_ud to x86.c, then it makes sense to have the
>> module parameter in the kvm module.  I haven't checked.
> 
> I don't see a reason why you couldn't do that.
> 
>> 
>> Otherwise you would have to EXPORT_SYMBOL_GPL the variable; in the
> 
> This is what I did for enable_vmware_backdoor module parameter.
> I think this is what should be done in this case as-well.
> 
>> end
>> it's just a debugging tool, so it'd be simpler to just add it
>> separately
>> to kvm_intel and kvm_amd.
> 
> I agree it's just a debugging tool. But no reason for it to be used differently
> when running tests on Intel CPU vs. AMD CPU.
> I think the effort to fix this is low.
> 
>> 
>> Paolo
> 
> 
