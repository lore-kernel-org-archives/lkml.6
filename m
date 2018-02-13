Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965173AbeBMPON (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:14:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43228 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965054AbeBMPOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:14:11 -0500
Subject: Re: [patch] kvm: suppress KVM_SET_GSI_ROUTING allocation failure
To: David Rientjes <rientjes@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <alpine.DEB.2.10.1802081334120.133173@chino.kir.corp.google.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 13 Feb 2018 16:14:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1802081334120.133173@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18021315-0012-0000-0000-000005AE4D29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021315-0013-0000-0000-0000192A1554
Message-Id: <47a55220-0006-6486-5a9d-1d1142efcc47@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-13_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802130180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/08/2018 10:35 PM, David Rientjes wrote:
> The KVM_SET_GSI_ROUTING ioctl does a vmalloc() of
> sizeof(struct kvm_irq_routing_entry) multiplied by a user-supplied value.
> This can be up to 4096 entries on architectures such as arm64 and s390
> (and the upper bound may be increased on s390 eventually).
> 
> This can produce a vmalloc allocation failure warning:
> 
[...]
>  kvm_vm_ioctl+0x910/0x15e0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4153

                                                                       ^^^^^

> @@ -3063,7 +3063,8 @@ static long kvm_vm_ioctl(struct file *filp,

      ^^^^^


Are you sure that you got the right vmalloc?


>  			goto out;
>  		if (routing.nr) {
>  			r = -ENOMEM;
> -			entries = vmalloc(routing.nr * sizeof(*entries));
> +			entries = __vmalloc(routing.nr * sizeof(*entries),
> +					GFP_KERNEL | __GFP_NOWARN, PAGE_KERNEL);
>  			if (!entries)
>  				goto out;
>  			r = -EFAULT;
> 
