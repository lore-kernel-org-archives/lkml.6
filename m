Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82462C6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 00:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B77620870
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 00:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="jUyIJB13"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B77620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbeJaJiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 05:38:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38952 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbeJaJiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 05:38:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id c25-v6so6710110pfe.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 17:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q2BmpXzxK9CQ+aNOqEoRHSyyEgATEMM80AJ2FWmA7Jw=;
        b=jUyIJB13ZQ/Oyn0sWJlM5nddOAKg7eTtRmxN4N8xCyPfYGRd0rEB5eLjTHpR5ku/n7
         tjMROYBjHHC8JMP869Ezt1yQ/6PzGWMtGyKGp50bltDQDACRFOYNSjSLUwkj1+dQ0vZz
         Qi6Sc3dQJBFIPOqUIE/T0WWHKeTHmnl1xkmiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q2BmpXzxK9CQ+aNOqEoRHSyyEgATEMM80AJ2FWmA7Jw=;
        b=rb94FVdmEdWZynOibXOlFhQ4MVqH/yv3572fARzj0Hrn2dwwHs6TmpqQ7UUrMoV0Ea
         EdkIIcYzYwkSZTA4TFngX+eI9c8V4h9g/Omve2Hz0CyICHCsNjI4w7obje4aLWn3dcb6
         MrgyMznqGDBn+y0UKZbfGEpWDI6ALiY9U8mBNheVzOfZg5nWViyHKxmUfoD6UZ1DexJi
         fJ43Z54t2LluAJWpnffjGQMUOA48xkJdUFUuFMrl/WBXAxHdIf17GvFgGvNolF01qJEf
         CJh4dD5iTJqbf8RE+3Sgz5fbsj2QYM32hDFxOXbdiPm3vefp85OQ7iFRV97XptqPgcwU
         0V0g==
X-Gm-Message-State: AGRZ1gKgQh6qmrO66zsFCmO32pLvQTUtoNeeKk1J2U1BIyePe/KMh+uN
        P4DKbTv5jV2uZaDBrGnLQdxXcQ==
X-Google-Smtp-Source: AJdET5e5RNSv8KGabZjmIvhAauW7tK//kZjOKVkLNxwW95eD+M4/PCd2vgHKHZ71ur+8/ZBthwOBXQ==
X-Received: by 2002:a63:e943:: with SMTP id q3-v6mr957608pgj.42.1540946538295;
        Tue, 30 Oct 2018 17:42:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id r26-v6sm22364499pga.69.2018.10.30.17.42.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 17:42:16 -0700 (PDT)
Date:   Tue, 30 Oct 2018 17:42:16 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Daniel Colascione <dancol@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH] Implement /proc/pid/kill
Message-ID: <20181031004216.GC224709@google.com>
References: <20181029221037.87724-1-dancol@google.com>
 <20181030050012.u43lcvydy6nom3ul@yavin>
 <CAKOZuesKVic-5epRj8XcFNR_63SgvaPcbjDQuSLxNrEfS=O=Jg@mail.gmail.com>
 <20181030204501.jnbe7dyqui47hd2x@yavin>
 <20181030214243.GB32621@google.com>
 <20181030222339.ud4wfp75tidowuo4@yavin>
 <20181030223343.GB105735@joelaf.mtv.corp.google.com>
 <20181030224908.5rsldg4jsos7o5sa@yavin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030224908.5rsldg4jsos7o5sa@yavin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 09:49:08AM +1100, Aleksa Sarai wrote:
