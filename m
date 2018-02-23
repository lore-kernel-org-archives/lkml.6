Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752421AbeBWXi0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 18:38:26 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751952AbeBWXiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 18:38:25 -0500
Subject: Re: [PATCH v3 0/2] KVM: MSR-based features
To: Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <20180221193941.12005.34137.stgit@tlendack-t1.amdoffice.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cb405817-0bc5-fdea-baa7-e11e4a7a4163@redhat.com>
Date: Sat, 24 Feb 2018 00:38:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221193941.12005.34137.stgit@tlendack-t1.amdoffice.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2018 20:39, Tom Lendacky wrote:
> The following series implements support within KVM for MSR-based features.
> The first patch creates the MSR-based feature framework used to retrieve
> the available MSR-based features.  The second patch makes use of the
> framework to allow a guest to determine if the LFENCE instruction is
> serializing on AMD processors.
> 
> This series is based on the master branch of the KVM git tree.
> 
> https://git.kernel.org/pub/scm/virt/kvm/kvm.git

I made a couple adjustments:

- use a system (/dev/kvm) ioctl, which unfortunately means a new ioctl
#define but is more consistent with KVM_GET_SUPPORTED_CPUID and
KVM_GET_MSR_INDEX_LIST

- rename msr_feature to get_msr_feature

Please take a look at kvm/queue! Thanks,

Paolo

> ---
> 
> Changes from v2:
> - Moved back to initializing the MSR-based feature list in kvm_init_msr_list()
>   (based on the kvm_x86_ops callback return code)
> - Removed the definition of KVM_GET_MSR and switched back to using KVM_GET_MSRS
> - Consolidated the documentation to group the ioctl usage and describe the usage
>   specific to the version of the ioctl used.
> 
> Tom Lendacky (2):
>       KVM: x86: Add a framework for supporting MSR-based features
>       KVM: SVM: Add MSR-based feature support for serializing LFENCE
> 
> 
>  Documentation/virtual/kvm/api.txt |   29 +++++++++++----
>  arch/x86/include/asm/kvm_host.h   |    2 +
>  arch/x86/kvm/svm.c                |   43 ++++++++++++++++++++++
>  arch/x86/kvm/x86.c                |   72 +++++++++++++++++++++++++++++++++++--
>  include/uapi/linux/kvm.h          |    1 +
>  5 files changed, 136 insertions(+), 11 deletions(-)
> 
