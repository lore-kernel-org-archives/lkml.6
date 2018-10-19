Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598A3ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 20:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F8E20869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 20:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="GRqhRnvD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F8E20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeJTE4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 00:56:19 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:50711 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbeJTE4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 00:56:19 -0400
Received: by mail-it1-f193.google.com with SMTP id k206-v6so5803317ite.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 13:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lO+UJg6EiMQ0ZYPWxKmGumVP9aJi/YF7ZASwMKlOjX4=;
        b=GRqhRnvDbhBTqdmXFqtX3U+Vz22An61fBRKFR0zUAZVZSKW4b2xUT5fMm75lCOtqTe
         afmLETa3Eqs7W/9rypm6t4T02Eio47eVdd6ORSqHlnWdjbfxAD9F0kNPwCxJul8z71Gp
         9nGtMYIFVSJ54pNmKwKAzwpnA7JWLttwg03pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lO+UJg6EiMQ0ZYPWxKmGumVP9aJi/YF7ZASwMKlOjX4=;
        b=M9lqjVLei5XyM3hRj6T3A/65WD5XHIlQdgVvRiyHiEoJ8dt8ViKaqw8y9VosYrAnW2
         07uDN85Nd9sWDN3YaBcLYv/wt4lKAWs7/7qfwCjHyPm41Dy6D1qKLT7xw+onoFrTKzzP
         jT2Hbu4dUxfDV9pi906pMw5HaE7EUhiC71z7AVicFmbMBWTCXL0oetG+CiY0WYRt/2sI
         CWcoEJO95k/h6seqnEQ/e5ixCaiKNNjqIxWMRKyBkooFxGrF3rVPKt3hgwJlcg3kUqZW
         wq2COJwIIiJDFDTZVKtw2d6hpbsu3BDIUzfLR5yg7j2E4vJt4zbPd5ejDeqHLROlICMl
         5svw==
X-Gm-Message-State: ABuFfohtEQdjqh4HVtRg9w2t97bHLUkogDkyN7avmmKoMHKDnzWU/pIN
        MFsl6+lHJIkmJgeZRMfL12k+FDFZYgCf5IbyYwzT3w==
X-Google-Smtp-Source: ACcGV62TjpsscI2Lj8C2yK4kLkshKkPbf39UZHiBU6arPfNXX24L7bBaBoFeZWDONYoz/tvN6/FuIFWNeYz/qclC+Q0=
X-Received: by 2002:a02:1818:: with SMTP id k24-v6mr27104482jad.77.1539982116337;
 Fri, 19 Oct 2018 13:48:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bf41:0:0:0:0:0 with HTTP; Fri, 19 Oct 2018 13:48:35
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <05184f29b5778563519174769c675c5f6c5b2dd3.camel@hammerspace.com>
References: <20181019122049.27121-1-mszeredi@redhat.com> <20181019122049.27121-5-mszeredi@redhat.com>
 <2ca365ec330cf918188e8c47b26e741073382d9d.camel@primarydata.com>
 <CAJfpegtq1+vZ+uXwzFs20GeSPCR9UbtqD5-fOn8ynoJUJYx25g@mail.gmail.com> <05184f29b5778563519174769c675c5f6c5b2dd3.camel@hammerspace.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 19 Oct 2018 22:48:35 +0200
Message-ID: <CAJfpeguFe=KcahJmZire52TPppMk8amiTJFiBZuv=97bRbCj8g@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] nfs: don't clear STATX_ATIME from result_mask
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "mszeredi@redhat.com" <mszeredi@redhat.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "adilger@dilger.ca" <adilger@dilger.ca>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "fw@deneb.enyo.de" <fw@deneb.enyo.de>,
        "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 8:14 PM, Trond Myklebust
<trondmy@hammerspace.com> wrote:
> On Fri, 2018-10-19 at 19:46 +0200, Miklos Szeredi wrote:

>> How is it then that only STATX_ATIME is cleared and not the other
>> fields?
>
> It isn't just the atime. We can also fail to revalidate the ctime and
> mtime if they are not being requested by the user.
>
>>
>> Note: junk != stale.  The statx definition doesn't talk about the
>> fields being up-to-date, except for AT_STATX_FORCE_SYNC, so stale
>> attributes are okay, and do not warrant clearing the result_mask.
>>
>
> I disagree. stale == junk here, because the default of
> AT_STATX_SYNC_AS_STAT is described by the manpage as "Do  whatever
> stat(2) does." which this is not.

Ah, you are talking about this:

    /* Is the user requesting attributes that might need revalidation? */
    if (!(request_mask & (STATX_MODE|STATX_NLINK|STATX_ATIME|STATX_CTIME|
                    STATX_MTIME|STATX_UID|STATX_GID|
                    STATX_SIZE|STATX_BLOCKS)))
        goto out_no_update;

Well, if this is triggered for statx(...,  STATX_ATIME,
AT_STATX_SYNC_AS_STAT) and MNT_NOATIME, then yes, result will be junk.
Which means that the code is wrong, it shouldn't do that.

Otherwise (if something other than STATX_ATIME or STATX_INO or
STATX_TYPE is given as well) it *will* do the same thing as what
stat(2) does, so in that case STATX_ATIME should not  be cleared (yet
it is cleared).

I can do a patch, but not tonight...

Thanks,
Miklos


Thanks,
Miklos
