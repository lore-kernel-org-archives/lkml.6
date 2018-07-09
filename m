Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA61BC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA40208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA40208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933344AbeGIXup (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 19:50:45 -0400
Received: from gate.crashing.org ([63.228.1.57]:56090 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932847AbeGIXul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 19:50:41 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w69NoTeL024859;
        Mon, 9 Jul 2018 18:50:32 -0500
Message-ID: <95b22758709c7e3bec2e9b3e31a94333b363a353.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/2] drivers: core: Don't try to use a dead glue_dir
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Stanley <joel@jms.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 10 Jul 2018 09:50:29 +1000
In-Reply-To: <20180707165100.GD16279@kroah.com>
References: <c40fe912fe008b1b531a3867e8784ed79d68023e.camel@kernel.crashing.org>
         <CA+55aFxR0qg0yY-NWnH0DDruVWw8qRqp8=CRLq13p=TyxosJKw@mail.gmail.com>
         <828fb935c0cd04e74a09b8ed2b78aca405d7c5b2.camel@kernel.crashing.org>
         <20180707165100.GD16279@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-07-07 at 18:51 +0200, Greg Kroah-Hartman wrote:
> 
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index b610816eb887..e9eff2099896 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -1517,11 +1517,13 @@ static struct kobject *get_device_parent(struct device *dev,
> >  
> >  		/* find our class-directory at the parent and reference it */
> >  		spin_lock(&dev->class->p->glue_dirs.list_lock);
> > -		list_for_each_entry(k, &dev->class->p->glue_dirs.list, entry)
> > +		list_for_each_entry(k, &dev->class->p->glue_dirs.list, entry) {
> >  			if (k->parent == parent_kobj) {
> > -				kobj = kobject_get(k);
> > -				break;
> > +				kobj = kobject_get_unless_zero(k);
> > +				if (kobj)
> > +					break;
> 
> A parent directory _should_ not ever be able to be removed before the
> object being removed was, as we should have had a reference to it,
> right?  So I don't see how this can get hit "in real life".
> 
> Yes, enabling kobject debugging does keep objects around for a long time
> in order to try to help figure out where people are messing up their
> usage of them.  What subsystem is doing this in a way that causes
> problems here?  Shouldn't we fix that up instead?

The broken subsystem is the driver core itself :-) See the descriptions
here and in patch 2/2.

Note: This is a more generic problem with ksets vs relying on the magic
sysfs cleanup happening in kobject_release().

Any kobject that is a member of a kset and doesn't get explicitely
removed from sysfs with kobject_del() prior to dropping the last
reference with kobject_put() (and thus relies instead on the automatic
cleanup done by kobject_release()) will be exposed to the race:

The last kobject_put() will drop the refcount to 0 while the object is
still in the kset. Only some amount of time later (which can be very
short or very long if you enable kobject debugging), will
kobject_release() take it out of sysfs and out of the kset.

Thus the object will be visible, with a 0 refcount, to anything that
"walks" the kset during that period.

This is exactly what happens with the gluedirs in the device core, but
it could happen elsewhere for all I know.

Cheers,
Ben.
