Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4129FECDE5F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0024E20673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0024E20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbeGTAwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:52:45 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47892 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730687AbeGTAwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:52:45 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fgIuN-0000iV-BI; Fri, 20 Jul 2018 00:04:31 +0000
Date:   Fri, 20 Jul 2018 01:04:31 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Theuns Verwoerd <theuns.verwoerd@alliedtelesis.co.nz>
Cc:     dwmw2@infradead.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] jffs2: Provide jffs2_sync files to track gc POLL
 progress
Message-ID: <20180720000431.GA30522@ZenIV.linux.org.uk>
References: <cover.1532043059.git.theuns.verwoerd@alliedtelesis.co.nz>
 <f1c6c3cc0c8850e143594afd57b50d30cd8bb5f8.1532043059.git.theuns.verwoerd@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1c6c3cc0c8850e143594afd57b50d30cd8bb5f8.1532043059.git.theuns.verwoerd@alliedtelesis.co.nz>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 11:50:12AM +1200, Theuns Verwoerd wrote:

> +ssize_t jffs2_sync_file_read(struct file *f,
> +	      char __user *b, size_t len, loff_t *ofs)
> +{
> +	struct jffs2_sb_info *c = file_inode(f)->i_private;
> +
> +	while (c->tidemark)
> +		schedule();
> +
> +	return 0;
> +}

Brilliant.  So when that gets called with c->tidemark being true and
need_resched() - false, we shall...

Bonus question: what happens if that is called after that jffs2_sb_info
gets freed?

--
It Doesn't Need To Make Sense - It's For Security Purposes.
