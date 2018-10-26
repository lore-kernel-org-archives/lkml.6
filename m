Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B805ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8A820869
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 20:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HyLFPSe6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB8A820869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeJ0Es6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 00:48:58 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38592 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeJ0Es6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 00:48:58 -0400
Received: by mail-lj1-f196.google.com with SMTP id k11-v6so2279870lja.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 13:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QLkHV6pWJe+d2iTOq9CFVVNca99PLFJdKWtysCVEe2U=;
        b=HyLFPSe6bZrKzK27B3sfl4VlIuDEB/OWrWL1/IUP5YVYi+ad6/Kio3/O3XFlqHoglC
         ImG9EuqzH+7mi2hbOJBYaN/MdHCAQ/E4dW2x/F6OqP8/NSqnWexP7zwGQTvywAMRWc7Y
         VhdWmAS8kEw/YJlhO35lPHD3M6LJLsCIj9ikM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QLkHV6pWJe+d2iTOq9CFVVNca99PLFJdKWtysCVEe2U=;
        b=TWf8oPJJ+PN7lzI9wUkzQ/Os6gfdsqQtMGt3u4jN9960FQD50TMDy5fUkz7dizQuR3
         bkAVvlkU2wlKYqvKx0c4nQJudJ1quJTpGuq2M5M5ltSObhQ9F2Jd5E152qqE1ouJiWxw
         b6PqVAofa21458AeXOdBcoWlgc2ph6XtbU6W2Rc+bN21uqDlSy1gHgp/iqPEhJbiMVMO
         GkCqHSWwRi6B3CMW+HOEfEs82qr2Wv9uRMdruYlD3KdeVA8ToYEvleRRWccBCMLIK7L/
         l6sS2tXFBMXsm7mzfJKH4s3RaMGMJ5EzYEdF1kUonazrFVosMIGE5skxOnspLE7Z/mxx
         gbcw==
X-Gm-Message-State: AGRZ1gL6DMB14IH/+FPZIlgD07vV1WQ/IS7tbBijOkH39RdUpkcie2K6
        NDk++BntFfP6elFriSzkhoAZtQec8bAzuA==
X-Google-Smtp-Source: AJdET5ctvvBuA4U1Wt4gWg+D/vEX1WA4b/9S8/LN5AWaYgAi0GzCLcSoWoI6oPJdFd2nFGXi9cpWCA==
X-Received: by 2002:a2e:3006:: with SMTP id w6-v6mr3299788ljw.146.1540584633537;
        Fri, 26 Oct 2018 13:10:33 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id c22sm1779629lfd.88.2018.10.26.13.10.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 13:10:32 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id c24-v6so1811861lfi.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 13:10:32 -0700 (PDT)
X-Received: by 2002:a19:7019:: with SMTP id h25-v6mr3223752lfc.147.1540584632204;
 Fri, 26 Oct 2018 13:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <6bbed95d83465dde644c6f66acc73e3cd94f123e.camel@hammerspace.com>
In-Reply-To: <6bbed95d83465dde644c6f66acc73e3cd94f123e.camel@hammerspace.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Oct 2018 13:10:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wheW3hFQ8Jy5YYnNL1V+ZqA_qQoA63q2uK9ngz4=pXCqw@mail.gmail.com>
Message-ID: <CAHk-=wheW3hFQ8Jy5YYnNL1V+ZqA_qQoA63q2uK9ngz4=pXCqw@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull NFS client changes for Linux 4.20.
To:     trondmy@hammerspace.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 8:45 AM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> NFS client updates for Linux 4.20

Pulled.

Btw, just out of curiosity - is there some pattern to when I get the
pull requests from you vs Anna? Or is it just "whoever happens to have
the baton"? Not that it matters, but I was wondering if there was some
logic to it that I've missed..

                Linus
