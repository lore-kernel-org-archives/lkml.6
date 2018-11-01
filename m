Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D28C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 255092081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="U1XMTKnA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 255092081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbeKBBV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:21:29 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:42301 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728681AbeKBBV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 21:21:29 -0400
Received: by mail-lj1-f170.google.com with SMTP id f3-v6so18559076ljk.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 09:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OGJAR3D2F5h9Qo0cVHAAdAplIknW95hx44WJH7BOXJk=;
        b=U1XMTKnASgRtmhah45H8quGj7tCCtiIoAuJ4Bn8SppkZVBBRwucskwVoCxxX13PMm8
         fOgxZUPk9B6nimqgUFWQHAnswnETyup6paNNTgg7K+5arzNXPfgaSr+jgGqnW6fEZdvT
         CmhoAiN6ut2PvbttnC5hNfBfPiwpMKHYu4aT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OGJAR3D2F5h9Qo0cVHAAdAplIknW95hx44WJH7BOXJk=;
        b=rm0MOf+0God8Wu4sukli3r1LhGThQn7+mqIIb8bXVbSWDe0qCqTwwpXN5eTi93fHAf
         wEaixrP+6wo6oaKMJioVZcRjqee6dBYpYkvDdAR2IZ235jtrJFTKuuHxjCZSfm+rcy8o
         nRjbNTcRnsqK3B3m4XomwSHbkIT70q57EKXCf4PMUkfqjIqHF4+6xnyeGmGZqCKajVYo
         Rll7LWRYUGOLVzR6Anm2bvrh5AkhgHvAc9rqgKghmodzKO5zaFcyk0xEn1KM/pqD4mqB
         bfnZqcm9768nvaM++rEnVxnvE90cxzCCcRAZRJQi+oySvh9dAs5QLcd7V39j7jFCpbOl
         79mw==
X-Gm-Message-State: AGRZ1gIeUWl1ct40mTyStRpV6U8vcSOPTphiptJxnXUTeCRgLFFZ1/3K
        I4KuqAFHEFbIolGqPsxpFNl/sYoAOk3ENA==
X-Google-Smtp-Source: AJdET5cuQAlOUivCOkYMfLlPRo71Y6P7rp6WZ4UIAEiGaXHl6C6TePdy/z1AhYCfOkEzN1mpweXrxQ==
X-Received: by 2002:a2e:9b15:: with SMTP id u21-v6mr5169828lji.29.1541089069971;
        Thu, 01 Nov 2018 09:17:49 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id n3-v6sm4751948lfe.8.2018.11.01.09.17.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 09:17:49 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id i26so10289588lfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 09:17:49 -0700 (PDT)
X-Received: by 2002:ac2:41d8:: with SMTP id d24-v6mr4583825lfi.138.1541089068517;
 Thu, 01 Nov 2018 09:17:48 -0700 (PDT)
MIME-Version: 1.0
References: <20181031.184402.2213867913967695313.davem@davemloft.net>
In-Reply-To: <20181031.184402.2213867913967695313.davem@davemloft.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Nov 2018 09:17:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi-NXfNAFr80D+s4KFLWhwo2zAw0-fG-J7W_5sOSMh6Dw@mail.gmail.com>
Message-ID: <CAHk-=wi-NXfNAFr80D+s4KFLWhwo2zAw0-fG-J7W_5sOSMh6Dw@mail.gmail.com>
Subject: Re: [GIT] Networking
To:     David Miller <davem@davemloft.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 6:44 PM David Miller <davem@davemloft.net> wrote:
>
> Please pull, thanks a lot!

Pulled,

                    Linus
