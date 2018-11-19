Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78662C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A6E72086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="ZhYttCEM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A6E72086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731205AbeKTIDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:03:10 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47059 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731020AbeKTIDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 03:03:09 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so14383292pgp.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 13:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VOjW638z3d5q6CKfTj+S+sb/ShrwILedBHxdMuQQBoA=;
        b=ZhYttCEM59onYuWzzVD1D3DwYnz/KCxai+0/+Tur9qe/+UyGs7gGL4IKMHushG7r+x
         RZhpyoG64a67jDYiFy0/t/QLQlkl3unEvxV8LiZBESwaqUC2ItkqWXQjFN/ZhjrfMYeR
         faW92FcyMimPyvDSN3bfmCs/JC8a83eih0zacpFLHwZPAQzl7qHOBJ+qEzYVf94UKF8B
         tOcjzFKHiBB1o6yA/86MSkXs/JVn5fup9FFXJ5MH/+KaZV428/x6AH8RstX+48I2eNUg
         N77Y0ce9pkvMNzCwZIGn5bqyfH+9fanfJipkrnNdfc/+YhSwKf11rBn4WwuTM+IKwmra
         FXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VOjW638z3d5q6CKfTj+S+sb/ShrwILedBHxdMuQQBoA=;
        b=thzVau40kMIajCGjht2EqZac57+6dc3aESl6BsmoLPJfUFmLJV4VlfNm4/YWQQt0ek
         XrtNCURxR8vQ5mtuIrTkIXWfO0zcvOgfM4zaiNmZDjHgFEDZs+kvNDCRrt4hpCmlyl6g
         Jq9cJR5FMoH6U38I1SfDMdSkwOsLMiOxr1R7qLT4qoss8biVQPphbrhyAOHStxoO9KJp
         9lef787BaupwfPj4rIBNCmm/x0JZo2t8gmsUIFqsRubmpiAZLmw+AC9txfA4fvUCvCBl
         xrJSJYThAPhKpTpy8gOnwoNVglkLKqh+8EaE1rrCY4g56xUyr4RUX06ctonBZF6gv/QZ
         LqQQ==
X-Gm-Message-State: AGRZ1gJAQlcpS7YCJfr0WpTzHNA91fkka84VjrExHN8F8e385vmP4kQx
        McRgvvbdcFpdv1a99uX0o3Advw==
X-Google-Smtp-Source: AJdET5esLxqLZg1PPmp6vopLaNjR7oR3VISGNzyaevxNNFIKytdp6BkM/MVpjd1yFFUiDWQGuHpJ/g==
X-Received: by 2002:a63:dd15:: with SMTP id t21mr20839991pgg.347.1542663453805;
        Mon, 19 Nov 2018 13:37:33 -0800 (PST)
Received: from brauner.io ([2404:4404:133a:4500:9d11:de0b:446c:8485])
        by smtp.gmail.com with ESMTPSA id 128-v6sm45808638pfd.64.2018.11.19.13.37.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 13:37:33 -0800 (PST)
Date:   Mon, 19 Nov 2018 22:37:24 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Daniel Colascione <dancol@google.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v1 2/2] signal: add procfd_signal() syscall
Message-ID: <20181119213722.z54huio5g4kuldxk@brauner.io>
References: <20181119103241.5229-1-christian@brauner.io>
 <20181119103241.5229-3-christian@brauner.io>
 <20181119202857.k5zw742xjfrw677j@yavin>
 <20181119205518.btew3vxwgva4w3zh@brauner.io>
 <20181119211810.73ptfhnwdmkngfi4@yavin>
 <20181119212126.u2nkijmula6wcfqi@brauner.io>
 <CAKOZuevEx6CbcxrR8eVZrUXDcN5y1GPsXdSoHfQteSQKypx0qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKOZuevEx6CbcxrR8eVZrUXDcN5y1GPsXdSoHfQteSQKypx0qw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 01:26:22PM -0800, Daniel Colascione wrote:
> On Mon, Nov 19, 2018 at 1:21 PM, Christian Brauner <christian@brauner.io> wrote:
> > That can be done without a loop by comparing the level counter for the
> > two pid namespaces.
> >
> >>
> >> And you can rewrite pidns_get_parent to use it. So you would instead be
> >> doing:
> >>
> >>     if (pidns_is_descendant(proc_pid_ns, task_active_pid_ns(current)))
> >>         return -EPERM;
> >>
> >> (Or you can just copy the 5-line loop into procfd_signal -- though I
> >> imagine we'll need this for all of the procfd_* APIs.)
> 
> Why is any of this even necessary? Why does the child namespace we're
> considering even have a file descriptor to its ancestor's procfs? If

Because you can send file descriptors between processes and container
runtimes tend to do that.

> it has one of these FDs, it can already *read* all sorts of
> information it really shouldn't be able to acquire, so the additional
> ability to send a signal (subject to the usual permission checks)
> feels like sticking a finger in a dike that's already well-perforated.
> IMHO, we shouldn't bother with this check. The patch would be simpler
> without it.

We will definitely not allow signaling processes in an ancestor pid
namespace! That is a security issue! I can imagine container runtimes
killing their monitoring process etc. pp. Not happening, unless someone
with deep expertise in signals can convince me otherwise.
