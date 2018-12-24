Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80ED4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4737F21773
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545638921;
	bh=LjtegiaL9dYMAll2c7DYHsdKnnlLrqc785gwGqCTMm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ATL+72QU0PqUD3poZ3oGdLzPm33P/Q1B7lliD/gaIW7mfRyVVvT3ZDBD9NHWg1du4
	 gRAhux2V2nVnvRP5GeQjDQbC6JYaV3yjBjS8e3zLw0YKj85iIn8JHBSZoIMTHKCuXf
	 TuhzrMk8HgQPeqNeab0410NOpdqLViguR6qqe/Oo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbeLXIIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 03:08:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:43158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbeLXIIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 03:08:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BF572171F;
        Mon, 24 Dec 2018 08:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545638918;
        bh=LjtegiaL9dYMAll2c7DYHsdKnnlLrqc785gwGqCTMm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RSEnUKXFvCE2jyUvjxqzHSqjbP6YqFhhtjCQXVRZMbIHdXyfM4nAgSWTja7ySNcHr
         St4ClIFQLU/e1T/jxSHiP/RCg1KQOX/4DBMiiYhAqGMYgF3SWOcpNFOo5LIWyNt1K2
         saeIE3YJFrMyKVE/hVMYW/BZ711C9ZCUe7m8j5iQ=
Date:   Mon, 24 Dec 2018 09:08:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Backlund <tmb@mageia.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        christian.brauner@canonical.com, nix.or.die@gmail.com,
        "Eric W. Biederman" <ebiederm@xmission.com>, ellierevves@gmail.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, seth.forshee@canonical.com,
        stable@vger.kernel.org
Subject: Re: [BREAKAGE] Since 4.18, kernel sets SB_I_NODEV implicitly on
 userns mounts, breaking systemd-nspawn
Message-ID: <20181224080836.GA12568@kroah.com>
References: <e62d4c3a-b89b-2380-7b39-66733b389145@gmail.com>
 <CAEJqkggwbNP3Q+7AWr4i64CvAdCp15jVLOtUsnMo6rLk3ExTkA@mail.gmail.com>
 <CAHk-=wjd2VJDM+RXwg30MpW45F5EHZtLErzxQzYxi4+Dnm3sjw@mail.gmail.com>
 <CAPP7u0Vo6gB86S-hZcOW9Rmki8oKHd=Lyx3x-N9gjPC4JP_YxQ@mail.gmail.com>
 <CAHk-=wg-6jYZ=bJWdyBR=n8QOfwHTZZdzSUUPgFW+NGCV-pe2g@mail.gmail.com>
 <CAPP7u0UhPyC=eewx4dYu+AU5tK_URE8_5PW9cNkK6Ppp7vkqHg@mail.gmail.com>
 <CAHk-=wg8Qrh4nvFbWttz6zPMeRKO2Twv57vZfGaQ6odsjYFEnQ@mail.gmail.com>
 <828415b6-9fee-96bd-b6b0-fd4450df97a8@mageia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <828415b6-9fee-96bd-b6b0-fd4450df97a8@mageia.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2018 at 12:54:11PM +0200, Thomas Backlund wrote:
> Den 23-12-2018 kl. 01:28, skrev Linus Torvalds:
> > On Sat, Dec 22, 2018 at 3:07 PM Christian Brauner
> > <christian.brauner@canonical.com> wrote:
> > > 
> > > However, for this case should I resend the revert?
> > 
> > Since I was pointed at the original email thread, I just picked it up
> > from there directly. It still applied cleanly, nothing had changed in
> > that area.
> > 
> >                  Linus
> > 
> 
> This should also be picked up for 4.19 lts
> 
> Greg, it's now upstream as:
> 
> From 94f82008ce30e2624537d240d64ce718255e0b80 Mon Sep 17 00:00:00 2001
> From: Christian Brauner <christian@brauner.io>
> Date: Thu, 5 Jul 2018 17:51:20 +0200
> Subject: Revert "vfs: Allow userns root to call mknod on owned filesystems."

Now queued up, thanks.

greg k-h
