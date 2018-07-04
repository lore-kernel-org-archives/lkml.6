Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4ECC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 23:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3C3240CB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 23:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fu1XOYaI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3C3240CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752999AbeGDXiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 19:38:01 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46280 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752888AbeGDXiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 19:38:00 -0400
Received: by mail-pf0-f195.google.com with SMTP id l123-v6so3694007pfl.13;
        Wed, 04 Jul 2018 16:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N+u7cIwcer1zICcmyryQjTdbZY567Drz9PsiR8JOuGg=;
        b=fu1XOYaI0i2/4auidvA4XUr/qvezCmry69LlkFkszeZWOeVGoRUfh03rX5CzogKQqe
         yiRywJTmeLs250vNdg5nXM76F4lMFZU3KQile70sDxckARmMwdDexohYG3WKkf6yWmEn
         Jnna/ZLsQIwF7YjiyXX5UJnf9vEvwMktIPXUx9f/JczcR0F3EEliY2jn1oc27v5jhMax
         udTBtKK98ZDiNkXX+o1ZfPIT39CDiUqFx7AYkWogdJcvVxpwCnpcxvoQxr3pjmersiEZ
         kqfd+PzNXCw/9cxEEmICGzEVyKw2kxx1IYiNg+6RaveDpcl4fjQd4dCgfQbDRBni1U4f
         N30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N+u7cIwcer1zICcmyryQjTdbZY567Drz9PsiR8JOuGg=;
        b=bbdje3SBULc38tbvgvHU4m23idj96ZvJzuUueYszmnMaL4OiG3wcWBFFOldAFRiZlJ
         51AKiBXtXcnp/wSAYfk3MN8bql+Dic85n6bA9WoKFd2OqgpFN/By5ugfXH59ktLky297
         c74G5kPXfS67UCeXraxE470eKvJAHG/RM5dsDgiI3HV8BbKGES5ElCY69p0cEstEmrDd
         uJIXK1LOkFkiob6SNgMDMr5uhL8X/pJIqm89DDSN6J0gIJQ8PdalFzV70mVmIACYG9I/
         eV5NhlNOgVCoNTFz1M2txwDj2yIugDINA2k+/IEpxPyLghCrwGp30dgRlaj067nptmg5
         d1mw==
X-Gm-Message-State: APt69E2xggCBCOLH6UOzu8g4uk1hjgaQuapj489s5GfGeyJmRpeH3Ep6
        3B/8o1iYF5yRvvfKjJ5AMEU=
X-Google-Smtp-Source: AAOMgpecOCgtXsZ7v+eBL39YV8kUe8aMzIeFP1fZofVdYR8R+9oqgnLOTay7j8tl2y3yOP7WrHFCvA==
X-Received: by 2002:a65:64cf:: with SMTP id t15-v6mr3437998pgv.79.1530747479738;
        Wed, 04 Jul 2018 16:37:59 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id y184-v6sm8124914pfy.6.2018.07.04.16.37.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 16:37:59 -0700 (PDT)
Date:   Wed, 4 Jul 2018 16:37:57 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     Stephan Mueller <smueller@chronox.de>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+9c251bdd09f83b92ba95@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] AF_ALG: register completely initialized request in list
Message-ID: <20180704233757.GK725@sol.localdomain>
References: <00000000000092ad87056950ef9e@google.com>
 <3337259.MW9pfDCdka@positron.chronox.de>
 <CACT4Y+bGDOi-+vVs=-eD=wHaUbFz2ZVO13yF8hq4cU4dkGXorg@mail.gmail.com>
 <3223691.KS9TZr8pPl@tauon.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3223691.KS9TZr8pPl@tauon.chronox.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 09:54:12AM +0200, Stephan Mueller wrote:
> Am Montag, 9. April 2018, 09:51:13 CEST schrieb Dmitry Vyukov:
> 
> Hi Dmitry,
> 
> > You can ask syzbot to test by replying to its report email with a test
> > command, see:
> > https://github.com/google/syzkaller/blob/master/docs/syzbot.md#communication
> > -with-syzbot
> > 
> > Note that all testing of KMSAN bugs needs to go to KMSAN tree, for details
> > see:
> > https://github.com/google/syzkaller/blob/master/docs/syzbot.md#kmsan-bugs
> 
> Thank you. I will resend the patch later today with the proper tags.
> 
> Ciao
> Stephan

Hi Stephan, it seems you never sent your patch out.

- Eric
