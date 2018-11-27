Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A624C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B3A2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B3A2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731044AbeK1D1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:27:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:59276 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726768AbeK1D1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:27:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8BB4AAB6D;
        Tue, 27 Nov 2018 16:29:17 +0000 (UTC)
Date:   Tue, 27 Nov 2018 17:29:16 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, "Kirill A . Shutemov" <kirill@shutemov.name>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] mm: warn only once if page table misaccounting is
 detected
Message-ID: <20181127162916.GB6923@dhcp22.suse.cz>
References: <20181127083603.39041-1-heiko.carstens@de.ibm.com>
 <20181127131916.GX12455@dhcp22.suse.cz>
 <20181127143638.GE3625@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127143638.GE3625@osiris>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27-11-18 15:36:38, Heiko Carstens wrote:
> On Tue, Nov 27, 2018 at 02:19:16PM +0100, Michal Hocko wrote:
> > On Tue 27-11-18 09:36:03, Heiko Carstens wrote:
> > > Use pr_alert_once() instead of pr_alert() if page table misaccounting
> > > has been detected.
> > > 
> > > If this happens once it is very likely that there will be numerous
> > > other occurrence as well, which would flood dmesg and the console with
> > > hardly any added information. Therefore print the warning only once.
> > 
> > Have you actually experience a flood of these messages? Is one per mm
> > message really that much?
> 
> Yes, I did. Since in this case all compat processes caused the message
> to appear, I saw thousands of these messages.

This means something went colossally wrong and seeing an avalanche of
messages might be actually helpful because you can at least see the
pattern. I wonder whether the underlying issue would be obvious from a
single instance.

Maybe we want ratelimit instead?
 
> > If yes why rss counters do not exhibit the same problem?
> 
> No rss counter messages appeared. Or do you suggest that the other
> pr_alert() within check_mm() should also be changed?

Whatever we go with (and I do not have a strong opinion here) we should
be consistent I believe.

-- 
Michal Hocko
SUSE Labs
