Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C77C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A5620658
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0A5620658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbeIECvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 22:51:47 -0400
Received: from nautica.notk.org ([91.121.71.147]:55251 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbeIECvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 22:51:47 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 0ECB2C009; Wed,  5 Sep 2018 00:24:37 +0200 (CEST)
Date:   Wed, 5 Sep 2018 00:24:22 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: Re: [PATCH] proc/kcore: fix invalid memory access in multi-page read
 optimization
Message-ID: <20180904222422.GB17486@nautica>
References: <20180828105959.GA29204@nautica>
 <1535515447-21167-1-git-send-email-asmadeus@codewreck.org>
 <20180904180352.GA24406@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180904180352.GA24406@vader>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Omar Sandoval wrote on Tue, Sep 04, 2018:
> On Wed, Aug 29, 2018 at 06:04:07AM +0200, Dominique Martinet wrote:
> > The 'm' kcore_list item can point to kclist_head, and it is incorrect to
> > look at m->addr / m->size in this case.
> > There is no choice but to run through the list of entries for every address
> > if we did not find any entry in the previous iteration
> > 
> > Fixes: bf991c2231117 ("proc/kcore: optimize multiple page reads")
> > Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> > ---
> > 
> > I guess now I'm looking at bf991c2231117 again that it would be slightly
> > more efficient to remove the !m check and initialize m to point to
> > kclist_head like this:
> >  m = list_entry(&kclist_head, struct kcore_list, list);
> > but it feels a bit forced to me; deferring the choice to others.
> 
> Good catch! Sorry I missed this last week, Google decided this was spam
> for some reason.

Joys of self-hosted emails, it happens from time to time :/

> How about fixing it like this? One less conditional in the common
> case, no hacky list_entry :)

Good idea, I'll send a v2 in a few minutes after rebooting into it, no
reason it won't work but might as well make earth a slightly warmer
place along the way.

-- 
Dominique
