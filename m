Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B395FC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B6A25F62
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ssvu2FR7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B6A25F62
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964871AbeFYRfH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:35:07 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38716 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964786AbeFYRfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:35:04 -0400
Received: by mail-pf0-f195.google.com with SMTP id a1-v6so2919453pfi.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 10:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=spLml2p6aSIwGAsBxNaTRgCVYAj6vbWBIQAtaeuf/AE=;
        b=Ssvu2FR7BWoggL8E2b0PqzvPQYxPwAIa3L1NfsHyTMIaL5ZsNmRvMJOz0Ih8KQaqH/
         XnaOJrSwdepnfF6V9qjdTpwgwUqy3YeihIhU+qoVjOup1gW4hOsvzeQPXUpl5GkBY9zL
         6rpTs6BFZPEpiN6btX2rw1L8ybgxFNXcK/9CA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=spLml2p6aSIwGAsBxNaTRgCVYAj6vbWBIQAtaeuf/AE=;
        b=VkRQJ2w1zDuff/W4zAcD9QUrcFVBYj2konVkJO/II2MEVpGZ+/RpLw+1fJ5oljikV6
         WkXY5Qb8rQ0ltv9mZZp2OVtwRai3Lce9bYyr/0rY2GkHe6774A1vsFmVNlnS4aIu2DpJ
         dWj+QN6YLgo9bgzm7KywGdrhTJuegPQ50gpDHUFKckpRpGQl7MgoNJRwcPOwITQwXFgL
         14ykx66xjzzETsWTUpOmKOsgmmFAcliP7v3FtpG52S+3yoBXzstfK0/dYBsgo5hPloQg
         G49rlsZshbzHo9Ghg1/lupvkGVSmJbIrypdMwfpIMunXmzEXu8gaR5FkvvIntjwL6L5z
         qnoA==
X-Gm-Message-State: APt69E26yIzXypZ0i6nLobxFuqOU+dm+Kj9hd/1ekVCqvGWfg3lt3Mo2
        3B5G04+pIc60zbIuv+yaS9JB/A==
X-Google-Smtp-Source: ADUXVKKTMfE9V3Z7SInJchi5mDSJnPeLHf1uW1Pivb/hdTyrGqQYgEkotJwWu7fvoXpUTuLnVuVxOQ==
X-Received: by 2002:a63:35c3:: with SMTP id c186-v6mr5153519pga.217.1529948103948;
        Mon, 25 Jun 2018 10:35:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id m10-v6sm4001968pfi.101.2018.06.25.10.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 10:35:03 -0700 (PDT)
Date:   Mon, 25 Jun 2018 10:35:02 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2] kvm: x86: mmu: Add cast to negated bitmasks in
 update_permission_bitmask()
Message-ID: <20180625173502.GD129942@google.com>
References: <20180619192504.180479-1-mka@chromium.org>
 <4dd99306-4fea-24b2-4bea-5b7927ea5e79@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4dd99306-4fea-24b2-4bea-5b7927ea5e79@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paolo,

On Mon, Jun 25, 2018 at 06:05:01PM +0200, Paolo Bonzini wrote:
> On 19/06/2018 21:25, Matthias Kaehlcke wrote:
> > update_permission_bitmask() negates u8 bitmask values and assigns them
> > to variables of type u8. Since the MSB is set in the bitmask values the
> > compiler expands the negated values to int, which then is assigned to
> > an u8 variable. Cast the negated value back to u8.
> > 
> > This fixes several warnings like this when building with clang:
> > 
> > arch/x86/kvm/mmu.c:4266:39: error: implicit conversion from 'int' to 'u8'
> >   (aka 'unsigned char') changes value from -205 to 51 [-Werror,
> >   -Wconstant-conversion]
> >     u8 wf = (pfec & PFERR_WRITE_MASK) ? ~w : 0;
> >        ~~                               ^~
> > 
> > (gcc also raises a warning (see https://godbolt.org/g/6JWfWk), however it
> > doesn't seem to be universally enabled)
> > 
> > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > Changes in v2:
> > - negate the bitmask at initialization and rename variables to not_X
> 
> The patch is not that bad, but I'd like to get confirmation that other
> maintainers are applying fixes like this.  Honestly I'm not really
> impressed by most new clang warnings, these days.

Some other instances of the warning that have been addressed are:

commit 644d87dccdc69cf79834a72ed0c889580d6af32a
Author: Stefan Agner <stefan@agner.ch>
Date:   Thu Apr 5 16:25:38 2018 -0700

    mm/memblock.c: cast constant ULLONG_MAX to phys_addr_t


commit e2a5dca753d1cdc3212519023ed8a13e13f5495b
Author: Borislav Petkov <bp@suse.de>
Date:   Thu Nov 23 10:19:51 2017 +0100

    x86/umip: Fix insn_get_code_seg_params()'s return value


commit dae1a432ab1fe79ae53129ededeaece35a2dc14d
Author: Nick Desaulniers <nick.desaulniers@gmail.com>
Date:   Sat Jun 24 22:50:12 2017 -0700

    Input: mousedev - fix implicit conversion warning


commit d1600401faad4bc186bfdb291d8af644465e20bd
Author: Matthias Kaehlcke <mka@chromium.org>
Date:   Fri Mar 31 18:00:04 2017 -0700

    ALSA: hda/ca0132: Limit values for chip addresses to 32-bit


commit a45463cbf3f9dcdae683033c256f50bded513d6a
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Wed Feb 1 18:01:17 2017 +0100

    workqueue: avoid clang warning


Thanks

Matthias
