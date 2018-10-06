Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591EFC00449
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 01:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2113721473
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 01:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="TUP1E4/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2113721473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbeJFJAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 05:00:41 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43230 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbeJFJAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 05:00:40 -0400
Received: by mail-pl1-f195.google.com with SMTP id 30-v6so7595588plb.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 18:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ieo5aU7IW8O9fdGCRZUMA1k1N44dJBGOAndkP0WH7a4=;
        b=TUP1E4/Te28gJ0zdutR/9N/xM8HBL5RKTL/rstAl0DB4Xu3xRChoFC0s9rXjaqqwxf
         dy9PIYYHqAnuz2L/S86i60CE6UpgejTd7fUsLogLnpLwkz190zzKl0rgqPa9ZIA6FvIt
         ESPqwCmIgF8ezLSvMRlHd12QPQMcHry9ybMIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ieo5aU7IW8O9fdGCRZUMA1k1N44dJBGOAndkP0WH7a4=;
        b=AOh/B5zfw+iQISDbdmI6IrsoapTMwKEY1sxlJjuVSV6BI/GQ4n74+vS9/TNvxHGAIC
         7hkY3hfpUFvONwHLWjxFhFBJ6QJ5/LBTDo4TA0ytVmiS+lLFK8uEie0yOnYaG/fnkeie
         YThq2m1r8V1fOONy4ZXRzqaUmdyhjiL00VRpgOUnFDrd9S4IDhzqU+NOSo2q2Ts11vUF
         FTtD+6IHS6sPXGq8UHg5fmHJw737jJft1k3FDJy3xhdXrIbARWjp7zVwcx2OZlbKd46E
         fHoV6HwzAnE0JRH/dcaXJjX3pqDJpZ3JgkxPZmt/LDdCIoLU0JvwcU85qEUj2TW/Xjzy
         L2OQ==
X-Gm-Message-State: ABuFfohk71NKUsd1dDkp2pU2y8E0uWj8DdZ0hyHMXdkB4RBj+pFzfo7i
        nIlziHSSmt+Pi4nuhhrY3vd1pQ==
X-Google-Smtp-Source: ACcGV63FiFGTFFHYQgtpBk1XbeetKlFLwIzLf3Tk6bo3Ie2iIV04DizEH9UmilTeXwlVZsJzITH+6g==
X-Received: by 2002:a17:902:9a45:: with SMTP id x5-v6mr13991406plv.213.1538791155852;
        Fri, 05 Oct 2018 18:59:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id g88-v6sm16501506pfd.181.2018.10.05.18.59.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 18:59:14 -0700 (PDT)
Date:   Fri, 5 Oct 2018 18:59:13 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>, pantin@google.com
Subject: Re: [PATCH RFC 0/5] rcu doc updates for whatisRCU and checklist
Message-ID: <20181006015913.GA204532@joelaf.mtv.corp.google.com>
References: <20181005231815.170433-1-joel@joelfernandes.org>
 <20181005234628.GB2548@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005234628.GB2548@thunk.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 07:46:28PM -0400, Theodore Y. Ts'o wrote:
> On Fri, Oct 05, 2018 at 04:18:09PM -0700, Joel Fernandes (Google) wrote:
> > 
> > Here are this week's rcu doc updates based on combing through whatisRCU and
> > checklists. Hopefully you agree with them. I left several old _bh and _sched
> > API references as is, since I don't think its a good idea to remove them till
> > the APIs themselves are removed, however I did remove several of them as well
> > (like in the first patch in this series) since I feel its better to "encourage"
> > new users not to use the old API.
> 
> Hi Joel,

Hi Ted,

> 
> As it so happens, I just recently wrote my first RCU patch[1] (file
> systems, especially on-disk data structures, generally tend not to be
> good candidates for RCU semantics).
> 
> [1] http://patchwork.ozlabs.org/patch/979779/
> 
> So if you are working on improving RCU documentation, I thought I
> would give two comments on the RCU docs from the perspective of a
> developer trying to use RCU for the first time.
> 
> * whatisRCU is great, but one the example in Section 3 uses
>   rcu_dereference_protected() without explaining it.  Given that using
>   that function seems to be considered best practice, maybe a few more
>   words there would be in order?  That function isn't mentioned in
>   rcu.txt either, BTW.

I actually felt the same about rcu_dereference_protected while reading and
then looked at the comment above the implementation. The code comments are
pretty detailed, but I agree the example should mention a few words about it
since it uses it. I could look into improving that, no problem.

> * lockdep.txt *does* explain what rcu_dereference_protected() does,
>   but it doesn't really describe lockdep_is_held().  You can mostly
>   figure it out from context, but it wasn't obvious to me what locks
>   it could be used against, and in the case of a rw_semaphore, whether
>   it applied to shared as well as exclusive locks.  That's a lockdep
>   abstraction, and not a RCU abstraction, but lockdep isn't
>   particularly well documented, so I ended up spending 20-30 minutes
>   or so looking at the lockdep implementation before I was sure it
>   actually worked the way I thought it was going to.

Ok, makes sense to improve it. Since I haven't yet looked through lockdep.txt
yet (as a part of my broader documentation effort for the RCU consolidation),
I can take up improving that based on your suggestions since I have to look
into it anyway :). I'll look into that next week and CC you on this.

> Anyway, I was going to put submitting a patch to improve whatisRCU on
> my (vastly over-long) TODO list, but when I saw your patch set, I
> couldn't resist trying to see if I could fob it off on you.  If you
> don't think that's fair (and it probably isn't really), just let me
> know, and I'll put it back on my todo list.  :-)

Its Ok :) I'm happy to help! thanks for letting me know.

Best,

 - Joel

