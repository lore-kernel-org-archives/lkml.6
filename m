Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FAEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F1E20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="audtYqfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfAOI7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 03:59:43 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42169 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfAOI7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 03:59:43 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so1960147wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 00:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OK3OKVULq95JjzLPyPV42wcwaFQuWKqJt4Nd/dvlXu0=;
        b=audtYqfHOMPNRAYSWWk5nee0DQv9WxdI+hs+0O7+hXf4G+qTPKzgL+b6tB3nKZwJys
         TcSzKvZejKtaHAkf9Q/Myl2PArgKy+bLzv0+VqqHeJYRWMj5SOJPlvCGLTljWgu1LoKd
         G+d8Oldo2WZAgqHOZlUvnGnm5reU3QMeeoMbG0XlWMxFRwqukFmyBg8ehWDsZ5+dOyHs
         1qOc9ZiMAnTNuoaZlrqyAXEHjWBg641x1TuDS3T2WzCuSBZmeNW8nttz2sSLUKkKq/aO
         gfQo/M6B30g1nYa7IAE3UB4GDeRCkSNTZtzXyedcUGwkEA/XojOFnF5RnqReMRO5a4LI
         /VRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OK3OKVULq95JjzLPyPV42wcwaFQuWKqJt4Nd/dvlXu0=;
        b=oAKKXyUC3f4ZeBfxINgro/SVwatRtDfCXv+X86GsvOMgIcpfwEXL3F701CDRHjAqqY
         1sMhLRo0Q9DNhGtwGZTG06HZlszFvvsHWV6BpCo9zrEiHKk45ftn1XHagc6ESUHYzMlz
         PN6k02l9KtW1TQDnDKcJSbtGdk2WPeFqpxZGfEejORbldlgWVn/D3IRWB367y4hvFR3C
         TCVDP2y+h8Q/T2F8XPE/hDO4EtolMLE6yJ+anICBGrswgPScuzo3Iv6/VETAM8+04nHn
         6fMz/rifja09IjwcERjvk8SuwTlbAmYHVRKzwgXqxc/7uNLK4iHnuQMzakIHquc71M7f
         FYJA==
X-Gm-Message-State: AJcUukdT7VIveDpDWnUydOKdE/lLu5rJhy81Fx1y5bDvuWMdNf+Gi734
        WLtZJYo61u36OWuH/qZ+wemh9wL5huAE1g==
X-Google-Smtp-Source: ALg8bN5c9EtcD8SLd9LO5WwLYYaA/v87SBPI4FHHfdIbVVaOb9l36TJtEvfSiErK+/IekZJuVM9Bvw==
X-Received: by 2002:a5d:494a:: with SMTP id r10mr2173888wrs.272.1547542781013;
        Tue, 15 Jan 2019 00:59:41 -0800 (PST)
Received: from brauner.io ([154.119.33.254])
        by smtp.gmail.com with ESMTPSA id s132sm13783388wmf.28.2019.01.15.00.59.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 00:59:40 -0800 (PST)
Date:   Tue, 15 Jan 2019 09:59:36 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] Documentation/filesystems: add binderfs
Message-ID: <20190115085935.qq7ekff7zdaotv3u@brauner.io>
References: <20190111134100.24095-1-christian@brauner.io>
 <20190114172401.018afb9c@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190114172401.018afb9c@lwn.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 05:24:01PM -0700, Jonathan Corbet wrote:
> On Fri, 11 Jan 2019 14:40:59 +0100
> Christian Brauner <christian@brauner.io> wrote:
> 
> > This documents the Android binderfs filesystem used to dynamically add and
> > remove binder devices that are private to each instance.
> > 
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Two quick notes:
> 
> > ---
> > /* Changelog */
> > v1:
> > - switch from *.txt to *.rst format
> > ---
> >  Documentation/filesystems/binderfs.rst | 70 ++++++++++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> >  create mode 100644 Documentation/filesystems/binderfs.rst
> 
> You didn't add it to index.rst, so it won't actually become part of the
> docs build.
> 
> > diff --git a/Documentation/filesystems/binderfs.rst b/Documentation/filesystems/binderfs.rst
> > new file mode 100644
> > index 000000000000..74a744b42db7
> > --- /dev/null
> > +++ b/Documentation/filesystems/binderfs.rst
> > @@ -0,0 +1,70 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +The Android binderfs Filesystem
> > +===============================
> > +
> > +Android binderfs is a filesystem for the Android binder IPC mechanism.  It
> > +allows to dynamically add and remove binder devices at runtime.  Binder devices
> > +located in a new binderfs instance are independent of binder devices located in
> > +other binderfs instances.  Mounting a new binderfs instance makes it possible
> > +to get a set of private binder devices.
> > +
> > +Mounting binderfs
> > +-----------------
> > +
> > +Android binderfs can be mounted with:
> > +
> > +::
> 
> This can be more readably formatted as:
> 
> 	Android binderfs can be mounted with::
> 
> I've applied the patches, taking the liberty of fixing both of those
> things up.  Thanks!

Thanks Jon! Highly appreciated!

Christian
