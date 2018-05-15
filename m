Return-Path: <vdavydov.dev@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526357315; cv=none;
        d=google.com; s=arc-20160816;
        b=hTnA72nxMg2mgTBC15SJwnCtIzrfvXQPa+TvsUvhq7II+wK5EDpTEpWLVOl0rN6mEL
         f8jYVsoF/SmurK3DVBnAvXb9W7vQDVce/A1gM4LWOiEhAF8g8aft96p2CgXium/cJbOx
         TlWF+33UMndGEbY09xNJTQKwWJNEwKpxjnQ95XKKtf3mNvnyerHJXWpF3zmpjF4J0ard
         8+9tKIXuFObTBKMLqJmNzLx1l334+J/3PDzVDJ2r3dw9tdoa4dM3XgfSwm4lSGegPhOT
         SgGsBBC3mFZpw3F8F71bMscIrAiof5bx2LNUVNaKJ685+KB9yc1JHBDB1qySFf9fApfH
         9xaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=xQ5Po2hfSBIS2BDk/g7fXex7vkMx7XX6lZjc1E9QqRE=;
        b=NxfF8v7wzMdAmoUpBQQAjSAL1gfbNst0xEq9UvUkj/edy2Cv3Xu9iMRNdIqMDgqQUe
         tQjyzteOR/CiZaw2I366MpUf71TySr6aDZXiu1k3rjsqXggRpx/1c+XiUi8sdPf6iBJ/
         tNFLsY6exvo/0aE5RH5E5f/s97j3uli50Grj+tKHPVmtd4Ar6Bd3lEdbrLI2msIRLxmA
         Umsfw9w0BxkD+z11jFhjB7/N6FgfOo0APDU5fJaFptcn8yERb54d+WdVBeFkZIOVSMU0
         yqm+gJq5Ft7hwK5VJmF8F5F8+0F8oS6rMKUGK9LJBE687XJvPOfU2HNPnAKGb85WMR+0
         l1fA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lcTer8a2;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lcTer8a2;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZoISVT6/OFy7wsI+pYXr98S9bEoh0XQ2FZSxUvW91GH3B1pDa8X4lNCLEdl0SSE2mgCRcQqmw==
Date: Tue, 15 May 2018 07:08:32 +0300
From: Vladimir Davydov <vdavydov.dev@gmail.com>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: akpm@linux-foundation.org, shakeelb@google.com, viro@zeniv.linux.org.uk,
	hannes@cmpxchg.org, mhocko@kernel.org, tglx@linutronix.de,
	pombredanne@nexb.com, stummala@codeaurora.org,
	gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
	mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
	chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
	ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
	linux@roeck-us.net, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
	aryabinin@virtuozzo.com
Subject: Re: [PATCH v5 10/13] mm: Set bit in memcg shrinker bitmap on first
 list_lru item apearance
Message-ID: <20180515040832.ukmrcdl5czqpldgv@esperanza>
References: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
 <152594602582.22949.2526776640167844592.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152594602582.22949.2526776640167844592.stgit@localhost.localdomain>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600070389099005691?=
X-GMAIL-MSGID: =?utf-8?q?1600501648501316156?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 10, 2018 at 12:53:45PM +0300, Kirill Tkhai wrote:
> Introduce set_shrinker_bit() function to set shrinker-related
> bit in memcg shrinker bitmap, and set the bit after the first
> item is added and in case of reparenting destroyed memcg's items.
> 
> This will allow next patch to make shrinkers be called only,
> in case of they have charged objects at the moment, and
> to improve shrink_slab() performance.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  include/linux/memcontrol.h |   15 +++++++++++++++
>  mm/list_lru.c              |   22 ++++++++++++++++++++--
>  2 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index e5e7e0fc7158..82f892e77637 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1274,6 +1274,21 @@ static inline void memcg_put_cache_ids(void)
>  
>  extern int memcg_shrinker_nr_max;
>  extern int memcg_expand_shrinker_maps(int old_id, int id);
> +
> +static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg, int nid, int nr)

Nit: too long line (> 80 characters)
Nit: let's rename 'nr' to 'shrinker_id'

> +{
> +	if (nr >= 0 && memcg && memcg != root_mem_cgroup) {
> +		struct memcg_shrinker_map *map;
> +
> +		rcu_read_lock();
> +		map = MEMCG_SHRINKER_MAP(memcg, nid);

Missing rcu_dereference.

> +		set_bit(nr, map->map);
> +		rcu_read_unlock();
> +	}
> +}
> +#else
> +static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
> +					  int node, int id) { }

Nit: please keep the signature (including argument names) the same as in
MEMCG-enabled definition, namely 'node' => 'nid', 'id' => 'shrinker_id'.

Thanks.
