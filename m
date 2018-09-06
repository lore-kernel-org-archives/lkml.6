Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D310DC4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE2020659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="uPSPXBMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE2020659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbeIGDUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 23:20:06 -0400
Received: from imap.thunk.org ([74.207.234.97]:60732 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbeIGDUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 23:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=slsTku73Cxw/ihQxR6Z0iOhKkYfMux615hAUa0qRy7U=; b=uPSPXBMtkyaLBYDSRCqYIoLG0y
        U1MfNTK/A7Zbog4x2EYn7VQGB7512NmJsfykl4Euv51SloLdMbqbI4psG60ORH5WnTR5zcSft1qQS
        6ngyqQUuR2OZKntpk55zBzqUcootRkVPgq8jRmyOl0l4w4FP7RslBEUzqZFXZ+DLcmq0=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fy2yZ-0007vp-Dx; Thu, 06 Sep 2018 22:42:11 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A19477A5675; Thu,  6 Sep 2018 18:42:10 -0400 (EDT)
Date:   Thu, 6 Sep 2018 18:42:10 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Xuewei Zhang <xueweiz@google.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aditya Kali <adityakali@google.com>,
        Guenter Roeck <groeck@chromium.org>, maze@google.com
Subject: Re: [PATCH] scsi: sd: Contribute to randomness when running
 rotational device
Message-ID: <20180906224210.GK5098@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Bart Van Assche <bvanassche@acm.org>,
        Xuewei Zhang <xueweiz@google.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Christoph Hellwig <hch@lst.de>, Paolo Bonzini <pbonzini@redhat.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aditya Kali <adityakali@google.com>,
        Guenter Roeck <groeck@chromium.org>, maze@google.com
References: <20180906203719.209399-1-xueweiz@google.com>
 <1536272873.26747.11.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536272873.26747.11.camel@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 03:27:53PM -0700, Bart Van Assche wrote:
> 
> Although this patch looks fine to me, seeing this patch makes me wonder
> whether the default should be changed (QUEUE_FLAG_MQ_DEFAULT) instead of
> modifying the sd driver. Can anyone remind me why QUEUE_FLAG_MQ_DEFAULT does
> not include QUEUE_FLAG_ADD_RANDOM?

There was a discussion about a number of *years* ago; blk-mq has been
baking for a very long time.  In the early days of block_mq, the
overwhelming percentage of the users of blk-mq where those who were
using PCIe attached flash.  So when, I raised this question, the
argument was that SSD users have no entropy.  Which I agree with; but
now that blk-mq is the default, and hard drives are using blk-mq, it's
time for a patch like Xuewei's.

Cheers,

					- Ted
