Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DC7C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C41D2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fUmsnBE8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C41D2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbeJONft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 09:35:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54338 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeJONft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 09:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=u8SqXO869Fypoollilqk2m6Wy2EBIusIKW9x1jr+Mp0=; b=fUmsnBE8QxChKwNEfL/UpFNST
        yTd3PPFdkUBXEVbssds7FD+aqs65YlgMsjuHiuwK03KZvcfDK89hRHzRpvKrKTfYOsx//rKQ1fH2n
        C1mnr5MV2bstwKqUbc59yrWCKsOFGmHwx7YGhdb85I1dkkQBtgy2OVmD9MJN9ws4nCDyq6lByienN
        snZYlyGtpsbuZDKe6MtHZtPjP3QDRLiE3w9yShYKRZFiCHC3hPOCc46jlpU7BK62pWCrI9HgXA23C
        2LFHRSQbRJ8otJTljwtC8lEHuFBjfejZt4YQDZ4NL5WkI6ut2cqFVu1khTgdyZ2QvtfiozgcQkkrZ
        wh3B9jUhg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBvnN-0006uc-KS; Mon, 15 Oct 2018 05:52:01 +0000
Date:   Sun, 14 Oct 2018 22:52:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] esp_scsi: Grant disconnect privilege for untagged
 commands
Message-ID: <20181015055201.GA21295@infradead.org>
References: <cover.1539497520.git.fthain@telegraphics.com.au>
 <91b9ff9fc19ba40e3a2562171c8cd78a2ce7dc79.1539497520.git.fthain@telegraphics.com.au>
 <20181014154753.GA19252@infradead.org>
 <alpine.LNX.2.21.1810151004440.10@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.21.1810151004440.10@nippy.intranet>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 10:13:37AM +1100, Finn Thain wrote:
> On Sun, 14 Oct 2018, Christoph Hellwig wrote:
> 
> > > +	*p++ = IDENTIFY(lp && (tp->flags & ESP_TGT_DISCONNECT), lun);
> > 
> > I think lp should always be non-NULL here.
> > 
> 
> It's not clear from Documentation/scsi/scsi_mid_low_api.txt, but I guess 
> that's true for scanning of targets.
> 
> Is it true in general that queuecommand for a device will not occur before 
> its slave_alloc and not after its slave_destroy invocation?

Yes.
