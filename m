Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E158C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8972064E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D8972064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbeJIS0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:26:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:47190 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbeJIS0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:26:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CAD24AF6F;
        Tue,  9 Oct 2018 11:10:06 +0000 (UTC)
Date:   Tue, 9 Oct 2018 13:10:05 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     ytk.lee@samsung.com, "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm, oom_adj: avoid meaningless loop to find processes
 sharing mm
Message-ID: <20181009111005.GK8528@dhcp22.suse.cz>
References: <67eedc4c-7afa-e845-6c88-9716fd820de6@i-love.sakura.ne.jp>
 <af7ae9c4-d7f1-69af-58fa-ec6949161f5b@I-love.SAKURA.ne.jp>
 <20181008011931epcms1p82dd01b7e5c067ea99946418bc97de46a@epcms1p8>
 <20181008061407epcms1p519703ae6373a770160c8f912c7aa9521@epcms1p5>
 <CGME20181008011931epcms1p82dd01b7e5c067ea99946418bc97de46a@epcms1p2>
 <20181008083855epcms1p20e691e5a001f3b94b267997c24e91128@epcms1p2>
 <f5bdf4a7-e491-1cda-590c-792526f49050@i-love.sakura.ne.jp>
 <20181009063541.GB8528@dhcp22.suse.cz>
 <20181009075015.GC8528@dhcp22.suse.cz>
 <df4b029c-16b4-755f-2672-d7ec116f78ba@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df4b029c-16b4-755f-2672-d7ec116f78ba@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 09-10-18 19:00:44, Tetsuo Handa wrote:
> On 2018/10/09 16:50, Michal Hocko wrote:
[...]
> >                               Well, that is unfortunate indeed and it
> > breaks the OOM_SCORE_ADJ_MIN contract. There are basically two ways here
> > 1) do not care and encourage users to use a saner way to set
> > OOM_SCORE_ADJ_MIN because doing that externally is racy anyway e.g.
> > setting it before [v]fork & exec. Btw. do we know about an actual user
> > who would care?
> 
> I'm not talking about [v]fork & exec. Why are you talking about [v]fork & exec ?

Because that is the only raceless way to set your oom_score_adj.

> > 2) add OOM_SCORE_ADJ_MIN and do not kill tasks sharing mm and do not
> > reap the mm in the rare case of the race.
> 
> That is no problem. The mistake we made in 4.6 was that we updated oom_score_adj
> to -1000 (and allowed unprivileged users to OOM-lockup the system).

I do not follow.

-- 
Michal Hocko
SUSE Labs
