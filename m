Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632B513F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1874120873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1874120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbeG3KuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 06:50:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:38070 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726686AbeG3KuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 06:50:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 767C4AE08;
        Mon, 30 Jul 2018 09:16:06 +0000 (UTC)
Date:   Mon, 30 Jul 2018 11:16:05 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     John Allen <jallen@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kamezawa.hiroyu@jp.fujitsu.com, n-horiguchi@ah.jp.nec.com,
        mgorman@suse.de, nfont@linux.vnet.ibm.com
Subject: Re: Infinite looping observed in __offline_pages
Message-ID: <20180730091605.GF24267@dhcp22.suse.cz>
References: <20180725181115.hmlyd3tmnu3mn3sf@p50.austin.ibm.com>
 <20180725200336.GP28386@dhcp22.suse.cz>
 <20180727173259.htdxpn4i2fxprpaj@p50.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727173259.htdxpn4i2fxprpaj@p50.austin.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 27-07-18 12:32:59, John Allen wrote:
> On Wed, Jul 25, 2018 at 10:03:36PM +0200, Michal Hocko wrote:
> > On Wed 25-07-18 13:11:15, John Allen wrote:
> > [...]
> > > Does a failure in do_migrate_range indicate that the range is unmigratable
> > > and the loop in __offline_pages should terminate and goto failed_removal? Or
> > > should we allow a certain number of retrys before we
> > > give up on migrating the range?
> > 
> > Unfortunatelly not. Migration code doesn't tell a difference between
> > ephemeral and permanent failures. We are relying on
> > start_isolate_page_range to tell us this. So the question is, what kind
> > of page is not migratable and for what reason.
> > 
> > Are you able to add some debugging to give us more information. The
> > current debugging code in the hotplug/migration sucks...
> 
> After reproducing the problem a couple times, it seems that it can occur for
> different types of pages. Running page-types on the offending page over two
> separate instances produced the following:
> 
> # tools/vm/page-types -a 307968-308224
>             flags	page-count       MB  symbolic-flags			long-symbolic-flags
> 0x0000000000000400	         1        0  __________B________________________________	buddy
> 	     total	         1        0

Huh! How come a buddy page has non zero reference count.
> 
> And the following on a separate run:
> 
> # tools/vm/page-types -a 313088-313344
>             flags	page-count       MB  symbolic-flags			long-symbolic-flags
> 0x000000000000006c	         1        0  __RU_lA____________________________________	referenced,uptodate,lru,active
>             total	         1        0

Hmm, what is the expected page count in this case? Seeing 1 doesn't look
particularly wrong.
-- 
Michal Hocko
SUSE Labs
