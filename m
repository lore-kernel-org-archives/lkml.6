Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A94CC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04EC42081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="XgnxQlPD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04EC42081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbeJaGh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 02:37:57 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45998 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbeJaGh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 02:37:56 -0400
Received: by mail-pl1-f193.google.com with SMTP id o19-v6so6183556pll.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 14:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8QCqJgAl8VSP/+D43xtXMFyyZG8G6+6kHrj6YGCEpCk=;
        b=XgnxQlPD2f8Qek79sXGB73Xfa4NzxlSnaepLiclWLwb3CqlyuC17NBzH9tqp8weudx
         BW4szGyWPtU71JTOy3JPZwci2zAKxZheVzYD2xmaPbyCBaHbAGIcTqckCVu3FkfepKM/
         n082dHxnGH/SnK+KgNbIOdKCUJk3EUppztPfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8QCqJgAl8VSP/+D43xtXMFyyZG8G6+6kHrj6YGCEpCk=;
        b=Zs7bHi9yQBbgJFyPRnZfHiEgUpehUA1qiKVhWtuXTYbK0Oq1vBWJSod2OPSLMf0GSb
         Tap7QgVJivXhquwB10ulhvF3NVkmThsosf5z5zUROKIMdCM47FalIv/lZrzBj6r+UnQM
         1qseeQYJB7OYqRRRWNEn5/4uXpNZtFe5Nz+OlsmVs3ymdSXRuPzYn+Rk9xwOP20iAuR4
         KsSyWd7FlLGVQErq9foEgM7fQE2fFLUTI+7BAQj1zW4bPcdslBoaTUX2xmYBw+JGXv1P
         vbU7B0yV8HMLMI721l/TiJUcX7KAYZNYKHiJEcPKtaVBABekWvRwWwmT2+2a4AHlnaiu
         wjuA==
X-Gm-Message-State: AGRZ1gITG8mLEIgb8VaNqbhe5T7MhvE0IbZQR4+HSjY6R6i83GpyGQPg
        ryUxDy8TZOvHER7MKjykK1tXVA==
X-Google-Smtp-Source: AJdET5fA+ctJuBwPZIErrkAakA+rA5rpjcduM8yHEcnStBRoIDy94qX4NuwzMhl7rQjfIy/YKYUd5g==
X-Received: by 2002:a17:902:b784:: with SMTP id e4-v6mr415126pls.45.1540935766477;
        Tue, 30 Oct 2018 14:42:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id x189-v6sm20318323pfb.162.2018.10.30.14.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 14:42:44 -0700 (PDT)
Date:   Tue, 30 Oct 2018 14:42:43 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Daniel Colascione <dancol@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH] Implement /proc/pid/kill
Message-ID: <20181030214243.GB32621@google.com>
References: <20181029221037.87724-1-dancol@google.com>
 <20181030050012.u43lcvydy6nom3ul@yavin>
 <CAKOZuesKVic-5epRj8XcFNR_63SgvaPcbjDQuSLxNrEfS=O=Jg@mail.gmail.com>
 <20181030204501.jnbe7dyqui47hd2x@yavin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030204501.jnbe7dyqui47hd2x@yavin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 07:45:01AM +1100, Aleksa Sarai wrote:
[...] 
> > > (Unfortunately
> > > there are lots of things that make it a bit difficult to use /proc/$pid
> > > exclusively for introspection of a process -- especially in the context
> > > of containers.)
> > 
> > Tons of things already break without a working /proc. What do you have in mind?
> 
> Heh, if only that was the only blocker. :P
> 
> The basic problem is that currently container runtimes either depend on
> some non-transient on-disk state (which becomes invalid on machine
> reboots or dead processes and so on), or on long-running processes that
> keep file descriptors required for administration of a container alive
> (think O_PATH to /dev/pts/ptmx to avoid malicious container filesystem
> attacks). Usually both.
> 
> What would be really useful would be having some way of "hiding away" a
> mount namespace (of the pid1 of the container) that has all of the
> information and bind-mounts-to-file-descriptors that are necessary for
> administration. If the container's pid1 dies all of the transient state
> has disappeared automatically -- because the stashed mount namespace has
> died. In addition, if this was done the way I'm thinking with (and this
> is the contentious bit) hierarchical mount namespaces you could make it
> so that the pid1 could not manipulate its current mount namespace to
> confuse the administrative process. You would also then create an
> intermediate user namespace to help with several race conditions (that
> have caused security bugs like CVE-2016-9962) we've seen when joining
> containers.
> 
> Unfortunately this all depends on hierarchical mount namespaces (and
> note that this would just be that NS_GET_PARENT gives you the mount
> namespace that it was created in -- I'm not suggesting we redesign peers
> or anything like that). This makes it basically a non-starter.
> 
> But if, on top of this ground-work, we then referenced containers
> entirely via an fd to /proc/$pid then you could also avoid PID reuse
> races (as well as being able to find out implicitly whether a container
> has died thanks to the error semantics of /proc/$pid). And that's the
> way I would suggest doing it (if we had these other things in place).

I didn't fully follow exactly what you mean. If you can explain for the
layman who doesn't know much experience with containers..

Are you saying that keeping open a /proc/$pid directory handle is not
sufficient to prevent PID reuse while the proc entries under /proc/$pid are
being looked into? If its not sufficient, then isn't that a bug? If it is
sufficient, then can we not just keep the handle open while we do whatever we
want under /proc/$pid ?

- Joel

