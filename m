Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B329BC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7227521726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548244714;
	bh=LLGw68OcF7jTXYNq3Xh87u9Jd9LaEbZfXSnSASJOdrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hVezovoVB/kGe7+23cj3imVtELfzKj8MJ0TW5B2+9WIPRSl67E3w3pDpQ6Rqk3Vpe
	 YxNBpso3m4h6h4NzkCNBZZMZzDIfyTzETrySqRmNpog5wS03emuxvhqZCUFMPhzoqa
	 bAbZUPa5uAZZa1BPgaaYCJMsLwdkapsY76+xpZ80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfAWL6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 06:58:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:39770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfAWL6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 06:58:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45A0A20870;
        Wed, 23 Jan 2019 11:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548244711;
        bh=LLGw68OcF7jTXYNq3Xh87u9Jd9LaEbZfXSnSASJOdrs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=muuBFnpLVpcn10SSeFHen/Vdmcf+fEUADEzYwBy2TrXtTsu9RF1VRQzpQKqfok+Ux
         w7HBhaXM+RfJfagPnk3tqYLOxDqKsO7z8SenVs0oBPzOGo/jdAK0H0BMvWtuu6Zd/P
         fNEg2uXnn99LTngHnEMOwjlcAD6zTxVkX/IHQ6tA=
Date:   Wed, 23 Jan 2019 12:58:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        Alexander Popov <alex.popov@linux.com>,
        xen-devel@lists.xenproject.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dev@openvswitch.org, linux-kbuild@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 1/3] treewide: Lift switch variables out of switches
Message-ID: <20190123115829.GA31385@kroah.com>
References: <20190123110349.35882-1-keescook@chromium.org>
 <20190123110349.35882-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190123110349.35882-2-keescook@chromium.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 03:03:47AM -0800, Kees Cook wrote:
> Variables declared in a switch statement before any case statements
> cannot be initialized, so move all instances out of the switches.
> After this, future always-initialized stack variables will work
> and not throw warnings like this:
> 
> fs/fcntl.c: In function ‘send_sigio_to_task’:
> fs/fcntl.c:738:13: warning: statement will never be executed [-Wswitch-unreachable]
>    siginfo_t si;
>              ^~

That's a pain, so this means we can't have any new variables in { }
scope except for at the top of a function?

That's going to be a hard thing to keep from happening over time, as
this is valid C :(

greg k-h
