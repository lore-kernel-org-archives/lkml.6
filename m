Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BF9C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95262479A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dkFbXimC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95262479A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754419AbeFVTHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 15:07:19 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43600 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751345AbeFVTHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 15:07:17 -0400
Received: by mail-ed1-f68.google.com with SMTP id d16-v6so1792923edp.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 12:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mhEuh8nhakyorTFw3vjAXOEOIvZtyQDkzvPmPNHKM60=;
        b=dkFbXimCWDOLb0hxTrWQHMye6Mo4PhtR/X822TIcu/8/6LVMac1sxRSy5oR5EiM8xt
         sslTmCO3+CNBaiK5Cfzy1WnzCP4m37lIVSqdA1H9WIgPqJlqUKMPArpaPePldiJ10WOS
         wFuF3yVDgumdpYtIkzZLsn9TUGIaiKVdjuveQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mhEuh8nhakyorTFw3vjAXOEOIvZtyQDkzvPmPNHKM60=;
        b=XqkMfXLngYOCN3fpsVvMx2DM6qlircR55+X4oeQnN0Ka8XApHJxkuzdFH+1F6sQkQ1
         Olja895HOmR8UfzQUy383aBpHDjIo2wunc6HU55hEiAk3I4yGqQU+4jFVrOaiqYnJuL9
         Dl3UORGzYm3cJeciFSFDcJaoL2cbB4Q8w+NvnspyXr42+l4gf0t29Ov241ObPB5CyD0L
         hhS8M4l7HUJCS1bYATTrYxf4bUQsO36x45zQwDLgpPXypAn+eaF0PIbnQ/cUfO2AHZbb
         pIje+HAd6/ETXYEL3yjuEs8WXafe5YOEddsxaCgHqVUwO3DPVfana9DrmMk/fl0O/gDY
         A7LQ==
X-Gm-Message-State: APt69E0Hy+taORZu1N+TKlMXeNJZ6bzUnOGzDVB/F8l0yrGR+NxxsP0P
        HSgpTkDOs5GEmB/KwYYMAT/xBzOTR6o=
X-Google-Smtp-Source: ADUXVKJE4E7qgMfiOvoZ3EUUwMMQBldZKW8fIlM2hJnTw9C3BLugFmIfCyYckiczbbMCrABm7HyucA==
X-Received: by 2002:a50:ad6e:: with SMTP id z43-v6mr2414509edc.77.1529694436204;
        Fri, 22 Jun 2018 12:07:16 -0700 (PDT)
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com. [74.125.82.42])
        by smtp.gmail.com with ESMTPSA id x11-v6sm6350561edb.39.2018.06.22.12.07.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 12:07:15 -0700 (PDT)
Received: by mail-wm0-f42.google.com with SMTP id p126-v6so3192344wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 12:07:14 -0700 (PDT)
X-Received: by 2002:a1c:6b51:: with SMTP id g78-v6mr2721396wmc.149.1529694434245;
 Fri, 22 Jun 2018 12:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180622082752.GX11011@yexl-desktop> <CA+55aFw5ghByk_zCN25G6rPPSAQma3Mh0t4s18CtLg=h6U9+Zg@mail.gmail.com>
 <20180622095608.GA12263@lst.de> <20180622100014.GA12425@lst.de> <20180622110117.GU30522@ZenIV.linux.org.uk>
In-Reply-To: <20180622110117.GU30522@ZenIV.linux.org.uk>
From:   Sean Paul <seanpaul@chromium.org>
Date:   Fri, 22 Jun 2018 15:06:36 -0400
X-Gmail-Original-Message-ID: <CAOw6vbLPBR5LE7YBwEUuUTq_esaZmwuH5mVkw93pgjQ7ng1m1g@mail.gmail.com>
Message-ID: <CAOw6vbLPBR5LE7YBwEUuUTq_esaZmwuH5mVkw93pgjQ7ng1m1g@mail.gmail.com>
Subject: Re: [lkp-robot] [fs] 3deb642f0d: will-it-scale.per_process_ops -8.8% regression
To:     viro@zeniv.linux.org.uk
Cc:     hch@lst.de, torvalds@linux-foundation.org, xiaolong.ye@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        darrick.wong@oracle.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 7:01 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, Jun 22, 2018 at 12:00:14PM +0200, Christoph Hellwig wrote:
> > And a version with select() also covered:
>
> For fuck sake, if you want vfs_poll() inlined, *make* *it* *inlined*.
> Is there any reason for not doing that other than EXPORT_SYMBOL_GPL
> fetish?  Because if there isn't, I would like to draw your attention
> to the fact that _this_ pwecious inchewlekshul pwopewty can be trivially
> open-coded by out-of-tree shite even if it happens to be non-GPL one.
>

Was this suggestion so bad that you have to insult not only the
author, but also people with speech impediments?

Sean


> >                                       mask = vfs_poll(f.file, wait);
> > +                                     if (f.file->f_op->poll) {
>
> ... not to mention that here you forgot to remove the call itself while
> expanding it.
>
> Said that, you are not attacking the worst part of it - it's a static
> branch, not the considerably more costly indirect ones.  Remember when
> I asked you about the price of those?  Method calls are costly.
>
> Another problem with with ->get_poll_head() calling conventions is
> that originally you wanted to return ERR_PTR(-mask) as a way to report
> not needing to call ->poll_mask(); that got shot down since quite
> a few of those don't fit into 12 bits that ERR_PTR() gives us.
>
> IIRC, the real reason for non-constant ->get_poll_head() was the sockets,
> with
>
> static struct wait_queue_head *sock_get_poll_head(struct file *file,
>                 __poll_t events)
> {
>         struct socket *sock = file->private_data;
>
>         if (!sock->ops->poll_mask)
>                 return NULL;
>         sock_poll_busy_loop(sock, events);
>         return sk_sleep(sock->sk);
> }
>
> The first part isn't a problem (it is constant).  The second is
> static inline void sock_poll_busy_loop(struct socket *sock, __poll_t events)
> {
>         if (sk_can_busy_loop(sock->sk) &&
>             events && (events & POLL_BUSY_LOOP)) {
>                 /* once, only if requested by syscall */
>                 sk_busy_loop(sock->sk, 1);
>         }
> }
>
> and the third -
>
> static inline wait_queue_head_t *sk_sleep(struct sock *sk)
> {
>         BUILD_BUG_ON(offsetof(struct socket_wq, wait) != 0);
>         return &rcu_dereference_raw(sk->sk_wq)->wait;
> }
>
> Now, ->sk_wq is modified only in sock_init_data() and sock_graft();
> the latter, IIRC, is ->accept() helper.  Do we ever call either of
> those on a sock of already opened file?  IOW, is there any real
> reason for socket ->get_poll_head() not to be constant, other
> than wanting to keep POLL_BUSY_LOOP handling out of ->poll_mask()?
> I agree that POLL_BUSY_LOOP is ugly as hell, but you *still* have
> sock_poll_mask() not free from it...
