Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EABDC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6C520645
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD6C520645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbeLNJcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:32:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:45358 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727579AbeLNJcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 04:32:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 864D2AD02;
        Fri, 14 Dec 2018 09:32:02 +0000 (UTC)
Date:   Fri, 14 Dec 2018 10:32:01 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v14 03/11] livepatch: Consolidate klp_free functions
Message-ID: <20181214093201.otrr7irvigrhwlzu@pathway.suse.cz>
References: <20181129094431.7801-1-pmladek@suse.com>
 <20181129094431.7801-4-pmladek@suse.com>
 <20181213221037.qaxd5jswdrbv5oxz@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213221037.qaxd5jswdrbv5oxz@treble>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-12-13 16:10:37, Josh Poimboeuf wrote:
> On Thu, Nov 29, 2018 at 10:44:23AM +0100, Petr Mladek wrote:
> > +static void klp_free_funcs(struct klp_object *obj)
> >  {
> >  	struct klp_func *func;
> >  
> > -	for (func = obj->funcs; func->old_name && func != limit; func++)
> > -		kobject_put(&func->kobj);
> > +	klp_for_each_func(obj, func) {
> > +		/* Might be called from klp_init_patch() error path. */
> > +		if (func->kobj_alive) {
> > +			func->kobj_alive = false;
> > +			kobject_put(&func->kobj);
> > +		}
> 
> Why does it set 'kobj_alive' to false?  The value will never be read
> again anyway, right?

You are right. I'll remove it in v15.

My intention was that it might signalize that the kobject is being
freed and eventually affect the behavior of sysfs-related callbacks.
But in reality, it should be handled by some per-patch flag instead
of a per-object one.


> Also, the name isn't quite right.  The kobject is technically still
> alive here, and may even continue to be alive after the kobject_put(),
> if there's a sysfs reference to it somewhere.
> 
> Maybe it should be called something like 'kobj_initialized' instead.
> Then it doesn't ever need to be set to false -- unless I'm missing
> something.

This might cause confusion with kobj.state_initialized. This internal
kobject flag is set when the reference counter is initialized. But
it is true even before kobject_add() is called.

We need a flag that signalizes that kobject_add() succeeded and we
can and must call kobject_put().

What about calling it 'kobj_added'?

Best Regards,
Petr
