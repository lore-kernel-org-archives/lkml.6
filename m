Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9F4C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0FA20855
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D0FA20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbeHBBmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 21:42:33 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43660 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeHBBmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 21:42:33 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fl0wW-0003pr-Bh; Wed, 01 Aug 2018 23:54:12 +0000
Date:   Thu, 2 Aug 2018 00:54:12 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] aio: implement IOCB_CMD_POLL
Message-ID: <20180801235412.GT30522@ZenIV.linux.org.uk>
References: <20180730071544.23998-1-hch@lst.de>
 <20180730071544.23998-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730071544.23998-4-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 09:15:43AM +0200, Christoph Hellwig wrote:

> +	apt.error = -EINVAL; /* same as no support for IOCB_CMD_POLL */

> +	mask = vfs_poll(req->file, &apt.pt) & req->events;
> +	if (mask || apt.error) {
> +		bool removed = false;
> +
> +		/* we did not manage to set up a waitqueue, done */
> +		if (unlikely(!req->head))
> +			goto out_fput;

> +out_fput:
> +	fput(req->file);
> +	return apt.error;

Ugh...  So anything that simply returns a constant value, without
even bothering to do poll_wait() (on the theory that no matter how
much you wait, nothing will change) is going to git -EINVAL?
What am I missing here?
