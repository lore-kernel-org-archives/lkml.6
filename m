Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8404C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C44E20882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C44E20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbeILVau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:30:50 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:32894 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbeILVat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:30:49 -0400
Received: by mail-qt0-f195.google.com with SMTP id r37-v6so2483188qtc.0;
        Wed, 12 Sep 2018 09:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AKa3o29nzk/66T1aFcHqve0oKWXgbx4uBdaplVGLK5I=;
        b=SXBNRW4hFGgmih7sgKNt2djkeUPJl3JCzzTMAE+C6ZMB/HaARMup9LDe8CvMh8DDyS
         yFtfEh38OGwJt3BUXi0tfSXVzs2Sh3VTTzbDBY3Jq3R4lwl3PzrOXECi70vQPZeYdZGJ
         VSt2KHQwGnIsjcCi6G3yvfYch67YJKyhpXGHi3KFqqbu3SjuwpJPzj/YaigkWF9wZevP
         rck/6cGHq+SweqE1DH3kzJbner1z7fIwWNRa9mqIJFwP5nOWkaPf1cMngVsZeHSUuRzl
         ufQBeoB8XDZeTO6iG9ZF41+3Zq5Els5e7H3oLI1PEpzhAq3fwtN+KZ613ELjmPEdXe+g
         +1Mw==
X-Gm-Message-State: APzg51B12PEm4C6xK/W1Btnez//881p0xBVyCVh2Gpm5fyYBZC6BkK38
        5vJJe2w+rl/ssOjpvG70AvQRmcNB4t4X0l4tFI4=
X-Google-Smtp-Source: ANB0VdYJm8pwZ3/Bl7DUQ9rSk6UOjae+FTz2bmp0V+2/kLSMMYJkqg9PlccfAUqDyc5sNdSJqA1rW109k5Rgqf9J7sI=
X-Received: by 2002:aed:2b47:: with SMTP id p65-v6mr2136329qtd.132.1536769532613;
 Wed, 12 Sep 2018 09:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180912150142.157913-1-arnd@arndb.de> <20180912150142.157913-4-arnd@arndb.de>
 <9e5f6ad82a2344c095234b39224605d4@AcuMS.aculab.com>
In-Reply-To: <9e5f6ad82a2344c095234b39224605d4@AcuMS.aculab.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 12 Sep 2018 18:25:16 +0200
Message-ID: <CAK8P3a3BZUG36VrqeCzyNmy0U972scPOUAqOeO7Gey3mS7d+sA@mail.gmail.com>
Subject: Re: [PATCH v2 04/17] ceph: fix compat_ioctl for ceph_dir_operations
To:     David Laight <David.Laight@aculab.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>, Zheng Yan <zyan@redhat.com>,
        Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Chengguang Xu <cgxu519@gmx.com>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 6:10 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Arnd Bergmann
> > Sent: 12 September 2018 16:01
> >
> > The ceph_ioctl function is used both for files and directories, but only
> > the files support doing that in 32-bit compat mode.
> >
> > For consistency, add the same compat handler to the dir operations
> > as well.
>
> Have you verified that all the relevant ioctl buffer structures are
> exactly the same for 32bit and 64bit applications?

I checked it now, it's fine: there are only ceph_ioctl_dataloc
and ceph_ioctl_layout structures passed here, both of which
are compatible.

I assumed that the ceph_dir_fops operations were correct
here (they are), but you are right that I should have double
checked for more bugs as I encountered one of them.

        Arnd
