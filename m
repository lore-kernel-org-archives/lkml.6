Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A0C2BC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF4020020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VtKgdb0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF4020020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935449AbeFML7e (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:59:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42444 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935242AbeFML7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3+8kOIdUjpRPRoytKNLWNnNmgjFA6N/QiaLH0nJLreQ=; b=VtKgdb0HLP6TqI8F9KXIWIyGM
        TGHl+iQ910lESOjQZxkcdRmkpy475ar0QaoI/YLJJqHj8H38g5gjtsmXcXukZEG9CHJgCyVUgJyXz
        bdlOeFD7sipiaUMTxzgfUX7OR5q5F283wY7e8aDYsJPcnNnh3ajQbpvMy9X7JpsN3jaqE1Hgf7JZX
        gbm8I7vEt6eiKM0sfnqAJjdlylzOycTUXtAFTEoSYDnlPyQIUiqZIZgsJaMzdoWKw8Up6oeiBP6f1
        16ZmWa6HyYsU7VuB8w76CgIbK+JYhLEzvpZGYoyobU0ukQxFbqb58XS5sS2DbR39Ctl5fooNJIADv
        mNhj+cdJg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fT4Qz-0004e9-QO; Wed, 13 Jun 2018 11:59:29 +0000
Date:   Wed, 13 Jun 2018 04:59:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] scsi: don't add scsi command result bytes
Message-ID: <20180613115929.GC12438@infradead.org>
References: <20180613075349.7509-1-jthumshirn@suse.de>
 <20180613075349.7509-4-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613075349.7509-4-jthumshirn@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 09:53:49AM +0200, Johannes Thumshirn wrote:
> Some drivers are ADDing the scsi command's result bytes instead of
> ORing them.
> 
> While this can produce correct results it has unexpected side effects.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

> -			cmd->result = (DID_OK << 16) + (l & STATUS_MASK);
> +			cmd->result = DID_OK << 16 | (l & STATUS_MASK);

Although I would have keep the braces around the shift operators
to stick closer to the original code.  But the code should be fine
even without them.
