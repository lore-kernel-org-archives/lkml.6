Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE0EC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F3162083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o4wN7uA0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F3162083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbeJZEBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 00:01:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43886 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725725AbeJZEBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 00:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zzyR8uR1qt+Q/p/5QV3n1p9nX2lzQPMWIgefNGc6IN0=; b=o4wN7uA0UtKcMsyOAUrkRv+Pm
        CBWc/PtyJw3oIB/uFhWEHdw2dARUiWVMIt/KpeGyIS5dA6cbFUamskAXNfvPUR/6CZqi1NqnN9N0W
        eGerRGz3ULcNQPdUsANpdf1qAVMdirvwpKTyNQQNIvjAs0As3yYZDScqcFcgmi8RioL9C8Q82CsuI
        oU1JoeoIddIatJ6rDRj8fCokfOdC+3GWmh7NRK3ImgQEXTxT44uO3ooHPhNl+WwJnUNHQIcjz/LlQ
        ridPYcfSyNsREGPe7vH5LBZ4YdD3OXDfu6eU+TjKRpoV+wsifluzEjHHtRpQ5I/8hloqQDEBSnGfb
        X2tFDSFEQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFlHa-0001sr-6r; Thu, 25 Oct 2018 19:27:02 +0000
Date:   Thu, 25 Oct 2018 12:27:01 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     miles.chen@mediatek.com
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        wsd_upstream@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] mm/page_owner: use vmalloc instead of kmalloc
Message-ID: <20181025192701.GK25444@bombadil.infradead.org>
References: <1540492481-4144-1-git-send-email-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540492481-4144-1-git-send-email-miles.chen@mediatek.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 02:34:41AM +0800, miles.chen@mediatek.com wrote:
> The kbuf used by page owner is allocated by kmalloc(),
> which means it can use only normal memory and there might
> be a "out of memory" issue when we're out of normal memory.
> 
> Use vmalloc() so we can also allocate kbuf from highmem
> on 32bit kernel.

... hang on, there's a bigger problem here.

static const struct file_operations proc_page_owner_operations = {
        .read           = read_page_owner,
};

read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
{
...
                return print_page_owner(buf, count, pfn, page,
                                page_owner, handle);
}

static ssize_t
print_page_owner(char __user *buf, size_t count, unsigned long pfn,
                struct page *page, struct page_owner *page_owner,
                depot_stack_handle_t handle)
{
...
      kbuf = kmalloc(count, GFP_KERNEL);

So I can force the kernel to make an arbitrary size allocation, triggering
OOMs and forcing swapping if I can get a file handle to this file.
The only saving grace is that (a) this is a debugfs file and (b) it's
root-only (mode 0400).  Nevertheless, I feel some clamping is called
for here.  Do we really need to output more than 4kB worth of text here?

