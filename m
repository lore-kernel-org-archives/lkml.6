Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8C2C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E630221480
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E630221480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbeJRTle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 15:41:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:46054 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727439AbeJRTle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 15:41:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BE297B098;
        Thu, 18 Oct 2018 11:40:55 +0000 (UTC)
Date:   Thu, 18 Oct 2018 13:40:55 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v13 04/12] livepatch: Consolidate klp_free functions
Message-ID: <20181018114055.zxusn2w3lt6xx6fk@pathway.suse.cz>
References: <20181015123713.25868-1-pmladek@suse.com>
 <20181015123713.25868-5-pmladek@suse.com>
 <20181017182254.3s3fzb72u2uazdfa@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017182254.3s3fzb72u2uazdfa@treble>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-10-17 13:22:54, Josh Poimboeuf wrote:
> On Mon, Oct 15, 2018 at 02:37:05PM +0200, Petr Mladek wrote:
> > @@ -637,6 +647,7 @@ static int klp_init_patch(struct klp_patch *patch)
> >  	mutex_lock(&klp_mutex);
> >  
> >  	patch->enabled = false;
> > +	INIT_LIST_HEAD(&patch->list);
> 
> Is this a bug fix?  If so, it should go in a separate patch.  I'm
> wondering how this worked before.

It is not a bug fix. It was not needed before because
klp_register_patch() did not checked this field when failed.

But this patch started to use the generic
klp_free_patch_start()/klp_free_patch_finish() in both
klp_unregister_patch() and in klp_init_patch() error patch.
Therefore we need to have a valid value from the beginning.

Best Regards,
Petr
