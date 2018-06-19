Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68307C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3BE20652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Ognqla78"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F3BE20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757049AbeFSOEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 10:04:47 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:39215 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756929AbeFSOEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 10:04:43 -0400
Received: by mail-ot0-f194.google.com with SMTP id l15-v6so22673744oth.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 07:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bV83TdM3N0InaIFNv+91wO16PuJxEqo2X/h2Y++QqkY=;
        b=Ognqla785vKK3koa1Z+RWnDiPehYSQiopcOH7Xt1ash/JKG3E8yTHS2xp9ShYyZcYi
         hLGrzOYxpEa0K0yWv5s1oBZmk2O2q0WF59rMfYvY3jUdyEztdcLBmRNDaoIaUxVQDzXn
         YoCOvQKryZmtWUkX1yRpeL0CLJ0tTBbM44tis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bV83TdM3N0InaIFNv+91wO16PuJxEqo2X/h2Y++QqkY=;
        b=NRwjafZa9MxX3dDVK0Zma2Xq54FC5LFd5qW/lpJQo3BHdrwYs3y6BJ9ordq6gszdRp
         Xrx2yURJ5jyLaiwDwMWlea/he+g/tVCIu5l5le/XXv6YdJWaMMKZab9oblL7/70cWzOV
         JZCHYZeauBl0Fmn9nuwT4j168y/NV7VxABS/M/9hC0KHmBopsF9x5MROUrLfdIdewcEs
         BxIIMPKlme5eZLdeJ3NdpcEmyDxWsgk+fnFDs+fzbkumqZxmOt7y8b2AFVpi6XL6Hhnu
         RbU7Dw597N7QFWzptXyI+03DfC3pQunOGgKEVlk2oIEkSnKuBai6BAbDOeBrOV/PCUUx
         lKqQ==
X-Gm-Message-State: APt69E1esrXZYqxXG0z2Jm/mWBgc1mEnZHJYTBPXzUJug2KA5upnug1I
        URcsK2t6WbniaCLUxogZAzPi3xm7TDSq/HIowC3EEw==
X-Google-Smtp-Source: ADUXVKKBtEnJzOZoqOj+F05tPX9ULzYVL7TsHLOpIUIl+y/lK5BrdYiRqWS4IteTLFpetiWwfwXDl87jDgads8ZfaG4=
X-Received: by 2002:a9d:1033:: with SMTP id h48-v6mr11104415ote.306.1529417082619;
 Tue, 19 Jun 2018 07:04:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1123:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 07:04:41
 -0700 (PDT)
X-Originating-IP: [176.63.54.97]
In-Reply-To: <20180611162412.GA7574@infradead.org>
References: <20180529144339.16538-1-mszeredi@redhat.com> <20180529144339.16538-8-mszeredi@redhat.com>
 <20180604084904.GF11333@infradead.org> <20180610045657.GM30522@ZenIV.linux.org.uk>
 <CAJfpegtGtAR25qWgpNisvL8F51h3K6s44zkWBSVVbqecut6tBQ@mail.gmail.com> <20180611162412.GA7574@infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 19 Jun 2018 16:04:41 +0200
Message-ID: <CAJfpegvxHs+MvC3N2Cbocp0UNrM47_GEUSV+mAx=8VVNDz7r_g@mail.gmail.com>
Subject: Re: [PATCH 07/39] vfs: export vfs_ioctl() to modules
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 6:24 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Jun 11, 2018 at 09:19:01AM +0200, Miklos Szeredi wrote:
>> We don't.  Obviously need to make sure to only ever do ioctl's in
>> overlayfs that have a common definition across filesystems.  Not a lot
>> of those, luckily...
>
> Which are those?  If they are common and possibly called from kernel
> code they should probably be made into methods instead.

FS_IOC*

Haven't looked deeply.  For now overlayfs just implements
FS_IOC_{GET|SET}FLAGS because some of these flags are quite generic
and implementing them on the overlay is easy.

Yes, turning into a method makes sense.

Thanks,
Miklos
