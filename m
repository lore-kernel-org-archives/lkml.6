Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBC8C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C669218A7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C669218A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeHQQBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 12:01:33 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45038 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbeHQQBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 12:01:33 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fqeKS-0005e9-NU; Fri, 17 Aug 2018 12:58:12 +0000
Date:   Fri, 17 Aug 2018 13:58:12 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Query on shrink list
Message-ID: <20180817125812.GC6515@ZenIV.linux.org.uk>
References: <301a5546-d326-d78e-3be6-41b5a6a08c0e@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <301a5546-d326-d78e-3be6-41b5a6a08c0e@codeaurora.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 03:39:22PM +0530, Mukesh Ojha wrote:
> Hi Al Viro,
> 
> Is there is reason we have kept data->found++, if the dentry already there
> in shrink list ?
> 
> static enum d_walk_ret select_collect(
> ...
>         if (dentry->d_flags & DCACHE_SHRINK_LIST) {
>                 data->found++;
>         } else {
>   ..
> 
> If the dentry is already there on shrink list, does it not mean that
> data->found is already non-zero ?

Nope.  It can be on *another* shrink list - if two processes are doing
that...

> Can't we just go out from here directly?
