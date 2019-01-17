Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5941CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6B920855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sMddgaa1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfAQVf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 16:35:28 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43035 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfAQVf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 16:35:28 -0500
Received: by mail-pf1-f195.google.com with SMTP id w73so5441551pfk.10;
        Thu, 17 Jan 2019 13:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J1I6zXpaKjVach8x1gD1fvxRJO7nOaBCJzi8PJw5XQg=;
        b=sMddgaa1UIynrH+3FdSYdxlecKM1BNmycphsmW58acwCLxSWAIyHgoPv1ZWVzIslhc
         DaWhuTl654PhXcQa/XV0i4RtG04b3XVz+J3vQALq+Xm2+/MiXtPJLAvqzhgOIOUlVnXk
         92WvkeE+E8/fjI9O2MfywQfeWYBWPK5dyZdriokLJckBfbblj737/ASgWsFy2CY4Cp+N
         VNE1ReZMAz7EaT0hBZf3EGxVwxP0SOQjEBtQsoejc2/MJUThqnC1sf58pHsv+/vMKJAu
         3TY1x4a7S7OJDAVVtWw72QfQFgE/SUOJSX8+WjO9w0tRz5xGQnzPdUbT+sGIkMDkkK5l
         Un7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=J1I6zXpaKjVach8x1gD1fvxRJO7nOaBCJzi8PJw5XQg=;
        b=Xogc0qFN+iwGmMqG0lGwKkjacCmGGHPCZILJ42J0Ctj1wvXvOtVXQg5By52EOt44kP
         sEXYDLOCuaU5O17C9Uk+a1Y01rjGlH4+eDfSHybf8llB909ZQDAsWemUf2jMTqNH/f6L
         TIV+AhwIy+InjQHpBeawLBl+8+3C3N6ztpsWBWmglf/W17+hEtrfqjLHRvcY4vHaES9e
         AfN5jVSDd/baLeNXbrHcnlf32MBnHjfO5b5ZHjXBlVTprCfnYBSFaMMw9Vt7VrK2gGyw
         Jfk42tsiTxpl8+MQUV/bDp/L9ViE8P63BxA+zQ7gYyb8TmNrF53DTLyLkdAJFsFVuEcT
         X6NA==
X-Gm-Message-State: AJcUukcpnW9Bf0HnILG2BwXTdsGkh6IO2YK1M8kokBB+ujasbeqP2jCD
        p8VKScqiIDrv+qKWfOrFsbQ=
X-Google-Smtp-Source: ALg8bN4EPknLV7PmbXjfMN/snYbmRUatVp0fQ1lLcssu/j8+k7wfvLonoauYw2XTS0leMVAMXCxC/A==
X-Received: by 2002:a63:ff16:: with SMTP id k22mr15113776pgi.244.1547760927008;
        Thu, 17 Jan 2019 13:35:27 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c23sm3445322pfi.83.2019.01.17.13.35.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 13:35:26 -0800 (PST)
Date:   Thu, 17 Jan 2019 13:35:24 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Omar Sandoval <osandov@fb.com>
Subject: Re: linux-next: Tree for Jan 16
Message-ID: <20190117213524.GA26237@roeck-us.net>
References: <20190116173838.042db659@canb.auug.org.au>
 <20190116203547.GA788@roeck-us.net>
 <20190117084902.GA20220@ming.t460p>
 <20190117103553.GB23565@ming.t460p>
 <20190117183254.GA17361@roeck-us.net>
 <10619062-9531-e843-1620-7518e27583f8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10619062-9531-e843-1620-7518e27583f8@kernel.dk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 11:34:01AM -0700, Jens Axboe wrote:
> On 1/17/19 11:32 AM, Guenter Roeck wrote:
> > On Thu, Jan 17, 2019 at 06:35:55PM +0800, Ming Lei wrote:
> >>>
> >>> Hi Guenter,
> >>>
> >>> Could you share me the .config?
> >>
> > Any 32 bit configuration from affected architectures should work.
> > 
> >> From your dmesg log, looks the test is run on i386, so please
> >> feel free to try the following patch:
> >>
> >> https://marc.info/?l=linux-kernel&m=154772088110800&w=2
> >>
> > Is this still relevant ? Today's image is fine.
> 
> The patches were pulled, I think Ming would still appreciate it if
> you could test the previous tree with that patch on top.
> 

next-20190116 with Ming's patch added and "sh: generate uapi header and
syscall table header files" reverted:

Qemu test results:
	total: 343 pass: 343 fail: 0

Note though that my tests do not run any block device stress tests.

Guenter
