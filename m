Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407B2C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA89F20671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g3zXH0XN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA89F20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbeJWRQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:16:59 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:35748 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727632AbeJWRQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:16:59 -0400
Received: by mail-lj1-f169.google.com with SMTP id o14-v6so600858ljj.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 01:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jlAeSvNRsqo+mZHkg+XBd353XhLj3ak59U6F0tmtddQ=;
        b=g3zXH0XN5s2N9ICxkaY6RhO8pX5Qwfa9R8PeCZ/IaHWrr+lJFPZ3bQstGZa+0NwnkQ
         RVLC1rbwwSyFRW9s+lwg/ZliE3Cec7PklCd26AP5jPe1wSgkmIeue1Xf/iJN9ga7spGR
         quZUN/NeIjowK4/zTSwHWiBWS5qKprhqllCUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jlAeSvNRsqo+mZHkg+XBd353XhLj3ak59U6F0tmtddQ=;
        b=mxeOcP0lSFjqH1KgF0A/RXWJ8o2mdtqZ2RVWlQswtRZ2zx72mEmcuCuIfcoCPBxCTG
         b31iGIWFeshqhtQRuGgFORe1NcO3q/Y/4z/H+xR872A9+5SSP6yTyxXvS3UEhC1dT2sz
         YhTAldR897IEWhIU4sxTie+G0+pXgTIklsw4rj2PrXnhu+22fTSj4N9e9oVCKbDGH0ps
         i4O1ksgWPFL5NL/7B6h3qrpv4aLp+EtalTshE0rQbN6hTIYtr1wi04JhFR+76x7pIEWt
         Bly5EqXj+TFGWtPdT46dJVFYe0ql7KmszIo5ZHagKf+R14y1Bq62cfigqLJ+Z8gQklj8
         npLA==
X-Gm-Message-State: AGRZ1gLHTLWazxTYxKcoainVMV7iJq49pAlKWZaApiRsbiXFzS5oGcvW
        n5DTqOad2N8nWvItnI68L/wD0pPmh0JcTEm+
X-Google-Smtp-Source: ACcGV61Gy+7pPA5UcVqw5YPy6HNQDnffjsXih+1CWnYvJKbgKtye/6gj7CGXKcjmp2iHPG1DcZu8WA==
X-Received: by 2002:a2e:4b11:: with SMTP id y17-v6mr10266979lja.42.1540284870521;
        Tue, 23 Oct 2018 01:54:30 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id v1-v6sm125493lje.50.2018.10.23.01.54.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 01:54:29 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id c24-v6so477638lfi.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 01:54:29 -0700 (PDT)
X-Received: by 2002:a19:7019:: with SMTP id h25-v6mr12259042lfc.147.1540284869209;
 Tue, 23 Oct 2018 01:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <a03e86d4-6888-de64-ff0b-9908b5024574@acm.org>
In-Reply-To: <a03e86d4-6888-de64-ff0b-9908b5024574@acm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Oct 2018 09:54:13 +0100
X-Gmail-Original-Message-ID: <CAHk-=wgvvtBew7PbS1_fHB=dta4T_vuZ0m=BhWM8nmdsuMGMeA@mail.gmail.com>
Message-ID: <CAHk-=wgvvtBew7PbS1_fHB=dta4T_vuZ0m=BhWM8nmdsuMGMeA@mail.gmail.com>
Subject: Re: [GIT PULL] IPMI updates for 4.20
To:     minyard@acm.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Trying "option 2" - ack after pull, but before it has necessarily
passed the tests that might cause it to get unpulled again. Do people
care?  ]

On Mon, Oct 22, 2018 at 10:23 PM Corey Minyard <minyard@acm.org> wrote:
>
>    https://github.com/cminyard/linux-ipmi.git tags/for-linus-4.20

Pulled.

               Linus
