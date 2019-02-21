Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5A3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2868220818
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="v/yujilo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfBUU4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 15:56:32 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:58312 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfBUU4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 15:56:32 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1LKnT8X135715;
        Thu, 21 Feb 2019 20:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=GAYiQfikElUCJ+tuWkFXEkJ6hrDbvTfboL2Nu7/SVhc=;
 b=v/yujilo7snk1Be2I1C9UILAih/OlP/3MKYxyf/2q5jQThMki2RcaMMZr17Hxx330IiQ
 jfZq3rhaEH4peE23dwDeRssxouCT9zFS2FF4fo3X9zpjem+rJv6gYB8wlGJ5nhCpCHKa
 uR5QJdwobT2nEwqTvHmKXzD6a1dYW6KyVX7uErsfS1AG8ZDyK7HZAXPjMTFoPSCka0vE
 r/Yl/zThQRC/tVUJzvFbbFGJXSOR7GWG27ol/CZmaBh2kEL9XVH1+7OGlPY1FXZdXqof
 hudCCnwFjaZToVPqRLZyRqYM21wHKx7HtGEm3rbJA4b3E9J8mwubikF+9mpJcFFQCnY5 VQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2qp9xuatdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 20:56:14 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1LKuDNp022479
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 20:56:13 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1LKuCTj004016;
        Thu, 21 Feb 2019 20:56:12 GMT
Received: from [10.175.213.26] (/10.175.213.26)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Feb 2019 12:56:11 -0800
Subject: Re: [PATCH RFC 02/39] KVM: x86/xen: intercept xen hypercalls if
 enabled
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
 <20190220201609.28290-3-joao.m.martins@oracle.com>
 <20190221182910.GC7224@linux.intel.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <1f6a2410-f9da-15ed-327c-7d8c1255368b@oracle.com>
Date:   Thu, 21 Feb 2019 20:56:06 +0000
MIME-Version: 1.0
In-Reply-To: <20190221182910.GC7224@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9174 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902210142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/19 6:29 PM, Sean Christopherson wrote:
> On Wed, Feb 20, 2019 at 08:15:32PM +0000, Joao Martins wrote:
>> Add a new exit reason for emulator to handle Xen hypercalls.
>> Albeit these are injected only if guest has initialized the Xen
>> hypercall page - the hypercall is just a convenience but one
>> that is done by pretty much all guests. Hence if the guest
>> sets the hypercall page, we assume a Xen guest is going to
>> be set up.
>>
>> Emulator will then panic with:
>>
>> KVM: unknown exit reason 28
>> RAX=0000000000000011 RBX=ffffffff81e03e94 RCX=0000000040000000
>> RDX=0000000000000000
>> RSI=ffffffff81e03e70 RDI=0000000000000006 RBP=ffffffff81e03e90
>> RSP=ffffffff81e03e68
>> R8 =73726576206e6558 R9 =ffffffff81e03e90 R10=ffffffff81e03e94
>> R11=2e362e34206e6f69
>> R12=0000000040000004 R13=ffffffff81e03e8c R14=ffffffff81e03e88
>> R15=0000000000000000
>> RIP=ffffffff81001228 RFL=00000082 [--S----] CPL=0 II=0 A20=1 SMM=0 HLT=0
>> ES =0000 0000000000000000 ffffffff 00c00000
>> CS =0010 0000000000000000 ffffffff 00a09b00 DPL=0 CS64 [-RA]
>> SS =0000 0000000000000000 ffffffff 00c00000
>> DS =0000 0000000000000000 ffffffff 00c00000
>> FS =0000 0000000000000000 ffffffff 00c00000
>> GS =0000 ffffffff81f34000 ffffffff 00c00000
>> LDT=0000 0000000000000000 ffffffff 00c00000
>> TR =0020 0000000000000000 00000fff 00808b00 DPL=0 TSS64-busy
>> GDT=     ffffffff81f3c000 0000007f
>> IDT=     ffffffff83265000 00000fff
>> CR0=80050033 CR2=ffff880001fa6ff8 CR3=0000000001fa6000 CR4=000406a0
>> DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000
>> DR3=0000000000000000
>> DR6=00000000ffff0ff0 DR7=0000000000000400
>> EFER=0000000000000d01
>> Code=cc cc cc cc cc cc cc cc cc cc cc cc b8 11 00 00 00 0f 01 c1 <c3> cc
>> cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc b8 12
>> 00 00 00 0f
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>  arch/x86/include/asm/kvm_host.h | 13 +++++++
>>  arch/x86/kvm/Makefile           |  2 +-
>>  arch/x86/kvm/trace.h            | 33 +++++++++++++++++
>>  arch/x86/kvm/x86.c              | 12 +++++++
>>  arch/x86/kvm/xen.c              | 79 +++++++++++++++++++++++++++++++++++++++++
>>  arch/x86/kvm/xen.h              | 10 ++++++
>>  include/uapi/linux/kvm.h        | 17 ++++++++-
>>  7 files changed, 164 insertions(+), 2 deletions(-)
>>  create mode 100644 arch/x86/kvm/xen.c
>>  create mode 100644 arch/x86/kvm/xen.h
> 
> ...
> 
>> diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
>> index 31ecf7a76d5a..2b46c93c9380 100644
>> --- a/arch/x86/kvm/Makefile
>> +++ b/arch/x86/kvm/Makefile
>> @@ -10,7 +10,7 @@ kvm-$(CONFIG_KVM_ASYNC_PF)	+= $(KVM)/async_pf.o
>>  
>>  kvm-y			+= x86.o mmu.o emulate.o i8259.o irq.o lapic.o \
>>  			   i8254.o ioapic.o irq_comm.o cpuid.o pmu.o mtrr.o \
>> -			   hyperv.o page_track.o debugfs.o
>> +			   hyperv.o xen.o page_track.o debugfs.o
> 
> Can this be wrapped in a config?  Or even better, as a loadable module?

Turning that into a loadable module might be a little trickier, but I think it
is doable if that's what folks/maintainers would prefer.

The Xen addition follows the same structure as Hyper-V in kvm (what you suggest
here is probably applicable for both). i.e. there's some Xen specific routines
for vm/vcpu init/teardown, and timer handling. We would have to place some of
those functions into a struct that gets registered at modinit.

> 2k+ lines of code is a non-trival amount of baggage for folks that don't
> care about running Xen guests.  I've only glanced through the series, so
> I've no idea if the resulting code would be an abomination.
> 
>>  
>>  kvm-intel-y		+= vmx/vmx.o vmx/vmenter.o vmx/pmu_intel.o vmx/vmcs12.o vmx/evmcs.o vmx/nested.o
>>  kvm-amd-y		+= svm.o pmu_amd.o
