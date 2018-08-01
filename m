Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54591C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0362420862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 22:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="STPiYMdQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0362420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387415AbeHBA0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 20:26:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39499 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732049AbeHBA0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 20:26:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id j8-v6so117260pff.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 15:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aLxw0gq+MkJVxvwPIApQqXsq6eYwQS4XQmZKhO4nyIE=;
        b=STPiYMdQX61PzvwchmHE3wrPeM44zdW+Ur4+HaJJbsKTUWLz6BKApnoAeFjIoaEnx1
         wJAFo+e2EDkmCkZRCnJzo+2w7jLAS51zXXAOqQc746QethVSO9GPCK5x1JN/StvvrG0g
         WtJjlVEIGFkr6NFZU5iBi63h0WwTLKjh8m+iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aLxw0gq+MkJVxvwPIApQqXsq6eYwQS4XQmZKhO4nyIE=;
        b=JwMDJfvdhLOAgIDyF1GrzO4/09bY6RKREMW0YhnX+b7yaSIQnMvFGBpTh94FjmN1uR
         h6YcyvRFwbfbwfvX2sv0cM2xaxlofliRDbnD1jvBItiNOzxrc9H9M1VCzqHikRs3fymU
         gOwSEVvF7rmYMwBh1wJ/tedxevNjbDNHj0xloY0QD90iHME6qRUlKnGei2X7OcDnfW7Z
         Z2xUe+EbdkKcezkZsEimHkHnL2jbP94807oIFtHXhRvcx1GdilG2A64Yk26d1HW9mLBs
         PorGsZ9YMbTTI0S8S/Zp3fzGmyYpGj62NGUn8CZC+IWG3SlA4+F1+1BAxJoH2aRsvKqQ
         fUOg==
X-Gm-Message-State: AOUpUlGarntdL7F5J3lx05TPs7Heo9m0NsJI9ewafTS/hIU3WAcKMQ5J
        QBaluSshF++sQqj/zyj/kntatQ==
X-Google-Smtp-Source: AAOMgpd538Sr1cBtBN1rZtXffIP5vzAqPn+DUuGomneLUlUc91ms5XDIM5+l15fcKdo5UdyUpRcvsQ==
X-Received: by 2002:a62:ea05:: with SMTP id t5-v6mr245021pfh.228.1533163091552;
        Wed, 01 Aug 2018 15:38:11 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 64-v6sm140761pfi.89.2018.08.01.15.38.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 15:38:10 -0700 (PDT)
Date:   Wed, 1 Aug 2018 15:36:35 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     Marc Zyngier <marc.zyngier@arm.com>, swboyd@chromium.org,
        evgreen@chromium.org, linus.walleij@linaro.org,
        rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND RFC 1/4] drivers: pinctrl: qcom: add wakeup
 capability to GPIO
Message-ID: <20180801223635.GO30024@minitux>
References: <20180801020021.9782-1-ilina@codeaurora.org>
 <20180801020021.9782-2-ilina@codeaurora.org>
 <86600uy4vh.wl-marc.zyngier@arm.com>
 <20180801194538.GA6422@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801194538.GA6422@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01 Aug 12:45 PDT 2018, Lina Iyer wrote:

> Thanks for the feedback, Marc.
> 
> On Wed, Aug 01 2018 at 00:31 -0600, Marc Zyngier wrote:
> > On Wed, 01 Aug 2018 03:00:18 +0100,
> > Lina Iyer <ilina@codeaurora.org> wrote:
[..]
> > Why isn't that the case? And if that's because the HW is broken and
> > doesn't buffer edge interrupts, why can't you use the resend mechanism
> > instead?
> > 
> The PDC hardware can replay the interrupts accurately. However, it will
> replay only the pin and its not the TLMM summary IRQ. The handler here,
> needs to notify the driver that the wakeup interrupt happened and needs
> to take action. If I could trip the summary IRQ in this handler that
> would work too. Can it be done?
> 

Does this means that the intr_status_reg will not hold the information
about the interrupt events that occurred before we powered on the TLMM
again? Or is the problem limited to it not triggering the TLMM IRQ?

Can the PDC (and MPM) be used in the non-sleep use cases as well?

Regards,
Bjorn
