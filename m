Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B978C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2D3206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 11:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qwySv7Ke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfBVLsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 06:48:08 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:45030 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfBVLsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 06:48:08 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1MBiFkw097900;
        Fri, 22 Feb 2019 11:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=2C9Ng6U9cOU7nqkoy3l21e5sJus8aWttTV0JL/Nl7nc=;
 b=qwySv7Ke5n0fOrnTumGpUk6HNFKHDnC+bFsICQEE4/ivIj33/VEEmsUzZ7J2VNsOthX/
 5I5lzp0WZcOgPTuIctWkVVrXcKTC1LHtiYtovtuRmI1VQitLPehxyKtV05GPkIB9PSbH
 OYBnlIm9sqXupkTOJzy0aks/4poZpDWLHxRrgy0Q2OjydbidPUV0yhKBOyXjhM4qYdod
 PQwJ2DN3IR5y4W9YyXrYBKJo1lbm+PZmPlLXOFwp/t+TV8zCSIFQa4OIBZVMHIFKHk9N
 l0Oq5vGJns8w7dcLT1osNMiNrZzvGmW8iyV3JmYMyLT6ViKg77C39jYQdnlOaGTc9btv yg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2qpb5rxr7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Feb 2019 11:47:47 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1MBllte012441
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Feb 2019 11:47:47 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1MBlkKK006503;
        Fri, 22 Feb 2019 11:47:46 GMT
Received: from [192.168.1.67] (/94.61.137.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 Feb 2019 03:47:46 -0800
From:   Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH RFC 01/39] KVM: x86: fix Xen hypercall page msr handling
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
 <20190220201609.28290-2-joao.m.martins@oracle.com>
 <20190222013008.GG7224@linux.intel.com>
Message-ID: <f6aa58f0-3ea8-6140-b1f2-58b909965bc3@oracle.com>
Date:   Fri, 22 Feb 2019 11:47:41 +0000
MIME-Version: 1.0
In-Reply-To: <20190222013008.GG7224@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9174 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902220084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/19 1:30 AM, Sean Christopherson wrote:
> On Wed, Feb 20, 2019 at 08:15:31PM +0000, Joao Martins wrote:
>> Xen usually places its MSR at 0x4000000 or 0x4000200 depending on
>> whether it is running in viridian mode or not. Note that this is not
>> ABI guaranteed, so it is possible for Xen to advertise the MSR some
>> place else.
>>
>> Given the way xen_hvm_config() is handled, if the former address is
>> selected, this will conflict with HyperV's MSR
>> (HV_X64_MSR_GUEST_OS_ID) which uses the same address.
> 
> Unconditionally servicing Hyper-V and KVM MSRs seems wrong, i.e. KVM
> should only expose MSRs specific to a hypervisor if userspace has
> configured CPUID to advertise support for said hypervisor.
>
Yeah, that makes sense.

> If we do the
> same thing for Xen, then the common MSR code looks like:
> 
> 	if (kvm_advertise_kvm()) {
> 		if (<handle kvm msr>)
> 			return ...;
> 	} else if (kvm_advertise_hyperv()) {
> 		if (<handle hyperv msr>)
> 			return ...;
> 	} else if (kvm_advertise_xen()) {
> 		if (<handle xen msrs>)
> 			return ...;
> 	}
> 
> 	<fall through to main switch statement>
> 
> Obviously assumes KVM only advertises itself as one hypervisor, and so
> the ordering is arbitrary.
> 
One thing to consider on the above is that there might be multiple hypervisors
in advertised in the hypervisor leaf. Which is used when you want to run a KVM
guest but with Hyper-V drivers, or an Hyper-V guest with KVM extensions or VirtIO.

The else part would probably need to be removed as IIUC when multiple
hypervisors are advertised (e.g. KVM in leaf 0x40000000, Hyper-V in leaf
0x40000100) you are still allowed to use all of its features.
