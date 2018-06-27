Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCC6C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F8B25EF5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F8B25EF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754802AbeF0PPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:15:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34408 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753013AbeF0PPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:15:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6A9CB400ADC2;
        Wed, 27 Jun 2018 15:15:46 +0000 (UTC)
Received: from treble (ovpn-120-92.rdu2.redhat.com [10.10.120.92])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3953C1C701;
        Wed, 27 Jun 2018 15:15:46 +0000 (UTC)
Date:   Wed, 27 Jun 2018 10:15:44 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Allan Xavier <allan.x.xavier@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: Fix GCC 8 cold function processing without
 -freorder-functions
Message-ID: <20180627151544.wieelchsffq3gjel@treble>
References: <20180626162045.25516-1-allan.x.xavier@oracle.com>
 <20180626164338.GH2458@hirez.programming.kicks-ass.net>
 <3a9a1cfa-4357-264e-3333-220a7f83a51d@oracle.com>
 <20180626184405.hsbuuq5eo7qzicoi@treble>
 <0556953a-3e9f-ff22-3514-b40ca7b5de1b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0556953a-3e9f-ff22-3514-b40ca7b5de1b@oracle.com>
User-Agent: NeoMutt/20180323
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 27 Jun 2018 15:15:46 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 27 Jun 2018 15:15:46 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 10:35:03AM +0100, Allan Xavier wrote:
> Looks good overall, just one comment.
> 
> On 26/06/18 19:44, Josh Poimboeuf wrote:
> > +			/*
> > +			 * Unfortunately, -fnoreorder-functions puts the child
> > +			 * inside the parent.  Remove the overlap so we can
> > +			 * have sane assumptions.
> > +			 */
> > +			if (sym->sec == pfunc->sec &&
> > +			    sym->offset >= pfunc->offset &&
> > +			    sym->offset < pfunc->offset + pfunc->len &&
> > +			    sym->offset + sym->len == pfunc->offset + pfunc->len) {
> > +				pfunc->len -= sym->len;
> 
> It's a bit of a nit but I'd say you could drop the third condition of the if
> since sym->offset would have to be less than pfunc->offset + pfunc->len for the
> fourth condition to ever be true. The only situation it would have caught is
> where sym->len == 0, which I think (hope?) is reasonable to assume wont happen
> and wouldn't have had an effect on pfunc->len anyway.
> 
> if (sym->sec == pfunc->sec &&
>     sym->offset >= pfunc->offset &&
>     sym->offset + sym->len == pfunc->offset + pfunc->len)

Thanks, will do.

-- 
Josh
