Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78486C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C23214C1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="VZs6FsOI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C23214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731927AbeIXVGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:06:51 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37792 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730111AbeIXVGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:06:49 -0400
Received: by mail-io1-f68.google.com with SMTP id v14-v6so17861593iob.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 08:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KCZtKkAnBWhjGuHz0Qqtj110cu8mPWHG0oxrWOK5/q4=;
        b=VZs6FsOI2EREWJvZIVz6ylNa4LUHFP9d/0m4tjJzpN7x/HgiwAWnPlasNzsI9ho2m4
         k8N0+zimIxAKBXVBgGyL+odfKT3ndbsk4QdWMZ2shgudas5uqUR50aZJUkrMkiTwBA3M
         mg+swulEL8gS8ALJqZ8Nx/Rz9CK6IP9dpOFMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KCZtKkAnBWhjGuHz0Qqtj110cu8mPWHG0oxrWOK5/q4=;
        b=G1MXVRAZ5vhQRaxNbR2RF+Op2TGnF6/hQ81JZADWiKrBBBQ2Gp7fuHXHDc1qClWqJy
         U/WozRN9uJgPjdemA4l2akUcDF0hvTBKoZUc1jFFRKHHEpyXoakkqSR/QlPVTkii+q1X
         HEC1ix/jbprYdFMdpG/6gOwK2KKrrvGtQj7nD8thFyukJZ8MDysnVo2osz5XUaaH1wgG
         jjr3NASJKgQtmlyTMnqEffMOG8oxso43v746aG4cZM23ztMPnjcHTwaAMbHMVqJe1AaC
         SQ6MeOC3AjjyebaekAHFx9/tNX62D3k8MjAtyaE0GANk7cBTzGcNyh5RxVU7Ny9kqfnb
         BwZw==
X-Gm-Message-State: ABuFfojqeV1PET/h1CqB3KvlSWs0xq9VqSoAZPAfHta0SGSkt9ZenswW
        Q2wj9R3rP3mlIhOmGgz+kHW3nNZBlckzZBZIW7RFTg==
X-Google-Smtp-Source: ACcGV62C10rXWFarnMQ7IgWL3fKIfJw6FgL7/9BYs/fkWL3Xs8FNYyKM178hBftFc0HX5SQRpOMlAr4ZxR5TzR2QrO8=
X-Received: by 2002:a6b:1e91:: with SMTP id e139-v6mr8429141ioe.246.1537801454424;
 Mon, 24 Sep 2018 08:04:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bf41:0:0:0:0:0 with HTTP; Mon, 24 Sep 2018 08:04:13
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <8222c235-ff07-b16b-3389-0b9780145abd@virtuozzo.com>
References: <153666041612.19117.14667042009014596105.stgit@localhost.localdomain>
 <8222c235-ff07-b16b-3389-0b9780145abd@virtuozzo.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 24 Sep 2018 17:04:13 +0200
Message-ID: <CAJfpegt60Bcmu+fHRTL-HE-Uw5rvP3Nb_yuzfpX02E9Z8ECbdg@mail.gmail.com>
Subject: Re: [PATCH 0/3] fuse: Solve request_find() bottleneck
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     kuznet@virtuozzo.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 2:08 PM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> 2 weeks passed, so ping.
>
> Miklos, any reaction on this?
>
> Thanks,
> Kirill
>
> On 11.09.2018 13:11, Kirill Tkhai wrote:
>> Hi,
>>
>> We noticed the performance bottle neck in FUSE running our
>> Virtuozzo storage over rdma. On some types of workload
>> we observe 20% of time spent in request_find() in profiler.
>> This function is iterating over long list of requests, and it
>> scales bad.
>>
>> The patch introduces hash table to reduce the number
>> of iterations, we do in this function. Also, algorithm
>> of generating IDs for interrupt requests is changed,
>> simplified request_find() function and killed
>> fuse_req::intr_unique field.

Concept looks good.  Will review details...

Thanks,
Miklos
