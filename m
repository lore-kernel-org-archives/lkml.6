Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C25C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA1021B69
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KHxPajvi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbfBKQ5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:57:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33120 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfBKQ5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4i+p1mAviZY9t6csLmdbK2G2O17z1DLnrRqG1LvAyF0=; b=KHxPajviZGh1UQ0zP77hVeDP6
        Lnuw4hw06FEGSF5Jbi87bxh0xYAr8eGjfJ4GrtzOW+2Zfyn+0v7tAw7rnaTkORUQ18llEgRZxlmqc
        S60s+oGOsvOMPWI7MBut+nddedy8Yxv59he78V/6aa8xMLDFiWr9289ohMH9xLMK0IELRY36RLqC7
        WKQSFebfDcBeBgYYVFN6ocieb7ljZGkBJyL1/98Ct5AYITMpI+q+l4VoiCavm57U3W3bLxkt3AoBV
        1WGF2/Tw8FbNg2BJcx3UcBxm0rLqmJJOA63e/HZB4bhx/5lOuvk8l8cYs8tcfjHOTIoH55iOE/O0/
        J+buPEU0A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtEtI-0000A0-9E; Mon, 11 Feb 2019 16:57:08 +0000
Date:   Mon, 11 Feb 2019 08:57:08 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Todd Kjos <tkjos@android.com>
Cc:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com, joel@joelfernandes.org, kernel-team@android.com
Subject: Re: [PATCH v3 0/7] binder: eliminate use of vmalloc space for binder
 buffers
Message-ID: <20190211165708.GA25685@infradead.org>
References: <20190208183520.30886-1-tkjos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208183520.30886-1-tkjos@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 10:35:13AM -0800, Todd Kjos wrote:
> Binder buffers have always been mapped into kernel space
> via map_kernel_range_noflush() to allow the binder driver
> to modify the buffer before posting to userspace for
> processing.
> 
> In recent Android releases, the number of long-running
> binder processes has increased to the point that for
> 32-bit systems, there is a risk of running out of
> vmalloc space.
> 
> This patch set removes the persistent mapping of the
> binder buffers into kernel space. Instead, the binder
> driver creates temporary mappings with kmap() or
> kmap_atomic() to copy to or from the buffer only when
> necessary.

Is there any good reason to actually map the user memory to kernel
space instead of just using copy_{to,from}_user?
