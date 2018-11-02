Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E77C0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 03:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE95620820
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 03:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cBbhlOzk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE95620820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbeKBMHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 08:07:37 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44063 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbeKBMHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 08:07:36 -0400
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so440819lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 20:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4p469V3gYi22U9kPRjpAyE78DmgvlzhyEKlRjryJmLU=;
        b=cBbhlOzkJXqPuL/OetfErN50Qs4JRlMk4w+oEhO7sPU4H4m/CNryvitSbiti97ndlx
         ujHc65cgItyNU5GXyMBKNKMa6AmmUten3X+OYToCeM/DolkWLBz8IhDTHIYqltCm0Q0F
         2KYNtghhPPtCNw3mFsGaK1uYUBPNwUbggKUUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4p469V3gYi22U9kPRjpAyE78DmgvlzhyEKlRjryJmLU=;
        b=E6I3SpUH1x8qGNzBSLKlh9VIIwnOnn2wznbGzW90UbeNhUDYp13cBu0dq/WwavaqRU
         6TTO7PVeixjWbkiDhryacLlRsRlKiLaF4sARr4wwGrlZXOWO5zCWopXl45Mk1ecbge0H
         4RwuSlThTm/OhNjbN+X+t4LPcemkYVfZKAz34SQaSAX8gRQdSr4gRrW7wPeAcfRdYxAs
         6YHgVxVe3o3/FchTsnk5GMQGqrZ1L1kGkcVvs0+bqsSTYEv4+d++v69k4kG0/6AzW2qV
         RJnPkK0zaf9S7hAkOdJ4Hl9yVh33Nd3XmUJfbIpYNuqBKGwgLaelrLLTlPr665Hz7Boh
         n90Q==
X-Gm-Message-State: AGRZ1gJF0xfLyQJ+TgRuK90nvXZD3P582mH4LD/acyI7sdq1ClqNr3qe
        SSaDctviDPOTO/9azS6ba3FoVo39aU/sXw==
X-Google-Smtp-Source: AJdET5eeUREbk/784KJjNp/yRC4DzFtwimwhrZuKG32bIjyMHHG8w26rfAj34Y31D07MmMyngPlQ1A==
X-Received: by 2002:a2e:12c1:: with SMTP id 62-v6mr7065942ljs.74.1541127722673;
        Thu, 01 Nov 2018 20:02:02 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id o5-v6sm3719382ljh.34.2018.11.01.20.02.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 20:02:01 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id k19-v6so440753lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 20:02:01 -0700 (PDT)
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr6937085lji.133.1541127720851;
 Thu, 01 Nov 2018 20:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <20181101234608.GU32577@ZenIV.linux.org.uk>
In-Reply-To: <20181101234608.GU32577@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Nov 2018 20:01:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgxGGwJFkJ+zgcWig+hXbAy70A-zAwfyAYzkjVFtJj-7g@mail.gmail.com>
Message-ID: <CAHk-=wgxGGwJFkJ+zgcWig+hXbAy70A-zAwfyAYzkjVFtJj-7g@mail.gmail.com>
Subject: Re: [git pull] work.afs
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 4:46 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         AFS series, with some iov_iter bits included.

Grr. Bad summary explanation of what actually is happening.

Also, this is very late in the merge window for no discernible reason for this.

I'm not happy. I'm taking it, but I'm no longer pulling random stuff
that I get after this.

                   Linus
