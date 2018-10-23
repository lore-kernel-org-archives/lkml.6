Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA95C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 05:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1497C20665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 05:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1497C20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeJWNzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 09:55:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:35536 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726764AbeJWNzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 09:55:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0846BAEAC;
        Tue, 23 Oct 2018 05:34:01 +0000 (UTC)
Date:   Tue, 23 Oct 2018 07:33:59 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Arun Sudhilal <getarunks@gmail.com>
Cc:     Arun KS <arunks@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>, Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Arun Sudhilal <getarunks@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] mm: convert totalram_pages, totalhigh_pages and
 managed_pages to atomic.
Message-ID: <20181023053359.GL18839@dhcp22.suse.cz>
References: <1540229092-25207-1-git-send-email-arunks@codeaurora.org>
 <20181022181122.GK18839@dhcp22.suse.cz>
 <CABOM9Zpq41Ox8wQvsNjgfCtwuqh6CnyeW1B09DWa1TQN+JKf0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABOM9Zpq41Ox8wQvsNjgfCtwuqh6CnyeW1B09DWa1TQN+JKf0w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Trimmed CC list + Julia - there is indeed no need to CC everybody maintain a
file you are updating for the change like this]

On Tue 23-10-18 10:16:51, Arun Sudhilal wrote:
> On Mon, Oct 22, 2018 at 11:41 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Mon 22-10-18 22:53:22, Arun KS wrote:
> > > Remove managed_page_count_lock spinlock and instead use atomic
> > > variables.
> >
> 
> Hello Michal,
> > I assume this has been auto-generated. If yes, it would be better to
> > mention the script so that people can review it and regenerate for
> > comparision. Such a large change is hard to review manually.
> 
> Changes were made partially with script.  For totalram_pages and
> totalhigh_pages,
> 
> find dir -type f -exec sed -i
> 's/totalram_pages/atomic_long_read(\&totalram_pages)/g' {} \;
> find dir -type f -exec sed -i
> 's/totalhigh_pages/atomic_long_read(\&totalhigh_pages)/g' {} \;
> 
> For managed_pages it was mostly manual edits after using,
> find mm/ -type f -exec sed -i
> 's/zone->managed_pages/atomic_long_read(\&zone->managed_pages)/g' {}
> \;

I guess we should be able to use coccinelle for this kind of change and
reduce the amount of manual intervention to absolute minimum.
-- 
Michal Hocko
SUSE Labs
