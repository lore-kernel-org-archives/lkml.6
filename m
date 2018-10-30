Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CC2ECDE44
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B58720823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gETWYdXs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B58720823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbeJaB4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:56:54 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43180 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbeJaB4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:56:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id g26-v6so10822360lja.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 10:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Q3wgszR78b4+PjUa3dqy8CbVErGwaA0DK2PGefZ+9I=;
        b=gETWYdXsaJGTecjGPK4+px7jYRTB9KYjBiPcyNH4fzVQSfls4MQhnEu8AkN16hjzhe
         B0TKls+NOorBinsJhlCAtlXniavs+hHUep68nMz2VTMAkdiqlCNfpCBLxeFTaByH2iy2
         CvlVcU2Xqt62Pv+Zom4MK3xYzZTnfrQl3PY+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Q3wgszR78b4+PjUa3dqy8CbVErGwaA0DK2PGefZ+9I=;
        b=TDZcVY0trOBrTBMHD2oPEbT/1PWMnnCUwqJwpkJg3iP6sROmvKM7VIePB4HeRhQStq
         BiJGTzYAS+jaK0J1A14B+eyljHqSxee0Z6A1SYD/2n+M2RQvySY2/ccITOzODNWu2Mra
         ngAKq5NpKzdH0st4kqY6uk1VIDo1+QToW29VG80tn3fJcRX72KPOx0gFeNHVbzs7b4zL
         ByNFHyE2zNZDqvTma97ncOepKUxg1pmWO8zisDZwjuMy9RWUkzPpAtBcLbE6uwJhwFUA
         o99RiJZ7Dqy0qGoN8L9c+Mm9FWoGJgGntN+Jhu8C8uYBM8XYt6D4NUXCKa/8koTxM0fv
         9a2A==
X-Gm-Message-State: AGRZ1gJitXkRi2tR9Kvug5gCyfKm+GU9S4LbpI0eTuk+CY0nUOQiia2I
        BNUlkaZHGeErX6TE8y1yLOd6f4qX7NXVpQ==
X-Google-Smtp-Source: AJdET5cUUDnkPOOEfolLLuW+lizJO6FgOkA1dY1adTDYe83WNf3PZ3Yb4ZNiBUv6TFzhdrOI1cykag==
X-Received: by 2002:a2e:7801:: with SMTP id t1-v6mr7270669ljc.120.1540918954602;
        Tue, 30 Oct 2018 10:02:34 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id e201-v6sm3785919lfg.42.2018.10.30.10.02.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 10:02:33 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id c24-v6so9437616lfi.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 10:02:33 -0700 (PDT)
X-Received: by 2002:a19:cb94:: with SMTP id b142mr2541758lfg.117.1540918952941;
 Tue, 30 Oct 2018 10:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20181030093734.6b4118bd@vmware.local.home>
In-Reply-To: <20181030093734.6b4118bd@vmware.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 Oct 2018 10:02:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=whmLFu=Cn2dti8oAAcPeVUSMeT_=uvuRvzdt-_xqjKSgQ@mail.gmail.com>
Message-ID: <CAHk-=whmLFu=Cn2dti8oAAcPeVUSMeT_=uvuRvzdt-_xqjKSgQ@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Updates for 4.20 (or 5.0)
To:     rostedt@goodmis.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, mhiramat@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 6:37 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> The biggest change here is the updates to kprobes

Pulled.

However, a little note:

>  - Added support for SDT in uprobes

As an explanation, the above kind of sucks. "SDT"? I had to look it
up. I added a note to the commit message, but please, don't use random
acronyms in kernel explanations unless they are industry-standard and
comprehensible to kernel people.

Good acronyms: "TLB", "WTF", "LOL". People know what those mean.
"SDT"? Not so much.

                    Linus
