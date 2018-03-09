Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932357AbeCISRr convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 13:17:47 -0500
Received: from mout.gmx.net ([212.227.17.20]:45515 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751192AbeCISRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 13:17:45 -0500
Message-ID: <1520619426.27998.18.camel@gmx.de>
Subject: Re: [PATCH v4] cpuset: Enable cpuset controller in default hierarchy
From: Mike Galbraith <efault@gmx.de>
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>
Date: Fri, 09 Mar 2018 19:17:06 +0100
In-Reply-To: <1c3fe7b0-2600-c46d-1527-d3aaf024bb91@redhat.com>
References: <1520609707-16582-1-git-send-email-longman@redhat.com>
         <1520613285.12489.36.camel@gmx.de>
         <1c3fe7b0-2600-c46d-1527-d3aaf024bb91@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K0:UQrhXYr85emSsiqZS8crq9stp0HyEWuzuB4aS/22oJ6rLCckLCS
 UTRXcvIgpsQUSELuAFNbd4cddDjLtNAp5G8QsxnOddKL7a3vel1VxQeUjLcDBL3mo289fx5
 v5t9nZAYzdYqVSr9cNhU2otYvI1tfuDIN/aXHCTZhIZyUEOYUqFuUfrstqHwmHJM9NXGtDF
 Pamk9JXim175274ubAdEQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rAdCwR9PiTE=:g7V4NUbYcQlSu+5hz3v8Xp
 jTA7do81kojqMy9R11NCRMaz/L6XnEiHX5F6eOettoasu4Vz3dR6FWNqTCYvHL2v3DiSWsHcB
 dT3+RRpPlNzYWgiC3RbX5JmA7XoUTCUIn9nVcz/ImBRDiJu0+5+WQVtgHJJeR2NdlPgj3BK7c
 AkrHpK46nfvIB92Huxq9ifIscZZ0+3yDmHmCc+B2O1lCYjWxOCE0olY3fhheS5ZydY1oTkq7b
 OlC6ebUemkbzeLavTTPjXwUUE75hY0KyBE9DfLhCK41GFAh6swQb5p5L9L4NTL8WQsci/Rs7y
 TwdZ6KAaUnKb5ktyd53wnN31m/OYupvylBMx1P4iwDZzIfMpDE58jzF7XvyABD06rtuxwXx9N
 qEpisVALASxy+1FbGVlTcJ8rfCQLfVhLCwCq6Q06mwJuqNH0ZnUexhgYwQi50UWZcBqyzM/FA
 zdPheYaf8Wx5L+F75MGPkDlsdYKYw76RLuwCZtfHf28Y/MhcrHOgE0ft6GxNb/Pma2xCaGUEi
 0X6gL2EctCgbee9KKqVU5N/CZlWxs0ZH7qeQMP9gVSsCJI0ZJ5Ry1NK2+LIJFq+464BI3e250
 AIcnErT/gLQS6QiebTM3nWcfzX4XSzzhJE4daaCJifOX4uhBTzAaBo1GFmDWjs8uiXVitOA5F
 YM1eVPbjN8QpJEoTYHgz4RqRqyVzoFCR/NYSQva4gywmg1XYevBPOF5ijKIlwfWGvC2Pa9Hmx
 qC1y/g/EI+De/UhFeLuB0tkDJAxRKUrXEzeawjyPqvdZAbTVYKUBkGR3oqb+63qgXTh7HbtxN
 pmH1fjZMfeJq4SJ7Pe3ibzZbSWvWS4yglNX72d7eF+HlQiFaqM=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-03-09 at 12:45 -0500, Waiman Long wrote:
> On 03/09/2018 11:34 AM, Mike Galbraith wrote:
> > On Fri, 2018-03-09 at 10:35 -0500, Waiman Long wrote:
> >> Given the fact that thread mode had been merged into 4.14, it is now
> >> time to enable cpuset to be used in the default hierarchy (cgroup v2)
> >> as it is clearly threaded.
> >>
> >> The cpuset controller had experienced feature creep since its
> >> introduction more than a decade ago. Besides the core cpus and mems
> >> control files to limit cpus and memory nodes, there are a bunch of
> >> additional features that can be controlled from the userspace. Some of
> >> the features are of doubtful usefulness and may not be actively used.
> > One rather important features is the ability to dynamically partition a
> > box and isolate critical loads.  How does one do that with v2?
> >
> > In v1, you create two or more exclusive sets, one for generic
> > housekeeping, and one or more for critical load(s), RT in my case,
> > turning off load balancing in the critical set(s) for obvious reasons.
> 
> This patch just serves as a foundation for cpuset support in v2. I am
> not excluding the fact that more v1 features will be added in future
> patches. We want to start with a clean slate and add on it after careful
> consideration. There are some v1 cpuset features that are not used or
> rarely used. We certainly want to get rid of them, if possible.

If v2 is to ever supersede v1, as is the normal way of things, core
functionality really should be on the v2 boat when it sails.  What you
left standing on the dock is critical core cpuset functionality.

	-Mike
