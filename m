Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4777EC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB7720869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mt3XXHKM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB7720869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbeJPUkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 16:40:09 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37993 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbeJPUkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 16:40:09 -0400
Received: by mail-ed1-f68.google.com with SMTP id c1-v6so21200794ede.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 05:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OOPSeBVlc0dpxa9bxN/IbhTn0w8nJk7De+Xv8mGDDtI=;
        b=mt3XXHKMnzyofoXtgxTF+ApKhrxi2Z4TSiuy7l2cFR266u7kxFrkLapwB9Q4MppU1e
         nKeBfJ8uUKXbM4QmfwsZYB+H9LxcoyQMKlimgssxzVYQryUHJkv4WZxcFNO4q5pXPFGK
         rsRp1DIl2vptFe8s5cMMxKLIHbqPlUbqS6Nm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OOPSeBVlc0dpxa9bxN/IbhTn0w8nJk7De+Xv8mGDDtI=;
        b=PzhYIZAMW8Ap/tVM8KYwGnf9cE3Jx2jbfT+BBi+2CUzzL18UPLT9r9GCnGu2Rbl6ed
         NNk6cl+9X7EuDkCIVSax+07w2PrqzVL31KSVMJUhpJky4liAZa9IRlPr/AIrKm9j5rK6
         ebubpx7hvFOkCPpWUuzkGVfQjHSZ0lUjNSwc/47Z4bRAQzBVPru6IgPocMzgYyKFsyU9
         Ah2cRrxKKXRTDLTeu2Q+JgePLYTEbqvrqiWsCyQuim3URWzK2WyWoJLEcSfMU/dOuwKd
         cejCnb0i165qJw4ZxHpnXUWRAQp/HfUUsOuEdPzG3dJ+7jioXUlwpDhDLt0sPIsA+gb7
         uiBg==
X-Gm-Message-State: ABuFfoiwzC5sGhhEy8ffmStocyiz5yiOfOKhEOyM4o23s+g2KUsWtVx8
        lv/kyxV32JA7Km1hOCpIpDEOnQ==
X-Google-Smtp-Source: ACcGV61bnoMmlw4qpUurGQV0Zske57wqtFIqAFnQsURKh4n9Z4AW/d7ZVhZW8w9bueiYhVjF84oYHQ==
X-Received: by 2002:a50:f14b:: with SMTP id z11-v6mr31119654edl.0.1539694187553;
        Tue, 16 Oct 2018 05:49:47 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id fx18-v6sm2834659ejb.31.2018.10.16.05.49.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 05:49:46 -0700 (PDT)
Date:   Tue, 16 Oct 2018 14:49:39 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: Convert mem_cgroup_id::ref to refcount_t type
Message-ID: <20181016124939.GA13278@andrea>
References: <153910718919.7006.13400779039257185427.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153910718919.7006.13400779039257185427.stgit@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,

On Tue, Oct 09, 2018 at 08:46:56PM +0300, Kirill Tkhai wrote:
> This will allow to use generic refcount_t interfaces
> to check counters overflow instead of currently existing
> VM_BUG_ON(). The only difference after the patch is
> VM_BUG_ON() may cause BUG(), while refcount_t fires
> with WARN().

refcount_{sub_and_test,inc_not_zero}() are documented to provide
"slightly" more relaxed ordering than their atomic_* counterpart,
c.f.,

  Documentation/core-api/refcount-vs-atomic.rst
  lib/refcount.c (inline comments)

IIUC, this semantic change won't cause problems here (but please
double-check? ;D ).

  Andrea


>But this seems not to be significant here,
> since such the problems are usually caught by syzbot
> with panic-on-warn enabled.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  include/linux/memcontrol.h |    2 +-
>  mm/memcontrol.c            |   10 ++++------
>  2 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 4399cc3f00e4..7ab2120155a4 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -78,7 +78,7 @@ struct mem_cgroup_reclaim_cookie {
>  
>  struct mem_cgroup_id {
>  	int id;
> -	atomic_t ref;
> +	refcount_t ref;
>  };
>  
>  /*
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7bebe2ddec05..aa728d5b3d72 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4299,14 +4299,12 @@ static void mem_cgroup_id_remove(struct mem_cgroup *memcg)
>  
>  static void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n)
>  {
> -	VM_BUG_ON(atomic_read(&memcg->id.ref) <= 0);
> -	atomic_add(n, &memcg->id.ref);
> +	refcount_add(n, &memcg->id.ref);
>  }
>  
>  static void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n)
>  {
> -	VM_BUG_ON(atomic_read(&memcg->id.ref) < n);
> -	if (atomic_sub_and_test(n, &memcg->id.ref)) {
> +	if (refcount_sub_and_test(n, &memcg->id.ref)) {
>  		mem_cgroup_id_remove(memcg);
>  
>  		/* Memcg ID pins CSS */
> @@ -4523,7 +4521,7 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
>  	}
>  
>  	/* Online state pins memcg ID, memcg ID pins CSS */
> -	atomic_set(&memcg->id.ref, 1);
> +	refcount_set(&memcg->id.ref, 1);
>  	css_get(css);
>  	return 0;
>  }
> @@ -6357,7 +6355,7 @@ subsys_initcall(mem_cgroup_init);
>  #ifdef CONFIG_MEMCG_SWAP
>  static struct mem_cgroup *mem_cgroup_id_get_online(struct mem_cgroup *memcg)
>  {
> -	while (!atomic_inc_not_zero(&memcg->id.ref)) {
> +	while (!refcount_inc_not_zero(&memcg->id.ref)) {
>  		/*
>  		 * The root cgroup cannot be destroyed, so it's refcount must
>  		 * always be >= 1.
> 
