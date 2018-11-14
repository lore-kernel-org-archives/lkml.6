Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF3BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C0C208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C0C208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733233AbeKOCFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:05:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:51758 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726295AbeKOCFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 21:05:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3C6E4B007;
        Wed, 14 Nov 2018 16:01:48 +0000 (UTC)
Date:   Wed, 14 Nov 2018 17:01:47 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ben Woodard <woodard@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] exec: increase BINPRM_BUF_SIZE to 256
Message-ID: <20181114160147.GD23419@dhcp22.suse.cz>
References: <20181112160931.GA28463@redhat.com>
 <20181112160956.GA28472@redhat.com>
 <20181112155248.4dde2613979f4c176565629e@linux-foundation.org>
 <20181113165557.GG30990@redhat.com>
 <20181113124305.73b8ac9e5a2ef9b18d3444b2@linux-foundation.org>
 <20181114155413.GC13885@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114155413.GC13885@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14-11-18 16:54:14, Oleg Nesterov wrote:
> On 11/13, Andrew Morton wrote:
> >
> > On Tue, 13 Nov 2018 17:55:58 +0100 Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > > > However it would be basically cost-free to increase
> > > > BINPRM_BUF_SIZE up to the point where sizeof(struct linux_binprm) ==
> > > > PAGE_SIZE?
> > >
> > > I don't think we should take sizeof(struct linux_binprm) into account, the
> > > new members can come at any time and we can never decrease BINPRM_BUF_SIZE.
> >
> > My main point is..  why not make BINPRM_BUF_SIZE a lot larger than 256?
> 
> Of course we can make it larger. And of course 256 is just another silly/random
> value. Currently it seems to work, but if we have another bug report we should
> probably rework load_script() to use vmalloc()'ed buffer. Perhaps we should do
> this right now and I am just too lazy.

I would rather not over-engineer this after a first bug. Even 256 path
seems like a torturing to me ;)

We would have to have some limit anyway and arbitrary value might just
not work for somebody crazy enough. Making it a part of of rlimit sounds
like opening a cane of worms to me.
-- 
Michal Hocko
SUSE Labs
