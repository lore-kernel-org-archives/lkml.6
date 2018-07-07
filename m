Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466E8C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 16:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC45E20844
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 16:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC45E20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754327AbeGGQvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 12:51:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57820 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754246AbeGGQvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 12:51:04 -0400
Received: from localhost (unknown [37.170.108.176])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 96212DC9;
        Sat,  7 Jul 2018 16:51:03 +0000 (UTC)
Date:   Sat, 7 Jul 2018 18:51:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Stanley <joel@jms.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] drivers: core: Don't try to use a dead glue_dir
Message-ID: <20180707165100.GD16279@kroah.com>
References: <c40fe912fe008b1b531a3867e8784ed79d68023e.camel@kernel.crashing.org>
 <CA+55aFxR0qg0yY-NWnH0DDruVWw8qRqp8=CRLq13p=TyxosJKw@mail.gmail.com>
 <828fb935c0cd04e74a09b8ed2b78aca405d7c5b2.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <828fb935c0cd04e74a09b8ed2b78aca405d7c5b2.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 12:21:51PM +1000, Benjamin Herrenschmidt wrote:
> Under some circumstances (such as when using kobject debugging)
> a gluedir whose kref is 0 might remain in the class kset for
> a long time. The reason is that we don't actively remove glue
> dirs when they become empty, but instead rely on the implicit
> removal done by kobject_release(), which can happen some amount
> of time after the last kobject_put().
> 
> Using such a dead object is a bad idea and will lead to warnings
> and crashes.
> 
> Unfortunately that can happen in get_device_parent() if the
> last child of a glue dir was removed and a new one added
> before the glue dir gets fully released().
> 
> This prevents this by making get_device_parent() only "find"
> a glue dir whose refcount is non-0.
> 
> While this fixes the crash, it doesn't fully fix the problem,
> instead the race will now result in an error attempting to
> use a duplicate file name in sysfs. A fix for that will come
> separately.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> (Adding lkml, I just realized I completely forgot to CC it in
> the first place on this whole conversation, blame the 1am debugging
> session)
> 
>  drivers/base/core.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index b610816eb887..e9eff2099896 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1517,11 +1517,13 @@ static struct kobject *get_device_parent(struct device *dev,
>  
>  		/* find our class-directory at the parent and reference it */
>  		spin_lock(&dev->class->p->glue_dirs.list_lock);
> -		list_for_each_entry(k, &dev->class->p->glue_dirs.list, entry)
> +		list_for_each_entry(k, &dev->class->p->glue_dirs.list, entry) {
>  			if (k->parent == parent_kobj) {
> -				kobj = kobject_get(k);
> -				break;
> +				kobj = kobject_get_unless_zero(k);
> +				if (kobj)
> +					break;

A parent directory _should_ not ever be able to be removed before the
object being removed was, as we should have had a reference to it,
right?  So I don't see how this can get hit "in real life".

Yes, enabling kobject debugging does keep objects around for a long time
in order to try to help figure out where people are messing up their
usage of them.  What subsystem is doing this in a way that causes
problems here?  Shouldn't we fix that up instead?

thanks,

greg k-h
