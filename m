Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB0AC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9366920652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bihdr3/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9366920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbeJWSTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:19:16 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:33326 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeJWSTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 14:19:15 -0400
Received: by mail-wm1-f50.google.com with SMTP id y140-v6so11210324wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 02:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CdDJvWCvshaW0zgvjby+Gz4gA0Bim2tKEfsCW0IZkdA=;
        b=bihdr3/Xi8bLOoepCeT4RS1GGuUFnlM00gqr/STmOCfrfxuZfcX2u/xM9n7DHqWfEi
         5cZHlV8egVuyBpjtwlikQnSM52S5opNYdV1hao32BnYP5DEXOUi087M8GyiaedUGo8KG
         VZtajXgu/s9n0uR5fagWYWtRfw5oHQ+ofJzvq2ydgcy6cXPnhmBcHzTBMSX7udLHOSmi
         mNC/UiUkA92FVWnGW9JmfADOIGrsaIg27HXeMK8YzmPUSxRD7IV1az7mzKYPI/Gq90l5
         SFJyldZ+Xg3yI52dIyvjB0aJzN2IAAEimtAty5uOpwMaCLKJ/n/PjYSGpeXmHJAn2v8U
         P7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CdDJvWCvshaW0zgvjby+Gz4gA0Bim2tKEfsCW0IZkdA=;
        b=FdYMRDxu5k0BhdhVRnkyndbbFZEf8abJKuQiAggdNTIPweX/2I0YR911lI00evUMtw
         NxWuB7fB92m4B+396AO9Win8QN1Flk/MEhnyMmkMKO2CznSOmHpUmTPVgEcz7sNGQ00/
         3oMlMDsEHUumN+0VCRLGpldK3AyDpnKMYreCQB9OyBWN5A1UNYESP61mHUtrp9XWgOdm
         +LpiWeT3ZwIkmoh8S09bgNYYJROxLKTZDHN8KpO1DtR8zSCLvzCnCFwsKRHghfoUnpav
         bLjXBcxfIzVtRifdWdZ8VLe+jroc85A5OsekztOiS/gEK7YuDMq7dhuOhfyOwiNJ2ZlD
         ptdA==
X-Gm-Message-State: ABuFfohowN5TrHSaAX3gaJTMdq//WHqqCux45XgiaLI32TJrHYiwlxCA
        HYq4LEvxoG/D0OuZMKVppxcY0x5NpokOjw==
X-Google-Smtp-Source: ACcGV63ddkieCwm0cwJswsCe+moaZfS/lTmD3o/D35ngr9f2/6NvaJq5ziFlGL1Z4igvti8UGNJD/w==
X-Received: by 2002:a1c:f313:: with SMTP id q19-v6mr18794784wmq.87.1540288592296;
        Tue, 23 Oct 2018 02:56:32 -0700 (PDT)
Received: from [10.111.198.69] ([109.144.220.182])
        by smtp.gmail.com with ESMTPSA id 90-v6sm1212822wrg.86.2018.10.23.02.56.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 02:56:30 -0700 (PDT)
Subject: Re: Git pull ack emails..
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wjS6cjjP+fkZWzzrdZ_fZ1F=PrAGcBc57vKCpNyoD73Vw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <140f804f-81a0-a75a-1dc4-0f8baa50899e@kernel.dk>
Date:   Tue, 23 Oct 2018 03:56:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjS6cjjP+fkZWzzrdZ_fZ1F=PrAGcBc57vKCpNyoD73Vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/18 2:41 AM, Linus Torvalds wrote:
> So I've obviously started pulling stuff for the merge window, and one
> of the things I noticed with Greg doing it for the last few weeks was
> that he has this habit (or automation) to send Ack emails when he
> pulls.
> 
> In fact, I reacted to them not being there when he sent himself his
> fake pull messages. Because he didn't then send himself an ack for
> having pulled it ;(
> 
> And I actually went into this saying "I'll try to do the same".
> 
> But after having actually started doing the pulls, I notice how it
> doesn't work well with my traditional workflow, and so I haven't been
> doing it after all.
> 
> In particular, the issue is that after each pull, I do a build test
> before the pull is really "final", and while that build test is
> ongoing (which takes anything from a few minutes to over an hour when
> I'm on the road and using my laptop), I go on and look at the *next*
> pull (or one of the other pending ones).
> 
> So by the time the build test has finished, the original pull request
> is already long gone - archived and done - and I have moved on.
> 
> End result: answering the pull request is somewhat inconvenient to my
> flow, which is why I haven't done it.
> 
> In contrast, this email is written "after the fact", just scripting
> "who did I pull for and then push out" by just looking at the git
> tree. Which sucks, because it means that I don't actually answer the
> original email at all, and thus lose any cc's for other people or
> mailing lists.  That would literally be done better by simple
> automation.
> 
> So I've got a few options:
> 
>  - just don't do it
> 
>  - acking the pull request before it's validated and finalized.
> 
>  - starting the reply when doing the pull, leaving the email open in a
> separate window, going on to the next pull request, and then when
> build tests are done and I'll start the next one, finish off the old
> pending email.
> 
> and obviously that first option is the easiest one. I'm not sure what
> Greg did, and during the later rc's it probably doesn't matter,
> because there likely simply aren't any overlapping operations.
> 
> Because yes, the second option likely works fine in most cases, but my
> pull might not actually be final *if* something goes bad (where  bad
> might be just "oops, my tests showed a semantic conflict, I'll need to
> fix up my merge" to "I'm going to have to look more closely at that
> warning" to "uhhuh, I'm going to just undo the pull entirely because
> it ended up being broken").
> 
> The third option would work reliably, and not have the "oh, my pull is
> only tentatively done" issue. It just adds an annoying back-and-forth
> switch to my workflow.
> 
> So I'm mainly pinging people I've already pulled to see how much
> people actually _care_. Yes, the ack is nice, but do people care
> enough that I should try to make that workflow change? Traditionally,
> you can see that I've pulled from just seeing the end result when it
> actually hits the public tree (which is yet another step removed from
> the steps above - I do build tests between every pull, but I generally
> tend to push out the end result in batches, usually a couple of times
> a day).

I like getting an ack when something has been seen, I don't necessarily
need one for when it's also finalized. I'm just going to assume it is,
unless I hear otherwise. I always reply to peoples pulls, even if it's
just saying "Pulled, thanks". What happens when you don't send one is
that:

1) I regularly check the git repo to see if it's actually in.
2) If I do get a reply to one, I cringe. Why? Because it's usually
   yelling about something wrong. This means I also more regularly
   check email to see if there's yelling queued up.

I'd say do whatever works the best for your workflow, but one of
option 2 or 3 would be preferable. #2 seems like it would fit just fine
with your existing workflow. 

-- 
Jens Axboe

