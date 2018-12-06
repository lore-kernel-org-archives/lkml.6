Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF664C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895D120989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 895D120989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbeLFIPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:15:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:41216 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727575AbeLFIPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 03:15:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D1AEBABE4;
        Thu,  6 Dec 2018 08:15:01 +0000 (UTC)
Date:   Thu, 6 Dec 2018 09:15:01 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v14 03/11] livepatch: Consolidate klp_free functions
Message-ID: <20181206081501.jkki7hg4u43fqwth@pathway.suse.cz>
References: <20181129094431.7801-1-pmladek@suse.com>
 <20181129094431.7801-4-pmladek@suse.com>
 <20181205190220.vterzx33opvvijne@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205190220.vterzx33opvvijne@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-12-05 14:02:20, Joe Lawrence wrote:
> On Thu, Nov 29, 2018 at 10:44:23AM +0100, Petr Mladek wrote:
> > The code for freeing livepatch structures is a bit scattered and tricky:
> > 
> > [ ... snip ... ]
> >
> > +static int klp_init_patch(struct klp_patch *patch)
> > +{
> > +	struct klp_object *obj;
> > +	int ret;
> > +
> > +	mutex_lock(&klp_mutex);
> > +
> > +	ret = klp_init_patch_before_free(patch);
> >  	if (ret) {
> >  		mutex_unlock(&klp_mutex);
> >  		return ret;
> >  	}
> > 
> 
> I believe klp_init_patch_before_free() accumulates more responsibilities
> later in the patchset, but I'll ask here: does it really need the
> klp_mutex since it looks to be operating only on the klp_patch, its
> objects and functions? 

I do not have a strong opinion about it.

On one hand, we are manipulating all the structures and should prevent
any parallel use. On the other hand, the rest of the code will not
touch the patch until it is added into klp_patches list or until
the sysfs interface is created.

If you think that it might cause false expectations and confusions
then I could move it out of the lock.

Well, in the final version we need to call klp_check_patch_conflict()
under the mutex.

Best Regards,
Petr
