Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F389C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E385F20817
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="gTsZpqqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E385F20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbeK0VbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:31:13 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:45906 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729093AbeK0VbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:31:13 -0500
Received: by mail-io1-f67.google.com with SMTP id w7so16537405iom.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 02:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kda4nFVztvjkiVWb+e1BVcnkxL0O06XMDSjXUZDWbEE=;
        b=gTsZpqqwW9zsMtm1lmJ16dfDMWHDIKtQwCe1lzBDtvmUNRBK5PelmQMq0bh8PzrLS0
         Z+cdacigD3CbMfUri3roeMlSWB1il/krICagK1hALmczaWPh3QmUC2RSHYmVOiD66mXY
         ihAX7vYpyGvQr4xFWEavZqxGuQmog54v3F/To=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kda4nFVztvjkiVWb+e1BVcnkxL0O06XMDSjXUZDWbEE=;
        b=XCBVZRQTQjO/SkbVyI5U2BWgf0I9Gd0BcSgYA+5neCjxKonCtLPO/D+KEvdpFxdxUa
         SObxGvoAjn0TtaoynpcNwoyfpl67aHse02N8ox+4Av0ekJn5qXE+mBA5Nw7/eiwQ4l2x
         tWU8jGEKOXviEyPlmKjGk41H1o4iC0o6ZLabqxUwIjhGbk2iZy/8zt0CEBiuuEcP7j4G
         1lAzbeMgcaJSvKQWLqQM1dRT21C3Y8E6W6qWezu2X7DSiI2UA1xxI/tqrj9I8YET240l
         u8Qi7DJaCPiMMh5i12HnqVmqKypiVxZnSd2lSvLId1DWtcSFvCEaWchzJgPnx2OBNHAY
         VVCA==
X-Gm-Message-State: AA+aEWaTky5ZxImJ9ziDwxGpBPnQBkWU1fmMSPWChUp18iD8YeCkzYup
        +D1BzLw5K7hFhAXXTBvcWqY8jiZHopR4hY2sjk5Mwg==
X-Google-Smtp-Source: AFSGD/XwUaNKKcvGHTymbbJfIPrQMtnBu5asV9qGWbMdIbbpmusOP1tRsVZKTJNJIHBj8wiMqaj1pmdBi/23DRV5Mao=
X-Received: by 2002:a5d:9698:: with SMTP id m24mr289153ion.246.1543314825653;
 Tue, 27 Nov 2018 02:33:45 -0800 (PST)
MIME-Version: 1.0
References: <1543104923-81192-1-git-send-email-bianpan2016@163.com>
 <20181127092551.GC16301@quack2.suse.cz> <20181127095712.GA32100@bp> <20181127100536.GF16301@quack2.suse.cz>
In-Reply-To: <20181127100536.GF16301@quack2.suse.cz>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 27 Nov 2018 11:33:33 +0100
Message-ID: <CAJfpeguWXT5w20tGeJ55CHBvp_3prYWKnxSPd3Osj3wXp68PMQ@mail.gmail.com>
Subject: Re: [PATCH V2] namei: free new_dentry late
To:     Jan Kara <jack@suse.cz>
Cc:     bianpan2016@163.com, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 11:05 AM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 27-11-18 17:57:12, PanBian wrote:

> > I am not quite sure about the actual execution logic. But I guess new_dentry
> > reference may be dropped outside vfs_rename in cocurrent executions.
> > Otherwise, there is no need to acquire & drop new_dentry reference as it
> > is always alive along vfs_rename.
>
> I don't think that's the case. The dget() - dput() pair just looks
> superfluous to me in vfs_rename(). Am I missing something Miklos?

I think those are to protect against d_delete() called from fs to
reset d_inode.  The caller indeed has to hold one ref anyway.

So not superfluous, but only needed due to d_delete() and not to
protect against freeing of dentry.

Thanks,
Miklos
