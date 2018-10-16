Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D666DC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E80A208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="OjtxgrcK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E80A208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbeJPXYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:24:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34854 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbeJPXYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:24:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id w5-v6so26073664wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 08:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IB7DKyIPj3rW1dZMGLPlsx9a1LoUaF9Sd38HZpsTMEI=;
        b=OjtxgrcKrC+BOBHliKPrL8vC9KavQR1COSFOe9V/mhUy/ttAAFbNu0/+yadYpfcm43
         Sgx7417/Asp5mgaZOXoWleqJOl2NQcqC96RkgyeycrlQtbBRDD0P5ac+o/EkN9Q+PqiR
         jSIUR1jsPDYq9ppFwZfy4Os9SbRLoCG/DYtlSy66zmaDFFQcHFnTihH7yCyhXDGOabWj
         GW+LBcytd5WxDWq9rfxsU5cGmT5RGbqzrjKNHey2EEFhnmeHKx+J6/cSdBJECyVCdJpX
         9xeIYkCUb7BGOtIGeZF6ncgz5G8as5o3msTHpXw3viAbEKVVTwWvutu8fsPIhR4/um7i
         PUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IB7DKyIPj3rW1dZMGLPlsx9a1LoUaF9Sd38HZpsTMEI=;
        b=uLOuGYcI6zX+OgQZS8bVrBUO8tck6fR+1hkLF3TDlwRwWc4SGXm8P8wWbq09rWUrh0
         9hG2WCNIFd5RdapqStWWcq458oRlsWBVbqYutqo2lNlF9nTX58HJLQGHkE7nUZy2b9x3
         BsIrcjfY0TJzz9/Hr5gqCvRzUbJaRo/HfTVtKPnaK7UYjbyfM50bW3TtuEAxjboiTyjM
         mlT63VENmG9Y1rtIX/JmTTgeRV1TbkU50p8yuZ39E0GGfQcLEK747UO+2fAZt50XBoA/
         A1ygHFkVFoJWeXKnQFMv7AA+ACx8D62KbmHlOjBIS2UskB2yGWZMJOWOLUk80vHiA4ZI
         zLRQ==
X-Gm-Message-State: ABuFfojtmXKB2DN8WvQBoc0Z4F1eFjbg3kPkcrAEgUtoMr+uvQNMZFS5
        8h+nriae8YfqQ0IiqPcj9LMoFA==
X-Google-Smtp-Source: ACcGV637ibt0HNq24Momt37XEfUIlMsy3SONni990kqmSmW0/rwvoyCW7r9AX6uWdvB47nYGXGtp1Q==
X-Received: by 2002:a5d:46d2:: with SMTP id g18-v6mr18571658wrs.185.1539704020797;
        Tue, 16 Oct 2018 08:33:40 -0700 (PDT)
Received: from brauner.io ([2a02:8070:8895:9700:8197:8849:535a:4f00])
        by smtp.gmail.com with ESMTPSA id h13-v6sm12467519wrr.73.2018.10.16.08.33.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 08:33:39 -0700 (PDT)
Date:   Tue, 16 Oct 2018 17:33:33 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Waiman Long <longman@redhat.com>
Cc:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        ebiederm@xmission.com, mcgrof@kernel.org,
        akpm@linux-foundation.org, joe.lawrence@redhat.com,
        linux@dominikbrodowski.net, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v1 2/2] sysctl: handle overflow for file-max
Message-ID: <20181016153332.wi2l4cvngkk4kkyb@brauner.io>
References: <20181015105544.4395-1-christian@brauner.io>
 <20181015105544.4395-3-christian@brauner.io>
 <22319ca1-6dab-fe36-40d5-9c88f7a175ee@redhat.com>
 <20181016152100.zg2pmyk6puc5qsr5@brauner.io>
 <11e172de-0953-2c46-c0f0-72c42ae9a910@redhat.com>
 <20181016152955.vcjtzcx5rzlxeovh@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181016152955.vcjtzcx5rzlxeovh@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 05:29:55PM +0200, Christian Brauner wrote:
