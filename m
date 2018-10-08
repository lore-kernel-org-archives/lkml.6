Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E206C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9AA20858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:44:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC9AA20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbeJHUzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:55:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:49462 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726056AbeJHUzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:55:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 13F7EABE3;
        Mon,  8 Oct 2018 13:44:06 +0000 (UTC)
Date:   Mon, 8 Oct 2018 15:43:59 +0200
From:   Borislav Petkov <bp@suse.de>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/mm] kdump, proc/vmcore: Enable kdumping encrypted
 memory with SME enabled
Message-ID: <20181008134359.GF6490@zn.tnic>
References: <be7b47f9-6be6-e0d1-2c2a-9125bc74b818@redhat.com>
 <tip-992b649a3f013465d8128da02e5449def662a4c3@git.kernel.org>
 <21eab36e-d113-cf88-e497-7dd620981544@redhat.com>
 <20181007084742.GA30797@zn.tnic>
 <58270f3f-f17c-8996-09cd-6da3481beb40@redhat.com>
 <20181008053714.GA6490@zn.tnic>
 <710b9d95-2f70-eadf-c4a1-c3dc80ee4ebb@redhat.com>
 <20181008080013.GB6490@zn.tnic>
 <8147597a-f8e0-7f1a-bd2b-e914b18c5c74@redhat.com>
 <20181008085909.GC6490@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181008085909.GC6490@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 10:59:09AM +0200, Borislav Petkov wrote:
> On Mon, Oct 08, 2018 at 04:47:34PM +0800, lijiang wrote:
> > It looks like a good way to avoid the 'ifdefined', and it's also good enough for i386.
> > 
> > But for other architectures, such as POWERPC/ARM..., we will also have to add the same 
> > function for every architecture. Otherwise, i guess that they also have a same compile
> > error on other architectures.
> 
> Yap, just realized that and looking at the rest of fs/proc/vmcore.c -
> such functions are defined with the __weak attribute. Lemme see if that
> works better.

Seems so. I'll hammer on it more today:

---
 fs/proc/vmcore.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 42c32d06f7da..91ae16fbd7d5 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -187,6 +187,16 @@ int __weak remap_oldmem_pfn_range(struct vm_area_struct *vma,
 	return remap_pfn_range(vma, from, pfn, size, prot);
 }
 
+/*
+ * Architectures which support memory encryption override this.
+ */
+ssize_t __weak
+copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
+			   unsigned long offset, int userbuf)
+{
+	return copy_oldmem_page(pfn, buf, csize, offset, userbuf);
+}
+
 /*
  * Copy to either kernel or user space
  */
-- 
2.19.0.271.gfe8321ec057f

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
