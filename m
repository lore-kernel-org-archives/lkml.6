Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22058C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78B9206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C78B9206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbeIEOB4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:01:56 -0400
Received: from mondschein.lichtvoll.de ([194.150.191.11]:40403 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeIEOBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:01:55 -0400
Authentication-Results: auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 898793A2CC8;
        Wed,  5 Sep 2018 11:32:32 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Rogier Wolff <R.E.Wolff@bitwizard.nl>
Cc:     Jeff Layton <jlayton@redhat.com>,
        =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: POSIX violation by writeback error
Date:   Wed, 05 Sep 2018 11:32:32 +0200
Message-ID: <49555682.rh9yPTYizh@merkaba>
In-Reply-To: <20180905080444.GD24519@BitWizard.nl>
References: <CAJDTihz-rFb2SGaxZsQnXGnee_2qW_ynhPe=tZ4yzQBSV_KQ1g@mail.gmail.com> <3805399.0d8HT3LL4o@merkaba> <20180905080444.GD24519@BitWizard.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff - 05.09.18, 10:04:
> On Wed, Sep 05, 2018 at 09:39:58AM +0200, Martin Steigerwald wrote:
> > Rogier Wolff - 05.09.18, 09:08:
> > > So when a mail queuer puts mail the mailq files and the mail
> > > processor can get them out of there intact, nobody is going to
> > > notice.  (I know mail queuers should call fsync and report errors
> > > when that fails, but there are bound to be applications where
> > > calling fsync is not appropriate (*))
> > 
> > AFAIK at least Postfix MDA only reports mail as being accepted over
> > SMTP once fsync() on the mail file completed successfully. And I´d
> > expect every sensible MDA to do this. I don´t know how Dovecot MDA
> > which I currently use for sieve support does this tough.
> 
> Yes. That's why I added the remark that mailers will call fsync and
> know about it on the write side. I encountered a situation in the
> last few days that when a developer runs into this while developing,
> would have caused him to write:
>   /* Calling this fsync causes unacceptable performance */
>   // fsync (fd);

Hey, I still have

# KDE Sync
# Re: zero size file after power failure with kernel 2.6.30.5
# http://permalink.gmane.org/gmane.comp.file-systems.xfs.general/30512
export KDE_EXTRA_FSYNC=1

in my ~/.zshrc.

One reason KDE developers did this was Ext3 having been so slow with 
fsync(). See also:

Bug 187172 - truncated configuration files on power loss or hard crash 
https://bugs.kde.org/187172

> But when apt-get upgrade replaces your /bin/sh and gets a write error
> returning error on subsequent reads is really bad.

I sometimes used eatmydata with apt upgrade / dist-upgrade, but yeah, 
this asks for trouble on write interruptions.
 
> It is more difficult than you think.

Heh. :)

Thanks,
-- 
Martin


