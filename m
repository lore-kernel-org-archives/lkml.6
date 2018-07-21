Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D7FECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CB020858
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00CB020858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbeGUTOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 15:14:55 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35056 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728418AbeGUTOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 15:14:55 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fgwVJ-0000p0-0j; Sat, 21 Jul 2018 18:21:17 +0000
Date:   Sat, 21 Jul 2018 19:21:16 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Sean Fu <fxinrong@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/buffer.c: Optimize grow_buffer function.
Message-ID: <20180721182116.GC30522@ZenIV.linux.org.uk>
References: <1532194217-19002-1-git-send-email-fxinrong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532194217-19002-1-git-send-email-fxinrong@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 22, 2018 at 01:30:17AM +0800, Sean Fu wrote:
> Use PAGE_SHIFT and i_blkbits of bd_inode directly to avoid ugly sizebits
> calculation.
> Remove ugly sizebits calculation.
> Remove unnecessary sizebits parameter of grow_dev_page.
> 
> Reduces code size:
> 
> Before:
> 
> sean@linux-zmni:~/sda5/source/linus_repo/linux> size fs/buffer.o
>    text	   data	    bss	    dec	    hex	filename
>   34037	   1510	     16	  35563	   8aeb	fs/buffer.o
> 
> After:
> 
> sean@linux-zmni:~/sda5/source/linus_repo/linux> size fs/buffer.o
>    text	   data	    bss	    dec	    hex	filename
>   34021	   1510	     16	  35547	   8adb	fs/buffer.o

First of all, 16 bytes is pretty much noise.  What's more, the "remove ugly
sizebits calculation" part really needs an explanation of the reasons why
it's safe.  You assume that size == 1<<bdev->bd_inode->i_blkbits; where's
the proof that it always holds?
