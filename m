Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E381C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 11:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE8621848
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 11:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545651964;
	bh=YUL6nmqWX6VgncjHOlwK31fhXMjg6480qZkZOBZoV6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=njoC3Wk9Fa2RLQpTQgH3DoQi/M2jKnyoOfNz3C8sNeT65hzDHUurolnlK2Qn/lDV0
	 WvrLFLy9L+sPJr2JMGlT+bgD74DhA4XRIr6T0OWPNjP71bEgGzjIcfBQzfav0/ecr1
	 vZ9jpNn92Em+6GKoZrMw1/e9T0zlRxRfcmgrZKp4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbeLXLqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 06:46:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:52936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbeLXLqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 06:46:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99B722176F;
        Mon, 24 Dec 2018 11:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545651962;
        bh=YUL6nmqWX6VgncjHOlwK31fhXMjg6480qZkZOBZoV6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gfHpO5cCuRPgLSWDcc0MyGcwoUW+ZPgkuYQ6ZWUCcQnVMSoJ+MTZ/1/74MqZscEgv
         9MKj9GmCWGBTHW0LSbI4c2m+Vp1oHi4cio04m3jcGn0gl1KOLMuWlg1ETDixpf84hq
         Y8BKKAQpeoJv27jOo+g/mg+pt3lrcdxapUnahcXI=
Date:   Mon, 24 Dec 2018 12:45:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     tkjos@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, arve@android.com, maco@android.com,
        joel@joelfernandes.org, Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v1 1/2] binderfs: implement "max" mount option
Message-ID: <20181224114559.GA4124@kroah.com>
References: <20181223143550.10672-1-christian@brauner.io>
 <20181224110935.cop4v5kfcdkemtwo@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181224110935.cop4v5kfcdkemtwo@brauner.io>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 12:09:37PM +0100, Christian Brauner wrote:
> On Sun, Dec 23, 2018 at 03:35:49PM +0100, Christian Brauner wrote:
> > Since binderfs can be mounted by userns root in non-initial user namespaces
> > some precautions are in order. First, a way to set a maximum on the number
> > of binder devices that can be allocated per binderfs instance and second, a
> > way to reserve a reasonable chunk of binderfs devices for the initial ipc
> > namespace.
> > A first approach as seen in [1] used sysctls similiar to devpts but was
> > shown to be flawed (cf. [2] and [3]) since some aspects were unneeded. This
> > is an alternative approach which avoids sysctls completely and instead
> > switches to a single mount option.
> > 
> > Starting with this commit binderfs instances can be mounted with a limit on
> > the number of binder devices that can be allocated. The max=<count> mount
> > option serves as a per-instance limit. If max=<count> is set then only
> > <count> number of binder devices can be allocated in this binderfs
> > instance.
> > 
> > This allows to safely bind-mount binderfs instances into unprivileged user
> > namespaces since userns root in a non-initial user namespace cannot change
> > the mount option as long as it does not own the mount namespace the
> > binderfs mount was created in and hence cannot drain the host of minor
> > device numbers
> > 
> > [1]: https://lore.kernel.org/lkml/20181221133909.18794-1-christian@brauner.io/
> > [2]; https://lore.kernel.org/lkml/20181221163316.GA8517@kroah.com/
> > [3]: https://lore.kernel.org/lkml/CAHRSSEx+gDVW4fKKK8oZNAir9G5icJLyodO8hykv3O0O1jt2FQ@mail.gmail.com/
> > [4]: https://lore.kernel.org/lkml/20181221192044.5yvfnuri7gdop4rs@brauner.io/
> > 
> > Cc: Todd Kjos <tkjos@google.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Right, I forgot to ask. Do we still have time to land this alongside the
> other patches in 4.21? :)

It's too late for 4.21-rc1, but let's see what happens after that :)

greg k-h
