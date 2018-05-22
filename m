Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753357AbeEVWyF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 18:54:05 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33915 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753036AbeEVWyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 18:54:03 -0400
X-Google-Smtp-Source: AB8JxZoFxhmCvMUCqEAb2GaHzO9l5gDopnXTI4yUcZbiv5NoeEjo5VJgZ4mFMnWB1BileTNwa8AcQQ==
Date: Tue, 22 May 2018 15:54:01 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Michal Hocko <mhocko@kernel.org>
cc: =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        aarcange@redhat.com, penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Wind Yu <yuzhoujian@didichuxing.com>
Subject: Re: [PATCH] Add the memcg print oom info for system oom
In-Reply-To: <20180522063742.GE20020@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1805221542540.83718@chino.kir.corp.google.com>
References: <1526540428-12178-1-git-send-email-ufo19890607@gmail.com> <20180517071140.GQ12670@dhcp22.suse.cz> <CAHCio2gOLnj4NpkFrxpYVygg6ZeSeuwgp2Lwr6oTHRxHpbmcWw@mail.gmail.com> <20180517102330.GS12670@dhcp22.suse.cz> <alpine.DEB.2.21.1805211405300.41872@chino.kir.corp.google.com>
 <20180522063742.GE20020@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2018, Michal Hocko wrote:

> > I've had success with defining a single line output the includes the 
> > CONSTRAINT_* of the oom kill, the origin and kill memcgs, the thread name, 
> > pid, and uid.  On system oom kills, origin and kill memcgs are left empty.
> > 
> > oom-kill constraint=CONSTRAINT_* origin_memcg=<memcg> kill_memcg=<memcg> task=<comm> pid=<pid> uid=<uid>
> > 
> > Perhaps we should introduce a single line output that will be backwards 
> > compatible that includes this information?
> 
> I do not have a strong preference here. We already print cpuset on its
> own line and we can do the same for the memcg.
> 

Yes, for both the memcg that has reached its limit (origin_memcg) and the 
memcg the killed process is attached to (kill_memcg).

It's beneficial to have a single-line output to avoid any printk 
interleaving or ratelimiting that includes the constraint, comm, and at 
least pid.  (We include uid simply to find oom kills of root processes.)

We already have all this information, including cpuset, cpuset nodemask, 
and allocation nodemask for mempolicy ooms.  The only exception appears to 
be the kill_memcg for CONSTRAINT_NONE and for it to be emitted in a way 
that can't be interleaved or suppressed.

Perhaps we can have this?

oom-kill constraint=CONSTRAINT_* nodemask=<cpuset/mempolicy nodemask> origin_memcg=<memcg> kill_memcg=<memcg> task=<comm> pid=<pid> uid=<uid>

For CONSTRAINT_NONE, nodemask and origin_memcg are empty.  For 
CONSTRAINT_CPUSET and CONSTRAINT_MEMORY_POLICY, origin_memcg is empty.
