Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48AFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B94220851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="PnzYsVZ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B94220851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731145AbeKTHrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 02:47:10 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:47069 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730753AbeKTHrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 02:47:09 -0500
Received: by mail-pg1-f194.google.com with SMTP id w7so14366951pgp.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 13:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CcqVs1xEsV1w9KquUJ1XSh+K1FpH2DHob904gkmknVQ=;
        b=PnzYsVZ+QtEiOa36R9UsZJmo8+z9PmlLpLNmbfReF1fHHQpTANugFjYiWcvKTBhFro
         3LSTdh5FPky5Fhfb/ZNbh7udbSpVG2yjbeAq2OVDVVDzVhm3iuBsXUeC0uqnUrapcV2G
         Ue3sQiKtQZfXUaVi9N9G2zzgiRGx2g2SQ8OKUiy860bsW7UqqVYFfeZsuK5b7NMVH3h2
         HoAn+hkix2sULp48NBTUy2g6jjen1JiPJIeT051btElXj++pZbhQNA7rdWWM9SG8wjwE
         cnTe3gwxORQcfM+TWxKaQMpxolC6G7yrBiGZtqff7JoKcpHx4i91YbAQXF2vedp0sQaO
         3a7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CcqVs1xEsV1w9KquUJ1XSh+K1FpH2DHob904gkmknVQ=;
        b=RDOcxkKKkD8elz+dHqIqHhT499F9O65tZhf6i/bXNxirj2r48oOv9BB2c3Nlqywa6w
         d/A9rE/xOMweExNXn02TbHLn2/ZLGoK9uLmDiQ4GQ/D6FWgkuGNsegJag/wdtegZHE3I
         zKOiS8IvwXLrnTz2qrNHIMNgWjpleilTZ9PxYi3CP+dvFPM4O6aH5lVZLue7+axQm6oo
         hPg31Wh5Yn0zO2eOTidVXUcVRGtKY+fJHF/oU1A6kfpF9AIvXbDVOx2Aqfh/lpekTZXk
         BlX8nAWI/JYYBXUEy9zv6j1fbnPzgsftWhS64uIC6tKtHCt5PRXY4UhJw3jEmwCkyqnc
         Se9Q==
X-Gm-Message-State: AGRZ1gIqUFk8yBCkTYDcFa8aue4xjQoQ40XgJgtDmZIYyriSkKlKowwY
        8Rg/P5rmPaR4DnZNf8dh9BKDTg==
X-Google-Smtp-Source: AJdET5c7UvU8t74JANMbpNlwT6uAhl+JEkpO6JBFxtwoen6goLyQ1gdDmMpdKdHzXDnhXkCxw+mOSA==
X-Received: by 2002:a63:4d66:: with SMTP id n38mr21660350pgl.270.1542662497568;
        Mon, 19 Nov 2018 13:21:37 -0800 (PST)
Received: from brauner.io ([2404:4404:133a:4500:9d11:de0b:446c:8485])
        by smtp.gmail.com with ESMTPSA id d11sm27052206pgi.25.2018.11.19.13.21.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 13:21:36 -0800 (PST)
Date:   Mon, 19 Nov 2018 22:21:28 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        serge@hallyn.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, oleg@redhat.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, dancol@google.com, timmurray@google.com,
        linux-man@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v1 2/2] signal: add procfd_signal() syscall
Message-ID: <20181119212126.u2nkijmula6wcfqi@brauner.io>
References: <20181119103241.5229-1-christian@brauner.io>
 <20181119103241.5229-3-christian@brauner.io>
 <20181119202857.k5zw742xjfrw677j@yavin>
 <20181119205518.btew3vxwgva4w3zh@brauner.io>
 <20181119211810.73ptfhnwdmkngfi4@yavin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181119211810.73ptfhnwdmkngfi4@yavin>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 08:18:10AM +1100, Aleksa Sarai wrote:
> On 2018-11-19, Christian Brauner <christian@brauner.io> wrote:
> > On Tue, Nov 20, 2018 at 07:28:57AM +1100, Aleksa Sarai wrote:
> > > On 2018-11-19, Christian Brauner <christian@brauner.io> wrote:
> > > > +	if (info) {
> > > > +		ret = __copy_siginfo_from_user(sig, &kinfo, info);
> > > > +		if (unlikely(ret))
> > > > +			goto err;
> > > > +		/*
> > > > +		 * Not even root can pretend to send signals from the kernel.
> > > > +		 * Nor can they impersonate a kill()/tgkill(), which adds
> > > > +		 * source info.
> > > > +		 */
> > > > +		ret = -EPERM;
> > > > +		if ((kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL) &&
> > > > +		    (task_pid(current) != pid))
> > > > +			goto err;
> > > > +	} else {
> > > > +		prepare_kill_siginfo(sig, &kinfo);
> > > > +	}
> > > 
> > > I wonder whether we should also have a pidns restriction here, since
> > > currently it isn't possible for a container process using a pidns to
> > > signal processes outside its pidns. AFAICS, this isn't done through an
> > > explicit check -- it's a side-effect of processes in a pidns not being
> > > able to address non-descendant-pidns processes.
> > > 
> > > But maybe it's reasonable to allow sending a procfd to a different pidns
> > > and the same operations working on it? If we extend the procfd API to
> > 
> > No, I don't think so. I really don't want any fancy semantics in here.
> > Fancy doesn't get merged and fancy is hard to maintain. So we should do
> > something like:
> > 
> > if (proc_pid_ns() != current_pid_ns)
> > 	return EINVAL
> 
> This isn't quite sufficient. The key thing is that you have to be in an
> *ancestor* (or same) pidns, not the *same* pidns. Ideally you can re-use
> the check already in pidns_get_parent, and expose it. It would be
> something as trivial as:
> 
> bool pidns_is_descendant(struct pid_namespace *ns,
>                          struct pid_namespace *ancestor)
> {
>     for (;;) {
>         if (!ns)
>             return false;
>         if (ns == ancestor)
>             break;
>         ns = ns->parent;
>     }
>     return true;
> }

That can be done without a loop by comparing the level counter for the
two pid namespaces.

> 
> And you can rewrite pidns_get_parent to use it. So you would instead be
> doing:
> 
>     if (pidns_is_descendant(proc_pid_ns, task_active_pid_ns(current)))
>         return -EPERM;
> 
> (Or you can just copy the 5-line loop into procfd_signal -- though I
> imagine we'll need this for all of the procfd_* APIs.)
> 
> -- 
> Aleksa Sarai
> Senior Software Engineer (Containers)
> SUSE Linux GmbH
> <https://www.cyphar.com/>


