Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D704C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 06:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE66208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 06:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCfQsV0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE66208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeJPOSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 10:18:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727043AbeJPOSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 10:18:20 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8062B208B3;
        Tue, 16 Oct 2018 06:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539671367;
        bh=ghqw+lTK/9dR406KC1CcOU8M1aPWABGAm2Ko/3N14wM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jCfQsV0sNlRTR/jhdl8yVqD8liZOxp1PIkJ3GGInqd30R/AYfFSuwpZ31rd46xvkb
         KQWJnNk5b5SIa5a3l/aCP8DXKRd+8uZRgPyRXBZQlbB/i5Xd3oKUUhKm872OT7niqM
         9TqOYNq5ytJLqYC+bYBiyr4aYiqn/yjR+aKXzbJU=
Date:   Tue, 16 Oct 2018 08:29:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Roman Kiryanov <rkir@google.com>
Cc:     linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v3 09/15] platform: goldfish: pipe: Move goldfish_pipe to
 goldfish_pipe_v2
Message-ID: <20181016062924.GB882@kroah.com>
References: <20181003171720.169953-1-rkir@google.com>
 <20181003171720.169953-9-rkir@google.com>
 <20181015183807.GA6905@kroah.com>
 <CAOGAQeo31ggKCHsJw3D297J6Ya1kq8MptTaDR7q6H7-q99sdGw@mail.gmail.com>
 <20181015190134.GA6700@kroah.com>
 <CAOGAQepAqCorTosBwqJq-Kez=MUThv35JM=S8jfZEkkk1Xr9jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOGAQepAqCorTosBwqJq-Kez=MUThv35JM=S8jfZEkkk1Xr9jw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 01:23:35PM -0700, Roman Kiryanov wrote:
> > > I want our "v2" driver to be in a "v2" file and our "v1" driver in a
> > > "v1" file. I think this is reasonable.
> >
> > The in kernel driver is the "v1" one.
> 
> I believe v2 (on our end) was upstream as goldfish_pipe.c instead of
> goldfish_pipe_v2.c.

I do not understand this, sorry.  My point of view is the in-kernel
code, I know nothing about out-of-tree code, nor do I care :)

> >  Why do you need a totally new driver file at all anyway?
> 
> I don't want to mix v1 and v2.

Why?  What is the difference?  Why do you even need/want 2 different
drivers here for something that really should be done with the virtio
interface instead?

> > And again, can you GUARANTEE that userspace will not break if you rename
> > the kernel module?
> 
> Yes, it works:
> https://android.googlesource.com/kernel/goldfish/+/android-goldfish-4.14-dev/drivers/platform/goldfish/

That's a kernel, not userspace, code.

> I don't see how userspace could be affected, unless we refer to
> __FILE__ inside the driver for some important things. I believe we
> don't.

How does your userspace know what module to automatically load?  That's
what usually breaks if you do not have proper platform binding happening
automatically.

thanks,

greg k-h
