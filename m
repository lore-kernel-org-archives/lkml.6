Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeB1GYL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 01:24:11 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:34178 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751682AbeB1GYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 01:24:09 -0500
X-Google-Smtp-Source: AG47ELt90JbiGC7w5Te5bw1kQkTsZqsFpGrkChcNo1SgOlW653vzbDJCCkQOG4NjpBXdhRinpwim/g==
Date: Wed, 28 Feb 2018 15:19:03 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Tyler Baicar <tbaicar@codeaurora.org>
Cc: ard.biesheuvel@linaro.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, jhugo@codeaurora.org,
        sgoel@codeaurora.org, timur@codeaurora.org
Subject: Re: [PATCH 0/2] ESRT fixes for relocatable kexec'd kernel
Message-ID: <20180228061901.GJ6019@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Tyler Baicar <tbaicar@codeaurora.org>, ard.biesheuvel@linaro.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhugo@codeaurora.org, sgoel@codeaurora.org, timur@codeaurora.org
References: <1519414953-5478-1-git-send-email-tbaicar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519414953-5478-1-git-send-email-tbaicar@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tyler,

# I missed catching your patch as its subject doesn't contain arm64.

On Fri, Feb 23, 2018 at 12:42:31PM -0700, Tyler Baicar wrote:
> Currently on arm64 ESRT memory does not appear to be properly blocked off.
> Upon successful initialization, ESRT prints out the memory region that it
> exists in like:
> 
> esrt: Reserving ESRT space from 0x000000000a4c1c18 to 0x000000000a4c1cf0.
> 
> But then by dumping /proc/iomem this region appears as part of System RAM
> rather than being reserved:
> 
> 08f10000-0deeffff : System RAM
> 
> This causes issues when trying to kexec if the kernel is relocatable. When
> kexec tries to execute, this memory can be selected to relocate the kernel to
> which then overwrites all the ESRT information. Then when the kexec'd kernel
> tries to initialize ESRT, it doesn't recognize the ESRT version number and
> just returns from efi_esrt_init().

I'm not sure what is the root cause of your problem.
Do you have good confidence that the kernel (2nd kernel image in this case?)
really overwrite ESRT region?
To my best knowledge, kexec is carefully designed not to do such a thing
as it allocates a temporary buffer for kernel image and copies it to the
final destination at the very end of the 1st kernel.

My guess is that kexec, or rather kexec-tools, tries to load the kernel image
at 0x8f80000 (or 0x9080000?, not sure) in your case. It may or may not be
overlapped with ESRT.
(Try "-d" option when executing kexec command for confirmation.)

Are you using initrd with kexec?

Thanks,
-Takahiro AKASHI


> This causes an early ioremap leak because
> the memory allocated for 'va' is never unmapped. So first fix that error
> case to properly unmap 'va' before returning.
> 
> This still leaves ESRT unable to initialize in the kexec'd kernel, so now
> mark the ESRT memory block as nomap so that this memory is not treated as
> System RAM. With this change I'm able to see that the ESRT data is not
> overwritten when running a kexec'd kernel.
> 
> Tyler Baicar (2):
>   efi/esrt: fix unsupported version initialization failure
>   efi/esrt: mark ESRT memory region as nomap
> 
>  drivers/firmware/efi/esrt.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> -- 
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project.
> 
