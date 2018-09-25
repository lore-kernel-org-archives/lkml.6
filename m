Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0D9C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7981F214D5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="USGD7POO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7981F214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbeIYPPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:15:30 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33227 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbeIYPPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:15:30 -0400
Received: by mail-io1-f67.google.com with SMTP id l25-v6so6755049ioj.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 02:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SZL6QQS3XeYEyVRw3GXvtQcEhyLVTaKH4ANdPWYBzjo=;
        b=USGD7POOhc4b/BYljH2BRZ/OaQ4Ecda4bEaTdR6wPZRCIEoXfScDoJmaElcxJOWrY0
         dhMytc383xxfy/5D9EmVsYm3W8emmQpZCi27YwF5FmldAaoStVnk+CjGp3mJaMjGGhun
         VwmkmOKY9rSRlgb5PLFoR5Gehvbznn3sKD4PQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SZL6QQS3XeYEyVRw3GXvtQcEhyLVTaKH4ANdPWYBzjo=;
        b=W/P0WFMPNUptVwM4WASRitU+hCaz9H8/Ye6S2Mg3nI4Di7P978okKVb9tlgjidWBlc
         3ztHY3Zlx/7NRo/rrNO+FG71OjVGbBreM/YXpfgGOrgElC4EVGKcaRBqDhMLSffaY/Mp
         w5oF0cbmjbr/Lz9cfc3nwzsEuBO1vGAGi4/Nehl+ljV+9befoaefCXe8nF/RstiPD161
         DI0AkCEhEaErHV8fI0axZlzh1Wp/ZhZtG7LA7NSdXnV78T3p3HJNHh+wMGxUbSrFsbho
         aPXYllKJ9sDFcmaEsHcIBU+N7jooEoOgDmhSzlEA4Hvz8HbGaLdZRaTVk4R5nCKXoXhd
         uorQ==
X-Gm-Message-State: ABuFfoj4s4Q8cj6EeiyMPwnUknKAEAGgWLJCZV9qT08rBQXdJ5ORaJaj
        iAqXSRulEXcedtwc5EQipsOx1BQocLHS7qDEkbFgtXC9
X-Google-Smtp-Source: ACcGV63UJpWMXtdgvWtS2pYDF55tb2WhNOS28wrphIMmTIWdUTfFflEh29C8m4HMTiM+1ie+j5+1C6FYk4BN0yInzwY=
X-Received: by 2002:a6b:fe09:: with SMTP id x9-v6mr55085ioh.294.1537866535901;
 Tue, 25 Sep 2018 02:08:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bf41:0:0:0:0:0 with HTTP; Tue, 25 Sep 2018 02:08:55
 -0700 (PDT)
X-Originating-IP: [185.79.95.212]
In-Reply-To: <153666073461.19117.1958730317836145457.stgit@localhost.localdomain>
References: <153666041612.19117.14667042009014596105.stgit@localhost.localdomain>
 <153666073461.19117.1958730317836145457.stgit@localhost.localdomain>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 25 Sep 2018 11:08:55 +0200
Message-ID: <CAJfpegt3ckxAUAdabXKwxgFYdP9=wVSis+G3pztWgqzXVGNFSA@mail.gmail.com>
Subject: Re: [PATCH 3/3] fuse: Use hash table to link processing request
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     kuznet@virtuozzo.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 12:12 PM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> We noticed the performance bottle neck in FUSE running our
> Virtuozzo storage over rdma. On some types of workload
> we observe 20% of times pent in request_find() in profiler.
> This function is iterating over long requests list, and it
> scales bad.
>
> The patch introduces hash table to reduce the number
> of iterations, we do in this function. Hash generating
> algorithm is taken from hash_add() function, while
> 512 lines table is used to store pending requests.
> This fixes problem and improves the performance.

Pushed to fuse.git#for-next with a number of small changes.   E.g. I
reduced the number of cachlines to 256 to make the hashtable size just
4k.   Was there a scientific reason for choosing 512 as the optimal
number of cache lines?

Thanks,
Miklos
