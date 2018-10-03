Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6572C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 02:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C70020878
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 02:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="cZ2iJrTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C70020878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbeJCJIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 05:08:18 -0400
Received: from imap.thunk.org ([74.207.234.97]:49800 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbeJCJIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 05:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=mAehQJ5uEUq+K8zl0TM89r6mCU7xifDolHlOOnds+Fw=; b=cZ2iJrTpnM17g1J0MVcJDQ+LwA
        OX8LEAbQFk+uPbPvRUVHhDjlA1JlPEzKNG5tWvB8rceMp4fBrC+6onjV6A/7FyLl4v1FETwIobEAi
        LgLXd1BSzIZ25ofV6QYiZHgkkeFZ1ejwqf5h5q3X53YUAYOGWfnVc9p+h+TpZgLmZesM=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1g7WnJ-0002NJ-LM; Wed, 03 Oct 2018 02:21:45 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 49C5B7A5187; Tue,  2 Oct 2018 22:21:44 -0400 (EDT)
Date:   Tue, 2 Oct 2018 22:21:44 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     adilger.kernel@dilger.ca, darrick.wong@oracle.com, axboe@kernel.dk,
        nborisov@suse.com, ak@linux.intel.com, viro@zeniv.linux.org.uk,
        kemi.wang@intel.com, willy@infradead.org,
        gregkh@linuxfoundation.org, ebiggers@google.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/ext4: Convert fault handler to use vm_fault_t type
Message-ID: <20181003022144.GB18521@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Souptick Joarder <jrdr.linux@gmail.com>, adilger.kernel@dilger.ca,
        darrick.wong@oracle.com, axboe@kernel.dk, nborisov@suse.com,
        ak@linux.intel.com, viro@zeniv.linux.org.uk, kemi.wang@intel.com,
        willy@infradead.org, gregkh@linuxfoundation.org,
        ebiggers@google.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180910154611.GA20252@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910154611.GA20252@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 09:16:12PM +0530, Souptick Joarder wrote:
> Return type of ext4_page_mkwrite and ext4_filemap_fault are
> changed to use vm_fault_t type.
> 
> With this patch all the callers of block_page_mkwrite_return()
> are changed to handle vm_fault_t. So converting the return type
> of block_page_mkwrite_return() to vm_fault_t.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Thanks, applied.

					- Ted
