Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9BCC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF4E2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="GchKETCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF4E2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeJPXMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:12:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36377 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJPXMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:12:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id y16so26028042wrw.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 08:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p0qLxeCpiBAFE040fgHjKvG59bYwWCKtpW0E7xd8WhQ=;
        b=GchKETCsZIhtTbcSDX+FCjBYZySXRjHi04pdIgNo5EcDAKYBppQBJYo3iuCEXlj0Fr
         ypak8Z6U0O+Ef/GSfXQwKy3ktwetMldb7ARj2+pQbH6/eE5sqcItHNvgC9C/pJeTVUnd
         YlrbalZXsrg+AH+pqgMfFFm2yaaG3++ox4gIGL1gKmxU3vX9vw32uaI1i1fHNQAcxVkS
         gc6HjtwJ6Vb80vV+2mNNnWWxd+VWAdmz2Bq9nwSPs9KVLMXuAeqiDt3jdIVqQKK1xt4a
         RnKQ2ULmHWMKh9NBye7s5QKPZ/cDUjRQnYFsQTybBwe7rpwiak8KUys4TcgoSsKTRF3V
         fKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p0qLxeCpiBAFE040fgHjKvG59bYwWCKtpW0E7xd8WhQ=;
        b=aBi/6Gr8G/QCWSKf28Ho5yj9OSvxxdhh6uN/ukxc5HmGPhLL/cBGTyKoSYzeevjWfQ
         wixpe32nTO7SU+wpGtUsK6dCkMuzgW6+xZD+j2Xnm7uIPArUzzof2Yfu5dpcrbx4djOI
         k6mh9xjYYmw7SVcBHb4siDwlGnKqJ4Uqxlvq+OCPcaYwvTg3mBDN1jkTFWBKxfYAVjPy
         XbdrUKYbT41EiTgvP4L54eNk9eXXSxzrPBc6aRB74PIJISy2xI2EJlX8iC8WrpW7TZlS
         6hE/Yp2E33HX7fjWISIUgs2lXv5RKI50yJ4vCymHg5YW5vrJ0eU8ELNG1wBvkh7XJp5P
         u5aA==
X-Gm-Message-State: ABuFfohDc89SQuRvSSnZPOicGoLE17PmqwzWZd4DdlTqAV7SIf0a9rLL
        LlQQf2jgvPHgGBcYRuydpvyQCg==
X-Google-Smtp-Source: ACcGV61zhDdQkhB/aZGt7jR6UEzcecjFOeHHyl5JX87C2HEyhPaj/9XYlCnXBsAiptkmjCPXmqGe3g==
X-Received: by 2002:a5d:694c:: with SMTP id r12-v6mr3628668wrw.170.1539703269609;
        Tue, 16 Oct 2018 08:21:09 -0700 (PDT)
Received: from brauner.io ([2a02:8070:8895:9700:8197:8849:535a:4f00])
        by smtp.gmail.com with ESMTPSA id b5-v6sm11231344wrr.94.2018.10.16.08.21.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 08:21:07 -0700 (PDT)
Date:   Tue, 16 Oct 2018 17:21:01 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Waiman Long <longman@redhat.com>
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        ebiederm@xmission.com, mcgrof@kernel.org,
        akpm@linux-foundation.org, joe.lawrence@redhat.com,
        linux@dominikbrodowski.net, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v1 2/2] sysctl: handle overflow for file-max
Message-ID: <20181016152100.zg2pmyk6puc5qsr5@brauner.io>
References: <20181015105544.4395-1-christian@brauner.io>
 <20181015105544.4395-3-christian@brauner.io>
 <22319ca1-6dab-fe36-40d5-9c88f7a175ee@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <22319ca1-6dab-fe36-40d5-9c88f7a175ee@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 11:13:28AM -0400, Waiman Long wrote:
> On 10/15/2018 06:55 AM, Christian Brauner wrote:
> > Currently, when writing
> >
> > echo 18446744073709551616 > /proc/sys/fs/file-max
> >
> > /proc/sys/fs/file-max will overflow and be set to 0. That quickly
> > crashes the system.
> > This commit explicitly caps the value for file-max to ULONG_MAX.
> >
> > Note, this isn't technically necessary since proc_get_long() will already
> > return ULONG_MAX. However, two reason why we still should do this:
> > 1. it makes it explicit what the upper bound of file-max is instead of
> >    making readers of the code infer it from proc_get_long() themselves
> > 2. other tunebles than file-max may want to set a lower max value than
> >    ULONG_MAX and we need to enable __do_proc_doulongvec_minmax() to handle
> >    such cases too
> >
> > Cc: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Christian Brauner <christian@brauner.io>
> > ---
> > v0->v1:
> > - if max value is < than ULONG_MAX use max as upper bound
> > - (Dominik) remove double "the" from commit message
> > ---
> >  kernel/sysctl.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index 97551eb42946..226d4eaf4b0e 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -127,6 +127,7 @@ static int __maybe_unused one = 1;
> >  static int __maybe_unused two = 2;
> >  static int __maybe_unused four = 4;
> >  static unsigned long one_ul = 1;
> > +static unsigned long ulong_max = ULONG_MAX;
> >  static int one_hundred = 100;
> >  static int one_thousand = 1000;
> >  #ifdef CONFIG_PRINTK
> > @@ -1696,6 +1697,7 @@ static struct ctl_table fs_table[] = {
> >  		.maxlen		= sizeof(files_stat.max_files),
> >  		.mode		= 0644,
> >  		.proc_handler	= proc_doulongvec_minmax,
> > +		.extra2		= &ulong_max,
> 
> What is the point of having a maximum value of ULONG_MAX anyway? No
> value you can put into a ulong type can be bigger than that.

This is changed in the new code to LONG_MAX. See the full thread for
context. There's also an additional explantion in the commit message.

> 
> >  	},
> >  	{
> >  		.procname	= "nr_open",
> > @@ -2795,6 +2797,8 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int
> >  				break;
> >  			if (neg)
> >  				continue;
> > +			if (max && val > *max)
> > +				val = *max;
> >  			val = convmul * val / convdiv;
> >  			if ((min && val < *min) || (max && val > *max))
> >  				continue;
> 
> This does introduce a change in behavior. Previously the out-of-bound
> value is ignored, now it is capped at its maximum. This is a
> user-visible change.

Not completely true though. Try

echo 18446744073709551616 > /proc/sys/fs/file-max

on a system you find acceptable loosing.
So this is an acceptable user-visible change I'd say. But I'm open to
other suggestions.

> 
> Cheers,
> Longman
> 
> 
