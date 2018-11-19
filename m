Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B7CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792012075B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="e1ovfNl9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 792012075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbeKTF4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:56:44 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33717 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeKTF4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:56:44 -0500
Received: by mail-pg1-f195.google.com with SMTP id z11so11634055pgu.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 11:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mu6qKRf+9E/4CL62LIsiA9rAeSPSuiYJbFtGi+7TcLE=;
        b=e1ovfNl9xPKyHeKUy0RoAMQx9TOwkHNmrHtEtzp1GbvW0OVFDnScgvojPTtIkeJ9s6
         GIP4IrBSB/bMuIYbF2TB3xtiIDqWgl5AmmUj7rkIlOzZhzJxvMpqobR++uuIhcFe4CH5
         TI3IM6jXvuqNC6ZHJGCaWe+RC1U0GkBGJso3gBzfNrhF3g+gJ3k4h0KmwooRX7LC05H7
         SHdqggOm2wOQNhhhTwumZZE7j28ND28+Y3a43Sae5gb9wuZFl6GODnh4eMAINVXlt3ee
         BDC3JkanUS9giILXy1E7Sktnd5cMF0/R6rKYmhlbtK0V7ceru7WtUwtMv2p/jUVpZjWG
         CrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mu6qKRf+9E/4CL62LIsiA9rAeSPSuiYJbFtGi+7TcLE=;
        b=RjXd1n3FZlqKrM82aCwMpQUraMGKgTb65xBvw32QAdmSJdJLoIXyG9UyyESY5Iga3O
         xiestKw9imjHHapWGmMk8Hlnd2DrkLofS3Lq4rQlHl7bV593+T8IE4jShriwDsp9B5eA
         vyoAQ/xMeFZQ+SBNbxG4Lu1sLUs3YPMXuVV99IwLstZrG+OQrjjqt2Lzz3AYoXMJG0gx
         4GxKam1L2yIvvzKEOOVw3WQdF/8O9+WU/XUTLEz+AIa/SsMKNWgzpl6+QYveNag/RnaG
         UkcgmQ0rDnFPGyUGWwO4oUUKWDeBlgnsMNwbKovhnkB67I5OH/gR87g1b0grabsfU2Pt
         wc8Q==
X-Gm-Message-State: AGRZ1gLtrM8uFSYYDRDRXBCJTAx+I+Gpa7Ho4KwrZpuu1mLdE7EmQn0k
        i2w2oJT8g0ek9L++qHU6xa1uxQ==
X-Google-Smtp-Source: AJdET5cujqEJprT/UKg6vQryTYtEMMG37SNmU3H/bupbSb4IssigyIsPrygELW+nRCE6l8yyntwsFw==
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr21068310pgh.265.1542655900177;
        Mon, 19 Nov 2018 11:31:40 -0800 (PST)
Received: from brauner.io ([2404:4404:133a:4500:9d11:de0b:446c:8485])
        by smtp.gmail.com with ESMTPSA id b5sm27377357pfc.150.2018.11.19.11.31.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 11:31:39 -0800 (PST)
Date:   Mon, 19 Nov 2018 20:31:31 +0100
From:   Christian Brauner <christian@brauner.io>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Daniel Colascione <dancol@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v1 2/2] signal: add procfd_signal() syscall
Message-ID: <20181119193128.hv7z4j52ajrue2jr@brauner.io>
References: <20181119103241.5229-1-christian@brauner.io>
 <20181119103241.5229-3-christian@brauner.io>
 <CAKOZueshQ2DAwUYp+dLpmfYG6FtvCqeRQxH41SjNS+WqY3e0Fw@mail.gmail.com>
 <20181119182902.fadw6qiu3eepndm3@brauner.io>
 <87o9ak28nl.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o9ak28nl.fsf@xmission.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 01:02:06PM -0600, Eric W. Biederman wrote:
> Christian Brauner <christian@brauner.io> writes:
> 
> > On Mon, Nov 19, 2018 at 07:59:24AM -0800, Daniel Colascione wrote:
> >> You never addressed my comment on the previous patch about your use of
> >
> > Sorry, that thread exploded so quickly that I might have missed it.
> >
> >> private_data here. Why can't you use the struct pid reference that's
> >> already in the inode?
> >
> > If that's what people prefer we can probably use that. There was
> > precedent for stashing away such data in fs/proc/base.c already for
> > various other things including user namespaces and struct mm so I
> > followed this model. A prior version of my patch (I didn't send out) did
> > retrive the inode via proc_pid() in .open() took an additional reference
> > via get_pid() and dropped it in .release(). Do we prefer that?
> 
> If you are using proc/<pid>/ directories as your file descriptors, you
> don't need to add an open or a release method at all.  The existing file
> descriptors hold a reference to the inode which holds a reference the
> the struct pid.
> 
> The only time you need to get a reference is when you need a task
> and kill_pid_info already performs that work for you.

Oh, I see what you and Andy are saying now. Sweet, that means we can
trim down the patch even more. Less code, less headache.

Thanks!

> 
> So using proc_pid is all you need to do to get the pid from the existing
> file descriptors.
> 
> Eric
> 
