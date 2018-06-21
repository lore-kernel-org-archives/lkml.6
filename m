Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12ABC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9638D20652
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="rhYX6VY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9638D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754079AbeFUOfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 10:35:31 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:48740 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750806AbeFUOfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 10:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cmpxchg.org
        ; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=G5JHiVjcmIJqXosJFomg7k1ePFiaho4lsxfFGSeVsAY=; b=rhYX6VY0MsUwsbHc0Nf8rqKYZg
        SKqkJ+F2/ApbJnWIWVSwJYQQfAyCloI5omkhkrRzKY46zzRy7I7eAlduDMea83r1vNlVKJ+TFZoOb
        MSnuS+cokQ0jlYRX+YEy61AoQrLHptPP4S8VZUVc0vz8R8MsK10Wk6/7lWS5GwxRJTBk=;
Date:   Thu, 21 Jun 2018 10:37:51 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] memcg, oom: move out_of_memory back to the charge
 path
Message-ID: <20180621143751.GA11230@cmpxchg.org>
References: <20180620103736.13880-1-mhocko@kernel.org>
 <20180621080927.GE10465@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621080927.GE10465@dhcp22.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 10:09:27AM +0200, Michal Hocko wrote:
> @@ -496,14 +496,14 @@ void mem_cgroup_print_oom_info(struct mem_cgroup *memcg,
>  
>  static inline void mem_cgroup_oom_enable(void)
>  {
> -	WARN_ON(current->memcg_may_oom);
> -	current->memcg_may_oom = 1;
> +	WARN_ON(current->in_user_fault);
> +	current->in_user_fault = 1;
>  }
>  
>  static inline void mem_cgroup_oom_disable(void)
>  {
> -	WARN_ON(!current->memcg_may_oom);
> -	current->memcg_may_oom = 0;
> +	WARN_ON(!current->in_user_fault);
> +	current->in_user_fault = 0;
>  }

Would it make more sense to rename these to
mem_cgroup_enter_user_fault(), mem_cgroup_exit_user_fault()?

Other than that, this looks great to me.

Thanks
