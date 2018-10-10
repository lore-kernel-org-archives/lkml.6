Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD77C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9907A214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="jimTMOTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9907A214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeJKASD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:18:03 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36920 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbeJKASD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:18:03 -0400
Received: by mail-ot1-f67.google.com with SMTP id o14so6057739oth.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 09:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NXBnbT+4zx9IwFrqmamONNal5xOn+MriYyeH0v83R0c=;
        b=jimTMOTNQ1m68+Ab/EeICBeCnCO+fW6mtWGNAMG7KfyH/ytdfpfIU9n1qTPeAdl9et
         6bWOLUMgzXKdX0MviICKEK0spND0WhvrlGdsJzBL+rIjqd95tq4RMMsn61izjL+4pCr8
         RHCh3FPMjKXTjuSM0UzIxIrVbG3RbfbHQEnIOKWWgId+XcSwneYjnKSL6AYHPrzL20By
         ySC5iko4EyOoHewtV4A09/oxrWJR4AHf0B6oc+4Kqvyh6Wpht2QOARIoVUHmxv2ioBur
         0WwBF3I2ZxSVsv7bTgUtQWp031I1YLipzNrr/BOMPQ9JMwIQ55QlbozrIAxA8KmJ2fYd
         KK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NXBnbT+4zx9IwFrqmamONNal5xOn+MriYyeH0v83R0c=;
        b=Ot5uaMEj1ZgedrH/5FlBYkjK4G/XDRU6iyZzoWDMT8En+xPlFFkgLPKGXuI1yo8bBI
         Z/Int0Sji47p6lhs5bO1/OYVre67a5S5dQ2jTkHncVqXc87YMm+ebZOtsHh/k9H8/4aa
         QPD8kNCsNlEFihenrgqtAcitdTSSW/REQwTRvNTJMBEBoNIHUkIpnYURXHwUi1I72HDX
         k60HrVsHOe0tuixecXUt/t3Pzcm55Sz4O1kEU58+T19PBQzH93Qup/RyWlD6RseQrayK
         57HjKFKtc3XUrcarcQtfm95pDm+j24GaGBbmGPyK+oLmmaeQtNPbL1jKTrQjK/4qD6VM
         yngw==
X-Gm-Message-State: ABuFfog80sVsQFuK2cpLXkbSTmW7yDcEEIUtbAgSiIFCP2faWkMN0Pfz
        9KcWGIW0kdzGlg/M1o1lw0KCvQ==
X-Google-Smtp-Source: ACcGV61/kJ2LH5LXGI6I1z/hk+jeY3iShJR2Q4y5i2YLIzmgZoJ6SwwkmEL344mvpfznJUaHvjWNSQ==
X-Received: by 2002:a9d:d52:: with SMTP id 76mr21724977oti.326.1539190502056;
        Wed, 10 Oct 2018 09:55:02 -0700 (PDT)
Received: from cisco ([2001:420:28e:1260:c7c:88c5:50e7:459f])
        by smtp.gmail.com with ESMTPSA id 31-v6sm8062145ota.23.2018.10.10.09.54.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 09:55:00 -0700 (PDT)
Date:   Wed, 10 Oct 2018 09:54:58 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Christian Brauner <christian@brauner.io>
Cc:     Jann Horn <jannh@google.com>, Paul Moore <paul@paul-moore.com>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        containers@lists.linux-foundation.org, suda.akihiro@lab.ntt.co.jp,
        Oleg Nesterov <oleg@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [PATCH v7 3/6] seccomp: add a way to get a listener fd from
 ptrace
Message-ID: <20181010165458.GA5607@cisco>
References: <CAG48ez3zaqOXH_jHN8=+jXjOf3vhFyWUkM_6KLPi9T8HcQySeg@mail.gmail.com>
 <20181008162147.ubfxxsv2425l2zsp@brauner.io>
 <CAG48ez3O+wAkq+0yDfoMt73ybnCOEPpi3Mu-uF57_v=6hA8ZEw@mail.gmail.com>
 <20181008181815.pwnqxngj22mhm2vj@brauner.io>
 <CAG48ez3PEce4ynRnDk=yfsAOuFGH=YMmuf13CAxEt07Yjk3ZCw@mail.gmail.com>
 <20181009132850.fp6yne2vgmfpi27k@brauner.io>
 <CAG48ez2EV8Z=Egn7hNpXd86bHdvQhVxStqE1N=U2L2R7sA-gjg@mail.gmail.com>
 <CAHC9VhQfzJgG3i=Q8C+pGY2Lpr+2MRTwxgUWec_heGOecd=xRg@mail.gmail.com>
 <CAG48ez2hTBFwmA65FXv0zJjc0_wpc1S-uOBn1t+X=0vPH25YvQ@mail.gmail.com>
 <20181010153956.zzlatxdlcwolbs6k@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010153956.zzlatxdlcwolbs6k@brauner.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 05:39:57PM +0200, Christian Brauner wrote:
> On Wed, Oct 10, 2018 at 05:33:43PM +0200, Jann Horn wrote:
> > On Wed, Oct 10, 2018 at 5:32 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Tue, Oct 9, 2018 at 9:36 AM Jann Horn <jannh@google.com> wrote:
> > > > +cc selinux people explicitly, since they probably have opinions on this
> > >
> > > I just spent about twenty minutes working my way through this thread,
> > > and digging through the containers archive trying to get a good
> > > understanding of what you guys are trying to do, and I'm not quite
> > > sure I understand it all.  However, from what I have seen, this
> > > approach looks very ptrace-y to me (I imagine to others as well based
> > > on the comments) and because of this I think ensuring the usual ptrace
> > > access controls are evaluated, including the ptrace LSM hooks, is the
> > > right thing to do.
> > 
> > Basically the problem is that this new ptrace() API does something
> > that doesn't just influence the target task, but also every other task
> > that has the same seccomp filter. So the classic ptrace check doesn't
> > work here.
> 
> Just to throw this into the mix: then maybe ptrace() isn't the right
> interface and we should just go with the native seccomp() approach for
> now.

Please no :).

I don't buy your arguments that 3-syscalls vs. one is better. If I'm
doing this setup with a new container, I have to do
clone(CLONE_FILES), do this seccomp thing, so that my parent can pick
it up again, then do another clone without CLONE_FILES, because in the
general case I don't want to share my fd table with the container,
wait on the middle task for errors, etc. So we're still doing a bunch
of setup, and it feels more awkward than ptrace, with at least as many
syscalls, and it only works for your children.

I don't mind leaving capable(CAP_SYS_ADMIN) for the ptrace() part,
though. So if that's ok, then I think we can agree :)

Tycho
