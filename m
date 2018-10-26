Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF38C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA6220856
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA6220856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeJZTdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 15:33:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:47588 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726275AbeJZTdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 15:33:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 76A82AE86;
        Fri, 26 Oct 2018 10:56:58 +0000 (UTC)
Date:   Fri, 26 Oct 2018 12:56:56 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     miles.chen@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        wsd_upstream@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] mm/page_owner: use vmalloc instead of kmalloc
Message-ID: <20181026085410.GA8277@dhcp22.suse.cz>
References: <1540492481-4144-1-git-send-email-miles.chen@mediatek.com>
 <20181025192701.GK25444@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025192701.GK25444@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-10-18 12:27:01, Matthew Wilcox wrote:
> On Fri, Oct 26, 2018 at 02:34:41AM +0800, miles.chen@mediatek.com wrote:
> > The kbuf used by page owner is allocated by kmalloc(),
> > which means it can use only normal memory and there might
> > be a "out of memory" issue when we're out of normal memory.
> > 
> > Use vmalloc() so we can also allocate kbuf from highmem
> > on 32bit kernel.
> 
> ... hang on, there's a bigger problem here.
> 
> static const struct file_operations proc_page_owner_operations = {
>         .read           = read_page_owner,
> };
> 
> read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
> {
> ...
>                 return print_page_owner(buf, count, pfn, page,
>                                 page_owner, handle);
> }
> 
> static ssize_t
> print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>                 struct page *page, struct page_owner *page_owner,
>                 depot_stack_handle_t handle)
> {
> ...
>       kbuf = kmalloc(count, GFP_KERNEL);
> 
> So I can force the kernel to make an arbitrary size allocation, triggering
> OOMs and forcing swapping if I can get a file handle to this file.
> The only saving grace is that (a) this is a debugfs file and (b) it's
> root-only (mode 0400).  Nevertheless, I feel some clamping is called
> for here.  Do we really need to output more than 4kB worth of text here?

Completely agreed. Let's just clamp it to a single page. Userspace can
easily loop around the syscall.

-- 
Michal Hocko
SUSE Labs
