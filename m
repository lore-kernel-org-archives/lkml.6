Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F1DC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF85920856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RKBm8jQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF85920856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388656AbeGXThg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 15:37:36 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:39682 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388455AbeGXThf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 15:37:35 -0400
Received: by mail-it0-f67.google.com with SMTP id g141-v6so5098246ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 11:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i/EkRxm9AT/g25xMRscHdEIcaT5x87CGATQpi9kuXh8=;
        b=RKBm8jQO8Tc671imyBWUDy6XvTpCunK/3UThRSu/Ig73CMuAfq53/ieHVJ+Lwji3qg
         4Z9R/ZjOHGQ6EDuZ/o3t4PQeDj1bpt3QP9+lfUMZAQEwB1MklCnna8eSVg5+oqgnDlgX
         l1072V708hEcI6CYbXJS4yfM4fCo7SQ/sDm/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i/EkRxm9AT/g25xMRscHdEIcaT5x87CGATQpi9kuXh8=;
        b=Kt2uyCUDpWxhqnDA3Cb0o34T6ob1hOEDVkp9XZ7ERHm2pVX2hZdqLqX5uBtlpJvIhE
         vK87rQvVHMP2HZSbiQ97VwpeMwS95sV1w4msXFQVrItbhD0OTD75JS9m0R/7OyaMoFmO
         Mv9exTS1T3kuSUEBE8DYyGcnkkdntPXu8VcHdVK3s4Vm9G8fEky0GPoA7BUj112Y5Fgn
         SYpjlXnFKWpgKMiL68bEYWOGDD3tX/+eK04ZzRIE6iBysaI/i28Qfa0bINpt/VsEfO6W
         97Km94JL6j8olRHdmGj7iK3g4rUOAVVaV7O7dLqYKUTPIo3ZgrYZZPx0KI94mb2LqoFO
         x/MA==
X-Gm-Message-State: AOUpUlFdGEapBSSt4dn7blXnn/3kWRyKfRRRfl3bmTg33Qc4VBbnJzqG
        Boh14KvsvULX+Vvx7jECR8dQEGo3oFJATVQHU1c=
X-Google-Smtp-Source: AAOMgpcb8L1qv1n3m6lmq9k0X76PznT5oWE1lX6IYFnSPfanO752Yvt8hRMFjQjoJ69gME+YH3QQH+Xq7TobS/vp0lQ=
X-Received: by 2002:a24:5002:: with SMTP id m2-v6mr3640515itb.16.1532456990629;
 Tue, 24 Jul 2018 11:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <87efft5ncd.fsf_-_@xmission.com> <20180724032419.20231-20-ebiederm@xmission.com>
 <CA+55aFxNijeenFd6o7fg3iJFqAjdTZLaFV2=Eaqbg1fDOzx26A@mail.gmail.com> <874lgo5xdg.fsf@xmission.com>
In-Reply-To: <874lgo5xdg.fsf@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Jul 2018 11:29:39 -0700
Message-ID: <CA+55aFw_CTTRTZfUf1e9yg04X_djG3q7HrCG-XqnyQorpKjaTQ@mail.gmail.com>
Subject: Re: [PATCH 20/20] signal: Don't restart fork when signals come in.
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>, majiang <ma.jiang@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 10:58 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Yes you are quite right.   Easy enough to fix, but it definitely needs
> to be fixed.
>
> I will respin.

Would you mind trying a slightly different approach for this?

How about moving the "copy_signal()" and "copy_sighandler()" cases up
to fairly early in the "copy_process()" function (and clean up late,
obviously).

Then, instead of that "struct multiprocess_signals" thing, just add a
"struct hlist_node node" to "struct signal" itself, and add it to the
multiprocess hlist there.

And then you can just remove it in bad_fork_cleanup_signal.

Does this make "struct signal" a bit larger? Yes, but it's not a huge
deal. We *could* make is some union with existing fields if we cared.

But I think it would make the code *much* more understandable, and it
would allow us to not have that "sigpending" copy, because you can
just populate the final "signal->shared_pending" directly.

Hmm?

             Linus
