Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC3DC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361F024768
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361F024768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934391AbeFVSrA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 14:47:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33528 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933878AbeFVSq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 14:46:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6194E87AAC;
        Fri, 22 Jun 2018 18:46:59 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 43D352026D6C;
        Fri, 22 Jun 2018 18:46:59 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w5MIkxMG015041;
        Fri, 22 Jun 2018 14:46:59 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w5MIkwf7015037;
        Fri, 22 Jun 2018 14:46:58 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 22 Jun 2018 14:46:58 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     jing xia <jing.xia.mail@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>, agk@redhat.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: dm bufio: Reduce dm_bufio_lock contention
In-Reply-To: <20180622131013.GA10465@dhcp22.suse.cz>
Message-ID: <alpine.LRH.2.02.1806221445310.2717@file01.intranet.prod.int.rdu2.redhat.com>
References: <20180615073201.GB24039@dhcp22.suse.cz> <alpine.LRH.2.02.1806150724260.15022@file01.intranet.prod.int.rdu2.redhat.com> <20180615115547.GH24039@dhcp22.suse.cz> <alpine.LRH.2.02.1806150832100.26650@file01.intranet.prod.int.rdu2.redhat.com>
 <20180615130925.GI24039@dhcp22.suse.cz> <alpine.LRH.2.02.1806181003560.4201@file01.intranet.prod.int.rdu2.redhat.com> <20180619104312.GD13685@dhcp22.suse.cz> <alpine.LRH.2.02.1806191228110.25656@file01.intranet.prod.int.rdu2.redhat.com>
 <20180622090151.GS10465@dhcp22.suse.cz> <alpine.LRH.2.02.1806220828040.8072@file01.intranet.prod.int.rdu2.redhat.com> <20180622131013.GA10465@dhcp22.suse.cz>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 22 Jun 2018 18:46:59 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 22 Jun 2018 18:46:59 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Jun 2018, Michal Hocko wrote:

> On Fri 22-06-18 08:44:52, Mikulas Patocka wrote:
> > On Fri, 22 Jun 2018, Michal Hocko wrote:
> [...]
> > > Why? How are you going to audit all the callers that the behavior makes
> > > sense and moreover how are you going to ensure that future usage will
> > > still make sense. The more subtle side effects gfp flags have the harder
> > > they are to maintain.
> > 
> > I did audit them - see the previous email in this thread: 
> > https://www.redhat.com/archives/dm-devel/2018-June/thread.html
> 
> I do not see any mention about throttling expectations for those users.
> You have focused only on the allocation failure fallback AFAIR

How should the callers be analyzed with respect to throttling?

Mikulas
