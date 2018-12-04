Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA25BC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770A4204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dw/75FWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770A4204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbeLDAIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:08:15 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:44037 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLDAIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 19:08:14 -0500
Received: by mail-ot1-f48.google.com with SMTP id f18so13451622otl.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 16:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iQfRL74ErdChu048ys5z9LflH5c6GKBTjd+Iml3JJyM=;
        b=Dw/75FWP4g7jgJD5o8MzQz2xwEu3WurBEU+r1TH+c38+2gREbQ3l6TcoKfoAayhH21
         Wbkm/L6JqEmzoyNGPK2EwSzLMSYeLM9mWzH98FRd6oKgoyfAduVJZJRbMXyJrRwWNs6D
         jmdAzDz71rooxDDVtYvVIUewUNICr9zzz8xr5krdL0z6nBAhwBoPpNbtiBcLykpBvDq3
         3zTo6nk6/xTSzQYedvdKwqyO9F4ZsVnUYbRT8NY9CX1cznaPePzFi8yTWiMotTU2YiQ7
         V/wAfKjrZ6WaHmXjGX2vDTYUYPRFBN/Ru1KaK1BWY6K26grUY8MeC8M37BwPXhavtLEx
         fxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iQfRL74ErdChu048ys5z9LflH5c6GKBTjd+Iml3JJyM=;
        b=XjFj/Ngflwno2Vk1FXJmE5MzELZ4mDX7pJ24xx1j4DVecWEGtaFsQdGsqdckp5SGVy
         aPBt3MX+hsrGuUyczEfq89NggsPIBaoGx2UGsLu5b92ETXUVrIjLZgofCLrqYBtmemB+
         yavVwHDiLs+suU6oqfu5R++WB7Femr1d+mm8WluW51Lt82IC6NELWrWxuEvUKNvz5HgU
         Ovkt6LQGwr0STIo8I0LfewjGn1DqrDQQ8XcS2mdl32uZCxNTUBjSBYosVsHBN49X42HW
         McII25DFP5fwKKDVGAXTcC3zRAAroj+gXsJMa3UgwN9xAg5ebcZ8NDhFwWSDMifcrVUH
         SqjQ==
X-Gm-Message-State: AA+aEWY5Zmqk09GoHUfZOKKHH3B+BF5dwti1rFOo/bxREtipO08GXkk6
        odBNVqhpp7JQZ5VeMsw7kfPR+GidS/pxqVTXoHGS8g==
X-Google-Smtp-Source: AFSGD/UgbYB5Rd1vxff6SL8u6gvZ9YrwKGjjmb2IMcqnzLgKBxvdvWo51EfiHqCAw1/+HkLlDPFb1bwxm/dyWx2vHfg=
X-Received: by 2002:a05:6830:1005:: with SMTP id a5mr10870915otp.113.1543882094045;
 Mon, 03 Dec 2018 16:08:14 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-18-brendanhiggins@google.com> <CAL_Jsq+09Kx7yMBC_Jw45QGmk6U_fp4N6HOZDwYrM4tWw+_dOA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+09Kx7yMBC_Jw45QGmk6U_fp4N6HOZDwYrM4tWw+_dOA@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 3 Dec 2018 16:08:02 -0800
Message-ID: <CAFd5g44bmhAOLYeHX8timke-zSr_6AA4tuxQcfeyc6AHFAxHeQ@mail.gmail.com>
Subject: Re: [RFC v3 17/19] of: unittest: migrate tests to run on KUnit
To:     Rob Herring <robh@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, mcgrof@kernel.org,
        shuah@kernel.org, Joel Stanley <joel@jms.id.au>,
        mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, dan.j.williams@intel.com,
        linux-nvdimm@lists.01.org, kieran.bingham@ideasonboard.com,
        Frank Rowand <frowand.list@gmail.com>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 12:56 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Nov 28, 2018 at 1:38 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > Migrate tests without any cleanup, or modifying test logic in anyway to
> > run under KUnit using the KUnit expectation and assertion API.
>
> Nice! You beat me to it. This is probably going to conflict with what
> is in the DT tree for 4.21. Also, please Cc the DT list for
> drivers/of/ changes.

Oh, I thought you were asking me to do it :-) In any case, I am happy to.

Oh yeah, sorry about not CC'ing the list.

Cheers
