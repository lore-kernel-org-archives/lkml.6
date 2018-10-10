Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E47C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F96A20835
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F96A20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeJJQU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:20:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:48546 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727168AbeJJQU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:20:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AC2A5B013;
        Wed, 10 Oct 2018 08:59:46 +0000 (UTC)
Date:   Wed, 10 Oct 2018 10:59:45 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+77e6b28a7a7106ad0def@syzkaller.appspotmail.com>,
        hannes@cmpxchg.org, akpm@linux-foundation.org, guro@fb.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rientjes@google.com,
        syzkaller-bugs@googlegroups.com, yang.s@alibaba-inc.com
Subject: Re: INFO: rcu detected stall in shmem_fault
Message-ID: <20181010085945.GC5873@dhcp22.suse.cz>
References: <000000000000dc48d40577d4a587@google.com>
 <201810100012.w9A0Cjtn047782@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201810100012.w9A0Cjtn047782@www262.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 10-10-18 09:12:45, Tetsuo Handa wrote:
> syzbot is hitting RCU stall due to memcg-OOM event.
> https://syzkaller.appspot.com/bug?id=4ae3fff7fcf4c33a47c1192d2d62d2e03efffa64

This is really interesting. If we do not have any eligible oom victim we
simply force the charge (allow to proceed and go over the hard limit)
and break the isolation. That means that the caller gets back to running
and realease all locks take on the way. I am wondering how come we are
seeing the RCU stall. Whole is holding the rcu lock? Certainly not the
charge patch and neither should the caller because you have to be in a
sleepable context to trigger the OOM killer. So there must be something
more going on.

> What should we do if memcg-OOM found no killable task because the allocating task
> was oom_score_adj == -1000 ? Flooding printk() until RCU stall watchdog fires 
> (which seems to be caused by commit 3100dab2aa09dc6e ("mm: memcontrol: print proper
> OOM header when no eligible victim left") because syzbot was terminating the test
> upon WARN(1) removed by that commit) is not a good behavior.

We definitely want to inform about ineligible oom victim. We might
consider some rate limiting for the memcg state but that is a valuable
information to see under normal situation (when you do not have floods
of these situations).
-- 
Michal Hocko
SUSE Labs
