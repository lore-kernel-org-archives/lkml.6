Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6F3C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4922083C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QV2BZufm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E4922083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbeJOUin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 16:38:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59674 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbeJOUin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 16:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ye7qdguWGVMxyMFXGZc3mYxNm8/GKTNpe/iAI/SCtS4=; b=QV2BZufmKOTf53vuMKCSaQufu
        QvYcfWUVnYvkiZFOt1oXs7HDYBMjLr538iYpzEUAFkl4pn9Sa7qFuHBkb8bEef4clo+mwacinPW2T
        BtJlH5uVYVnn3TlQggyR4P0yYYJOcYyPFUH+03x6tExukzvmcq+AK6KI/mEKAK3IVe14vCFmp714r
        jC9q5BXQic0xJqxA9vdYsQa5udR9Buz4wtW/6rrt7WEYDrc/HdKoShfTf+rnK8n30lH0BEI8c+hiv
        cYgirtyBSi2S7k7n9OLQW+QEvCQPIl8lp2cbvAb2KKzZuU5q88ZBiBlEdgR8K0rap/BC4KYWtnd+7
        U9AjsK6Fg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gC2NF-0002cR-7y; Mon, 15 Oct 2018 12:53:29 +0000
Date:   Mon, 15 Oct 2018 05:53:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-scsi@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] esp_scsi: De-duplicate PIO routines
Message-ID: <20181015125329.GA8952@infradead.org>
References: <cover.1539497520.git.fthain@telegraphics.com.au>
 <d5fe773ea8c922631836dad2ef2dbb952672c7c7.1539497520.git.fthain@telegraphics.com.au>
 <35ac9f31-7068-ab93-4629-363ee0bb4c70@suse.de>
 <alpine.LNX.2.21.1810151717520.10@nippy.intranet>
 <2b48c925-73f0-0ca0-2f3c-3c35d90010ba@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b48c925-73f0-0ca0-2f3c-3c35d90010ba@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 12:58:42PM +0200, Hannes Reinecke wrote:
> However, the function declaration really is a worry, as the actual function
> body only exists when the config option is enabled.

Having a prototype without an implementation is no problem at all.
We have this case all over the kernel, either intentionally to keep
things simple or due to bitrot.
