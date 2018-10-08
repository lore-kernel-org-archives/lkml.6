Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4040C64EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8395020878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8395020878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbeJHPKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 11:10:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:43508 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725983AbeJHPKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 11:10:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7CA5CAD6D;
        Mon,  8 Oct 2018 08:00:19 +0000 (UTC)
Date:   Mon, 8 Oct 2018 10:00:13 +0200
From:   Borislav Petkov <bp@suse.de>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/mm] kdump, proc/vmcore: Enable kdumping encrypted
 memory with SME enabled
Message-ID: <20181008080013.GB6490@zn.tnic>
References: <be7b47f9-6be6-e0d1-2c2a-9125bc74b818@redhat.com>
 <tip-992b649a3f013465d8128da02e5449def662a4c3@git.kernel.org>
 <21eab36e-d113-cf88-e497-7dd620981544@redhat.com>
 <20181007084742.GA30797@zn.tnic>
 <58270f3f-f17c-8996-09cd-6da3481beb40@redhat.com>
 <20181008053714.GA6490@zn.tnic>
 <710b9d95-2f70-eadf-c4a1-c3dc80ee4ebb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <710b9d95-2f70-eadf-c4a1-c3dc80ee4ebb@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 03:11:56PM +0800, lijiang wrote:
> I used this ".config" to compile kernel in the attachment, and got a compile error.
> Would you like to have a try?
> 
> [root@hp-dl385g10-03 linux]# make ARCH=i386 -j32
>   ......
>   LD      vmlinux.o
>   MODPOST vmlinux.o
> fs/proc/vmcore.o：In function ‘read_from_oldmem’：
> /home/linux/fs/proc/vmcore.c:127：undefined reference to ‘copy_oldmem_page_encrypted’
> make: *** [vmlinux] error 1

Thanks, that triggered here. Ok, I guess something like this, to avoid
the ugly ifdeffery:

---
diff --git a/arch/x86/kernel/crash_dump_32.c b/arch/x86/kernel/crash_dump_32.c
index 33ee47670b99..8696800f2eea 100644
--- a/arch/x86/kernel/crash_dump_32.c
+++ b/arch/x86/kernel/crash_dump_32.c
@@ -80,6 +80,16 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 	return csize;
 }
 
+/*
+ * 32-bit parrot version to avoid build errors.
+ */
+ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
+				   unsigned long offset, int userbuf)
+{
+	WARN_ON_ONCE(1);
+	return copy_oldmem_page(pfn, buf, csize, offset, userbuf);
+}
+
 static int __init kdump_buf_page_init(void)
 {
 	int ret = 0;



-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
