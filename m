Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936420AbeE2N7H (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:59:07 -0400
Received: from a9-99.smtp-out.amazonses.com ([54.240.9.99]:35350 "EHLO
        a9-99.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935745AbeE2N6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:58:12 -0400
Date: Tue, 29 May 2018 13:58:11 +0000
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Vladimir Davydov <vdavydov.dev@gmail.com>
cc: Shakeel Butt <shakeelb@google.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Linux MM <linux-mm@kvack.org>, cgroups@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm: fix race between kmem_cache destroy, create and
 deactivate
In-Reply-To: <20180526185837.k5ztrillokpi65qj@esperanza>
Message-ID: <01000163ac3122e8-e705287a-17f4-4ff6-8eae-1ad310676096-000000@email.amazonses.com>
References: <20180522201336.196994-1-shakeelb@google.com> <20180526185837.k5ztrillokpi65qj@esperanza>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.05.29-54.240.9.99
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 May 2018, Vladimir Davydov wrote:

> > The reference counting is only implemented for root kmem_caches for
> > simplicity. The reference of a root kmem_cache is elevated on sharing or
> > while its memcg kmem_cache creation or deactivation request is in the
> > fly and thus it is made sure that the root kmem_cache is not destroyed
> > in the middle. As the reference of kmem_cache is elevated on sharing,
> > the 'shared_count' does not need any locking protection as at worst it
> > can be out-dated for a small window which is tolerable.
>
> I wonder if we could fix this problem without introducing reference
> counting for kmem caches (which seems a bit of an overkill to me TBO),
> e.g. by flushing memcg_kmem_cache_wq before root cache destruction?

Would prefer that too but the whole memcg handling is something of a
mystery to me.
