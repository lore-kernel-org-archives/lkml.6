Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79160C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230412085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 230412085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387461AbeKFRWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 12:22:53 -0500
Received: from smtprelay0234.hostedemail.com ([216.40.44.234]:48321 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729021AbeKFRWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 12:22:52 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id BD69618029585;
        Tue,  6 Nov 2018 07:58:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: owner79_1351625f00457
X-Filterd-Recvd-Size: 4032
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Tue,  6 Nov 2018 07:58:52 +0000 (UTC)
Message-ID: <932e46a701ebe9b3b33a110d187880eda14c23fb.camel@perches.com>
Subject: Re: [PATCH v2] kobject: to use pr_warn replace KERN_WARNING
From:   Joe Perches <joe@perches.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>, tsu.yubo@gmail.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 05 Nov 2018 23:58:51 -0800
In-Reply-To: <CAJZ5v0gzM+_a+HJa_kjpgaj96iiH3f_x1ZXjK3HE8=E5FvuAPA@mail.gmail.com>
References: <1541472103-6212-1-git-send-email-tsu.yubo@gmail.com>
         <CAJZ5v0gzM+_a+HJa_kjpgaj96iiH3f_x1ZXjK3HE8=E5FvuAPA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-06 at 08:49 +0100, Rafael J. Wysocki wrote:
> On Tue, Nov 6, 2018 at 3:42 AM Bo YU <tsu.yubo@gmail.com> wrote:
> > Fix warning form checkpatch, use pr_warn replace KERN_WARNING
> > 
> > Signed-off-by: Bo YU <tsu.yubo@gmail.com>
> 
> First off, IMO, you should not change the existing code just in order
> to make checkpatch happy about it.  That alone is not a good enough
> reason for modifying it.
> 
> If the checkpatch warning indicates an issue like broken white space
> (and I mean really broken and not lines longer than 80 chars etc),
> then that may be a reason to modify the existing code, depending.

Existing code is slightly broken.
There is currently a missing terminating newline in the
non-switch case match, when msg == NULL;

It might be simpler to initialize msg like

	const char *msg = "failed to send uevent";

and always use msg and not msg ?: in the printk.

> > changes in v2:
> > According to Joe's suggestion,drop newline from msg, otherwise
> > it can be unterminated with newline.ch
> > ---
> >  lib/kobject_uevent.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> > index 63d0816ab23b..1837765ebf01 100644
> > --- a/lib/kobject_uevent.c
> > +++ b/lib/kobject_uevent.c
> > @@ -195,12 +195,12 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
> >         enum kobject_action action;
> >         const char *action_args;
> >         struct kobj_uevent_env *env;
> > -       const char *msg = NULL, *devpath;
> > +       const char *msg = NULL;
> >         int r;
> > 
> >         r = kobject_action_type(buf, count, &action, &action_args);
> >         if (r) {
> > -               msg = "unknown uevent action string\n";
> > +               msg = "unknown uevent action string";
> >                 goto out;
> >         }
> > 
> > @@ -212,7 +212,7 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
> >         r = kobject_action_args(action_args,
> >                                 count - (action_args - buf), &env);
> >         if (r == -EINVAL) {
> > -               msg = "incorrect uevent action arguments\n";
> > +               msg = "incorrect uevent action arguments";
> 
> Second, this change is not what the changelog of your patch is talking about.
> 
> >                 goto out;
> >         }
> > 
> > @@ -223,8 +223,9 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
> >         kfree(env);
> >  out:
> >         if (r) {
> > -               devpath = kobject_get_path(kobj, GFP_KERNEL);
> > -               printk(KERN_WARNING "synth uevent: %s: %s",
> > +               char *devpath = kobject_get_path(kobj, GFP_KERNEL);
> > +
> > +               pr_warn("synth uevent: %s: %s\n",
> >                        devpath ?: "unknown device",
> >                        msg ?: "failed to send uevent");
> >                 kfree(devpath);
> > --
> > 2.11.0
> > 

