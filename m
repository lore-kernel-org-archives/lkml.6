Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B65CC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6CB520666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ABVtzyey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6CB520666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbeJBWGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 18:06:03 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44477 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeJBWGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 18:06:02 -0400
Received: by mail-lj1-f194.google.com with SMTP id v6-v6so2112777ljc.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 08:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GCABJA274f7GptjJrL0hQdXxQxwNuRH/rCXy0Lx++Z8=;
        b=ABVtzyeyrcF+aH2akPQjh0XNW2P1Pl7b9T98ZLKwiHqKk+ZRSLp9WzRv6xZiptvQuJ
         8/ofdfzBBt8AE/dI3KvULSmxRusTbl4KZyGWEqr9viGRMPtsdrHN/fD5k7JcWhIBEOA9
         NsVYmuY6t3IrkBbfM6cdkHQ2PCgcfhRu28MRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GCABJA274f7GptjJrL0hQdXxQxwNuRH/rCXy0Lx++Z8=;
        b=JaBXoDFcO80Pv7wBNt1fLNLMERq1aJf7swJwYNOU4ErMFIxBmo3bGdB9h6/YgiVNdO
         /mjhdg536STy+sX5BPl3CkVCCVGYW1Ckx+MnJUAX+jP5v1KqTye+ELpH32JIFHVOmRIe
         fg+bOSmh0LPMIBiyJOb6XHWO3V39nj4WNLLFHYRWL//Jw94f9G3cxvgdD67tdRtPIxUx
         X+yZt010IZJRePuRnz3pjpu9nyUAa4leBIjoIyIn3GQuqc+kccup25DuqhkTLi7pbaaW
         V8r00Mqdasu3cw+pt/g932gtT3s1Km/WrLcb5qnW5TIa4MPFd3hv6/9LqN8bvtM9fj17
         U6dw==
X-Gm-Message-State: ABuFfohUY/fI2sr8msugUJDFKKrDH2/fiGHqxB/V+QTbGJQ6N3+hRKwZ
        xCyNhs6ouKXAg4n/MgGVhSOxF+Zag2k=
X-Google-Smtp-Source: ACcGV61YaJfb6prrft0rmRAnh+pBPYcvzGu6vwb5kYPA6MS8toX4mZubOGALRJxPHZ25idJuU4a0qQ==
X-Received: by 2002:a2e:800e:: with SMTP id j14-v6mr9633337ljg.114.1538493725836;
        Tue, 02 Oct 2018 08:22:05 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id k23-v6sm2702518ljc.49.2018.10.02.08.22.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 08:22:05 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 63-v6so2140113ljs.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 08:22:03 -0700 (PDT)
X-Received: by 2002:a2e:7c18:: with SMTP id x24-v6mr10458772ljc.174.1538493723329;
 Tue, 02 Oct 2018 08:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20181001161506.100284-1-evgreen@chromium.org> <ef53fcb4-9001-c06b-779f-d40949224c98@interlog.com>
In-Reply-To: <ef53fcb4-9001-c06b-779f-d40949224c98@interlog.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 2 Oct 2018 08:21:26 -0700
X-Gmail-Original-Message-ID: <CAE=gft5TFz4XQMLp8zH83W-agq-B7Df_1X-kX-UrSg8g1vipmw@mail.gmail.com>
Message-ID: <CAE=gft5TFz4XQMLp8zH83W-agq-B7Df_1X-kX-UrSg8g1vipmw@mail.gmail.com>
Subject: Re: [PATCH RESEND] scsi: sg: Prevent potential double frees in sg driver
To:     dgilbert@interlog.com
Cc:     jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, hch@infradead.org, rglasser@google.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 4:34 PM Douglas Gilbert <dgilbert@interlog.com> wrote:
>
> On 2018-10-02 02:15 AM, Evan Green wrote:
> > From: Robb Glasser <rglasser@google.com>
> >
> > sg_ioctl could be spammed by requests, leading to a double free in
> > __free_pages. This protects the entry points of sg_ioctl where the
> > memory could be corrupted by a double call to __free_pages if multiple
> > requests are happening concurrently.
>
> Hi,
> I  don't like this patch. I would like to see the trace for the double
> call to the __free_pages you are referring too. A test program that
> show the fault, perhaps?
>
> I have test code to "spam" the sg driver and have not seen a double
> __free_pages that you refer to (see sg3_utils package version 1.44,
> testing/sg_tst_async.cpp).
>
> Currently I am dusting off 20 years of "laparoscopic" patches to the sg
> driver that have made a bit of a mess of the naming and comments. Also
> the 16 outstanding requests per file descriptor limit is being removed.
> Then I want to add the SG_IOSUBMIT and SG_IORECEIVE ioctls proposed by
> Linus Torvalds two week ago.
>
> Executive summary: nak, without further information

That makes sense. Thanks for taking a look.
