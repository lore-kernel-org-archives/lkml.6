Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BC4C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160EF21A41
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 160EF21A41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932487AbeGCCh7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 22:37:59 -0400
Received: from gate.crashing.org ([63.228.1.57]:49107 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932301AbeGCCh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 22:37:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w632bk8h017739;
        Mon, 2 Jul 2018 21:37:47 -0500
Message-ID: <2be488e0134d8efb66ecc8636ed686ca4225bd62.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] drivers: core: Remove glue dirs from sysfs earlier
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Stanley <joel@jms.id.au>
Date:   Tue, 03 Jul 2018 12:37:46 +1000
In-Reply-To: <CA+55aFy927VYjFDwe9Zy_M+XFNxSFh2HLFcQ25pm8AMNXBUoQA@mail.gmail.com>
References: <c40fe912fe008b1b531a3867e8784ed79d68023e.camel@kernel.crashing.org>
         <CA+55aFxR0qg0yY-NWnH0DDruVWw8qRqp8=CRLq13p=TyxosJKw@mail.gmail.com>
         <edc7b03b9550ddcf1291ebf5a6dafd24f4455c23.camel@kernel.crashing.org>
         <CA+55aFxS7OVEN5XrxceC5ibz780mhn-qRa50w1gVFjsz2JjMbw@mail.gmail.com>
         <7eb06b499f2be366cf68c6b6588b16c603e6a567.camel@kernel.crashing.org>
         <CA+55aFyS1bdmETHUYEejecOcG5MAjGCAbkr-M5iphJYfrj2oLA@mail.gmail.com>
         <675c0752ea41c9dc52c2a4b69f09fb9746207de3.camel@kernel.crashing.org>
         <CA+55aFxqUyACDPBL4trTfGyJudg8P7YGazVGUW7-UaNFJiwZRQ@mail.gmail.com>
         <36fb9c9f873629abb7bf3758033cce00e463f768.camel@kernel.crashing.org>
         <CA+55aFzUhe7j+6XL_BB+gvSnCvMCOePZhanTBk5tq=zqvFFWSw@mail.gmail.com>
         <d56f1c255f7caa913ad77a174e1e3bde08043ac0.camel@kernel.crashing.org>
         <0dc3c0632b1821bd07abdf0224ccd9f32a4f250d.camel@kernel.crashing.org>
         <CA+55aFyzYXSTTuVoGfVeC574-7i0zp3q39RTsiPn3GoRceuwAQ@mail.gmail.com>
         <213dd8fa77629e04277e68552068581da881e7e4.camel@kernel.crashing.org>
         <CA+55aFy927VYjFDwe9Zy_M+XFNxSFh2HLFcQ25pm8AMNXBUoQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-02 at 19:15 -0700, Linus Torvalds wrote:
> On Mon, Jul 2, 2018 at 5:57 PM Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > 
> > I'll have a look see if I can find a way to check that the sysfs dir is
> > empty without adding that childcount, that would at least alleviate
> > some of your objection, and would probably make the patch
> > smaller/simpler.
> 
> That would definitely make me happier.
> 
> Right now we already remove the actual device node sysfs associations
> synchronously with "kobject_del()" (even if it still then stays around
> as a kobject), and that does the remove for the object itself - just
> not the glue directory.
> 
> If we then just did a "if glue dir is empty, delete the glue dir too"
> in cleanup_glue_dir(), at least ther patch would be prettier.
> 
> I *think* that should be easy. Maybe. Something almost, but not quite,
> entirely unlike the below UNTESTED hack?

Yes, something like that. I have a bunch of other things I need to
attend to today, so I might not come up with a patch before some time
tomorrow but I'll have a look.
 
> It's whitespace-damaged on purpose. It's probably broken shit. DO NOT
> USE UNDER ANY CIRCUMSTANCES.  Think of it more as a "something like
> this might work, but probably doesn't". Maybe it gives you an idea,
> although that idea might be "Linus has finally lost it".
> 
> I suspect it's broken because kernfs has this notion of inactive
> nodes, so just testing for the rbtree being empty is probably wrong. I
> think maybe it needs to test for there not being any active nodes, but
> then you'd need the kernfs_mutex etc, so that would make things much
> worse.

There's also a "subdirs" in kernfs_node which we could use. That's a
bit ugly because it only account directories but we happen to know that
the gluedirs only contain directories, so it would work fine in
practice for that case.

> I really haven't touched the kernfs code much, thus the "this may be
> complete and utter garbage" warning.
> 
> Adding Tejun to the participants, he should know. Or Greg, who has
> been silent, presumably because he's still getting over his crazy
> travels.

Cheers,
Ben.

>                 Linus
> 
> ---
> 
>     --- a/drivers/base/core.c
>    +++ b/drivers/base/core.c
>    @@ -1585,6 +1585,12 @@ static inline struct kobject
> *get_glue_dir(struct device *dev)
>         return dev->kobj.parent;
>     }
> 
>    +static inline bool has_children(struct kobject *dir)
>    +{
>    +    struct kernfs_node *kn = dir->sd;
>    +    return kn && kn->dir.children.rb_node;
>    +}
>    +
>     /*
>      * make sure cleaning up dir as the last step, we need to make
>      * sure .release handler of kobject is run with holding the
>    @@ -1597,6 +1603,10 @@ static void cleanup_glue_dir(struct device
> *dev, struct kobject *glue_dir)
>                 return;
> 
>         mutex_lock(&gdp_mutex);
>    -    kobject_put(glue_dir);
>    +    if (has_children(glue_dir))
>    +            kobject_put(glue_dir);
>    +    else
>    +            kobject_del(glue_dir);
>         mutex_unlock(&gdp_mutex);
>     }