> On Tue, Oct 16, 2018 at 11:25:42AM -0400, Waiman Long wrote:
> > On 10/16/2018 11:21 AM, Christian Brauner wrote:
> > > On Tue, Oct 16, 2018 at 11:13:28AM -0400, Waiman Long wrote:
> > >> On 10/15/2018 06:55 AM, Christian Brauner wrote:
> > >>> Currently, when writing
> > >>>
> > >>> echo 18446744073709551616 > /proc/sys/fs/file-max
> > >>>
> > >>> /proc/sys/fs/file-max will overflow and be set to 0. That quickly
> > >>> crashes the system.
> > >>> This commit explicitly caps the value for file-max to ULONG_MAX.
> > >>>
> > >>> Note, this isn't technically necessary since proc_get_long() will already
> > >>> return ULONG_MAX. However, two reason why we still should do this:
> > >>> 1. it makes it explicit what the upper bound of file-max is instead of
> > >>>    making readers of the code infer it from proc_get_long() themselves
> > >>> 2. other tunebles than file-max may want to set a lower max value than
> > >>>    ULONG_MAX and we need to enable __do_proc_doulongvec_minmax() to handle
> > >>>    such cases too
> > >>>
> > >>> Cc: Kees Cook <keescook@chromium.org>
> > >>> Signed-off-by: Christian Brauner <christian@brauner.io>
> > >>> ---
> > >>> v0->v1:
> > >>> - if max value is < than ULONG_MAX use max as upper bound
> > >>> - (Dominik) remove double "the" from commit message
> > >>> ---
> > >>>  kernel/sysctl.c | 4 ++++
> > >>>  1 file changed, 4 insertions(+)
> > >>>
> > >>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > >>> index 97551eb42946..226d4eaf4b0e 100644
> > >>> --- a/kernel/sysctl.c
> > >>> +++ b/kernel/sysctl.c
> > >>> @@ -127,6 +127,7 @@ static int __maybe_unused one = 1;
> > >>>  static int __maybe_unused two = 2;
> > >>>  static int __maybe_unused four = 4;
> > >>>  static unsigned long one_ul = 1;
> > >>> +static unsigned long ulong_max = ULONG_MAX;
> > >>>  static int one_hundred = 100;
> > >>>  static int one_thousand = 1000;
> > >>>  #ifdef CONFIG_PRINTK
> > >>> @@ -1696,6 +1697,7 @@ static struct ctl_table fs_table[] = {
> > >>>  		.maxlen		= sizeof(files_stat.max_files),
> > >>>  		.mode		= 0644,
> > >>>  		.proc_handler	= proc_doulongvec_minmax,
> > >>> +		.extra2		= &ulong_max,
> > >> What is the point of having a maximum value of ULONG_MAX anyway? No
> > >> value you can put into a ulong type can be bigger than that.
> > > This is changed in the new code to LONG_MAX. See the full thread for
> > > context. There's also an additional explantion in the commit message.
> > >
> > >>>  	},
> > >>>  	{
> > >>>  		.procname	= "nr_open",
> > >>> @@ -2795,6 +2797,8 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int
> > >>>  				break;
> > >>>  			if (neg)
> > >>>  				continue;
> > >>> +			if (max && val > *max)
> > >>> +				val = *max;
> > >>>  			val = convmul * val / convdiv;
> > >>>  			if ((min && val < *min) || (max && val > *max))
> > >>>  				continue;
> > >> This does introduce a change in behavior. Previously the out-of-bound
> > >> value is ignored, now it is capped at its maximum. This is a
> > >> user-visible change.
> > > Not completely true though. Try
> > >
> > > echo 18446744073709551616 > /proc/sys/fs/file-max
> > >
> > > on a system you find acceptable loosing.
> > > So this is an acceptable user-visible change I'd say. But I'm open to
> > > other suggestions.
> > 
> > I am not saying this is unacceptable. I just say this is a user-visible
> > change and so should be documented somehow. BTW, you cap the max value,
> 
> Sure, I'll update linux manpages and I can CC stable on the next round.

Sorry, s/stable/linux-api@vger.kernel.org/

> 
> > but not the min value. So there is inconsistency. I would say you either
> > do both, or none of them.
> 
> The min value is 0. I don't think it needs to be set explicitly. I just
> kept the max value because it is != ULONG_MAX but LONG_MAX for file-max.
