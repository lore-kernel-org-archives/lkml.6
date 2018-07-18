Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E94ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32F620850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F32F620850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbeGRWRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:17:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35841 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbeGRWRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:17:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id m19-v6so2585925pgv.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 14:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GBK6tzyDUvOa6mQFoL7jPStc6L4dBwNl9kDKqprSzg4=;
        b=JZ4JHfr+lL9eMGuNYFqMT38XmQ4myz37w3nonhoaIj9oz6jfhBAwOpPPFBJ1KRxZ2V
         r571JNcM7CyJ6zIGrcDByD1KxDYIvc17NeOKsLwKrzu1VMfVZ/2tQpRHPVVwP0BKFyC+
         7aOAOit1enh8YiJ5UQYJ/9vRxO1dQ5ibLc5JplTGqXe6MaWFgQ+oXfI8xXR3hZeAg2jN
         G1BSikDF40eZMJsKS7AA10E2vCr8TFfK2pxZ5r9g9bTU9fqCsoNrvfDF5XnrLCLXYoU4
         TGf+E6HtoGI2LGvgriHbMqdu/QW4UKkpyWZB5Ro1zN3RECgXIdt0DOGV/vhvHp1YvKmQ
         3RiA==
X-Gm-Message-State: AOUpUlEcldGsmjlhWzs0N8pW6FnL8VpUHwDfMZbrZq4qV6Sp+NjqUrDL
        iWX1Y+mKm/5EHI0DtaXhMxuxoQ==
X-Google-Smtp-Source: AAOMgpfZKOjiL1DUYHUns1nnV3pmwAQhxP6zYn6cmcxEqnLU0UvMnUBy1IWsHt3NZeElfQL5QEm9UQ==
X-Received: by 2002:a63:a44a:: with SMTP id c10-v6mr7261837pgp.198.1531949882233;
        Wed, 18 Jul 2018 14:38:02 -0700 (PDT)
Received: from localhost ([2405:204:1408:e6f0:4529:2779:e150:51d8])
        by smtp.gmail.com with ESMTPSA id d9-v6sm9155364pfb.86.2018.07.18.14.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 14:38:00 -0700 (PDT)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        bhupesh.linux@gmail.com, takahiro.akashi@linaro.org,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH] arm64, kaslr: export offset in VMCOREINFO ELF notes
Date:   Thu, 19 Jul 2018 03:07:44 +0530
Message-Id: <1531949864-27447-1-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include KASLR offset in VMCOREINFO ELF notes to assist in debugging.

makedumpfile user-space utility will need fixup to use this KASLR offset
to work with cases where we need to find a way to translate symbol
address from vmlinux to kernel run time address in case of KASLR boot on
arm64.

I already have those fixup ready, which will be sent upstream once this
patch makes through (see [0]).

I tested this on my qualcomm amberwing board both for KASLR and
non-KASLR boot cases:

Without this patch:
   # cat > scrub.conf << EOF
   [vmlinux]
   erase jiffies
   erase init_task.utime
   for tsk in init_task.tasks.next within task_struct:tasks
       erase tsk.utime
   endfor
   EOF

  # makedumpfile --split -d 31 -x vmlinux --config scrub.conf vmcore dumpfile_{1,2,3}
  readpage_elf: Attempt to read non-existent page at 0xffffa8a5bf180000.
  readmem: type_addr: 1, addr:ffffa8a5bf180000, size:8
  vaddr_to_paddr_arm64: Can't read pgd
  readmem: Can't convert a virtual address(ffff0000092a542c) to physical
  address.
  readmem: type_addr: 0, addr:ffff0000092a542c, size:390
  check_release: Can't get the address of system_utsname

After this patch check_release() is ok, and also we are able to erase
symbol from vmcore (I checked this with kernel 4.18.0-rc4+):

  # makedumpfile --split -d 31 -x vmlinux --config scrub.conf vmcore dumpfile_{1,2,3}
  The kernel version is not supported.
  The makedumpfile operation may be incomplete.
  Checking for memory holes                         : [100.0 %] \
  Checking for memory holes                         : [100.0 %] |
  Checking foExcluding unnecessary pages                       : [100.0 %]
  \
  Excluding unnecessary pages                       : [100.0 %] \

  The dumpfiles are saved to dumpfile_1, dumpfile_2, and dumpfile_3.

  makedumpfile Completed.

[0] https://github.com/bhupesh-sharma/makedumpfile/commit/555e5ae0fb2b21797c450ad55950e81c470224ef

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 arch/arm64/kernel/machine_kexec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index f62effc6e064..028df356a5fd 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -360,4 +360,5 @@ void arch_crash_save_vmcoreinfo(void)
 						kimage_voffset);
 	vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=0x%llx\n",
 						PHYS_OFFSET);
+	vmcoreinfo_append_str("KERNELOFFSET=%lx\n", kaslr_offset());
 }
-- 
2.7.4

