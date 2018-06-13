Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 42683C07D5C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 03:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E929220891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 03:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="f3peg/ct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E929220891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934053AbeFMDAX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 23:00:23 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36864 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933464AbeFMDAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 23:00:21 -0400
Received: by mail-it0-f67.google.com with SMTP id l6-v6so2003082iti.2;
        Tue, 12 Jun 2018 20:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KhJVctDpSjXMIP05JZGPlSLQQMKgzlnGqszd/XfWx10=;
        b=f3peg/ctwqGNe0UvPBHp7uAw5hgKRWLnGeGFJfpgsSwlwPRj0ABLmmmr0we+AMyoH0
         X+Ce2ORV/QtQpZ9mafJGDtykJ7YTleZH4SBBnflWjASTWYFLm2SSVHKVl7kEn+MN4DAL
         wqRUh/8IMj6iQYVbGc86QLNXbVElGeMN7vfIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KhJVctDpSjXMIP05JZGPlSLQQMKgzlnGqszd/XfWx10=;
        b=DrVjfMUj5s6ekC6e3BiuV05WHLWkobgnKvDRn9MTKW4WtYv+i/dvgKLmA+a9HS43ma
         lGGkCLCQ5kxexcSb9dgNHP1W+tYEMcMUkQSz9nh/oWh/Rz70Rt5FckwdygxuxyrtDHPn
         Xvn8RM5z65lreHH7BSPWubyoBh0tm8IisXZR5saBdw+rL6YY8K4evWpqqMszSc+Dy1AU
         cos4BD47GXfjLvTbwOdLyva/oKc4GnL3iMoMDdTSjtx5u1f3eAQFZqVuhssaGoo7tU7k
         8tg5BArmEC/goWZqKzC+3LnYytQ5nE+H9j7JaaWq+J4dnyFkjxIEgv2k5eSt1ywj7ST6
         YyrA==
X-Gm-Message-State: APt69E2cly80bEMQrsGg/Bz5QN7xg3EHvIaG2k+ZzuWLuoVCDwW1g2Bx
        5bxDRGfFBfWA6AXfrWm3qCz5FQ0nncuDPJqy+N8=
X-Google-Smtp-Source: ADUXVKJkfWGaGy7pz1c6wzmaXAWttZzRWIUR39L3BeMCwYw0ac6jSKM3vl+gsVRSYDoHDIWFaeYm7gjHstZ6x0q/FBI=
X-Received: by 2002:a24:3cd7:: with SMTP id m206-v6mr2887806ita.113.1528858820386;
 Tue, 12 Jun 2018 20:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <1528812229-53043-1-git-send-email-pbonzini@redhat.com>
 <CA+55aFwvE5G7MV7AV4naAXdbFoszc4JNKEj_QtYqpLFfa2RXtA@mail.gmail.com>
 <CA+55aFza9udpsCY=_YuBoshgVoXSce-Ja-nsqRbm5eJ6MgXK1g@mail.gmail.com> <CANRm+Cx194zWU0TwoiCaiTy+3tuHp4Ki1mk2VUfv5-z00j23jA@mail.gmail.com>
In-Reply-To: <CANRm+Cx194zWU0TwoiCaiTy+3tuHp4Ki1mk2VUfv5-z00j23jA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Jun 2018 20:00:09 -0700
Message-ID: <CA+55aFywZ0aX6u-JO8=GciDm9stwXOmXU4oG-u0K8i+o3qLwvg@mail.gmail.com>
Subject: Re: [GIT PULL] KVM changes for 4.18 merge window
To:     Wanpeng Li <kernellwp@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 7:51 PM Wanpeng Li <kernellwp@gmail.com> wrote:
> >
> > Bisecting. But that's unrelated to the recent kvm build breakage.
>
> Yeah, it happens before the KVM GIT PULL on Linus's tree, you will see
> the warning above unless you lauch the guest w/ root user, maybe other
> subsystems' modifications break something.

Yeah, the biusection seems to actually be diving into Greg's device pulls.

Odd. I'm not seeing why that would break kvm, but maybe there's
something in the device core layer that really messed it up.

I'll continue to bisect to see.

            Linus
