Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644A3C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1FE278C1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C1FE278C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935893AbeF1TvP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 15:51:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39258 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935793AbeF1TvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 15:51:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C38D6BF573;
        Thu, 28 Jun 2018 19:51:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 21E932026D69;
        Thu, 28 Jun 2018 19:51:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 28 Jun 2018 21:51:12 +0200 (CEST)
Date:   Thu, 28 Jun 2018 21:51:06 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     srikar@linux.vnet.ibm.com, rostedt@goodmis.org,
        mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Subject: Re: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
Message-ID: <20180628195106.GA3952@redhat.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
 <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 28 Jun 2018 19:51:12 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 28 Jun 2018 19:51:12 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have to admit that after a quick glance I can't understand this patch
at all... I'll try to read it again tomorrow, but could you at least explain
how find_node_in_range/build_probe_list can work if off_type==REF_CTR_OFFSET?

On 06/28, Ravi Bangoria wrote:
>
> -find_node_in_range(struct inode *inode, loff_t min, loff_t max)
> +find_node_in_range(struct inode *inode, int off_type, loff_t min, loff_t max)
>  {
>  	struct rb_node *n = uprobes_tree.rb_node;
>  
>  	while (n) {
>  		struct uprobe *u = rb_entry(n, struct uprobe, rb_node);
> +		loff_t offset = uprobe_get_offset(u, off_type);
>  
>  		if (inode < u->inode) {
>  			n = n->rb_left;
>  		} else if (inode > u->inode) {
>  			n = n->rb_right;
>  		} else {
> -			if (max < u->offset)
> +			if (max < offset)
>  				n = n->rb_left;
> -			else if (min > u->offset)
> +			else if (min > offset)
>  				n = n->rb_right;
>  			else
>  				break;

To simplify, lets forget about uprobe->inode (which acts as a key too). So uprobes_tree
is a binary tree sorted by uprobe->offset key and that is why the binary search works.

But it is not sorted by uprobe->ref_ctr_offset. So for example n->rb_left can have the
n->ref_ctr_offset key that is greater than the n's ref_ctr_offset. So how we can use the
binary search if REF_CTR_OFFSET?

I must have missed something, I assume you tested this patch and it works somehow...

Oleg.

