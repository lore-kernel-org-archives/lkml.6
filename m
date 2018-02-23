Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751416AbeBWDRB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 22:17:01 -0500
Received: from resqmta-ch2-05v.sys.comcast.net ([69.252.207.37]:44168 "EHLO
        resqmta-ch2-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751376AbeBWDQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 22:16:58 -0500
Date: Thu, 22 Feb 2018 21:16:55 -0600 (CST)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Jan Kara <jack@suse.cz>
cc: Shakeel Butt <shakeelb@google.com>,
        Amir Goldstein <amir73il@gmail.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Directed kmem charging
In-Reply-To: <20180222135345.epm6e34cvxzaxn74@quack2.suse.cz>
Message-ID: <alpine.DEB.2.20.1802222112280.6687@nuc-kabylake>
References: <20180221030101.221206-1-shakeelb@google.com> <alpine.DEB.2.20.1802211002200.12567@nuc-kabylake> <CALvZod68LD-wnbm2+MQks=bd_D2zY64uScUBp28hyug_vaGyDA@mail.gmail.com> <alpine.DEB.2.20.1802211155500.13845@nuc-kabylake>
 <20180222135345.epm6e34cvxzaxn74@quack2.suse.cz>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfG4efywwZbDSLUBTISmJIiGOHWAp02/z1A99jj3WFfdjjSOSk5OCBZeaTAzRy7gqs/uMaDTVJkMae7oDR9YivpyatIZpQodgieRCsU2RmMpjCbc9M1gj
 FMSMKhmnTfiVSPHtDMGLRjG4/V6n0/qd7WClzqHMtt4fGcz3uSeVCq0Qb1k+OASKgno9S0/4qBFO7261sOB18AObUVC1O66l4NEUXqTfY+t7sLWSIKAcZ8bv
 9VNk6wFeH48GSLiVagKgIGRukiYR4K4OHgXVe6mW0rQlZjrfyG5bKoi52hSqHhN4kh9tmUPWhowO6sRCtu5WDdbeqHf0NpNSRA0tj+QnvN65RV0M1KQe1ENk
 8mvZcRgGJx9e5YH5En+GGVyivtt4GC9Yir8dSG5al9fMKrjDSTMH+nT+9T91m+PpeB0GFVTm0phCw4HrltiF/W49Jlv0EVgyulyc23O+sGkIP9KHKpvKLftf
 MxPHrsiZNlMw6S9DYBdChJ4S1YIH3+LpRunKPwxzcaIC8alZK8I6wHY9AlX/8o99UVEEZH9OxIVPOBMn6VslwOz/Qy7fwj+WJ4Q5HjcM9j/S4Fcvd2d1C6ox
 GRODKprNprLbGrZ/ayebOZM620QIiNhlK2HW29zDBfwyfXDPT4LAg9IGZJ1gjal5wMo=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Feb 2018, Jan Kara wrote:

> I don't see how task work can be used here. Firstly I don't know of a case
> where task work would be used for something else than the current task -
> and that is substantial because otherwise you have to deal with lots of
> problems like races with task exit, when work gets executed (normally it
> gets executed once task exits to userspace) etc. Or do you mean that you'd
> queue task work for current task and then somehow magically switch memcg
> there? In that case this magic switching isn't clear to me...

Thats surprising since one can specify the task. If its only for current
then why do you need a parameter?

I think a capability of executing a function in the context of another
running task could simplify a lot. In particular if something triggers
behavior that is related to another task from the kernel like whats
happening here.

It should not be that difficult to do proper synchronization on the list
of work and then set some flag (maybe SIGPENDING) to make the task execute
whats on the tasklist. Signal delivery is after all similar.
