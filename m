Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E19C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454B820866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M+kQ3ESa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 454B820866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbeIKXVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:21:17 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:40160 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbeIKXVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:21:16 -0400
Received: by mail-io0-f194.google.com with SMTP id l14-v6so4359489iob.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 11:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L8PWVi64V+HXxYaawqOWuD8gu2wOwwGDM6U615liPUo=;
        b=M+kQ3ESaIuAdQrMpX3rL9UE0/78JGJ1tyB3JU5WWNT29XHOJYX1HN7s73bUk3K9C/1
         TkrBNXd1SVprZR2mTA7VnTJLcc705uVEUcVPfZeJN2P9ZhZigqBF3CmGORlwooXU1g4P
         7Mtly+RdoIyDKrTV01WSO/tKQLEY5tVzvvtMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L8PWVi64V+HXxYaawqOWuD8gu2wOwwGDM6U615liPUo=;
        b=QHd3rUZwl5Wszb/qEk0W/93YCUsYdpIP3/+kbAmBNHAfp6sL1OW7i9Jc7VAHPmU6Kw
         E/9OoQX5QhNW4CTYMvLNiQjnFFKKVYmFrLrQ7AupO+UWxEIU1kDlRS7bAjLScixF2alx
         3IKyyD6bfWcQGxHuhuWWvWYuO+CeimKWYpPI4VlQSQSVTafGn4/biGW4ymnwFNu8VU89
         HgPYpaYDsyGd75kq5S8HoEd6cQVEJ8zyZA34jHztnDtsy7PurrnTBwZZ2i750ubE7Gpf
         59cqEZIRWZOIL6czVtxYs3PO7Cv1Cz7ZMEqQPpVIau6TJDfSp4Kthn3AXxvSV/3Vcpm4
         TVDA==
X-Gm-Message-State: APzg51DH58OMb1HguX3TjM9YleDrgmN5y3GUieVuAO6GzG30I4IyrFNR
        fhXQ+PahmALpJV3RaMybq3NWFoRFdKOyFXtm+W8=
X-Google-Smtp-Source: ANB0VdYMGtoEBJAmkBUj9J0nNfXXW+4dmqynl871RzyvXPoVmZRnvMkHgXUp6F2JWAgu8aOQDUso3KsDBbuEDwh5cYA=
X-Received: by 2002:a6b:f609:: with SMTP id n9-v6mr23952143ioh.259.1536690045391;
 Tue, 11 Sep 2018 11:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1808301639570.15669@math.ut.ee>
 <20180830205527.dmemjwxfbwvkdzk2@suse.de> <alpine.LRH.2.21.1808310711380.17865@math.ut.ee>
 <20180831070722.wnulbbmillxkw7ke@suse.de> <alpine.DEB.2.21.1809081223450.1402@nanos.tec.linutronix.de>
 <20180911114927.gikd3uf3otxn2ekq@suse.de>
In-Reply-To: <20180911114927.gikd3uf3otxn2ekq@suse.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Sep 2018 08:20:33 -1000
Message-ID: <CA+55aFzo3b2aChbJ2aOSvKbguYKMG8wv02NS8qzp6w2T5z8WTg@mail.gmail.com>
Subject: Re: 32-bit PTI with THP = userspace corruption
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Meelis Roos <mroos@linux.ee>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 1:49 AM Joerg Roedel <jroedel@suse.de> wrote:
>
> I had a look into the THP and the HugeTLBfs code, and that is not
> really easy to fix there. As I can see it now, there are a few options
> to fix that, but most of them are ugly:

Just do (4): disable PTI with PAE.

Then we can try to make people perhaps not use !PAE very much, and
warn if you have PAE disabled on a machine that supports it.

As you say, there shouldn't be much of a performance impact from PAE.
There is a more noticeable performance impact from HIGHMEM, not from
HIGHMEM_64G, iirc.

                Linus
