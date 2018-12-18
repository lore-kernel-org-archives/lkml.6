Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C4DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6094D218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbeLRUlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 15:41:16 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:58258 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbeLRUlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 15:41:15 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1D28BEBA;
        Tue, 18 Dec 2018 20:41:14 +0000 (UTC)
Date:   Tue, 18 Dec 2018 12:41:13 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Oscar Salvador <osalvador@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include/linux/nodemask.h: Use nr_node_ids instead of
 MAX_NUMNODES in nodemask_pr_args
Message-Id: <20181218124113.c5179c675dd217be7bed7d80@linux-foundation.org>
In-Reply-To: <1545154231-22824-1-git-send-email-longman@redhat.com>
References: <1545154231-22824-1-git-send-email-longman@redhat.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018 12:30:31 -0500 Waiman Long <longman@redhat.com> wrote:

> When viewing the /proc/<pid>/status file, one can see output lines like
> 
>   Cpus_allowed:	ffffffff,ffffffff,ffffffff
>   Cpus_allowed_list:	0-95
>   Mems_allowed:	00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,0000000f
>   Mems_allowed_list:	0-3

Oh dear.

> It looks really strange that so many bits are displayed in the
> "Mems_allowed:" line.  Whereas the "Cpus_allowed:" line is perfectly
> fine.
> 
> It is because the nodemask_pr_args() macro uses MAX_NUMNODES as the
> number of nodes to iterate. The cpumask_pr_args() macro uses nr_cpu_ids
> instead of MAX_CPUS. For nodes, there is a corresponding nr_node_ids.
> So it makes sense to use nr_node_ids instead to be consistent with
> "Cpus_allowed:".
> 
> With that change, the "Mems_allowed:" line becomes
> 
>   Mems_allowed:	f

OK, I guess.  There is a risk of breaking existing userspace, but any
half-decent parser should treat the above as equivalent.

However there are quite a lot of nodemask_pr_args() callers in the tree
and this patch potentially changes behaviour at all those sites. 
Please work through all those callers and show how the output is
altered so we can consider the patch's complete effect.


