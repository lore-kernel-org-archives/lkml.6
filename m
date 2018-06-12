Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 98544C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EAEA208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZxBHPxIu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EAEA208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934861AbeFLQru (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:47:50 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34300 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934744AbeFLQrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:47:46 -0400
Received: by mail-io0-f194.google.com with SMTP id e15-v6so178569iog.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 09:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3VZJyxrUdnqVKtFZf33if9uZ9xV3BZhXi6sAHvE+SHc=;
        b=ZxBHPxIu5Ot4pCcWhXpc8OUj+ykOoElR5OtTflym/XEdvAnvFqr7WpNIxH6tFNm1rW
         QYuCWqPCGK7JVAlQ3H/Lv5IysYR2oHmFHp7rTlT7hZ9N8Ji7PvlCZnryqFToQ3EWYdUM
         BhJrWcjXh5HsLDRhaTpwJl1ddoanZbBIHxoD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3VZJyxrUdnqVKtFZf33if9uZ9xV3BZhXi6sAHvE+SHc=;
        b=gJTqdjS1PCVbxlkqmJwCtB3jwCKxWymn29ZZiS/kh6y5sdoz3xyQQo++5mDDFx/0KK
         Hw6cT7hUCfHrwg5EecAC40DGfdu45YMcEcIQQBnE46Jmw3sCkFu2pdcUPaNZDjZ6izcr
         gKGtX7MYnbbj1LMqo3Qo6TOFC2VKHIWucloCOc7DweXx5l7a2Ud8Ojcmm9i2K+jHIJrN
         wog+nrSbD7V8AVNny2eXBbLPwekClBN3P0Ba+2BPKZyxwq8cyAX5tKVJ0zasTVCrILeE
         58m941j0dof3VWqXppZx3YLxE+2kXTtvRNXRw2eFSc7hwTSha5XelReNh/SkiUWeWlnw
         mm7Q==
X-Gm-Message-State: APt69E26dSgrynkAs3Ky0IMYER0vJKY8f/VxfZIFfFBrvFDFHwg+Yxo9
        zwujL2FiMoliAIAbsc7CKzGBha9D4fc0fRQ/KXg=
X-Google-Smtp-Source: ADUXVKJTU8Y+jhNAKtHFmk0sjuSH3aIcBG3F1pt8JVa4YgWC2oO9pltYxiGg1YYUm180cV4zUHQb5svs29LITaAJq9U=
X-Received: by 2002:a6b:274f:: with SMTP id n76-v6mr1275528ion.259.1528822065673;
 Tue, 12 Jun 2018 09:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180612083449.100099222@infradead.org>
In-Reply-To: <20180612083449.100099222@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Jun 2018 09:47:34 -0700
Message-ID: <CA+55aFzLNFO1za9-Lb=jxO_F9NS0jZyti+we=ycr5NTpgzdEbw@mail.gmail.com>
Subject: Re: [PATCH 0/3] sched/swait: Convert to full exclusive mode
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"
On Tue, Jun 12, 2018 at 1:39 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> As mentioned by Linus, swait is exclusive mode and had better behave like it
> and be named like it.

Ack on the patches.

I do note how quilt emails are really hard to read, because that:

    Content-Disposition: inline

makes gmail think it's flowed.

Which works horribly badly for patches, surprise surprise.

So I really wish quilt wouldn't do that. It does smell like a gmail
bug, but at the same time, why would you use "Content-Disposition:
inline" when you don't have an actual multi-part email? So I do blame
quilt too for sending nonsensical headers.

(Yes, yes, I see the "It is permissible to use Content-Disposition on
the main body" in the RFC. But the RFC also makes it clear that it
actually matters for how things are presented, so saying "ok, I'll do
flowed" seems equally insane and equally technically RFC-compliant)

              Linus