> On 2018-10-30, Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > [...] 
> > > > > > > (Unfortunately
> > > > > > > there are lots of things that make it a bit difficult to use /proc/$pid
> > > > > > > exclusively for introspection of a process -- especially in the context
> > > > > > > of containers.)
> > > > > > 
> > > > > > Tons of things already break without a working /proc. What do you have in mind?
> > > > > 
> > > > > Heh, if only that was the only blocker. :P
> > > > > 
> > > > > The basic problem is that currently container runtimes either depend on
> > > > > some non-transient on-disk state (which becomes invalid on machine
> > > > > reboots or dead processes and so on), or on long-running processes that
> > > > > keep file descriptors required for administration of a container alive
> > > > > (think O_PATH to /dev/pts/ptmx to avoid malicious container filesystem
> > > > > attacks). Usually both.
> > > > > 
> > > > > What would be really useful would be having some way of "hiding away" a
> > > > > mount namespace (of the pid1 of the container) that has all of the
> > > > > information and bind-mounts-to-file-descriptors that are necessary for
> > > > > administration. If the container's pid1 dies all of the transient state
> > > > > has disappeared automatically -- because the stashed mount namespace has
> > > > > died. In addition, if this was done the way I'm thinking with (and this
> > > > > is the contentious bit) hierarchical mount namespaces you could make it
> > > > > so that the pid1 could not manipulate its current mount namespace to
> > > > > confuse the administrative process. You would also then create an
> > > > > intermediate user namespace to help with several race conditions (that
> > > > > have caused security bugs like CVE-2016-9962) we've seen when joining
> > > > > containers.
> > > > > 
> > > > > Unfortunately this all depends on hierarchical mount namespaces (and
> > > > > note that this would just be that NS_GET_PARENT gives you the mount
> > > > > namespace that it was created in -- I'm not suggesting we redesign peers
> > > > > or anything like that). This makes it basically a non-starter.
> > > > > 
> > > > > But if, on top of this ground-work, we then referenced containers
> > > > > entirely via an fd to /proc/$pid then you could also avoid PID reuse
> > > > > races (as well as being able to find out implicitly whether a container
> > > > > has died thanks to the error semantics of /proc/$pid). And that's the
> > > > > way I would suggest doing it (if we had these other things in place).
> > > > 
> > > > I didn't fully follow exactly what you mean. If you can explain for the
> > > > layman who doesn't know much experience with containers..
> > > > 
> > > > Are you saying that keeping open a /proc/$pid directory handle is not
> > > > sufficient to prevent PID reuse while the proc entries under /proc/$pid are
> > > > being looked into? If its not sufficient, then isn't that a bug? If it is
> > > > sufficient, then can we not just keep the handle open while we do whatever we
> > > > want under /proc/$pid ?
> > > 
> > > Sorry, I went on a bit of a tangent about various internals of container
> > > runtimes. My main point is that I would love to use /proc/$pid because
> > > it makes reuse handling very trivial and is always correct, but that
> > > there are things which stop us from being able to use it for everything
> > > (which is what my incoherent rambling was on about).
> > 
> > Ok thanks. So I am guessing if the following sequence works, then Dan's patch is not
> > needed.
> > 
> > 1. open /proc/<pid> directory
> > 2. inspect /proc/<pid> or do whatever with <pid>
> > 3. Issue the kill on <pid>
> > 4. Close the /proc/<pid> directory opened in step 1.
> > 
> > So unless I missed something, the above sequence will not cause any PID reuse
> > races.
> 
> (Sorry, I misunderstood your original question.)
> 
> The problem is that holding /proc/$pid doesn't stop the PID from dying
> and being reused. The benefit of holding open /proc/$pid is that you
> will get an error if you try to use it *after* the PID has died -- which
> means that you don't need to worry about explicitly checking for PID
> reuse if you are only operating with the file descriptor and not the
> PID.
> 
> So that sequence won't always work. There is a race where the pid might
> die and be recycled by the time you call kill(2) -- after you've done
> step 2. By tying step 2 and 3 together -- in this patch -- you remove
> the race (since in order to resolve the "kill" procfs file VFS must
> resolve the PID first -- atomically).

Makes sense, thanks.

> Though this race window is likely very tiny, and I wonder how much PID
> churn you really need to hit it.

Yeah that's what I asked initially how much of a problem it really is.

Also, I am wondering why the implementation does not want to keep a reference
to the task_struct for the duration of any open proc files/directories. Is
there a good reason?

 - Joel

