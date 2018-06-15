Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2908C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71E620896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71E620896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966142AbeFOQtk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:49:40 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40224 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966024AbeFOQtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:49:36 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fTruk-0005zP-Iq; Fri, 15 Jun 2018 16:49:30 +0000
Date:   Fri, 15 Jun 2018 17:49:30 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Jann Horn <jannh@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Doug Gilbert <dgilbert@interlog.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        security@kernel.org
Subject: Re: [PATCH] sg, bsg: mitigate read/write abuse, block uaccess in
 release
Message-ID: <20180615164930.GE30522@ZenIV.linux.org.uk>
References: <20180615152335.208202-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615152335.208202-1-jannh@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 05:23:35PM +0200, Jann Horn wrote:
> As Al Viro noted in commit 128394eff343 ("sg_write()/bsg_write() is not fit
> to be called under KERNEL_DS"), sg and bsg improperly access userspace
> memory outside the provided buffer, permitting kernel memory corruption via
> splice().
> But they don't just do it on ->write(), also on ->read() and (in the case
> of bsg) even on ->release().
> 
> As a band-aid, make sure that the ->read() and ->write() handlers can not
> be called in weird contexts (kernel context or credentials different from
> file opener), like for ib_safe_file_access().
> Also, completely prevent user memory accesses from ->release().

Band-aid it is, and a bloody awful one, at that.  What the hell is going on
in bsg_put_device() and can it _ever_ hit that call chain?  I.e.
	bsg_release()
		bsg_put_device()
			blk_complete_sgv4_hdr_rq()
				->complete_rq()
					copy_to_user()
If it can, the whole thing is FUBAR by design - ->release() may bloody well
be called in a context that has no userspace at all.

This is completely insane; what's going on there?
