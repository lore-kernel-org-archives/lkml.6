Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10BAC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F62920882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548859739;
	bh=2UIhGQizsA0htci/CicmGrzQCzNsXtqhfH9lNvSKc8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vAKmjljEzmfOiKDeYxcmSkvdlm10ZnwhwRsV2IGnO5n2diHyllh/FCdxBegYeGTcM
	 24aCJLX9dyDNe00WEOcE5d7DQqo+ZZD2Q7jzZ9/U3FEVzpGv0MLPFPQF+QWZu+l/9d
	 MxH6wf4QWUsVpFidppxOB0Asz+qG6NDYqHNrqILI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731256AbfA3Os6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:48:58 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:37537 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfA3Os5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:48:57 -0500
Received: by mail-yb1-f195.google.com with SMTP id 2so9694337ybw.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 06:48:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nS7YK53huqXIYaX82MPf/TjXei9FESVDex7jIbY/k30=;
        b=aJBUnWRpcy47gaRKHHggKkwPcKVtQkyd690qLqQYHPwGg5oqQlo2ESIfMz7WCJtX8O
         f5e3QyrAMEb3QQLER7wZuJMTW06kyVQum0gvYlBy17BMt+Kj1Vj5msp4+Tw1bovgs6yz
         Z2GjClt+pezfAD8vxpQz29v+Wx0OCSoKbs6j8FecUT1TBs86A7f8ztrgIU8FFzaDASSW
         pqEJCzXCv1U6UsimjkEtXh57GLtgfcim8UXeewLiXDftUsxWc7SSKL2LLwzarO0YfKPR
         hPngnICcqjZMsI0eHL+S9//rrUGXpzk3cNt55mWhOn1gcLBppCnJ3khVeFFbEufxE51j
         JC5w==
X-Gm-Message-State: AHQUAuZlJIZORA17KnnZOfTVCUk+K4nWF+vwnwVr/9MjSuFT3et56AtS
        6wETIbPcRwm8GvmmxeJQFOQ=
X-Google-Smtp-Source: AHgI3IbzqqPb5Cj9AThiP3VQRdXjEtA/RLCfM7lOuC7kPOJYa/k49YRwPjljMDu80fiKbRfqdZiY+g==
X-Received: by 2002:a25:38d3:: with SMTP id f202mr10776530yba.52.1548859736578;
        Wed, 30 Jan 2019 06:48:56 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id b11sm652685ywb.0.2019.01.30.06.48.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 06:48:55 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Wed, 30 Jan 2019 06:48:51 -0800
Date:   Wed, 30 Jan 2019 06:48:51 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        Vincent Whitchurch <rabinv@axis.com>
Subject: Re: [PATCH v2] sysctl: Add panic-fatal-signals
Message-ID: <20190130144851.GK11489@garbanzo.do-not-panic.com>
References: <20190128084959.13060-1-vincent.whitchurch@axis.com>
 <20190128100545.b62193aa8f49e1de8d6ea8b7@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128100545.b62193aa8f49e1de8d6ea8b7@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 10:05:45AM -0800, Andrew Morton wrote:
> On Mon, 28 Jan 2019 09:49:59 +0100 Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1242,6 +1242,20 @@ config SYSCTL_SYSCALL
> >  
> >  	  If unsure say N here.
> >  
> > +config SYSCTL_PANIC_FATAL_SIGNALS
> > +	bool "panic-fatal-signals sysctl" if EXPERT
> > +	depends on PROC_SYSCTL
> > +	help
> > +	  If you say Y here, a kernel.panic-fatal-signals sysctl will be
> > +	  offered.  If this sysctl is turned on, the kernel will panic if any
> > +	  userspace process receives a fatal signal which would trigger a core
> > +	  dump.
> > +
> > +	  When used together with kernel core dumps, this can be useful for
> > +	  debugging some system-wide problems, primarily on embedded systems.
> > +
> > +	  If unsure, say N.
> 
> I suggest that the Kconfig help and the forthcoming documentation
> should clearly explain the dangers of enabling this!

And so, should default to n.

  Luis
