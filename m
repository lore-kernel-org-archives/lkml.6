Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3099C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978B221924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549625165;
	bh=Q5ThEQnu7HtEketgN/UJFVfnXVKGRUe2t2cy/0m9E20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A51IzxzKTvJS+myW/vSApFAKdxBGp1YJgYeRqAwBxM0VANrQk7/aU0IVcGnW8aes0
	 xIO+8I8PlT2cw9O+ZazG/JeCzhmOx0CVaLsZI5OKelaCZab+F07/pM/tHOJd9kz6Tk
	 p23gPCTT76/JS40TmY7DXyof1Xh/ox4QfUnfTU+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfBHL0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 06:26:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:60838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbfBHL0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 06:26:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2AAF20863;
        Fri,  8 Feb 2019 11:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549625163;
        bh=Q5ThEQnu7HtEketgN/UJFVfnXVKGRUe2t2cy/0m9E20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aBvAX4q8MqpL0BPqCLlIYLvbI7YpeZNuea+NSRhRml2U1MTU/Io4qeVjvEatyDMoF
         qAUc+M1Q+xjUeZu7hJpO1C+LdROw4Xny/GEvynuvQVDQeN/LINA0B9eH/W6GcKSC6g
         Hbt415//b9aqR7ljh+/QjWt/bAbY2ZoDHzig/z3k=
Date:   Fri, 8 Feb 2019 12:26:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Todd Kjos <tkjos@android.com>
Cc:     tkjos@google.com, arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com,
        joel@joelfernandes.org, kernel-team@android.com
Subject: Re: [PATCH v2 0/7] binder: eliminate use of vmalloc space for binder
 buffers
Message-ID: <20190208112600.GA22147@kroah.com>
References: <20190130224655.255149-1-tkjos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190130224655.255149-1-tkjos@google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 02:46:48PM -0800, Todd Kjos wrote:
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

This patch series blows up when I apply it to my char-misc-next branch:

drivers/android/binder_alloc_selftest.c: In function ‘check_buffer_pages_allocated’:
drivers/android/binder_alloc_selftest.c:108:44: error: ‘struct binder_buffer’ has no member named ‘data’
  end = (void *)PAGE_ALIGN((uintptr_t)buffer->data + size);
                                            ^~
Did you forget to enable CONFIG_ANDROID_BINDER_IPC_SELFTEST when doing your
builds?

thanks,

greg k-h
