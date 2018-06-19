Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71A4C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F7C20883
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="NzVsEVW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F7C20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966399AbeFSOeh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 10:34:37 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:45836 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966267AbeFSOef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 10:34:35 -0400
Received: by mail-ot0-f194.google.com with SMTP id a5-v6so22781247otf.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 07:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7yrgEUXNJSPQNwTSId9Kj5IoIJ3AfmH6bvxrKeSa9No=;
        b=NzVsEVW+6bOvvoenJBt5D1SnWLHCOJCvXuUmZZ/sL/jRZIUhKzKtBDizam5pMIDKds
         ezfuMjlamPgsejcfQGUgcsO1AhhGXRUHIEph63/xSV4zjLOf9oOkP9S3nLlU7RtLlWlq
         jATeOO56AY6GuM1lvdgZUaBCv1xYblTXqKCXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7yrgEUXNJSPQNwTSId9Kj5IoIJ3AfmH6bvxrKeSa9No=;
        b=dka4ONEI5FxoVCr2wPAxqTDoCffpZ5H9uhZ9BWP9ZqMWadLNcPmuq6kE8/Ls0m97ou
         jbRF1F2W7tF9m1hS5vfCpfqIUp+owHF/fmGKMH/WF3mxX7XMQLSzyQYJcLj5mYkcCFyd
         53MYfLTyDHCsO8PzSDlJFsU1SAAve/tfZZgKA/cBoNWN9merIORUMLbvupMvspRakcKB
         QTkEUUTfsu4RWiRy3F5YdIzDXYw9ljTbMRNfcYem9wZHw1n2WsJ7abovBQZvdwtD8gV/
         xJzMACbmfrp8pTQ8JOyNzq/DO7eLRbXvaCxMFcg8YokEe7ZiVbQQJNFiLJBgmV96JrFc
         yeSg==
X-Gm-Message-State: APt69E3sRHnmowCh5Joik3O/F4knXKdCdRlWAt/evskKnwkzGKGCBECP
        QIOh0/wSOtTD5PTtLQTtrfbCx1ONw8QRDAtPtX1wAIhW
X-Google-Smtp-Source: ADUXVKKr0N79x1kZdyr3SgMTqW9DyB4o1LWWIdv74wYQQx/MnW68x6VF1fZZvVL0mm4v0mCMSNKBlyBOp/Emp9A5l1g=
X-Received: by 2002:a9d:4c02:: with SMTP id l2-v6mr9989155otf.242.1529418874892;
 Tue, 19 Jun 2018 07:34:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1123:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 07:34:33
 -0700 (PDT)
X-Originating-IP: [176.63.54.97]
In-Reply-To: <20180619142421.GA16151@infradead.org>
References: <20180529144339.16538-1-mszeredi@redhat.com> <20180529144339.16538-8-mszeredi@redhat.com>
 <20180604084904.GF11333@infradead.org> <20180610045657.GM30522@ZenIV.linux.org.uk>
 <CAJfpegtGtAR25qWgpNisvL8F51h3K6s44zkWBSVVbqecut6tBQ@mail.gmail.com>
 <20180611162412.GA7574@infradead.org> <CAJfpegvxHs+MvC3N2Cbocp0UNrM47_GEUSV+mAx=8VVNDz7r_g@mail.gmail.com>
 <20180619142421.GA16151@infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 19 Jun 2018 16:34:33 +0200
Message-ID: <CAJfpegt7QYa1SD=uJ84RE9qLbJLMCW+viV=FN_TJJjCK4BERLQ@mail.gmail.com>
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

On Tue, Jun 19, 2018 at 4:24 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, Jun 19, 2018 at 04:04:41PM +0200, Miklos Szeredi wrote:
>> FS_IOC*
>>
>> Haven't looked deeply.  For now overlayfs just implements
>> FS_IOC_{GET|SET}FLAGS because some of these flags are quite generic
>> and implementing them on the overlay is easy.
>>
>> Yes, turning into a method makes sense.
>
> Do you want to do this or should I send a patch?

Do it.  You are much more familiar with regular fs that implement
these ioctls.  Untangling overlap between FS_IOC_...FLAGS and
FS_IOC_...XATTR looks "interesting".

Thanks,
Miklos
