Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012B7C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B613F205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B613F205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbeJKT3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 15:29:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:44118 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727182AbeJKT3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 15:29:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 20EFAACE1;
        Thu, 11 Oct 2018 12:02:11 +0000 (UTC)
Date:   Thu, 11 Oct 2018 14:02:09 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@android.com, minchan@google.com, hughd@google.com,
        lokeshgidra@google.com, Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] mm: Speed up mremap on large regions
Message-ID: <20181011120209.GV5873@dhcp22.suse.cz>
References: <20181009201400.168705-1-joel@joelfernandes.org>
 <20181009220222.26nzajhpsbt7syvv@kshutemo-mobl1>
 <20181009230447.GA17911@joelaf.mtv.corp.google.com>
 <20181010100011.6jqjvgeslrvvyhr3@kshutemo-mobl1>
 <20181011004618.GA237677@joelaf.mtv.corp.google.com>
 <20181011081719.77f7ihcy6mu2vkkc@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011081719.77f7ihcy6mu2vkkc@kshutemo-mobl1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11-10-18 11:17:19, Kirill A. Shutemov wrote:
[...]
> > The thing is its quite a lot of change, I wrote a coccinelle script to do it
> > tree wide, following is the diffstat:
> >  48 files changed, 91 insertions(+), 124 deletions(-)
> > 
> > Imagine then having to add the address argument back in the future in case
> > its ever needed. Is it really worth doing it?
> 
> This is the point. It will get us chance to consider if the optimization
> is still safe.
> 
> And it shouldn't be hard: [partially] revert the commit and get the address
> back into the interface.

I agree with Kirill. This will also remove quite a lot of pointless
code and make it more clear. It is impossible to see what is the address
good for and I couldn't really trace back to commit introducing it to
guess that either. So making sure nobody does anything with it is a good
pre-requisite to make further changes on top.

The chage itself is really interesting, I still have to digest it
completely to see there are no cornercases but from a quick glance it
looks reasonable.
-- 
Michal Hocko
SUSE Labs
