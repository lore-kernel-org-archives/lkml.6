Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C37C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F24220844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F24220844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387511AbeHAIr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 04:47:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:32900 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733146AbeHAIrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 04:47:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C7690AEBC;
        Wed,  1 Aug 2018 07:03:12 +0000 (UTC)
Date:   Wed, 1 Aug 2018 09:03:12 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     jing xia <jing.xia.mail@gmail.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, agk@redhat.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: dm bufio: Reduce dm_bufio_lock contention
Message-ID: <20180801070312.GC16767@dhcp22.suse.cz>
References: <1528790608-19557-1-git-send-email-jing.xia@unisoc.com>
 <20180612212007.GA22717@redhat.com>
 <alpine.LRH.2.02.1806131001250.15845@file01.intranet.prod.int.rdu2.redhat.com>
 <CAN=25QMQiJ7wvfvYvmZnEnrkeb-SA7_hPj+N2RnO8y-aVO8wOQ@mail.gmail.com>
 <20180614073153.GB9371@dhcp22.suse.cz>
 <CAN=25QNrENVFbb9UAAAJJqKsEeMY+qNs5cQA4EGwgB2dMYTZug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN=25QNrENVFbb9UAAAJJqKsEeMY+qNs5cQA4EGwgB2dMYTZug@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01-08-18 10:48:00, jing xia wrote:
> We reproduced this issue again and found out the root cause.
> dm_bufio_prefetch() with dm_bufio_lock enters the direct reclaim and
> takes a long time to do the soft_limit_reclaim, because of the huge
> number of memory excess of the memcg.
> Then, all the task who do shrink_slab() wait for  dm_bufio_lock.
> 
> Any suggestions for this?Thanks.

Do not use soft limit?
-- 
Michal Hocko
SUSE Labs
