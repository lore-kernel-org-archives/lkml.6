Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752903AbeDTUxP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 16:53:15 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:52294 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752765AbeDTUxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 16:53:14 -0400
Date: Fri, 20 Apr 2018 16:54:50 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Roman Gushchin <guro@fb.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, kernel-team@fb.com,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2] mm: move the high field from struct mem_cgroup to
 page_counter
Message-ID: <20180420205450.GB24563@cmpxchg.org>
References: <20180420163632.3978-1-guro@fb.com>
 <20180420163632.3978-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420163632.3978-2-guro@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 05:36:32PM +0100, Roman Gushchin wrote:
> We do store memory.min, memory.low and memory.max actual values
> in struct page_counter fields, while memory.high value is located
> in the struct mem_cgroup directly, which is not very consistent.
> 
> This patch moves the high field from struct mem_cgroup to
> struct page_counter to simplify the code and make handling
> of all limits/boundaries clearer.

I would prefer not doing this.

Yes, it looks a bit neater if all these things are next to each other
in the struct, but on the other hand it separates the high variable
from high_work, and it adds an unnecessary setter function as well.

Plus, nothing in the page_counter code actually uses the value, it
really isn't part of that abstraction layer.
