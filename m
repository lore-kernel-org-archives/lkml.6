Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27CBC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C2892145D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WONmfdjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C2892145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbeJPCmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:42:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbeJPCmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:42:45 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D17CE208D9;
        Mon, 15 Oct 2018 18:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539629774;
        bh=mDK4+EIqo9md04S9e+DhwOr+0uETFJl7BVEnCiNhjY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WONmfdjxSF0Vmr3CmdKG/FfeMgaLhS5UXP3iA7VVnyeiLRsk2lJxDckHs5dnY8HxL
         JqlExvCOLBPaEbv+aCGZpHiMQH4JNsVKc51r1zTDrY64Vq3u1+lwHMuQ3mc1ktv4Jj
         wfRLwXp4qSPYrcdnGO+zn79wm+MPrFo94udh3Zhc=
Date:   Mon, 15 Oct 2018 20:56:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Roman Kiryanov <rkir@google.com>
Cc:     linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v3 06/15] platform: goldfish: pipe: Move memory
 allocation from probe to init
Message-ID: <20181015185611.GA5201@kroah.com>
References: <20181003171720.169953-1-rkir@google.com>
 <20181003171720.169953-6-rkir@google.com>
 <20181015183458.GA28454@kroah.com>
 <CAOGAQerzTxLEcFjqCqjGvFDaK79LWw7kuGqprw4mEj6gmcm6tA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOGAQerzTxLEcFjqCqjGvFDaK79LWw7kuGqprw4mEj6gmcm6tA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 11:48:28AM -0700, Roman Kiryanov wrote:
> > You should only allocate memory at probe time
> 
> probe does not know what memory to allocate. We have several versions
> of the driver (with different init) and different versions allocate
> different state.

I only see one driver here.

Why does probe not know what to allocate?  That is exactly when the
device is bound to the driver, you have _way_ more information than you
do at init time.

> >, not init time as what
> > happens if the hardware is not present yet your driver is loaded?
> 
> init will have to rollback what it allocated.

But those resources it will sit there wasted until unload happens.  And
unload _never_ happens on a system unless you are a developer working on
the module.

thanks,

greg k-h
