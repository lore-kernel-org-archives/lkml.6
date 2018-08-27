Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57B3C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA36208DA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vhti4eYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA36208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbeH0La6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 07:30:58 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:33203 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbeH0La6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 07:30:58 -0400
Received: by mail-yw1-f65.google.com with SMTP id x67-v6so5253934ywg.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 00:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eH4vm//qybksYdeJPpfi08obzMQoaLoLFRKlSFr+2lU=;
        b=Vhti4eYYz4PqCF4XKJd9GQ8tiGoqdERa54A5RrMzawUeI8sKSdUEDhZQpRNbhlEadQ
         LBXhEP3kVVIPKyAMmBP52Ad+/K7Zl1pZLhHXyP/YJnAZKo4awGnIjoeKZDM4+WdZ5Wst
         xN5to9qr18ofS8pFURiv1YWIxYDGY/KXpAMPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eH4vm//qybksYdeJPpfi08obzMQoaLoLFRKlSFr+2lU=;
        b=EqPxtENKloE1fFT5q54h1q2EfA7efs/gGHw/AMSV6uF1gCQiS6CeOAyUvIxiBvygsU
         2EGCWPJz2DCtwIFbTfCacn3V2utUhNhVIAxfWUe5fyXKF8ac4r+k7rCvsKaUpuaos5Pq
         xHWi1x5ks1M59r6nXNOkPU+IC7wPPKZPaDsLklmSZmCv1ivO1D+H6SPW06Lc7zjlGdeJ
         SRlX5P6pQGACHLzGhoIY6ahfClt+viJ4SUfdT7gKNHrvmN0azLSzs+KUypUsYFgqKi+F
         y1P8PzaiDcpPCXzb7VvfdlIb/mf8/0hWt49XTUwEC3MD74Y2IF0RPO0cGl4ybUKZFNyr
         8pZA==
X-Gm-Message-State: APzg51AgOdFSGeze9g8FN0gF8CMIH3Kx7yAM3muNA7gcgj8RfrhQGDId
        11b7yhYSVW5GZWipkVpIVPVtLN1SKgM=
X-Google-Smtp-Source: ANB0VdYKLoC0jiWD2rUM9+3r3VNaPU8UqMxp+ms6oiTBvcMeJMaXZ0tHmopO3yLp35o+Tce/dEBj7w==
X-Received: by 2002:a81:23d3:: with SMTP id j202-v6mr6126649ywj.201.1535355927967;
        Mon, 27 Aug 2018 00:45:27 -0700 (PDT)
Received: from mail-yw1-f47.google.com (mail-yw1-f47.google.com. [209.85.161.47])
        by smtp.gmail.com with ESMTPSA id k186-v6sm6014030ywd.106.2018.08.27.00.45.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 00:45:26 -0700 (PDT)
Received: by mail-yw1-f47.google.com with SMTP id q129-v6so5243419ywg.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 00:45:26 -0700 (PDT)
X-Received: by 2002:a81:9fd6:: with SMTP id w205-v6mr6568214ywg.288.1535355925994;
 Mon, 27 Aug 2018 00:45:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2c11:0:0:0:0:0 with HTTP; Mon, 27 Aug 2018 00:45:25
 -0700 (PDT)
In-Reply-To: <20180529132722.GH7445@brain>
References: <1520467365-7194-1-git-send-email-bbellevi@uci.edu> <20180529132722.GH7445@brain>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 27 Aug 2018 00:45:25 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLXm8mJuwtDEO_+dDJk5tRA+2mkEv5S9NaPP87J42B7KQ@mail.gmail.com>
Message-ID: <CAGXu5jLXm8mJuwtDEO_+dDJk5tRA+2mkEv5S9NaPP87J42B7KQ@mail.gmail.com>
Subject: Re: [PATCH] floppy: Do not copy a kernel pointer to user memory in
 FDGETPRM ioctl
