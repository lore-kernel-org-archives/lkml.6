Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8F6C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50FF320862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50FF320862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732272AbeHBBIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 21:08:09 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43136 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbeHBBIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 21:08:09 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fl0PM-00039x-G9; Wed, 01 Aug 2018 23:19:56 +0000
Date:   Thu, 2 Aug 2018 00:19:56 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] aio: add a iocb refcount
Message-ID: <20180801231956.GS30522@ZenIV.linux.org.uk>
References: <20180730071544.23998-1-hch@lst.de>
 <20180730071544.23998-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730071544.23998-3-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 09:15:42AM +0200, Christoph Hellwig wrote:
> This is needed to prevent races caused by the way the ->poll API works.
> To avoid introducing overhead for other users of the iocbs we initialize
> it to zero and only do refcount operations if it is non-zero in the
> completion path.

refcount_t looks like a bad match - you, AFAICS, have count 0 for everything
except poll, while for poll you start with 2.  That looks like
	if (iocb->shared && test_and_clear_bit(0, &iocb->shared))
		return;
	kill the sucker
in your iocb_put() and initializing it to 1 in poll.  No?
