Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B99C46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 06:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C80320873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 06:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C80320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbeG3H6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 03:58:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46957 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbeG3H6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 03:58:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id p23-v6so6658267pgv.13
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 23:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kt9ZQAiJsVNxoMrMkwqek1esIb3BwXrUZQNVQU45+VI=;
        b=GCeReiztOQvOB+MpXCEBJIyCQlbNdgsCOBq4GEBpOTqLbkT5Tc+FkoJiHXyFa7Af1p
         pUWXvypGjOZBLf9VNPbGadtALlkVeZmjSKXXNv5zdQhujLkkuDNUNSzMg8ksqYfERmxy
         YwI4AxD0IALz25iFTbZYOeoA12JPKwHpeV2OaVM0lCYwMqeBh/QRGmOAi7nViYosVwat
         RtgHJKJJ7W9nNTgrMAPe2hZ/DpRFI5Ng7iapGEgwmrtaTef3CJ1iFf20YiUHbqw2F4Tn
         o0rBJX8a720jDSlCRDFOzvJ1CsTTfl/e2b+tzGSGcoJGNaMNU1i6SnXZi0j4suj7xpUl
         EN7Q==
X-Gm-Message-State: AOUpUlFe8kqyYyq5mYFd6l1Nwe8isIM6Lpr25YbefQ1BMLl/Ow0uEIU+
        oNufPY9iI7OyzEAW5gKF59+NDA==
X-Google-Smtp-Source: AAOMgpeOGkQYieWQnz5sv/3hZiuPjm/Pmd3lMiLk6fsHRhsStmy/7g3N+k9odeUDdmV+OURtjz/NLw==
X-Received: by 2002:a63:342:: with SMTP id 63-v6mr14856268pgd.290.1532931908322;
        Sun, 29 Jul 2018 23:25:08 -0700 (PDT)
Received: from localhost ([122.177.135.53])
        by smtp.gmail.com with ESMTPSA id d18-v6sm11915423pgo.74.2018.07.29.23.25.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 23:25:06 -0700 (PDT)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        bhupesh.linux@gmail.com, takahiro.akashi@linaro.org,
        catalin.marinas@arm.com, Bhupesh Sharma <bhsharma@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH v2] arm64, kaslr: export offset in VMCOREINFO ELF notes
Date:   Mon, 30 Jul 2018 11:54:43 +0530
Message-Id: <1532931883-16132-1-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include KASLR offset in arm64 VMCOREINFO ELF notes to assist in
debugging. vmcore parsing in user-space already expects this value in
the notes and we are providing it for portability of those existing
tools with x86.

Ideally we would like core code to do this (so that way this
information won't be missed when an architecture adds KASLR support),
but mips has CONFIG_RANDOMIZE_BASE, and doesn't provide kaslr_offset(),
so I am not sure if this is needed for mips (and other such similar arch
cases in future). So, lets keep this architecture specific for now.

As an example of a user-space use-case, consider the
makedumpfile user-space utility which will need fixup to use this
KASLR offset to work with cases where we need to find a way to
translate symbol address from vmlinux to kernel run time address
in case of KASLR boot on arm64.

I have already submitted the makedumpfile user-space patch upstream
and the maintainer has suggested to wait for the kernel changes to be
included (see [0]).

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

[0] https://www.spinics.net/lists/kexec/msg21195.html

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
Changes since v1:
 - Addressed review comments from James regarding commit log
 - v1 can be viewed here: https://lkml.org/lkml/2018/7/18/951
 - v2 is rebased against linux-next/master

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

