Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CF0C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3D621019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548230401;
	bh=Ld0KRUt3QRCJ+ZW7Awr6wUdH+GXvmOvAXhrWQire5aU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GYQmAgaoZBXZjO/RBWuSbk5YfA/Oc8AEuF04YmknsHlH3APdOhJuLkvjdrjJwoqsJ
	 vs/4uJG6I/wgOWiLftWmmblSZrx+ShT70aqmFOH6DGJQOyxrtHp3FRQpHsnXt56SRk
	 vc/DMG/3gqlWwUSzrpOroasM60actLyF6gd7Irvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfAWIAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 03:00:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:53074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfAWH77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 02:59:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0F8421019;
        Wed, 23 Jan 2019 07:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548230399;
        bh=Ld0KRUt3QRCJ+ZW7Awr6wUdH+GXvmOvAXhrWQire5aU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T6o+64vaP/7PTjjSU+Nmajw6lWtdc91lszkbdkX8OOs4H/5ed5SRDonTMD6VzNSSY
         skLukGioId/Leo7wWbNfZFr7Pm0lwY6i3bQzl+cC6FZAuglualTp7EvuU9vgzbIB2d
         UT0b4t9fO5UC8x6kor2ATHJGKsJN5RQMqjYrs21k=
Date:   Wed, 23 Jan 2019 08:59:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] power: domain: no need to check return value of
 debugfs_create functions
Message-ID: <20190123075956.GA7597@kroah.com>
References: <20190122152151.16139-6-gregkh@linuxfoundation.org>
 <CAPDyKFo=6NCiAzwF2mvfuvfCApiegBBnJdPM1EypK8xO38h_DA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFo=6NCiAzwF2mvfuvfCApiegBBnJdPM1EypK8xO38h_DA@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 08:44:36AM +0100, Ulf Hansson wrote:
> On Tue, 22 Jan 2019 at 16:23, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> 
> Doesn't this boils done to whether we want to care to check if memory
> allocation failed?

You should not care.

> Somewhere down the call chain from debugfs_create_dir(), we end up in
> alloc_inode() and it looks like that can fail, no?

Yes it can, right now it will return NULL, I'll go change that to return
ENOMEM, but even then, your really do not care what happens as none of
your other code flow should ever care about what debugfs does, or does
not, do.

thanks,

greg k-h
