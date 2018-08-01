Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DB4C46463
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641F3208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 641F3208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389077AbeHANGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 09:06:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:37170 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389018AbeHANGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 09:06:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1D416ADBE;
        Wed,  1 Aug 2018 11:20:41 +0000 (UTC)
Date:   Wed, 1 Aug 2018 13:20:39 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     John Allen <jallen@linux.ibm.com>, n-horiguchi@ah.jp.nec.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kamezawa.hiroyu@jp.fujitsu.com, mgorman@suse.de
Subject: Re: Infinite looping observed in __offline_pages
Message-ID: <20180801112039.GJ16767@dhcp22.suse.cz>
References: <20180725181115.hmlyd3tmnu3mn3sf@p50.austin.ibm.com>
 <20180725200336.GP28386@dhcp22.suse.cz>
 <87r2jifimk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r2jifimk.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01-08-18 21:09:39, Michael Ellerman wrote:
> Michal Hocko <mhocko@kernel.org> writes:
> > On Wed 25-07-18 13:11:15, John Allen wrote:
> > [...]
> >> Does a failure in do_migrate_range indicate that the range is unmigratable
> >> and the loop in __offline_pages should terminate and goto failed_removal? Or
> >> should we allow a certain number of retrys before we
> >> give up on migrating the range?
> >
> > Unfortunatelly not. Migration code doesn't tell a difference between
> > ephemeral and permanent failures.
> 
> What's to stop an ephemeral failure happening repeatedly?

If there is a short term pin on the page that prevents the migration
then the holder of the pin should realease it and the next retry will
succeed the migration. If the page gets freed on the way then it will
not be reallocated because they are isolated already. I can only see
complete OOM to be the reason to fail allocation of the target place
as the migration failure and that is highly unlikely and sooner or later
trigger the oom killer and release some memory.

The biggest problem here is that we cannot tell ephemeral and long term
pins...
-- 
Michal Hocko
SUSE Labs