To:     Andy Whitcroft <robobotbotbot@gmail.com>
Cc:     Brian Belleville <bbellevi@uci.edu>,
        Jiri Kosina <jikos@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 6:27 AM, Andy Whitcroft <robobotbotbot@gmail.com> wrote:
> On Wed, Mar 07, 2018 at 04:02:45PM -0800, Brian Belleville wrote:
>> The final field of a floppy_struct is the field "name", which is a
>> pointer to a string in kernel memory. The kernel pointer should not be
>> copied to user memory. The FDGETPRM ioctl copies a floppy_struct to
>> user memory, including the "name" field. This pointer cannot be used
>> by the user, and it will leak a kernel address to user-space, which
>> will reveal the location of kernel code and data and undermine KASLR
>> protection. Instead, copy the floppy_struct except for the "name"
>> field.
>>
>> Signed-off-by: Brian Belleville <bbellevi@uci.edu>
>> ---
>>  drivers/block/floppy.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
>> index eae484a..4d4a422 100644
>> --- a/drivers/block/floppy.c
>> +++ b/drivers/block/floppy.c
>> @@ -3470,6 +3470,7 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode, unsigned int
>>                                         (struct floppy_struct **)&outparam);
>>               if (ret)
>>                       return ret;
>> +             size = offsetof(struct floppy_struct, name);
>>               break;
>>       case FDMSGON:
>>               UDP->flags |= FTD_MSG;
>
> I am not sure it is reasonable to simply set size here to the length of the
> valid data.  Though in the real world everyonne should be using the defines
> and those should include the full length, the code itself does not require
> this, it only prevents overly long reads.  So I think it is possible to do
> this read with a shorter userspace buffer; with this change we would
> then write beyond the end of the buffer.
>
> This also seems to introduce a slight behavioural difference between the
> primary and compat calls.  The compat call already elides the name but it
> also is copying into a new structure for return and this is pre-cleared,
> so the name will always be null for the compat case and undefined for
> the primary ioctl.
>
> Perhaps the below patch would be more appropriate.
>
> -apw
>
> From ddb8c77229a9507fa5575c910d2847e123a9c94c Mon Sep 17 00:00:00 2001
> From: Andy Whitcroft <apw@canonical.com>
> Date: Tue, 29 May 2018 13:04:15 +0100
> Subject: [PATCH 1/1] floppy: Do not copy a kernel pointer to user memory in
>  FDGETPRM ioctl
>
> The final field of a floppy_struct is the field "name", which is a pointer
> to a string in kernel memory.  The kernel pointer should not be copied to
> user memory.  The FDGETPRM ioctl copies a floppy_struct to user memory,
> including this "name" field.  This pointer cannot be used by the user
> and it will leak a kernel address to user-space, which will reveal the
> location of kernel code and data and undermine KASLR protection.
>
> Model this code after the compat ioctl which copies the returned data
> to a previously cleared temporary structure on the stack (excluding the
> name pointer) and copy out to userspace from there.  As we already have
> an inparam union with an appropriate member and that memory is already
> cleared even for read only calls make use of that as a temporary store.
>
> Based on an initial patch by Brian Belleville.
>
> CVE-2018-7755
> Signed-off-by: Andy Whitcroft <apw@canonical.com>

I didn't see this land anywhere? Who's tree is this going through?

-Kees

> ---
>  drivers/block/floppy.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index 8ec7235fc93b..7512f6ff7c43 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -3470,6 +3470,8 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode, unsigned int
>                                           (struct floppy_struct **)&outparam);
>                 if (ret)
>                         return ret;
> +               memcpy(&inparam.g, outparam, offsetof(struct floppy_struct, name));
> +               outparam = &inparam.g;
>                 break;
>         case FDMSGON:
>                 UDP->flags |= FTD_MSG;
> --
> 2.17.0
>



-- 
Kees Cook
Pixel Security
