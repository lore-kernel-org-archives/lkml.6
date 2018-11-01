Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D2BC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34026204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WfdJFWiQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34026204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbeKBGkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 02:40:24 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35755 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbeKBGkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 02:40:24 -0400
Received: by mail-lj1-f196.google.com with SMTP id x85-v6so15207345ljb.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 14:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rh62i0JHX7Kdt5RMUfOCsjsgkCoZpytmxbLT1d6Kw4o=;
        b=WfdJFWiQPlRqsW53aMjcb40rDZB/DKd+hvlqhWMLe7u8v3TyUNgHexg6jsUWKz79Nh
         kwMdvhA8kg5zXOJCLeHCiSm7nPudXpgAgTPpJiFkjEWSq06pKAb3iSp+eJW8Jjp8+AKY
         53RmURDCQW/qfaryTikkN4iRIWYu47XaIQj+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rh62i0JHX7Kdt5RMUfOCsjsgkCoZpytmxbLT1d6Kw4o=;
        b=eQmA+P+zfLmsCEYfUtQgqGv2RBfadZvLTLUrasux+othc6sH6iECSD10IBHEg3Lp5M
         H9WFCfL44JDrA8ZOZbt/H3mVjTlm83KD5dhyqvNshm9OQJxxjs7aPrXwO9+Yzl3arL8b
         X4NSWotEo0oCkAwYMw85lok+BMZEhkY/nJyZ4eu5Pj7HuYY/7g6Zo5MzIY4T5H62Uyft
         6/PkGY3xA4zdNRTauRrHNbZdAjaRZP05+Im3A6UJi6hPF0nf3HB2AkGoLHEr712DR4yO
         XYMor1xfD6ktHs1jN3CMzCaj5TB75zox+iUOjZvSDYTH2x81C0jJugavmFQWfm6R1Zc8
         rPLQ==
X-Gm-Message-State: AGRZ1gI/AjRpimZdQe1bWFu7mcUYuDaJO8o+uOF0FVbfAyV5B6c4qEil
        hIbtTDqSi+NUEQPZ57An/R1ejsNAViRTJg==
X-Google-Smtp-Source: AJdET5chnzfQvtdvUxru0GR4FsOQW8eYtcfdFVV4K2ITE5uCwrSjtgLNMJhRwV0SmVRXglGAwJ8Clw==
X-Received: by 2002:a2e:197:: with SMTP id f23-v6mr6029041lji.144.1541108137347;
        Thu, 01 Nov 2018 14:35:37 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id t77-v6sm5333852lfi.63.2018.11.01.14.35.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 14:35:36 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id c4-v6so19407771lja.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 14:35:36 -0700 (PDT)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr5786886ljh.59.1541108135729;
 Thu, 01 Nov 2018 14:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20181101210345.9076-1-jcmvbkbc@gmail.com>
In-Reply-To: <20181101210345.9076-1-jcmvbkbc@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Nov 2018 14:35:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=3KDNmCRaiRxACkgfDR-QNKsptFCgXe7hij9dGZep+A@mail.gmail.com>
Message-ID: <CAHk-=wj=3KDNmCRaiRxACkgfDR-QNKsptFCgXe7hij9dGZep+A@mail.gmail.com>
Subject: Re: [PULL 0/4] Xtensa fixes for v4.20
To:     jcmvbkbc@gmail.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, chris@zankel.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 2:04 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> Xtensa fixes and cleanups for v4.20:

Pulled,

              Linus
