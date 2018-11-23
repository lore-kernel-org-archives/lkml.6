Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D64C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9DE20685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA9DE20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391272AbeKXAwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 19:52:01 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:58296 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbeKXAwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 19:52:01 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gQC78-0003vG-7Y; Fri, 23 Nov 2018 14:07:22 +0000
Date:   Fri, 23 Nov 2018 14:07:22 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Pan Bian <bianpan2016@163.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] exportfs: do not read dentry after free
Message-ID: <20181123140722.GA2217@ZenIV.linux.org.uk>
References: <1542959793-118334-1-git-send-email-bianpan2016@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542959793-118334-1-git-send-email-bianpan2016@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 03:56:33PM +0800, Pan Bian wrote:
> The function dentry_connected calls dput(dentry) to drop the previously
> acquired reference to dentry. In this case, dentry can be released.
> After that, IS_ROOT(dentry) checks the condition
> (dentry == dentry->d_parent), which may result in a use-after-free bug.
> This patch directly compares dentry with its parent obtained before
> dropping the reference.

It's a bit more subtle than the description implies (the race has
dentry connected during dget_parent() and the child we'd reached it
through moved elsewhere during the dput()), but you are right - the
race is there and that patch fixes it.

I wonder if we could avoid those dget_parent()/dput() completely -
looks like we might be able to with rcu_read_lock() and some
care.  OTOH, that's not going to be a hot path, anyway...

Applied.
