Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED97C5AC75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 14:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6376721871
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 14:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jh8+OdWx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbeLXOk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 09:40:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43554 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbeLXOk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 09:40:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=v4OHpWESPR164irYocQK6fY/AYz7cBTOjf+M/A7kqfc=; b=jh8+OdWxWoTS5QRW0xdl2L1JT
        EjNZTLznDrjhazbcwdHKVp2nZF6ZwHbbqS7Ck0oThTVNfsN76DqEhjpwo0APYfyawq8RxHnO6gi22
        mQMwwfAiHao/E0R8XaOJtA6AacgrOgGhf29EMKo1HcYNrd+FxWSqzvyffQuJHjiGcv9CcMIhk4D4o
        9tr5/dciDRC/NmPejykl5SCat1mo14oGj0bqEIcK+1h2fM9j/Fseiu69JPj3KcQtGoBpjekcNIL05
        WdOX29KX/sIxqtYPXGR2cMLZjhhbtXDODCT/bjERMIhtSfisr6uo9dVy9+TTmMmlQ4uGL1CsLyAus
        ExvLaQF+A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gbRP4-0004vp-3m; Mon, 24 Dec 2018 14:40:22 +0000
Date:   Mon, 24 Dec 2018 06:40:21 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Greg Hackmann <ghackmann@android.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Omer Tripp <trippo@google.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] fs: fix possible Spectre V1 indexing in __close_fd()
Message-ID: <20181224144021.GN10600@bombadil.infradead.org>
References: <20181224142642.7385-1-ghackmann@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181224142642.7385-1-ghackmann@android.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 06:26:42AM -0800, Greg Hackmann wrote:
> +++ b/fs/file.c
> @@ -18,6 +18,7 @@
>  #include <linux/bitops.h>
>  #include <linux/spinlock.h>
>  #include <linux/rcupdate.h>
> +#include <linux/nospec.h>
>  
>  unsigned int sysctl_nr_open __read_mostly = 1024*1024;
>  unsigned int sysctl_nr_open_min = BITS_PER_LONG;
> @@ -626,6 +627,7 @@ int __close_fd(struct files_struct *files, unsigned fd)
>  	fdt = files_fdtable(files);
>  	if (fd >= fdt->max_fds)
>  		goto out_unlock;
> +	fd = array_index_nospec(fd, fdt->max_fds);
>  	file = fdt->fd[fd];
>  	if (!file)
>  		goto out_unlock;

This is insufficient.  do_dup2() has a similar problem.
