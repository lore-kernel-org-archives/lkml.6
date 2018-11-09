Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5AFC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 00:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D5620855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 00:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D5620855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeKIJmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 04:42:16 -0500
Received: from mail-vs1-f50.google.com ([209.85.217.50]:41886 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbeKIJmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 04:42:16 -0500
Received: by mail-vs1-f50.google.com with SMTP id t17so45350vsc.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 16:04:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CAk+1k0shuYGopg8VVtccJNGDqJOzQz7q3/ZAZfqn88=;
        b=oAhZmuGexP0m72k3+vCsfgxU68+wAP0Ozd1XCi1eg1OwFYKX5pclNQTzaAUc8eu/ib
         DeFjxGJ/6bDh6h0ZdTj++cGD+JAvsoIhISXbpBbiUi9itDXN5/pS44f44fMEYFwt0LkY
         hhIazgCHaXkiySc2rRFIrhxMD5PbjUqVWH9cMrpajk3hYvM0YJOBbqcMci6MxJlXQlAs
         6a9WkllvnVlr6WT+xrS5Gj2+tecJRaUNwgMgQt8+RGiaOpdu2Rm/YfVh0WRcMX7keq02
         wQU7RcEZI4Kwtll5MMigLUpTjO/2nRzGl9vSWypA4xikgP3mMPR1NexqlAe+ydPqS0ss
         oi1A==
X-Gm-Message-State: AGRZ1gL85Fx+rE/oZMHUwhkDa59it1u249aHghudVYatArKZLThkTfzf
        hJZrFLFVvwoEir1lni9LZUnZyzAyWX7T27FiyOC8WA==
X-Google-Smtp-Source: AJdET5fmi8nhtdaUB3SXVLxCytgm6Pk1Z9FW+tUV1rqmmfzum337OFBdK/x54yTeYF3RDAIU1Yn18go/IsPOV4XCz7U=
X-Received: by 2002:a67:6e87:: with SMTP id j129mr2959928vsc.171.1541721855642;
 Thu, 08 Nov 2018 16:04:15 -0800 (PST)
MIME-Version: 1.0
References: <20181101162707.598c1718@endymion> <20181108130509.3b2d42ff@endymion>
In-Reply-To: <20181108130509.3b2d42ff@endymion>
From:   David Airlie <airlied@redhat.com>
Date:   Fri, 9 Nov 2018 10:04:03 +1000
Message-ID: <CAMwc25oWstf8bFfWfb=FFR8GfFhx+jM77TzqE-qfi+ev2pMvFw@mail.gmail.com>
Subject: Re: Performance regression in ast drm driver
To:     jdelvare@suse.de
Cc:     christian.koenig@amd.com, "Iwai, Takashi" <tiwai@suse.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 10:05 PM Jean Delvare <jdelvare@suse.de> wrote:
>
> On Thu, 1 Nov 2018 16:27:07 +0100, Jean Delvare wrote:
> > Hi David,
> >
> > The following commit:
> >
> > commit 7cf321d118a825c1541b43ca45294126fd474efa
> > Author: Dave Airlie
> > Date:   Mon Oct 24 15:37:48 2016 +1000
> >
> >     drm/drivers: add support for using the arch wc mapping API.
> >
> > is causing a huge performance regression for the ast drm driver. In a
> > text console, if I call "cat" on a large text file, it takes almost
> > twice as much time to be displayed and scrolled completely.
> >
> > Can you please check that the ast driver portion of that commit is both
> > correct and complete?
>
> And in the meantime, what bad will happen if we just revert the ast
> portion of that commit?
>

This seems likely to be a hw problem with PCI writes to the AST "GPU",
since it's just some sort of RAM + ARM on the end of a PCIE bus, we've
definitely seen possible issues in the past with write combining
around some of the mga GPUs with some CPUs.

Have we seen the problem across a number of AST devices?

Dave.
