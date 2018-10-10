Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780DFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287BF2087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="CkACchr7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 287BF2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbeJJPup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:50:45 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42530 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbeJJPup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:50:45 -0400
Received: by mail-io1-f65.google.com with SMTP id n18-v6so3244029ioa.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 01:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=I3rSlDNFEqKD3ELXkwJ2Qg/0v5pfaKMnLGM4VMw7G90=;
        b=CkACchr7+/M3gD0lgEUEkcoA8+9UIrkOo7cSVJC+mEiRhi07+IiSL62SATJD8X/xR5
         pc6yKlwQH6NlbX6sybysfsTs/cJ35h0ZLgsl/rtGxk2oRTqFYAEN6JKDhO+PX3BdB3d4
         TiIhApXMsmLwnhn9gKUZ66vAxnsA2zgb4s7+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=I3rSlDNFEqKD3ELXkwJ2Qg/0v5pfaKMnLGM4VMw7G90=;
        b=TY1B4BfQleYs6AHY5JkAXpdTPYEEAGDxoQ9+OaMOSgTpiYshlF1RhSw941w90uqE+w
         EzcQ03MGsOXu4m/toD6RKy7dvWtZhLTKvtC72nay1r+RfJZ4l1MV3rQx/Chmtwh99vN6
         Z+TGWSvAKpupLEEGFE1ItisqsWadwyIOjhreSm8QViyi6sG6qrxvOB5cveLtFsUQbgwF
         +WDagZUU6paDUPtagBUHRdgfDAR3QjwC98iuKl8FmX85QfY0OUY+FAQK+3qqg8VYw/Aj
         jq/6Zm3/8JM8OMp7bVgoxOKw8dAWKZC4dXvOKvv6A9d30NvBvOEHyOFDQOjit5Bt5YWN
         rhYw==
X-Gm-Message-State: ABuFfoizZhmfWzndA3zUPb9VLMhxEXfmGNBD4UCRpSbvPIc2xnBJpG/W
        2IWZZR3N6Eulq+qPPaW0fLA5Itke+/gG3XwVih5Ykft+DQQ=
X-Google-Smtp-Source: ACcGV63JpxLh8cPzrdNB3hbxtDu5onGw8PbXdpEZhDvf17VXSxkcjjG2Sn9WIYTQw/x4/vVYCxWibHsld8Dx6qepqEs=
X-Received: by 2002:a5e:8b06:: with SMTP id g6-v6mr18543575iok.144.1539160180429;
 Wed, 10 Oct 2018 01:29:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bf41:0:0:0:0:0 with HTTP; Wed, 10 Oct 2018 01:29:39
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <FEA49C2E-639E-4B1E-A4A1-0E0879F1214A@fb.com>
References: <20180927135211.31641-1-dschatzberg@fb.com> <CAJfpegsRNv3Uby2w-B0+d4fE8ecSRkT0ef2AfQ_QnnEVT-nkmA@mail.gmail.com>
 <FEA49C2E-639E-4B1E-A4A1-0E0879F1214A@fb.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 10 Oct 2018 10:29:39 +0200
Message-ID: <CAJfpegugRrA7-U4+6zRWZBEuTiYa=GgLqCeJWvhBz15-5szubQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: enable caching of symlinks
To:     Dan Schatzberg <dschatzberg@fb.com>
Cc:     Tejun Heo <tj@kernel.org>, Kernel Team <Kernel-team@fb.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 11:33 PM, Dan Schatzberg <dschatzberg@fb.com> wrote:
> On 9/27/18, 9:59 AM, "Miklos Szeredi" <miklos@szeredi.hu> wrote:
>
>>  On Thu, Sep 27, 2018 at 3:52 PM, Dan Schatzberg <dschatzberg@fb.com> wrote:
>>> FUSE file reads are cached in the page cache, but symlink reads are
>>> not. This patch enables FUSE READLINK operations to be cached which
>>> can improve performance of some FUSE workloads.
>>>
>>> In particular, I'm working on a FUSE filesystem for access to source
>>> code and discovered that about a 10% improvement to build times is
>>> achieved with this patch (there are a lot of symlinks in the source
>>> tree).
>>>
>>> Please provide feedback, I'm looking to flesh this out more.
>>
>> Need to think about how/when to invalidate the cached symlink
>> contents.  I think treating it like metadata (i.e. look at
>> attr_timeout for validity) would be the simplest.
>>
>> Thanks,
>> Miklos
>>
>
> Any further thoughts on this? Just so I can confirm my understanding,
> the attached patch will unconditionally cache READLINK responses
> However, based on the entry timeout provided by the LOOKUP response,
> Userspace can decide to invalidate this by providing a different inode on
> a subsequent LOOKUP (e.g. during fuse_dentry_revalidate())

Indeed.

> Would you like there to be a way to invalidate the cached symlink without
>  changing the inode via LOOKUP?

No, that would make no sense, since symlink contents are not mutable.
This was just a braino on my part.

I still worry about backward compatibility, though.  So we should add
a flag to negotiate symlink caching in with the INIT request.

Thanks,
Miklos
