Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0BDECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173FA20823
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173FA20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbeKABrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:47:16 -0400
Received: from smtprelay0213.hostedemail.com ([216.40.44.213]:38496 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729826AbeKABrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:47:16 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id BBB9F181D3419;
        Wed, 31 Oct 2018 16:48:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: note22_48520a0328609
X-Filterd-Recvd-Size: 3859
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Wed, 31 Oct 2018 16:48:16 +0000 (UTC)
Message-ID: <4229ff1aa3d11cf302f6d0a4eec8e8f8f2bb919b.camel@perches.com>
Subject: Re: [PATCH 3/3] kobject: fix warnings use pr_* to replace  printk
From:   Joe Perches <joe@perches.com>
To:     YU Bo <tsu.yubo@gmail.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 31 Oct 2018 09:48:15 -0700
In-Reply-To: <20181031134109.7t3fy5p6uzj4tpa6@yubo-2>
References: <cover.1540886346.git.tsu.yubo@gmail.com>
         <bdfdef7349f54a69eb5c57764805b8eeb96a24ae.1540886346.git.tsu.yubo@gmail.com>
         <b12c68ec5dc34f69a3538a90a9a17e8d6b853b41.camel@perches.com>
         <20181031134109.7t3fy5p6uzj4tpa6@yubo-2>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-31 at 09:41 -0400, YU Bo wrote:
> Hi,
> On Tue, Oct 30, 2018 at 08:01:50AM -0700, Joe Perches wrote:
> > On Tue, 2018-10-30 at 08:01 -0400, Bo YU wrote:
> > > Fix warning from checkpatch.pl use pr_* to replace printk
> > 
> > If you look at msg, it can be unterminated with newline.
> > 
> > > diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> > []
> > > @@ -224,7 +224,7 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
> > >  out:
> > >  	if (r) {
> > >  		devpath = kobject_get_path(kobj, GFP_KERNEL);
> > > -		printk(KERN_WARNING "synth uevent: %s: %s",
> > > +		pr_warn("synth uevent: %s: %s",
> > >  		       devpath ?: "unknown device",
> > >  		       msg ?: "failed to send uevent");
> > >  		kfree(devpath);
> > 
> > Perhaps this block should be:
> > 
> > diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> > index 63d0816ab23b..0ba1197f366e 100644
> > --- a/lib/kobject_uevent.c
> > +++ b/lib/kobject_uevent.c
> > @@ -195,12 +195,12 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
> > 	enum kobject_action action;
> > 	const char *action_args;
> > 	struct kobj_uevent_env *env;
> > -	const char *msg = NULL, *devpath;
> > +	const char *msg = NULL;
> > 	int r;
> > 
> > 	r = kobject_action_type(buf, count, &action, &action_args);
> > 	if (r) {
> > -		msg = "unknown uevent action string\n";
> > +		msg = "unknown uevent action string";
> > 		goto out;
> > 	}
> > 
> > @@ -212,7 +212,7 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
> > 	r = kobject_action_args(action_args,
> > 				count - (action_args - buf), &env);
> > 	if (r == -EINVAL) {
> > -		msg = "incorrect uevent action arguments\n";
> > +		msg = "incorrect uevent action arguments";
> > 		goto out;
> > 	}
> > 
> > @@ -223,10 +223,11 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
> > 	kfree(env);
> > out:
> > 	if (r) {
> > -		devpath = kobject_get_path(kobj, GFP_KERNEL);
> > -		printk(KERN_WARNING "synth uevent: %s: %s",
> > -		       devpath ?: "unknown device",
> > -		       msg ?: "failed to send uevent");
> > +		char *devpath devpath = kobject_get_path(kobj, GFP_KERNEL);
> > +
> > +		pr_warn("synth uevent: %s: %s\n",
> > +			devpath ?: "unknown device",
> > +			msg ?: "failed to send uevent");
> > 		kfree(devpath);
> > 	}
> > 	return r;
> Sorry, but i have two stupid questions to annoy you:
> Q1: If i agree with your patch, here should i to do? Acked-by tag or others or nothing to do?

Send V2 with content and explanation of what
it does and why.

> Q2: In fact, i do not know how to test the patch. Only to cat /sys/bus/pci/* or something?

That wouldn't work as these go to dmesg only on
certain conditions.

It's a trivial patch, obviously correct.


