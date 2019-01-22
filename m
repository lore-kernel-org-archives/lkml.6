Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB66C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8A020879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548155110;
	bh=uZR+IWYW8Dd1HTz2HCl6kqsJLCVnzrNXpRRlOFITwGY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uy/TB9/AfZZAsSlTtbH4dHY+ztHcMVLxHw/JHPP5m06KfKblHu9qEEuwDlFXRm23s
	 co075i20whxOU7aaNVJ6zWsYTXA1abrlC4key4bCsu4asUhRc++Y5lcqOYjbtGmOVZ
	 XkhZwiWcxgQnfpKPPqn+Hl4xASPsosj9ff5PkeGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbfAVLFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:05:08 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39637 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbfAVLFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:05:07 -0500
Received: by mail-oi1-f193.google.com with SMTP id i6so17041536oia.6;
        Tue, 22 Jan 2019 03:05:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uZR+IWYW8Dd1HTz2HCl6kqsJLCVnzrNXpRRlOFITwGY=;
        b=PXENb38le1UVVzIq4J3s7qtOkwMPbDOrOMoMcFbYkTQQdHSUTcPB2nGpQeX105MMSL
         Wjohs9eNgxKE8xiqgSr0c7jrfUmryMJ8DE87qjQRyptXMImbpkWTMgRYD75HEJ5bUnsM
         xgzoJL6kAdU7+Sg/eegLp0u+Mnf7FRYM0EAGc41aJSApA+ldD3A7WxmWm3vdYOgtzSrR
         4G3sB8bM+oWr+l9hhqAi2PJpVqCkn5TaVO3SR1p7PsRVsiHzn/k0y9l3X1NQ4LU7E9LM
         VrWFc+eTyVui7bc/6Q2vo/22mUXJ8zWlIl3wlit6slKBG0xI7vj+9jRPD6YSHz2Etq5C
         r37g==
X-Gm-Message-State: AJcUukefX611ssrl2+VUYgpwdtAz69D21ayA870uXDw9FQLd7Uj745YP
        s4/kYHBeNoGVVmkJwo7sZ2pyE+goowYc2/OjBHc=
X-Google-Smtp-Source: ALg8bN5XM/9ximTJlIeETfn+nWn5sZGbNquli9yHETbjiY2ZhmeZG+BeVe8gGNbj1uwMo0/S0IpG8/XTkCwR8QyhnNY=
X-Received: by 2002:aca:368a:: with SMTP id d132mr8341218oia.193.1548155106761;
 Tue, 22 Jan 2019 03:05:06 -0800 (PST)
MIME-Version: 1.0
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-9-patrick.bellasi@arm.com> <3006911.57lVBuUGX3@aspire.rjw.lan>
 <20190122110205.lpk6o2jdfe3mttjr@e110439-lin>
In-Reply-To: <20190122110205.lpk6o2jdfe3mttjr@e110439-lin>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Jan 2019 12:04:54 +0100
Message-ID: <CAJZ5v0j2NQY_gKJOAy=rP5_1Dk9TODKNhW0vuvsynTN3BUmYaQ@mail.gmail.com>
Subject: Re: [PATCH v6 08/16] sched/cpufreq: uclamp: Add utilization clamping
 for FAIR tasks
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 12:02 PM Patrick Bellasi
<patrick.bellasi@arm.com> wrote:
>
> On 22-Jan 11:37, Rafael J. Wysocki wrote:
> > On Tuesday, January 15, 2019 11:15:05 AM CET Patrick Bellasi wrote:

[cut]

> >
> > IMO it would be better to combine this patch with the next one.
>
> Main reason was to better document in the changelog what we do for the
> two different classes...
>
> > At least some things in it I was about to ask about would go away
> > then. :-)
>
> ... but if it creates confusion I can certainly merge them.
>
> Or maybe clarify better in this patch what's not clear: may I ask what
> were your questions ?
>
> > Besides, I don't really see a reason for the split here.
>
> Was mainly to make the changes required for RT more self-contained.
>
> For that class only, not for FAIR, we have additional code in the
> following patch which add uclamp_default_perf which are system
> defaults used to track/account tasks requesting the maximum frequency.
>
> Again, I can either better clarify the above patch or just merge the
> two together: what do you prefer ?

Merge the two together, please.
