Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC378C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C3420652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="iziVU5Mz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C3420652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932899AbeFTX3k (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 19:29:40 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41126 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932469AbeFTX3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 19:29:39 -0400
Received: by mail-pg0-f66.google.com with SMTP id l65-v6so502323pgl.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 16:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1HuZ69iXPm5k8WD3DdMw1PtNK5y+QBhVornzUTpjHtc=;
        b=iziVU5MzRdcWSl0tDW6UdQgoW3WEFrwnVXcqABybvOKdEdZiaUQZWvdAQYX3FkxX8O
         D3fxLsJx/2dxuOuQzp+KR2HkdvtzJ0TiqQR6glkWXSu72skelPdauWHTj24+0RrVVbzP
         HQmf7ywcmxeAIGtz7oX9+JD35sjs+3WO6stMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1HuZ69iXPm5k8WD3DdMw1PtNK5y+QBhVornzUTpjHtc=;
        b=hgqXrVVpV/vyYRuEkyFnVYd04p+x21POTDsoXknXRGbUKbonkMEhiAd2knslBGfY2h
         +zLD4uHXSM7Iy5bLw2+Q4rRA1lc+k8fsQUcRtvZZgwwIL9wT003MS6AkWvpYsW+0ttcE
         /QwOmJtDUknhfwerTptWCDKrlIEmuSX/41yLqFozlAtXHWKz+xFOfYhZ0WAVH6zTgfV7
         5RFNRoAd/RgSwv4gP94vl73Jd3D7rDhU0ScDivawpoFfRAroafEtW3GlW8lOFKDhC23h
         lFH5LmDd2J0UDctFc3u0yyzhLfCQXdZg0wpbF3Bp0nWahj0IH6NYq7YJqbXQ9+2T8R9o
         3oEw==
X-Gm-Message-State: APt69E2e12hDurmzvQVS7qfV9NzZ+n4VD/4uRuAb8ZQI+m3C4oLNxD7c
        LKcLMmtvFmX2bExMQJcGd/t/kw==
X-Google-Smtp-Source: ADUXVKJm15go6MVCoQwhIIoefs2C4TYpWHHt2EUsB7YwR4+VsWqOhZ68jAzKR8m5ft5BkOPbfBiw/Q==
X-Received: by 2002:a65:5cc8:: with SMTP id b8-v6mr20434569pgt.85.1529537378413;
        Wed, 20 Jun 2018 16:29:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id o77-v6sm6497351pfj.0.2018.06.20.16.29.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 16:29:37 -0700 (PDT)
Date:   Wed, 20 Jun 2018 16:29:37 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     Alistair Strachan <astrachan@google.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>, devel@driverdev.osuosl.org,
        kernel-team@android.com
Subject: Re: [PATCH 2/2 v2] staging: android: ashmem: Fix mmap size validation
Message-ID: <20180620232937.GA177510@joelaf.mtv.corp.google.com>
References: <20180620005735.219840-1-astrachan@google.com>
 <20180620005735.219840-2-astrachan@google.com>
 <20180620043200.GA10888@joelaf.mtv.corp.google.com>
 <CAKOZuetoYikhAz1c6NuaVjeU_E58hbH7wMsDUKCYWqb63ESPeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZuetoYikhAz1c6NuaVjeU_E58hbH7wMsDUKCYWqb63ESPeA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 02:21:57PM -0700, Daniel Colascione wrote:
> On Tue, Jun 19, 2018 at 9:32 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> > On Tue, Jun 19, 2018 at 05:57:35PM -0700, Alistair Strachan wrote:
> > > The ashmem driver did not check that the size/offset of the vma passed
> > > to its .mmap() function was not larger than the ashmem object being
> > > mapped. This could cause mmap() to succeed, even though accessing parts
> > > of the mapping would later fail with a segmentation fault.
> > >
> > > Ensure an error is returned by the ashmem_mmap() function if the vma
> > > size is larger than the ashmem object size. This enables safer handling
> > > of the problem in userspace.
> 
> Are we sure that this approach is a good idea? You can over-mmap
> regular files. I don't like the idea of creating special mmap

ashmem isn't a regular file.

> semantics for files that happen to be ashmem files. Ashmem users can
> detect size-changing shenanigans with ASHMEM_GET_SIZE after mmap,
> since an ashmem file's size can't change after an mmap call succeeds.

But it is misleading to allow it. If the mmap succeeds, the any writes to the
extra area is infact not a part of ashmem and will not be shared. Instead if
the mmap fails up front, then we're telling the user upfront that they
screwed up and they should do something about it. I would much rather have
the mmap fail than to allow for other issues to later occur.

Also if you look at the kernel sources, there are dozens of drivers that
check for correct VMA size in mmap handler and fail if it isn't sized
correctly.

thanks!

 - Joel

