Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F563C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1072171F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F1072171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbeHOCe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 22:34:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57416 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbeHOCe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 22:34:56 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 23CDAC94;
        Tue, 14 Aug 2018 23:45:24 +0000 (UTC)
Date:   Tue, 14 Aug 2018 16:45:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Peter Kalauskas <peskal@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zram: fix bug storing backing_dev
Message-Id: <20180814164523.e0fdeed962917e23062ef958@linux-foundation.org>
In-Reply-To: <20180813073825.GA1062@jagdpanzerIV>
References: <20180808223100.225086-1-peskal@google.com>
        <20180813061623.GC64836@rodete-desktop-imager.corp.google.com>
        <20180813073825.GA1062@jagdpanzerIV>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2018 16:38:25 +0900 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

> On (08/13/18 15:16), Minchan Kim wrote:
> > > The call to strlcpy in backing_dev_store is incorrect. It should take
> > > the size of the destination buffer instead of the size of the source
> > > buffer.  Additionally, ignore the newline character (\n) when reading
> > > the new file_name buffer. This makes it possible to set the backing_dev
> > > as follows:
> > > 
> > >   echo /dev/sdX > /sys/block/zram0/backing_dev
> > > 
> > > Signed-off-by: Peter Kalauskas <peskal@google.com>
> > Acked-by: Minchan Kim <minchan@kernel.org>
> > 
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> > CC: LKML <linux-kernel@vger.kernel.org>
> > Cc: <stable@vger.kernel.org>    [4.14+]
> 
> Thanks for Cc-ing Minchan.
> 
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> 
> > > -	strlcpy(file_name, buf, len);
> 
> This is quite interesting. The reason it worked before was the fact that
> strlcpy() copies 'len - 1' bytes, which is strlen(buf) - 1 in our case,
> so it accidentally didn't copy the trailing new line symbol. Which also
> means that "echo -n /dev/sdX" most likely was broken.
> 

I can't find the original email on lkml for some reason, but I
recreated the patch.

The changelog doesn't describe the end-user impact of the bug, which is
very desirable when tagging a patch for -stable backporting.  Can we
have that paragraph please?

The implementation might be able to use strim() somehow.
