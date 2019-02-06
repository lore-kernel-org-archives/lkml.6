Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD31C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2661A218D3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 20:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfBFUwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 15:52:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:36082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbfBFUwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 15:52:46 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5216E217F9;
        Wed,  6 Feb 2019 20:52:45 +0000 (UTC)
Date:   Wed, 6 Feb 2019 15:52:43 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andreas Ziegler <andreas.ziegler@fau.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] tracing: uprobes: Re-enable $comm support for
 uprobe events
Message-ID: <20190206155243.725bc30d@gandalf.local.home>
In-Reply-To: <154778666570.19927.5960654930869453736.stgit@devbox>
References: <154778663676.19927.12774448308165809570.stgit@devbox>
        <154778666570.19927.5960654930869453736.stgit@devbox>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019 13:44:25 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> @@ -180,7 +183,12 @@ fetch_store_strlen(unsigned long addr)
>  	int len;
>  	void __user *vaddr = (void __force __user *) addr;
>  
> -	len = strnlen_user(vaddr, MAX_STRING_SIZE);
> +	if (addr == (unsigned long)current->comm) {
> +		len = strlen(current->comm);
> +		if (len)
> +			len++;

Why only add 1 if len is non zero? Why not always do it.

One thing, len should always be greater than 0, and the other is that
this makes it inconsistent with the NULL case of reading the address in
userspace.

-- Steve


> +	} else
> +		len = strnlen_user(vaddr, MAX_STRING_SIZE);
>  
>  	return (len > MAX_STRING_SIZE) ? 0 : len;
