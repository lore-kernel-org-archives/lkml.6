Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578D4C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F372145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F372145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeJRUf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 16:35:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:52930 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726417AbeJRUf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 16:35:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C31C8AC90;
        Thu, 18 Oct 2018 12:34:37 +0000 (UTC)
Date:   Thu, 18 Oct 2018 14:34:37 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v13 07/12] livepatch: Use lists to manage patches,
 objects and functions
Message-ID: <20181018123437.msigfmpbdv2d6jvt@pathway.suse.cz>
References: <20181015123713.25868-1-pmladek@suse.com>
 <20181015123713.25868-8-pmladek@suse.com>
 <20181017203107.lirzlz2sulntauqq@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017203107.lirzlz2sulntauqq@treble>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-10-17 15:31:07, Josh Poimboeuf wrote:
> On Mon, Oct 15, 2018 at 02:37:08PM +0200, Petr Mladek wrote:
> > +static int klp_init_lists(struct klp_patch *patch)
> > +{
> > +	struct klp_object *obj;
> > +	struct klp_func *func;
> > +
> > +	INIT_LIST_HEAD(&patch->obj_list);
> > +	if (!patch->objs)
> > +		return -EINVAL;
> > +
> > +	klp_for_each_object_static(patch, obj) {
> > +		list_add(&obj->node, &patch->obj_list);
> > +
> > +		INIT_LIST_HEAD(&obj->func_list);
> > +		if (!obj->funcs)
> > +			return -EINVAL;
> > +
> > +		klp_for_each_func_static(obj, func)
> > +			list_add(&func->node, &obj->func_list);
> > +	}
> > +
> > +	return 0;
> > +}
> 
> It may be ever-so-slightly better to use list_add_tail() instead of
> list_add(), so the list order matches the array order.  I doubt the
> ordering really matters, but you never know.  It could for example make
> debugging a little easier in some scenarios.

Makes sense. Will do in v14.

Best Regareds,
Petr
