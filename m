Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF4EC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9194E21527
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9194E21527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388324AbeHBRwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 13:52:22 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35288 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387645AbeHBRwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 13:52:22 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1flG1g-0000AT-K9; Thu, 02 Aug 2018 16:00:32 +0000
Date:   Thu, 2 Aug 2018 17:00:32 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] aio: implement IOCB_CMD_POLL
Message-ID: <20180802160032.GY30522@ZenIV.linux.org.uk>
References: <20180730071544.23998-1-hch@lst.de>
 <20180730071544.23998-4-hch@lst.de>
 <20180802002121.GU30522@ZenIV.linux.org.uk>
 <20180802092234.GA13797@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802092234.GA13797@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 11:22:34AM +0200, Christoph Hellwig wrote:

> Yes, I think you are right. I'll see how I could handle that case.
> One of the easiest options would be to just support aio poll on
> file ops that support keyed wakeups, we'd just need to pass that
> information up.

BTW, what happens if we insert into one queue and immediately get
woken up, even before the damn thing gets to the end of ->poll(),
which proceeds to call poll_wait() again (on another queue)?
AFAICS, apt.error will be set by the second callback and completely
ignored.  And so will the return value of ->poll()...

Sigh...  Analysis of that thing is bloody painful, mostly because
it's hard to describe the state...
