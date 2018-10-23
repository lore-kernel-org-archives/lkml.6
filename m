Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E9CC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E7720813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E7720813
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbeJWOfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 10:35:08 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:24761
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726764AbeJWOfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 10:35:08 -0400
X-IronPort-AV: E=Sophos;i="5.54,415,1534802400"; 
   d="scan'208";a="283003085"
Received: from 30.9-255-62.static.virginmediabusiness.co.uk (HELO [172.16.7.66]) ([62.255.9.30])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 08:13:10 +0200
Date:   Tue, 23 Oct 2018 07:13:09 +0100 (BST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Michal Hocko <mhocko@kernel.org>
cc:     Arun Sudhilal <getarunks@gmail.com>,
        Arun KS <arunks@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>, Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: convert totalram_pages, totalhigh_pages and
 managed_pages to atomic.
In-Reply-To: <20181023053359.GL18839@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1810230711220.2343@hadrien>
References: <1540229092-25207-1-git-send-email-arunks@codeaurora.org> <20181022181122.GK18839@dhcp22.suse.cz> <CABOM9Zpq41Ox8wQvsNjgfCtwuqh6CnyeW1B09DWa1TQN+JKf0w@mail.gmail.com> <20181023053359.GL18839@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 23 Oct 2018, Michal Hocko wrote:

> [Trimmed CC list + Julia - there is indeed no need to CC everybody maintain a
> file you are updating for the change like this]
>
> On Tue 23-10-18 10:16:51, Arun Sudhilal wrote:
> > On Mon, Oct 22, 2018 at 11:41 PM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Mon 22-10-18 22:53:22, Arun KS wrote:
> > > > Remove managed_page_count_lock spinlock and instead use atomic
> > > > variables.
> > >
> >
> > Hello Michal,
> > > I assume this has been auto-generated. If yes, it would be better to
> > > mention the script so that people can review it and regenerate for
> > > comparision. Such a large change is hard to review manually.
> >
> > Changes were made partially with script.  For totalram_pages and
> > totalhigh_pages,
> >
> > find dir -type f -exec sed -i
> > 's/totalram_pages/atomic_long_read(\&totalram_pages)/g' {} \;
> > find dir -type f -exec sed -i
> > 's/totalhigh_pages/atomic_long_read(\&totalhigh_pages)/g' {} \;
> >
> > For managed_pages it was mostly manual edits after using,
> > find mm/ -type f -exec sed -i
> > 's/zone->managed_pages/atomic_long_read(\&zone->managed_pages)/g' {}
> > \;
>
> I guess we should be able to use coccinelle for this kind of change and
> reduce the amount of manual intervention to absolute minimum.

Coccinelle looks like it would be desirable, especially in case the word
zone is not always used.

Arun, please feel free to contact me if you want to try it and need help.

julia
