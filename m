Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F38C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7B0215EB
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBvalW9h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7B0215EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933994AbeGFRum (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:50:42 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40558 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932895AbeGFRuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:50:40 -0400
Received: by mail-lj1-f195.google.com with SMTP id a6-v6so9744124ljj.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 10:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OkbqDxpMApogbWfgsRMKmScJD80hvoHW0nroC2QITLs=;
        b=GBvalW9hh9h3e8c7vBCkDdjvP8h76As1qLMSTDGyjJ2xjmkCYAl4vFI2om/NwwzyK1
         z2wMKf1A8BuQ019e1VC0G/jLMepbF/uKEFaYv0ANUHsqgIVS5VG2g7aDQIi5eQOd10x9
         wT/xbEzuJ8aWIR0mIFIe8OJwU+ysmIX97LLZZ6RDkL8/Nvj/KdMWnjVxxZp2llSsk0cf
         IbSDAnaCoIQ9gieu3PU97PvFMdG8NpPQIqlIomSSfYwzm8qwbWWv4m4f/kt1+aqR4TMj
         0coAyIcD010+b7A1FOA62zRrHeXIPeZuTWf8x0M7ZVvqJO6UniLK0LS4vBqVVvvmV4ys
         TI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OkbqDxpMApogbWfgsRMKmScJD80hvoHW0nroC2QITLs=;
        b=CpKmUo35qwC61f3KYcTlI76IG/Q/D9s5wpjPIWMHeX/wv2kH4YS/Wwi4y0XLygTKw8
         USB2HYgZX0ZWfinq9CAm5OV9kGDNjrWfXXVp3NUJIZZgN0ol/znv0apmdt1sJCOvu6lv
         DU7xJiqTmtTvYR8/O64pDVL0gZAbdZwKrthOv0l2cDEbbluOGAkxtontWbkLVMCsrtcX
         Dxgq4ogz1S5ZbNcAqLyMPO+P5QIXwIK20fZejlAKRnU5AmhlSwUyMyq70PFpalltf2SU
         7DEy1cBTmdgeabpwo/DXdStkcDHManeNryAj8tOEbfq16am3HzlUydJr53RuYaPPup43
         ScGA==
X-Gm-Message-State: APt69E0vOtu9NC6ijkapZFobjW9xTi3amG9yr3OjCHrtabNyVAgFJlAm
        myAmrTJW65f9pjuGs/DoACg=
X-Google-Smtp-Source: AAOMgpcW7vZvPpGdsVCRs4jbTcZV5W5aUNNUjNdxr4dkeo0fubLRwYapeqB52FdIMcYKCIwJ5V93mw==
X-Received: by 2002:a2e:195c:: with SMTP id p89-v6mr7548610lje.138.1530899438918;
        Fri, 06 Jul 2018 10:50:38 -0700 (PDT)
Received: from esperanza ([185.6.245.156])
        by smtp.gmail.com with ESMTPSA id l20-v6sm2282035lfg.14.2018.07.06.10.50.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 10:50:37 -0700 (PDT)
Date:   Fri, 6 Jul 2018 20:50:35 +0300
From:   Vladimir Davydov <vdavydov.dev@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
        aryabinin@virtuozzo.com
Subject: Re: [PATCH v8 05/17] mm: Assign memcg-aware shrinkers bitmap to memcg
Message-ID: <20180706175034.lptwrafs5iomb6jf@esperanza>
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
 <153063056619.1818.12550500883688681076.stgit@localhost.localdomain>
 <20180703135000.b2322ae0e514f028e7941d3c@linux-foundation.org>
 <aaa98988-29e9-fb81-1d36-6b8bd7a371be@virtuozzo.com>
 <20180705151030.c67eb9a989c5f0023a53d415@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705151030.c67eb9a989c5f0023a53d415@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 03:10:30PM -0700, Andrew Morton wrote:
> On Wed, 4 Jul 2018 18:51:12 +0300 Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> 
> > > - why aren't we decreasing shrinker_nr_max in
> > >   unregister_memcg_shrinker()?  That's easy to do, avoids pointless
> > >   work in shrink_slab_memcg() and avoids memory waste in future
> > >   prealloc_memcg_shrinker() calls.
> > 
> > You sure, but there are some things. Initially I went in the same way
> > as memcg_nr_cache_ids is made and just took the same x2 arithmetic.
> > It never decreases, so it looked good to make shrinker maps like it.
> > It's the only reason, so, it should not be a problem to rework.
> > 
> > The only moment is Vladimir strongly recommends modularity, i.e.
> > to have memcg_shrinker_map_size and shrinker_nr_max as different variables.
> 
> For what reasons?

Having the only global variable updated in vmscan.c and used in
memcontrol.c or vice versa didn't look good to me. So I suggested to
introduce two separate static variables: one for max shrinker id (local
to vmscan.c) and another for max allocated size of per memcg shrinker
maps (local to memcontrol.c). Having the two variables instead of one
allows us to define a clear API between memcontrol.c and shrinker
infrastructure without sharing variables, which makes the code easier
to follow IMHO.

It is also more flexible: with the two variables we can decrease
shrinker_id_max when a shrinker is destroyed so that we can speed up
shrink_slab - this is fairly easy to do - but leave per memcg shrinker
maps the same size, because shrinking them is rather complicated and
doesn't seem to be worthwhile - the workload is likely to use the same
amount of memory again in the future.

> 
> > After the rework we won't be able to have this anymore, since memcontrol.c
> > will have to know actual shrinker_nr_max value and it will have to be exported.

Not necessarily. You can pass max shrinker id instead of the new id to
memcontrol.c in function arguments. But as I said before, I really don't
think that shrinking per memcg maps would make much sense.

> >
> > Could this be a problem?
