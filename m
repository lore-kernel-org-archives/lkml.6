Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC9DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2751222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NC0usvaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391317AbfBNQ7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:59:50 -0500
Received: from mail-pl1-f171.google.com ([209.85.214.171]:46565 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbfBNQ7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:59:49 -0500
Received: by mail-pl1-f171.google.com with SMTP id o6so3437760pls.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 08:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6oKGsFl3KFzaCsPTqB4+XI+ENpv9qnKFvpPnyA2yzUk=;
        b=NC0usvaI5uuSZnbo7c3PXX+jlxXVz8royWn8YUo75Q2AJ0LSKpDuCmuk9YrnyVlWkQ
         66ZdLYNVWWCl2jg2stQaVsXwdzN2Jgmdb4fkxQHO1cpr9r8cjAWHX9OiiMNtJCI/QfN8
         7wKtqGRuq5/4DgcDXjNkyy9ZvxAXVrhdeAIIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6oKGsFl3KFzaCsPTqB4+XI+ENpv9qnKFvpPnyA2yzUk=;
        b=E7YLqwXk5PaY/vRt4bFpMSYh+BE8Q7pSt+SRPEvcHmC75bcrP0Maa7PZW1Y2wtM69o
         O9hLf13yMx+bEoaVFJTKC67cRPQeBEq2fWdPGf4e03rWI3dh8CUU5ZpeKXVaIOWJoFmF
         wJgibY1kSKkL7Co4TtkyJuCUt69R6eJxARoEo1kN+w4upHe645TR4wSKrwBrmSFcNZ+f
         vAYiDgiy2GLrqtSKY/MKQvYkBzb+K4/BBuAdqb5mo6n7Zgv0ZZoZ2tMFH0mcJ4hN0EyR
         rMH3pqMta4o65+5fAMANv2C7EAybglhJUYozIquitsqXdjcNWerKFX2Y2L48WqLrmxKI
         6kwg==
X-Gm-Message-State: AHQUAuZbsoGRw7vyOdMx2ghesa/OLrfnJbeJhVD3LaLVnA8bwjX3aYBk
        +jUDcADlE228L36r45uV8PRjkQ==
X-Google-Smtp-Source: AHgI3IZ1NkGC2bCiBiPt8Zo2HwrU+mluSlVdjMJ7JeV4Pc5IojmVxBEjCgxwEmhnYb7xG4ipudLB5g==
X-Received: by 2002:a17:902:5066:: with SMTP id f35mr5253312plh.78.1550163588984;
        Thu, 14 Feb 2019 08:59:48 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id j5sm3653268pfe.84.2019.02.14.08.59.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 08:59:48 -0800 (PST)
Date:   Thu, 14 Feb 2019 08:59:47 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH 1/4] PM / devfreq: Track overall load monitor state
 instead of 'stop_polling'
Message-ID: <20190214165947.GY117604@google.com>
References: <20190214013042.254790-1-mka@chromium.org>
 <20190214013042.254790-2-mka@chromium.org>
 <CAGTfZH3E+RetMzKxzZNEgYw6=kocdfgRcKSbmP5GfZ4k1j0Cuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGTfZH3E+RetMzKxzZNEgYw6=kocdfgRcKSbmP5GfZ4k1j0Cuw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On Thu, Feb 14, 2019 at 11:25:52PM +0900, Chanwoo Choi wrote:
> Hi Matthias,
> 
> 2019년 2월 14일 (목) 오후 7:16, Matthias Kaehlcke <mka@chromium.org>님이 작성:
> >
> > The field ->stop_polling indicates whether load monitoring should be/is
> > stopped, it is set in devfreq_monitor_suspend(). Change the variable to
> > hold the general state of load monitoring (stopped, running, suspended).
> > Besides improving readability of conditions involving the field and this
> > prepares the terrain for moving some duplicated code from the governors
> > into the devfreq core.
> >
> > Hold the devfreq lock in devfreq_monitor_start/stop() to ensure proper
> > synchronization.
> 
> IMHO, I'm not sure that there are any benefits changing
> from 'stop_polling' to 'monitor_state'. I have no objections
> if Myungjoo confirms it.

I agree that as an isolated change there isn't a clear benefit.
However in the context of the series the change is needed to
avoid resuming a load monitor that wasn't even started.

In case this series isn't accepted I'd still suggest to change the
name from 'stop_polling' to 'suspended'. I read 'stop_polling' as a
call for action, while 'suspended' is a state. IMO at least in some
contexts conditions using a state is clearer.

Cheers

Matthias
