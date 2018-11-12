Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26270C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E010F20881
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E010F20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbeKLMhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 07:37:47 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34600 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729729AbeKLMhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 07:37:47 -0500
Received: by mail-io1-f67.google.com with SMTP id f6so2189485iob.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 18:46:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FyYzrdC1HYt7KC4NolU3y30BFZovpyK+SwwinP6mcrY=;
        b=aExACU0ImPVLdbUfJswoQNysw1Gk47PEs1htJFuhuw63mMk41yC32prBNKjcxG1QB+
         nSMXVALO+CwcSV4rEDqD042kf9BydCIeIgK5otPQFrNKT3YFqyE1iHR248Or00Mc3M0j
         KYZfkQYsZZFVfHOkNeTRIIypt9Wq2vKsObZMx4TxJJ3An3Mn++HAsBCVd3w/sj1BRPT/
         +FeoJBedKUU3jUpdze6yqpqeaHPjvR6Sw1hV+a4n7Pt06lrYWGad6lzT5IPh2f+VReKx
         FlosY+MD7K0Q2KCP5XJsQxfXXXwch3R7bbH6LmIV9eKK0N5WNPJcDO164rbrw3aKehmH
         pHpQ==
X-Gm-Message-State: AGRZ1gK2b2j/xKdQdQeSPwaPH73Vw12dVR61PzCyPBGDw+2Ri7gsC1gR
        8cbTOtD7LYS3uISdZeqn/jEHhWQv4Lj3jLl9jeY=
X-Google-Smtp-Source: AJdET5eTfXr2Hjz5siqcqxY63SJGpogez6O5hF3Qrle5Gmu7CS6ppluzJ8juuYt8K4jVWnvNU8KM81gxm+6ggsPSXIc=
X-Received: by 2002:a6b:3b4a:: with SMTP id i71-v6mr14167834ioa.133.1541990805191;
 Sun, 11 Nov 2018 18:46:45 -0800 (PST)
MIME-Version: 1.0
References: <1539955889-9968-1-git-send-email-chenhc@lemote.com> <20181111192901.GA8332@kroah.com>
In-Reply-To: <20181111192901.GA8332@kroah.com>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Mon, 12 Nov 2018 10:52:39 +0800
Message-ID: <CAAhV-H72Yf86sEBykk=ziAr+6+ttT=GRWK5DnyFpNFqccoAahQ@mail.gmail.com>
Subject: Re: [PATCH V2] cacheinfo: Keep the old value if of_property_read_u32 fails
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        zhangfx <zhangfx@lemote.com>, wu zhangjin <wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 3:29 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Oct 19, 2018 at 09:31:29PM +0800, Huacai Chen wrote:
> > Commit 448a5a552f336bd7b847b1951 ("drivers: base: cacheinfo: use OF
> > property_read_u32 instead of get_property,read_number") makes cache
> > size and number_of_sets be 0 if DT doesn't provide there values. I
> > think this is unreasonable so make them keep the old values, which is
> > the same as old kernels.
> >
> > Fixes: 448a5a552f33 ("drivers: base: cacheinfo: use OF property_read_u32 instead of get_property,read_number")
> > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/base/cacheinfo.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
>
> What changed from v1?  Always put that below the --- line.
Hi, Greg,

V2 just add a Fixes line and Reviewed-by line, no functional changes.

Huacai
>
> Please fix this up and resend a v3.
>
> thanks,
>
> greg k-h
