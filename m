Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34B4C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E712082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KnLBUc5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78E712082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbeLDTuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:50:08 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42523 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbeLDTuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:50:04 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so12884371lfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 11:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WQarueTlVUuW6OTlUCByy80MaUVV6YeH2V65um6rXUQ=;
        b=KnLBUc5NlRQ18Ct4f5OxvzhNHe4P+iP9UvlGsmP05rRlmnlEXnvSr3TGEVnT8imPNG
         Zr8jqPF5DWHWftbG1dI/pAppTnCPlrsTfSw5dHMpqSoSQ5+I26RiU7WXYjH+oWYJVhif
         EHxoTKoXvZNsd7ehosZ+GdJqSRIz1jEVyuj+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WQarueTlVUuW6OTlUCByy80MaUVV6YeH2V65um6rXUQ=;
        b=kdXtslVcN6YkRsuEAyIguqTCfkrQcslfivU6rsIC1E60dSovMEdOCandXW6rvzzMc8
         hE3I2bTR21hQVtjsFqfV+zYrSQGK0Adp1spqu+5lvPiy1Fg+gU3oyzsg/jM4pPMVTNro
         Xsr8sONOk3+sSlt5vefEC8g3frY6uMoeZGkwGIncwbbGrRB4FpSdnIYR1+4v8plFNYfY
         k98XYSOc7SpRGfVKGzjfrEOWdrJ2pJG8FKvXySQiZp8GngYd5+/GbSm2GlMgQctTgxz2
         RlZMjrRQs8OG9ZlyZx2nug5Gmfj4y7ksFtT/RLARmc9HnwNRvP82wheC+IVhZqgkGZeh
         BDyw==
X-Gm-Message-State: AA+aEWbzq2fkxwixXu4Cqh+xBc3VUZeCzZQd2+SXvUX3aWl1vA+VKJiz
        KKmQ7FIFNW9gP03Zm1fDNotQgvCziu8=
X-Google-Smtp-Source: AFSGD/UERXafGOmVEkQ6LJZjCpWNpWw3HJ5jNPiT9lqBB18Mqo4cUdc1swm3noUuZy/llj+g+DWFYA==
X-Received: by 2002:a19:920a:: with SMTP id u10mr12317051lfd.122.1543953002335;
        Tue, 04 Dec 2018 11:50:02 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id m77sm3165582lfg.3.2018.12.04.11.50.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 11:50:01 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id i26so12923839lfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 11:50:01 -0800 (PST)
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr13308242lfc.124.1543953000774;
 Tue, 04 Dec 2018 11:50:00 -0800 (PST)
MIME-Version: 1.0
References: <20181203123857.GS31738@dhcp22.suse.cz> <20181203131006.GA10054@amd>
 <20181203135351.GU31738@dhcp22.suse.cz> <20181203141459.GA14789@amd>
 <20181203141737.GY31738@dhcp22.suse.cz> <20181204090228.GC73770@gmail.com>
 <20181204091020.GD1286@dhcp22.suse.cz> <20181204093310.GE73770@gmail.com>
 <20181204095802.GF1286@dhcp22.suse.cz> <CAHk-=wgaEw566btStrWE+NOgPJLn1whS-Yw1-=K2Qr6MDvSZ+A@mail.gmail.com>
 <20181204181714.GR1286@dhcp22.suse.cz> <CAHk-=wh128U4GxVeHa+z_5sB52ZVXhzt0__LQq4asZgh8VtvBw@mail.gmail.com>
In-Reply-To: <CAHk-=wh128U4GxVeHa+z_5sB52ZVXhzt0__LQq4asZgh8VtvBw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Dec 2018 11:49:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg1geOzkaDUVuxW-qHxhqrtpx-iCvd+e1TxZQ_AmTtn0w@mail.gmail.com>
Message-ID: <CAHk-=wg1geOzkaDUVuxW-qHxhqrtpx-iCvd+e1TxZQ_AmTtn0w@mail.gmail.com>
Subject: Re: [PATCH] Revert "exec: make de_thread() freezable (was: Re: Linux 4.20-rc4)
To:     mhocko@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>, pavel@ucw.cz,
        Oleg Nesterov <oleg@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        rafael.j.wysocki@intel.com, chanho.min@lge.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 11:33 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Looking at this, I'm agreeing that ot would be better to just try to
> narrow down the cred_guard_mutex use a lot.

Ho humm. This is a crazy idea, but I don't see why it wouldn't work.

How about we:

 - stop holding on to cred_guard_mutex entirely in the exec path

and instead just do:

 - prepare_bprm_creds takes a ref to our old creds, and saves it off in the bprm

 - security_bprm_{committing,committed}_creds() can do it's "is this a
valid transition" using the saved-off old creds instead of the current
creds

because honestly, the *only* reason we hold on to that lock is for the
insane and not really interesting case of "somebody tried to use
ptrace to change the creds in-flight during the exec".

Or maybe we could just add a task state flag that says "in exec, you
can't modify the creds in this window, because we're about to switch
to new creds".

Again, no *normal* situation will even notice or care, I think. We
hold the cred lock purely to make sure that the sequence from
prepare_exec_creds -> install_exec_creds is "atomic" wrt credentials,
and it already is for all the normal cases since this is all inside a
single execve system call.

               Linus
