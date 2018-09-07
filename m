Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EADC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51693206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51693206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbeIGMAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:00:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34476 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbeIGMAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:00:34 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BFA16D60;
        Fri,  7 Sep 2018 07:20:59 +0000 (UTC)
Date:   Fri, 7 Sep 2018 09:20:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dingxiang@cmss.chinamobile.com,
        Staging subsystem List <devel@driverdev.osuosl.org>,
        martyn@welchs.me.uk, manohar.vanga@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vme: remove unneeded kfree
Message-ID: <20180907072056.GB1334@kroah.com>
References: <1536223870-6324-1-git-send-email-dingxiang@cmss.chinamobile.com>
 <CA+55aFxuha1tQXcn+WtbOKzwwmtA8AORb04tMM=hk6jT3ntt3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxuha1tQXcn+WtbOKzwwmtA8AORb04tMM=hk6jT3ntt3w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 10:04:49PM -0700, Linus Torvalds wrote:
> On Thu, Sep 6, 2018 at 1:51 AM Ding Xiang
> <dingxiang@cmss.chinamobile.com> wrote:
> >
> > put_device will call vme_dev_release to free vdev, kfree is
> > unnecessary here.
> 
> That does seem to be the case.  I think "unnecessary" is overly kind,
> it does seem to be a double free.
> 
> Looks like the issue was introduced back in 2013 by commit
> def1820d25fa ("vme: add missing put_device() after device_register()
> fails").
> 
> It seems you should *either* kfree() the vdev, _or_ do put_device(),
> but doing both seems wrong.

You should only ever call put_device() after you have created the
structure, the documentation should say that somewhere...

> I presume the device_register() has never failed, and this being
> vme-only I'm guessing there isn't a vibrant testing community.
> 
> Greg?

It's the correct fix, I'll queue it up soon, thanks.

greg k-h
