Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E748C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4120820878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JzASF7++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4120820878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbeJBQVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:21:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59112 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbeJBQVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yDpK4WmxnW6G3LFwBT4yxzkYBQ8JvQgJpgd6yQE3a/Q=; b=JzASF7++qiKZvbcFASs6IsFkA
        Qhmf1h7T2pi9/G4mibpl5aqAu5kfwl5ItQjFghGFKs0KxWVyBGWwW8JlX0mm7j5mjgwoNfYSfYcR+
        Z0tw5JuJyqYq8Gu3dt3ON8QJlkEFNv31NXWZsc1/OR8bRlVBk8py+OEfdDbyNxu5LmpOORXDitNWF
        okm1MY0wcXYf9VTWm57SoO5Wcm7hHpur2FcbNv+JHRvxBJYDCUMB1m+GLTsdH/9dgPvdZ+lzCf/h6
        eHf96yxwEDwOPhbzsj9iYTkeQUQ8Qrp2yBySiqGWTtg79LSMTyBtpnZAt4q9iMrO1ZpKhbRpRvRKA
        YjGPXZ4UA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7H92-0005zm-TV; Tue, 02 Oct 2018 09:39:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 68A06202B9CBA; Tue,  2 Oct 2018 11:39:07 +0200 (CEST)
Date:   Tue, 2 Oct 2018 11:39:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] locking/lockdep: Make class->ops a percpu counter
Message-ID: <20181002093907.GV3439@hirez.programming.kicks-ass.net>
References: <1538157201-29173-1-git-send-email-longman@redhat.com>
 <1538157201-29173-5-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538157201-29173-5-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 01:53:20PM -0400, Waiman Long wrote:
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index ca002c0..7a0ed1d 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -139,6 +139,7 @@ static inline int debug_locks_off_graph_unlock(void)
>   */
>  unsigned long nr_lock_classes;
>  static struct lock_class lock_classes[MAX_LOCKDEP_KEYS];
> +static DEFINE_PER_CPU(unsigned long [MAX_LOCKDEP_KEYS], lock_class_ops);

> @@ -1387,11 +1391,15 @@ static inline int usage_match(struct lock_list *entry, void *bit)
>  
>  static void print_lock_class_header(struct lock_class *class, int depth)
>  {
> -	int bit;
> +	int bit, cpu;
> +	unsigned long ops = 0UL;
> +
> +	for_each_possible_cpu(cpu)
> +		ops += *per_cpu(class->pops, cpu);
>  
>  	printk("%*s->", depth, "");
>  	print_lock_name(class);
> -	printk(KERN_CONT " ops: %lu", class->ops);
> +	printk(KERN_CONT " ops: %lu", ops);
>  	printk(KERN_CONT " {\n");
>  
>  	for (bit = 0; bit < LOCK_USAGE_STATES; bit++) {

That is an aweful lot of storage for a stupid number. Some archs
(sparc64) are bzImage size constrained and this will hurt them.

Ingo, do you happen to remember what that number was good for?
Can't we simply ditch it?
