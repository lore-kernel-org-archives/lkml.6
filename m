Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081FDC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B167724B6E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B167724B6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754616AbeGCI1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:27:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:52592 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753560AbeGCI1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:27:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8946FACF3;
        Tue,  3 Jul 2018 08:27:19 +0000 (UTC)
Date:   Tue, 3 Jul 2018 10:27:18 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, willy@infradead.org,
        ldufour@linux.vnet.ibm.com, akpm@linux-foundation.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 PATCH 4/5] mm: mmap: zap pages with read mmap_sem for
 large mapping
Message-ID: <20180703082718.GF16767@dhcp22.suse.cz>
References: <1530311985-31251-1-git-send-email-yang.shi@linux.alibaba.com>
 <1530311985-31251-5-git-send-email-yang.shi@linux.alibaba.com>
 <20180702123350.dktmzlmztulmtrae@kshutemo-mobl1>
 <20180702124928.GQ19043@dhcp22.suse.cz>
 <20180703081205.3ue5722pb3ko4g2w@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703081205.3ue5722pb3ko4g2w@kshutemo-mobl1>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-07-18 11:12:05, Kirill A. Shutemov wrote:
> On Mon, Jul 02, 2018 at 02:49:28PM +0200, Michal Hocko wrote:
> > On Mon 02-07-18 15:33:50, Kirill A. Shutemov wrote:
> > [...]
> > > I probably miss the explanation somewhere, but what's wrong with allowing
> > > other thread to re-populate the VMA?
> > 
> > We have discussed that earlier and it boils down to how is racy access
> > to munmap supposed to behave. Right now we have either the original
> > content or SEGV. If we allow to simply madvise_dontneed before real
> > unmap we could get a new page as well. There might be (quite broken I
> > would say) user space code that would simply corrupt data silently that
> > way.
> 
> Okay, so we add a lot of complexity to accommodate broken userspace that
> may or may not exist. Is it right? :)

I would really love to do the most simple and obious thing

diff --git a/mm/mmap.c b/mm/mmap.c
index 336bee8c4e25..86ffb179c3b5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2811,6 +2811,8 @@ EXPORT_SYMBOL(vm_munmap);
 SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, len)
 {
 	profile_munmap(addr);
+	if (len > LARGE_NUMBER)
+		do_madvise(addr, len, MADV_DONTNEED);
 	return vm_munmap(addr, len);
 }
 
but the argument that current semantic of good data or SEGV on
racing threads is no longer preserved sounds valid to me. Remember
optimizations shouldn't eat your data. How do we ensure that we won't
corrupt data silently?

Besides that if this was so simple then we do not even need any kernel
code. You could do that from glibc resp. any munmap wrapper. So maybe
the proper answer is, if you do care then just help the system and
DONTNEED your data before you munmap as an optimization for large
mappings.
-- 
Michal Hocko
SUSE Labs
