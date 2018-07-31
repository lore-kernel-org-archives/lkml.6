Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC24BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7661D20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NaROk/h6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7661D20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732171AbeGaORD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 10:17:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35618 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731988AbeGaORC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 10:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+xso1fiqPOWus8OmqTgiUrR3ViyH1FuI1jfXY3TsNd4=; b=NaROk/h6omt+CHtQJdWaHSVUQ
        ZyEi2hU7WlN6l/MQRuBVfJPJ5lyxhZfkFkXR+FLe9yULFcxHhb9JZAFGjpjZ7cTikmTEq6Esd7MtM
        DL0Ep3B1kwZ+5dutUy/P50505Q9QBFCs6YdAFrKx/F9RLNn30uGHLY22lUSBzYak6tp6lUCzypG7G
        Ge1UCneyunpua+zvPdSVrXKB+bHQDBo/yENAJtRlxhH8uz+GiJsPFYKT01E3d02qy7nvlVtbT/rZu
        3XXWE2BYngQJDLe8KoVHEPh19DVkE4FIvR/C7eKyE6dRvDHfl7VO121gLXEl+3YYaXWBsg8EUGWPr
        aFs18rXlQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkTtV-0002W5-EH; Tue, 31 Jul 2018 12:36:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8A6E82027585B; Tue, 31 Jul 2018 14:36:51 +0200 (CEST)
Date:   Tue, 31 Jul 2018 14:36:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jiada_wang@mentor.com
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        george_davis@mentor.com, erosca@de.adit-jv.com
Subject: Re: [PATCH v2 1/1] sched/debug: fix potential deadlock when write to
 sched_features
Message-ID: <20180731123651.GW2494@hirez.programming.kicks-ass.net>
References: <20180731121222.26195-1-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731121222.26195-1-jiada_wang@mentor.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 09:12:22PM +0900, jiada_wang@mentor.com wrote:
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 60caf1fb94e0..7b2997d4a349 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -87,21 +87,21 @@ struct static_key sched_feat_keys[__SCHED_FEAT_NR] = {
>  
>  #undef SCHED_FEAT
>  
> -static void sched_feat_disable(int i)
> +static void sched_feat_disable_cpuslocked(int i)
>  {
> -	static_key_disable(&sched_feat_keys[i]);
> +	static_key_disable_cpuslocked(&sched_feat_keys[i]);
>  }
>  
> -static void sched_feat_enable(int i)
> +static void sched_feat_enable_cpuslocked(int i)
>  {
> -	static_key_enable(&sched_feat_keys[i]);
> +	static_key_enable_cpuslocked(&sched_feat_keys[i]);
>  }
>  #else
> -static void sched_feat_disable(int i) { };
> -static void sched_feat_enable(int i) { };
> +static void sched_feat_disable_cpuslocked(int i) { };
> +static void sched_feat_enable_cpuslocked(int i) { };
>  #endif /* HAVE_JUMP_LABEL */
>  
> -static int sched_feat_set(char *cmp)
> +static int sched_feat_set_cpuslocked(char *cmp)
>  {
>  	int i;
>  	int neg = 0;
> @@ -117,10 +117,10 @@ static int sched_feat_set(char *cmp)
>  
>  	if (neg) {
>  		sysctl_sched_features &= ~(1UL << i);
> -		sched_feat_disable(i);
> +		sched_feat_disable_cpuslocked(i);
>  	} else {
>  		sysctl_sched_features |= (1UL << i);
> -		sched_feat_enable(i);
> +		sched_feat_enable_cpuslocked(i);
>  	}
>  
>  	return 0;
> @@ -146,9 +146,11 @@ sched_feat_write(struct file *filp, const char __user *ubuf,
>  
>  	/* Ensure the static_key remains in a consistent state */
>  	inode = file_inode(filp);
> +	cpus_read_lock();
>  	inode_lock(inode);
> -	ret = sched_feat_set(cmp);
> +	ret = sched_feat_set_cpuslocked(cmp);
>  	inode_unlock(inode);
> +	cpus_read_unlock();
>  	if (ret < 0)
>  		return ret;
>  

I've made that..

---
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -89,12 +89,12 @@ struct static_key sched_feat_keys[__SCHE
 
 static void sched_feat_disable(int i)
 {
-	static_key_disable(&sched_feat_keys[i]);
+	static_key_disable_cpuslocked(&sched_feat_keys[i]);
 }
 
 static void sched_feat_enable(int i)
 {
-	static_key_enable(&sched_feat_keys[i]);
+	static_key_enable_cpuslocked(&sched_feat_keys[i]);
 }
 #else
 static void sched_feat_disable(int i) { };
@@ -146,9 +146,11 @@ sched_feat_write(struct file *filp, cons
 
 	/* Ensure the static_key remains in a consistent state */
 	inode = file_inode(filp);
+	cpus_read_lock();
 	inode_lock(inode);
 	ret = sched_feat_set(cmp);
 	inode_unlock(inode);
+	cpus_read_unlock();
 	if (ret < 0)
 		return ret;
 
