Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F453ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 10:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13CD2083A
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 10:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S2zw2fsw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13CD2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeIOP3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 11:29:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39954 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbeIOP3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 11:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LrVmO7YhskUdxsqNXcwgGc4uDp3hDpxnY302SQj+H1g=; b=S2zw2fswtui+nhYeyYc+uhsU+
        B2tYuMnHJ+QQQ3HafhVNIzAWcNdweY24JY5c12N9JxEe7hkn3PhByV0XQo9qgY8x8/RECIRHKPYcb
        wNVS5FAzlhzbDFMiCbngcyMOLCrEn11DgRZwZgvsus/jHq0qWK289Y7MkSpTkxad4CKhUEzg5thSE
        HxRSD0oH3IxxgN2WcZlXgJTUAPGOjpdtxi0fX4Z+LiT+jocNqhkOreVr2YmRZXqiQtU8Sc+ykT08x
        5LDF+YJC2fVyTIr0ro6BU6IOhblWA0uNEeA5CZxQgbUqWZQeq+NL5ADCFa8txkBXaerD9rq3QS9Dq
        vO1/bvypA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g17XG-0006UU-RN; Sat, 15 Sep 2018 10:10:42 +0000
Date:   Sat, 15 Sep 2018 03:10:42 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mhocko@kernel.org, ldufour@linux.vnet.ibm.com, vbabka@suse.cz,
        kirill@shutemov.name, akpm@linux-foundation.org,
        dave.hansen@intel.com, oleg@redhat.com, srikar@linux.vnet.ibm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v10 PATCH 0/3] mm: zap pages with read mmap_sem in munmap
 for large mapping
Message-ID: <20180915101042.GD31572@bombadil.infradead.org>
References: <1536957299-43536-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536957299-43536-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 15, 2018 at 04:34:56AM +0800, Yang Shi wrote:
> Regression and performance data:
> Did the below regression test with setting thresh to 4K manually in the code:
>   * Full LTP
>   * Trinity (munmap/all vm syscalls)
>   * Stress-ng: mmap/mmapfork/mmapfixed/mmapaddr/mmapmany/vm
>   * mm-tests: kernbench, phpbench, sysbench-mariadb, will-it-scale
>   * vm-scalability
> 
> With the patches, exclusive mmap_sem hold time when munmap a 80GB address
> space on a machine with 32 cores of E5-2680 @ 2.70GHz dropped to us level
> from second.
> 
> munmap_test-15002 [008]   594.380138: funcgraph_entry: |  __vm_munmap {
> munmap_test-15002 [008]   594.380146: funcgraph_entry:      !2485684 us |    unmap_region();
> munmap_test-15002 [008]   596.865836: funcgraph_exit:       !2485692 us |  }
> 
> Here the excution time of unmap_region() is used to evaluate the time of
> holding read mmap_sem, then the remaining time is used with holding
> exclusive lock.

Something I've been wondering about for a while is whether we should "sort"
the readers together.  ie if the acquirers look like this:

A write
B read
C read
D write
E read
F read
G write

then we should grant the lock to A, BCEF, D, G rather than A, BC, D, EF, G.
A quick way to test this is in __rwsem_down_read_failed_common do
something like:

-	if (list_empty(&sem->wait_list))
+	if (list_empty(&sem->wait_list)) {
 		adjustment += RWSEM_WAITING_BIAS;
+		list_add(&waiter.list, &sem->wait_list);
+	} else {
+		struct rwsem_waiter *first = list_first_entry(&sem->wait_list,
+						struct rwsem_waiter, list);
+		if (first.type == RWSEM_WAITING_FOR_READ)
+			list_add(&waiter.list, &sem->wait_list);
+		else
+			list_add_tail(&waiter.list, &sem->wait_list);
+	}
-	list_add_tail(&waiter.list, &sem->wait_list);

It'd be interesting to know if this makes any difference with your tests.

(this isn't perfect, of course; it'll fail to sort readers together if there's
a writer at the head of the queue; eg:

A write
B write
C read
D write
E read
F write
G read

but it won't do any worse than we have at the moment).

