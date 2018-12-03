Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EB5C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0637720661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K1ua6U3n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0637720661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbeLCRGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:06:44 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43398 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbeLCRGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:06:44 -0500
Received: by mail-lj1-f194.google.com with SMTP id 83-v6so12085223ljf.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 09:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i9ALoFMSXJ1UcqXr/lIr/p9DnNQLnN3pYeGFAcLDzzc=;
        b=K1ua6U3n0vvX601+AAR7GL+/xhonjeBxqHzWpGB1WhVIABQB1ilxdPR4tNTNZLCjtc
         NAN3X+gS9UilaRv0pzEvv9XuZ8CmzUucY+THk0SDDcDfs3lzhQE8AdCYFSrQzYBtnjlI
         OAG3zA7veq3DoHdiYHs3+3yrYLzfQj/dGVNXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i9ALoFMSXJ1UcqXr/lIr/p9DnNQLnN3pYeGFAcLDzzc=;
        b=c0kho/kwxq2OTsG9dQMwP6YP/pw/vtCcKNzESeCI/OVvt1Rmg5d+PxS1a/+HNx2JMC
         GWDPOsLTzjwBirP2yq9vCNQU8U9RTWyPJ2/Qk9JOlmtztGgb+Ysk82Ct4TiWn/d//GmL
         bp5xPOa084s/10iBEvH6D1RA6yEqKACgW9kW68DiDNpb9cR6i2mi9f+EHEkJeII6Dzq8
         YMDIiSRFl9AYlm5JdTPA+06e1yEGf5Ttcd4ypQ7gR2pdQJrKIoK/1UzZMhVg8vHmlis0
         EmRkFrx4y2ENRzkHuO0upyBNwZdHJy9cmzNSaXzJufW2qMC00ik0hNIaF0zRoCZxWcS9
         C6eQ==
X-Gm-Message-State: AA+aEWbBNt12nD77p4h7W157n00Gfq0BOSZB8NgnFYzErmQDfoCg4e8G
        STt50X5sKdVssraSYTM6151Aq7zw4Dw=
X-Google-Smtp-Source: AFSGD/Xaj2Ik3Xwf0PJ1++J7lWsespOd/whw2ITojjpgeFfawcwSw8CgL+Eomy3GPVaPF26KCUYh8g==
X-Received: by 2002:a2e:302:: with SMTP id 2-v6mr5572098ljd.137.1543856797476;
        Mon, 03 Dec 2018 09:06:37 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id l21-v6sm2575374ljj.48.2018.12.03.09.06.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 09:06:36 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id c19-v6so12105325lja.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 09:06:35 -0800 (PST)
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr11497263lji.133.1543856795466;
 Mon, 03 Dec 2018 09:06:35 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgdsXyCaLsFEpyUpAeRqVS69u=xo4rzEN+cS=xwz2gajg@mail.gmail.com>
 <20181203074700.GA21240@gmail.com> <20181203083942.GF31738@dhcp22.suse.cz>
 <20181203123149.GB31795@redhat.com> <20181203123857.GS31738@dhcp22.suse.cz>
 <20181203131006.GA10054@amd> <20181203135351.GU31738@dhcp22.suse.cz>
 <20181203141459.GA14789@amd> <20181203141737.GY31738@dhcp22.suse.cz>
In-Reply-To: <20181203141737.GY31738@dhcp22.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Dec 2018 09:06:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=wibyrfrpRoyGRwFrLZvrxAg=j5ueTje=4GckJcJSy-pwg@mail.gmail.com>
Message-ID: <CAHk-=wibyrfrpRoyGRwFrLZvrxAg=j5ueTje=4GckJcJSy-pwg@mail.gmail.com>
Subject: Re: [PATCH] Revert "exec: make de_thread() freezable (was: Re: Linux 4.20-rc4)
To:     mhocko@kernel.org
Cc:     pavel@ucw.cz, Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        rafael.j.wysocki@intel.com, chanho.min@lge.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 6:17 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> This argument just doesn't make any sense. Rare bugs are maybe even more
> annoying because you do not expect them to happen.

Absolutely.

And valid lockdep complaints are a real issue too.

So I don't think there's any question that this should be reverted,
the only question is whether I take the revert directly or get it from
the PM tree.

It does sound like the de_thread() behavior needs more work. Maybe,
for example, we need to make it clear that zapped threads are *not*
frozen, and instead the freezer will wait for them to exit?

Hmm?

                      Linus
