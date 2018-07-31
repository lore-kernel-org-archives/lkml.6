Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB0AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FF3208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 04:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="a8+ZRWjA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7FF3208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbeGaFjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 01:39:33 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45200 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeGaFjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 01:39:33 -0400
Received: by mail-pl0-f68.google.com with SMTP id j8-v6so6523519pll.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 21:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MvRrQWR7Q/fxZSpd4e7e/XaLSCLKGgGe8Oa4VsFPWBI=;
        b=a8+ZRWjAfzqV/E3aqyW7CzPLraqmbE0fsEjUgAKZQhdrF1yu+zJlxMy8MZKxapuvfH
         mBP9UyFAfctSLf86VcohI+V+jZAW4qVut2P/ctcd53ef3A0eGQvr85R4vF+wj0casgt4
         9FH0i19fAR4/QhPeaJc7OQKGJDZqcLZ+Ip1UE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MvRrQWR7Q/fxZSpd4e7e/XaLSCLKGgGe8Oa4VsFPWBI=;
        b=HSOF559WGFR/Hg2pYpDwZ7BBsz/84+YXEFXKkFA26z0R+2PF94DyvSCsjKE05BjagK
         EKtsfm2Jqczw3Ehov4vEjMqZx5tSuoHx0O3OB0PHbZNDhhyM7L+aQdPW/EQ62JfmmEy5
         U/DjDUPQTZPS13/Dh3HrXI7K7kMpkczokPkjhvUJllmIJDt8IbXueeE8C00mGtzzsEMv
         acZf4S5uN9EuEZ73FPo1Fs0XxRUredq/TkZDzg4ktkjHqGoK3tp9xDR5NbYgmZypqZyE
         qDMgXSoNNLpdH0Q+GAp9T0GL/ACietyiLqutWQlYSR5TJtO7FzkezLEjAHEfUODeTts8
         W0pg==
X-Gm-Message-State: AOUpUlGYx7hTIRxctZi8WaeotLhaq0IKD6Y4aP77AyRLxTtthdEG9RI/
        ydr6xT12PCd1hsmH5jDDbuoxxg==
X-Google-Smtp-Source: AAOMgpdJ2DGHK32TJ7dcMwFEOGV5VFx9o0OXQpegLYzM7UtpoXssbrOYmXCI1vaoYlRKbpkK9hzVxQ==
X-Received: by 2002:a17:902:b709:: with SMTP id d9-v6mr18985261pls.138.1533009680703;
        Mon, 30 Jul 2018 21:01:20 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v22-v6sm30731842pfi.60.2018.07.30.21.01.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 21:01:19 -0700 (PDT)
Date:   Mon, 30 Jul 2018 21:02:08 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, Mark Brown <broonie@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-remoteproc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hwspinlock: Fix incorrect return pointers
Message-ID: <20180731040208.GB5090@builder>
References: <782fc498b4f4c6e8130d64face93023eb3dc9866.1530152980.git.baolin.wang@linaro.org>
 <CAMz4kuKGaMh=M9=P4TkpF4w0onJZJcRaPd+twMyEpj56KNVJLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMz4kuKGaMh=M9=P4TkpF4w0onJZJcRaPd+twMyEpj56KNVJLA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 30 Jul 04:34 PDT 2018, Baolin Wang wrote:

> Hi Bjorn,
> 
> On 28 June 2018 at 10:32, Baolin Wang <baolin.wang@linaro.org> wrote:
> > The commit 4f1acd758b08 ("hwspinlock: Add devm_xxx() APIs to request/free
> > hwlock") introduces one bug, that will return one error pointer if failed
> > to request one hwlock, but we expect NULL pointer on error for consumers.
> > This patch will fix this issue.
> >
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> 
> Could you pick up this patch which fixes the incorrect return value
> issue? Thanks.
> 

I thought I had picked this already, it's applied now. Sorry about the
delay.

Regards,
Bjorn

> > ---
> >  drivers/hwspinlock/hwspinlock_core.c |    8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
> > index e16d648..2bad40d 100644
> > --- a/drivers/hwspinlock/hwspinlock_core.c
> > +++ b/drivers/hwspinlock/hwspinlock_core.c
> > @@ -877,10 +877,10 @@ struct hwspinlock *devm_hwspin_lock_request(struct device *dev)
> >
> >         ptr = devres_alloc(devm_hwspin_lock_release, sizeof(*ptr), GFP_KERNEL);
> >         if (!ptr)
> > -               return ERR_PTR(-ENOMEM);
> > +               return NULL;
> >
> >         hwlock = hwspin_lock_request();
> > -       if (!IS_ERR(hwlock)) {
> > +       if (hwlock) {
> >                 *ptr = hwlock;
> >                 devres_add(dev, ptr);
> >         } else {
> > @@ -913,10 +913,10 @@ struct hwspinlock *devm_hwspin_lock_request_specific(struct device *dev,
> >
> >         ptr = devres_alloc(devm_hwspin_lock_release, sizeof(*ptr), GFP_KERNEL);
> >         if (!ptr)
> > -               return ERR_PTR(-ENOMEM);
> > +               return NULL;
> >
> >         hwlock = hwspin_lock_request_specific(id);
> > -       if (!IS_ERR(hwlock)) {
> > +       if (hwlock) {
> >                 *ptr = hwlock;
> >                 devres_add(dev, ptr);
> >         } else {
> > --
> > 1.7.9.5
> >
> 
> 
> 
> -- 
> Baolin Wang
> Best Regards
