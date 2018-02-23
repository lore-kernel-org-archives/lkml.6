Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934144AbeBWTmk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 14:42:40 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57336 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754691AbeBWTmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 14:42:37 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 06D2C6079B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tbaicar@codeaurora.org
From: Tyler Baicar <tbaicar@codeaurora.org>
To: ard.biesheuvel@linaro.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, jhugo@codeaurora.org,
        sgoel@codeaurora.org, takahiro.akashi@linaro.org, timur@codeaurora.org
Cc: Tyler Baicar <tbaicar@codeaurora.org>
Subject: [PATCH 0/2] ESRT fixes for relocatable kexec'd kernel
Date: Fri, 23 Feb 2018 12:42:31 -0700
Message-Id: <1519414953-5478-1-git-send-email-tbaicar@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently on arm64 ESRT memory does not appear to be properly blocked off.
Upon successful initialization, ESRT prints out the memory region that it
exists in like:

esrt: Reserving ESRT space from 0x000000000a4c1c18 to 0x000000000a4c1cf0.

But then by dumping /proc/iomem this region appears as part of System RAM
rather than being reserved:

08f10000-0deeffff : System RAM

This causes issues when trying to kexec if the kernel is relocatable. When
kexec tries to execute, this memory can be selected to relocate the kernel to
which then overwrites all the ESRT information. Then when the kexec'd kernel
tries to initialize ESRT, it doesn't recognize the ESRT version number and
just returns from efi_esrt_init(). This causes an early ioremap leak because
the memory allocated for 'va' is never unmapped. So first fix that error
case to properly unmap 'va' before returning.

This still leaves ESRT unable to initialize in the kexec'd kernel, so now
mark the ESRT memory block as nomap so that this memory is not treated as
System RAM. With this change I'm able to see that the ESRT data is not
overwritten when running a kexec'd kernel.

Tyler Baicar (2):
  efi/esrt: fix unsupported version initialization failure
  efi/esrt: mark ESRT memory region as nomap

 drivers/firmware/efi/esrt.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
