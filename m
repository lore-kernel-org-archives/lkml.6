Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CA4C282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E11218A6
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jv3prsbY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfBBJlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 04:41:35 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42426 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfBBJld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 04:41:33 -0500
Received: by mail-ed1-f66.google.com with SMTP id y20so7435136edw.9
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 01:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bEfMhHDa9MBTeWUj0T9jDKJ2/Es/s2oL+argjHikJPY=;
        b=jv3prsbYfPGToN9VYrtVBCDnGVwI8FCguEqVr+vLr2YpkkYZHDJMVCxtU+fiLdmTpN
         zmvoRLA4S3QqE5tsaD9iSZh5IiG8DQu+09Or4V6zx5yVIlyDo9qkJov7pM0wG/Yw4Rc2
         NdocXwjOLMUrNN6GL6G3VW1GlFlkMkZUxgxaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bEfMhHDa9MBTeWUj0T9jDKJ2/Es/s2oL+argjHikJPY=;
        b=MguvFMtxzal2gH7q7avAy2PCWND/ytXmeueTZ4uR+8ye4k2qF/oRRSWhgdAA2Pd7Vc
         ibSBzywRS0LVdVwPd8bkLDGpuO82osvF6Bi5Yl2pbkx4vqG9HGac33TkoeVipka3IrA8
         H3mpzXW/xkTL9hhfNfVGqEl0QoB2393cM9tzLS1Y6g2eSsve9Bzt2HXfLxtWNpLCk7+L
         RL5s14y8WJhsRxWlZsoiPROCOA7hGRSIr6JoFFvBHEgXuHggeuYdu4TSeXyNgQgTQfjO
         baWaVJwicSwF/7U7ywsmCpJ6qCsBtllPrt62QTeTbHp+GrTe4VDz7tbCXuZIxvkQQMG0
         Pd5Q==
X-Gm-Message-State: AJcUukfliDTKT4b0xAS395ve9/otMFNdoya8Ttp8kZ7t2XcDPuY9eb+F
        QwKj5uqc42jsDAA+jUrAXucpVA==
X-Google-Smtp-Source: ALg8bN5J8Eb8YoqX6cCLVy/fE2X+UWuHh+56F2oHTCzUElIYEd4HSRJBNkwvwKt6sCd5el30G7WBfw==
X-Received: by 2002:a50:ba5c:: with SMTP id 28mr41749211eds.91.1549100491572;
        Sat, 02 Feb 2019 01:41:31 -0800 (PST)
Received: from mba13.c.hoisthospitality.com ([109.236.135.164])
        by smtp.gmail.com with ESMTPSA id l41sm2608824eda.83.2019.02.02.01.41.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 01:41:30 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [PATCH 03/10] efi: memattr: don't bail on zero VA if it equals the region's PA
Date:   Sat,  2 Feb 2019 10:41:12 +0100
Message-Id: <20190202094119.13230-4-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190202094119.13230-1-ard.biesheuvel@linaro.org>
References: <20190202094119.13230-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EFI memory attributes code cross-references the EFI memory map with
the more granular EFI memory attributes table to ensure that they are in
sync before applying the strict permissions to the regions it describes.

Since we always install virtual mappings for the EFI runtime regions to
which these strict permissions apply, we currently perform a sanity check
on the EFI memory descriptor, and ensure that the EFI_MEMORY_RUNTIME bit
is set, and that the virtual address has been assigned.

However, in cases where a runtime region exists at physical address 0x0,
and the virtual mapping equals the physical mapping, e.g., when running
in mixed mode on x86, we encounter a memory descriptor with the runtime
attribute and virtual address 0x0, and incorrectly draw the conclusion
that a runtime region exists for which no virtual mapping was installed,
and give up altogether. The consequence of this is that firmware mappings
retain their read-write-execute permissions, making the system more
vulnerable to attacks.

So let's only bail if the virtual address of 0x0 has been assigned to a
physical region that does not reside at address 0x0.

Fixes: 10f0d2f577053 ("efi: Implement generic support for the Memory ...")
Acked-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/memattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
index 8986757eafaf..aac972b056d9 100644
--- a/drivers/firmware/efi/memattr.c
+++ b/drivers/firmware/efi/memattr.c
@@ -94,7 +94,7 @@ static bool entry_is_valid(const efi_memory_desc_t *in, efi_memory_desc_t *out)
 
 		if (!(md->attribute & EFI_MEMORY_RUNTIME))
 			continue;
-		if (md->virt_addr == 0) {
+		if (md->virt_addr == 0 && md->phys_addr != 0) {
 			/* no virtual mapping has been installed by the stub */
 			break;
 		}
-- 
2.17.1

