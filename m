Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCF1C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F7B21473
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F8I3ji8e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24F7B21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbeK3STS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:19:18 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33809 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbeK3STS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:19:18 -0500
Received: by mail-pl1-f196.google.com with SMTP id w4so2357461plz.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 23:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xXNEyGe7hPkfBR901Wd6JrBQEyW6aHVZ8KBp7abev6U=;
        b=F8I3ji8e/NdaJknma8EWDdNsCQMU6h3vGnxBD1W/yS2RK9olUg/GcQrKspC2Yiw4A/
         MnAcWJjV4pcyZGjK+LuqxKeWGXD9j27ur+E8rmCMwLftHLNRvELR9egt894PZeoexNhC
         R2eyAKj6E4jN5nz1+AZHHQO7mWXlua1h5UJAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xXNEyGe7hPkfBR901Wd6JrBQEyW6aHVZ8KBp7abev6U=;
        b=louew7iuRzLoubBJ1TS7bioWTKBFkEzJFWofFTH7Z2cGEiN5jnG1tvOBMkbGRBELyC
         QxltUwXnTTo9i9PmfOP4Se97Bz98CCe2UZL3LCJ0QGWwa3RTi1HDT8CAqUNf/8eASmYM
         bfPUTWfgTAO+qHpQg0a4UQzdLX0/h6JtfOEnIZMiBYerXjs7hhzgKb+QWbLnG9rw6OKl
         HzAoYmEZ4UX61l8QrPNZ8Ld54TlcycXWZeiHCXjetHb4PE7BnFPHPKG5rYmvSIdK9mBW
         Uvi+5b6r+3HNwzUr40xmUS3g0kRlhjU80Y6wUxPUGRz9SpcrgT4LpVboX3YUaW+mr8V5
         nYHw==
X-Gm-Message-State: AA+aEWbVFJu+5axOSoqFiN9zPYcF+bN+dX6VGVJdYLDxkuM1bvN4YWui
        T2p+lMpWnDfLsk+YlaJmllo9YIbFmXk=
X-Google-Smtp-Source: AFSGD/VXUDyIqRisByqCeC+59BJCeSLMVMNjhlU+cz91Y4i+QdyDzfEHuq7trmipwu9aPjkgp8AlJg==
X-Received: by 2002:a17:902:c5:: with SMTP id a63mr4649316pla.267.1543561858622;
        Thu, 29 Nov 2018 23:10:58 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b27sm5733498pfh.113.2018.11.29.23.10.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 23:10:57 -0800 (PST)
Date:   Thu, 29 Nov 2018 23:10:54 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, evgreen@chromium.org,
        marc.zyngier@arm.com, linux-kernel@vger.kernel.org,
        rplsssn@codeaurora.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, thierry.reding@gmail.com
Subject: Re: [RFC v3 2/3] dt-bindings: sdm845-pinctrl: add wakeup interrupt
 parent for GPIO
Message-ID: <20181130071054.GF5278@tuxbook-pro>
References: <20181121000648.29262-1-ilina@codeaurora.org>
 <20181121000648.29262-3-ilina@codeaurora.org>
 <154283618199.88331.10217252750356423959@swboyd.mtv.corp.google.com>
 <20181126161455.GA28236@codeaurora.org>
 <154330994255.88331.11409511159882116164@swboyd.mtv.corp.google.com>
 <20181127182123.GC28236@codeaurora.org>
 <154335513853.88331.9713562640538396853@swboyd.mtv.corp.google.com>
 <20181128173959.GC18262@codeaurora.org>
 <20181129002457.GJ24969@minitux>
 <20181129214539.GG18262@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129214539.GG18262@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 29 Nov 13:45 PST 2018, Lina Iyer wrote:

> On Wed, Nov 28 2018 at 17:25 -0700, Bjorn Andersson wrote:
> > On Wed 28 Nov 09:39 PST 2018, Lina Iyer wrote:
> > 
> > > On Tue, Nov 27 2018 at 14:45 -0700, Stephen Boyd wrote:
> > > > Quoting Lina Iyer (2018-11-27 10:21:23)
> > > > > On Tue, Nov 27 2018 at 02:12 -0700, Stephen Boyd wrote:
> > > > > >
> > > > > >Two reasons. First, simplicity. The TLMM driver just needs to pass the
> > > > > >gpio number up to the PDC gpio domain and then that domain can figure
> > > > > >out what hwirq it maps to within the PDC hw irq space. I don't see any
> > > > > >reason why we have to know the hwirq of PDC within the TLMM driver
> > > > > >besides "let's not be different".
> > > > > >
> > > > > >And second, it makes it easier for us to implement the MPM case in the
> > > > > >TLMM driver by letting the TLMM code just ask "should I mask the irq
> > > > > >here or not?" by passing that with a wrapper struct around the fwspec
> > > > > >and a dedicated domain in the PDC/MPM driver. Keeping less things in the
> > > > > >TLMM driver and not driving the decision from DT but from tables in the
> > > > > >PDC driver also keeps things simple and reduces DT parsing code/time.
> > > > > >
> > > > > Couldn't this be simply achieved by matching the compatible flags for
> > > > > PDC/MPM bindings for the wakeup-parent in the TLMM driver?
> > > > >
> > > >
> > > > It could be, but then we would be making TLMM highly aware of the wakeup
> > > > parent
> > > It is is not aware of anything about the wakeup parent, just the
> > > compatible that indicates whether it needs to be mask locally or not.
> > > 
> > 
> > But the information related to how the PDC is wired to GPIO pins is a
> > property related to the PDC not of the TLMM, so it does make sense to
> > represent this information there.
> > 
> Hmm.. But we are inconsistent in what we provide as input into the PDC
> driver.
> From the PDC driver perspective, it gets a hwirq number either when
> driver requests a wakeup interrupt specified in DT as
> 	<&pdc 5 IRQ_TYPE_LEVEL_HIGH>
> or from GPIO, which translates the GPIO to the PDC hwirq and requests
> that.
> 

I see what you're saying, but need to think some more about this...

> > And iiuc it also makes sense to not encode it in DT because it's
> > physical wiring, not configuration.
> > 
> I would agree.
> 
> > > > and have to do compatible string matching in two places, instead
> > > > of making TLMM more abstractly aware that it needs to keep things masked
> > > > while irq parent deals with the interrupts.
> > > >
> > > Your approach seems too complex just to circumvent a simple match node.
> > > I think we are stretching too much to support something that is not a
> > > priority.
> > > 
> > 
> > What "something" are you referring to here?
> > 
> MPM :)
> 

There are still new platforms coming out with MPM, so there's even a
business case to care about it.

> BTW, I am discussing with the internal folks here on if we need to mask
> TLMM when the wakeup-parent is MPM. If we don't have to, we should be
> able to follow the same model as we done in this patch and don't even
> have to check the compatible or use the approach suggested by Stephen.
> 

Looking forward to the result of that discussion.

Regards,
Bjorn
