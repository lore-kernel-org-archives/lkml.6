Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD21DFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FADC20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FADC20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeG3JPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:15:15 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46899 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbeG3JPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:15:15 -0400
Received: by mail-oi0-f67.google.com with SMTP id y207-v6so19511999oie.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 00:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xBfL030f1ZHgv6lLCYn+TM4Y8fxklaDJt/kIBRqWk9c=;
        b=nzvg8Zg+rtTXaO8C0PyF+LTk195nj1El+Xer7R0z3gHg8Quu85DxU4n35FBiGTaq6M
         BLRSY9TuSjpG4bebyd3wcZ8PzHiudprhVElzHal6tg9RCn1DSqohQ4QdxkZN5uV0yEKs
         n1C0CcE9+ekAx/m8Pw0VYIr9xT42GtGEciKNoaSBYxNLu1rJhiJd8i5kuOgTJ/5xrZqY
         oc3K1gJVKxblNA1XOOTnlc7zApFVo9KEwHLLsqyyO4HKRnWBNL+OoBA040Gkdi9C1eiX
         zhXvj2c4RtCtmCtMLICKmcfXOcbFaOGO7HNh0OcBwFodtM9OCxKfuXkEbNavyiB0OOmS
         ea0Q==
X-Gm-Message-State: AOUpUlHPLHR6iRwV4GHhYdOeKCesaKRnhAz1aRwaZRdpFJ3n9HrpFouE
        KUAQd3XXSdNMClne/leDd3qWiCZEwmxICMzXOqGcLQ==
X-Google-Smtp-Source: AAOMgpdr1JvLWjfnEIH1Uoc1+9sP5EiGXYW36S6V+zgwdwiJtDQjznQEsnolWlpcUkIqkK/n+/XWst++P6VvWr4n4qs=
X-Received: by 2002:aca:5004:: with SMTP id e4-v6mr17936769oib.111.1532936494641;
 Mon, 30 Jul 2018 00:41:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3407:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 00:41:33
 -0700 (PDT)
In-Reply-To: <CAOQ4uxgOLEpaZ=UwA_CG6CzYbsJBPV4unEV9D5mXrooLXO0+0w@mail.gmail.com>
References: <20180729220317.GB30522@ZenIV.linux.org.uk> <20180729220453.13431-1-viro@ZenIV.linux.org.uk>
 <20180729220453.13431-3-viro@ZenIV.linux.org.uk> <CAOQ4uxgOLEpaZ=UwA_CG6CzYbsJBPV4unEV9D5mXrooLXO0+0w@mail.gmail.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Mon, 30 Jul 2018 09:41:33 +0200
Message-ID: <CAOssrKfmR0beT4dXjg1dn6DBsPbmGBpS5xHpG9QtAAEgMWo_Xg@mail.gmail.com>
Subject: Re: [PATCH 03/16] vfs: don't evict uninitialized inode
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 7:09 AM, Amir Goldstein <amir73il@gmail.com> wrote:
> On Mon, Jul 30, 2018 at 1:04 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>> From: Miklos Szeredi <mszeredi@redhat.com>
>>
>> iput() ends up calling ->evict() on new inode, which is not yet initialized
>> by owning fs.  So use destroy_inode() instead.
>>
>> Add to sb->s_inodes list only if inode is not in I_CREATING state (meaning
>> that it wasn't allocated with new_inode(), which already does the
>> insertion).
>>
>> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
>> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
>> Fixes: 80ea09a002bf ("vfs: factor out inode_insert5()")
>
> Backport hint: this patch depends on the patch ("new primitive:
> discard_new_inode()") currently commit 22dc9a168272 in Al's for-next.
>
> Still trying to figure out the best format to channel this information to
> stable maintainers...

Why are we talking about stable?  This regression was introduced in
4.18-rc1, spotted by Al *and* reported by testers.  It needs to be
fixed in one way or other in 4.18.

I've nothing against applying "new primitive: discard_new_inode() now
+ this patch, but if it is deemed too risky at this point, we could
just revert the buggy commit 80ea09a002bf ("vfs: factor out
inode_insert5()") and its dependencies.

Thanks,
Miklos
