Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDB0ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6917A20B80
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HdaVpTTD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6917A20B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbeGPUFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 16:05:41 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:40116 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729910AbeGPUFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 16:05:40 -0400
Received: by mail-it0-f66.google.com with SMTP id 188-v6so23142486ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 12:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OZPyEd7HfdegxTKTcmEmwIG8mpAV5WgVg8NSsF0quOg=;
        b=HdaVpTTDVmSWdF8uwanPrvPVnCV6c3TyZ3wL7Nz0IAm4fVKOXIIkEdrmawVQN9WHZA
         qbpdfWP1SicaZvqhXWy/gEfMHUCzR5sBm1GlLgKcWpLlC6ELvmlBCFk8I+d07LRLwwhR
         UiyLoKTZIUIcd6dz3Aj6JqE+tBRNsgmE1zQRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OZPyEd7HfdegxTKTcmEmwIG8mpAV5WgVg8NSsF0quOg=;
        b=MCNy4rnCzkiwd+rsirORHtkkUFbbAeuF8Bi0ZQxeUQesAsBoLHOtcJrHmUWzWQCDUf
         IOUqFMRiCcQiZpq0IJBr//KJ+JN1woUscrxsc3UjfPIFxQqkD6Lia+Qq5utCt9AFTgMG
         20xAbGJxKm+JN+Oye3Ty7lXedwaDenEU4vA36Z0jEupBLpesK70RbVeMoYD7bPVvGp6L
         uvGiK2PFWomSqqqh00fFe6cWFecUzQIgBTK/7drMIHDXQ14OZvWxox+fUOs1+e0BExZw
         oNmagmPEAb5AZx2kSVOL2QL7PJjU372GohWY6yZC2kBMNQDaw89tCbWbAtvmhfQqerOp
         DuUQ==
X-Gm-Message-State: AOUpUlHJGeXDe6uaOZqB7bxVynGlHGOW/kb6XUd5xG5+j12gu92/CFrg
        s8vGt8MIm/B77ihp/x8wlmgSgXWeH+Cvr2tA/iF/nw==
X-Google-Smtp-Source: AAOMgpdKqQsnjzVRYBd4xqjh4vg0GH1rei5jnnZnWjoRmdmWlP5rVPTT7+nUTjD/ofjXuDlBrk5oqqPhpa1QPSs0OFY=
X-Received: by 2002:a24:94f:: with SMTP id 76-v6mr13487913itm.113.1531769808056;
 Mon, 16 Jul 2018 12:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <877em2jxyr.fsf_-_@xmission.com> <20180711024459.10654-9-ebiederm@xmission.com>
 <20180716145540.GA20960@redhat.com> <87lgabrzfd.fsf@xmission.com>
 <CA+55aFxNMPgg3Y7m8hCjtaFVERPL6LaXPKcbBmz-6C=8_FMpKg@mail.gmail.com> <87pnznkn1u.fsf@xmission.com>
In-Reply-To: <87pnznkn1u.fsf@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Jul 2018 12:36:37 -0700
Message-ID: <CA+55aFy2A=UeDoJNBr9WE=E_h7dfq+_4TzRgF2dPYSbEXRNZzA@mail.gmail.com>
Subject: Re: [RFC][PATCH 09/11] tty_io: Use do_send_sig_info in __do_SACK to
 forcibly kill tasks
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

On Mon, Jul 16, 2018 at 12:17 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> I should have said it doesn't matter because init does not open ttys and
> become a member of session groups.  Or at least it never has in my
> experience.  The only way I know to get that behavior is to boot with
> init=/bin/bash.

That's hopefully true, yes.

Presumably init does open the console, but hopefull doesn't do setsid.

(We *do* do "setsid()" for the linuxrc running, but that's not done by
the init thread itself).

> With the force_sig already in do_SAK today my change is not a
> regression.  As force_sig in a completely different way forces the
> signal to init.

Ok. A couple of notes in the commit description on this might be good.

> So I think we want the patch below to clean that up.  Then we don't have
> to worry about the wrong things sending signals to init by accident, and
> SEND_SIG_FORCED becomes just SEND_SIG_PRIV that skips the unnecesary
> allocation of a siginfo struct.
>
> Thoughts?

I think the end result is fine, but then I look at that patch of yours
and it does many other things and that makes me nervous.

Can you separate out the different things it does into separate
patches to make it easier to read?

           Linus
