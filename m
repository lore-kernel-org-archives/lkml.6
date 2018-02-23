Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751407AbeBWDUA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 22:20:00 -0500
Received: from resqmta-ch2-10v.sys.comcast.net ([69.252.207.42]:45988 "EHLO
        resqmta-ch2-10v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751296AbeBWDT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 22:19:58 -0500
Date: Thu, 22 Feb 2018 21:19:55 -0600 (CST)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Andrew Morton <akpm@linux-foundation.org>
cc: Shakeel Butt <shakeelb@google.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Directed kmem charging
In-Reply-To: <20180221125426.464f894d29a0b6e525b2e3be@linux-foundation.org>
Message-ID: <alpine.DEB.2.20.1802222117140.6687@nuc-kabylake>
References: <20180221030101.221206-1-shakeelb@google.com> <alpine.DEB.2.20.1802211002200.12567@nuc-kabylake> <CALvZod68LD-wnbm2+MQks=bd_D2zY64uScUBp28hyug_vaGyDA@mail.gmail.com> <20180221125426.464f894d29a0b6e525b2e3be@linux-foundation.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfC+2BnQapE3bko5Hka0Ps5psNnCuu3TGLnhED+3ImUUOm/P6B1CyIe1EDw4n00+PCBR5MZa2punXwxj49FUpbii35O1wgTXLtof9cO24hH09KHxKfT1P
 8uUJ2rehYpCEeQYZzt29Cjyw1FLpXquo+cF5xT3W8/1UHNVb5qjFxi5SWNwCAFVmAV2X5is9eYJ4fvcjFNQjmu1ilbG9lJF60n9/niXvkYxsrS2QUSnkBuTo
 Djm3mUqCbZHRy9poh1LYq95lW33OTsMRULJF6KTTM5sgxwWskKPjYUXyniDYfs/IulCFT+PTuaMul7p4pZSJJ2U2I8YMFMbB2ngQf8woac7eVZLoU2AHjeeK
 HxIiFCgUENQno9YEE81ewbUbD0FGXXl0YexGH4/x9/Qe/C14dgOoEg22XJvDvosX8TQ+rmnUnCCSvdw3jckavRndNvQGcLStvVgsLsL5oUcupJmVhrBxGlnJ
 sqUE2yAyM0Zbg/4xLkkUD3grmZ57LasrqC8FkdN4Rtwy10Ohj3ZfhyMimNgBoBcXcXAuJ11du0mjQODnSvNRRyy3OhfG4gYxm6TQT0+nt0l1SGn+QxGDYlyI
 3iZdJSwXrS+uFxNIGqQ5mE34JKz26UwUgJJK6qrf/w6BV1MXCDpIHE4w3eQp7IN6Vok=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Feb 2018, Andrew Morton wrote:

> What do others think?

I think the changes to the hotpaths of the slab allocators increasing
register pressure in some of the hotttest paths of the kernel are
problematic.

Its better to do the allocation properly in the task context to which it
is finally charged. There may be other restrictions that emerge from other
fields in the task_struct that also may influence allocation and reclaim
behavior. It is cleanest to do this in the proper task context instead of
taking a piece (like the cgroup) out of context.
