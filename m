Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F65C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 19:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7855B20841
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 19:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rGmRvZQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7855B20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbeG1UaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 16:30:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38758 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730158AbeG1UaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 16:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OM3CyD0vtta3QT9PDo4cNlUxUZgQPgcVyHibzqPewlA=; b=rGmRvZQVu6Mb+re3SfaF6OumX
        reMwkZ0I6lD2aklF9nIYXz6mhMgdHxLFeS7Zxji5u0kJnF/fIwVWoCrFp9iLE22pE24y9J0Hoh/jp
        xUw19anJn8hadMMcJ837xu3yz4h9zK2tcZ1XAizxLP7MoketeRVB++8ohdoImHq07v5bt43WkWG3r
        KgVXbcv+9IpGiqOYPW5Xxmko9e5b1BU7o+ASJJQ6Tg99vLcZ2IAsTmQ7mKHBwudl2tfj5wGSG4wRg
        ydqw8vGhZXrKdMBShXN0PIfxUcR7voOBPZNOWy4pZAan86ZjsEFPc0v675+ADFaW2Zi3fqLMgL2Ho
        VrnZcUunQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fjUUK-0000LI-Sx; Sat, 28 Jul 2018 19:02:48 +0000
Date:   Sat, 28 Jul 2018 12:02:48 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        mhocko@suse.com, jack@suse.cz, jglisse@redhat.com,
        mike.kravetz@oracle.com, dave@stgolabs.net, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipc/shm.c add ->pagesize function to shm_vm_ops
Message-ID: <20180728190248.GA883@bombadil.infradead.org>
References: <20180727211727.5020-1-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727211727.5020-1-jane.chu@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 03:17:27PM -0600, Jane Chu wrote:
> +++ b/include/linux/mm.h
> @@ -387,6 +387,13 @@ enum page_entry_size {
>   * These are the virtual MM functions - opening of an area, closing and
>   * unmapping it (needed to keep files on disk up-to-date etc), pointer
>   * to the functions called when a no-page or a wp-page exception occurs.
> + *
> + * Note, when a new function is introduced to vm_operations_struct and
> + * added to hugetlb_vm_ops, please consider adding the function to
> + * shm_vm_ops. This is because under System V memory model, though
> + * mappings created via shmget/shmat with "huge page" specified are
> + * backed by hugetlbfs files, their original vm_ops are overwritten with
> + * shm_vm_ops.
>   */
>  struct vm_operations_struct {

I don't think this header file is the right place for this comment.
I'd think a better place for it would be at the definition of hugetlb_vm_ops.
