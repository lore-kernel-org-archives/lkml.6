Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340A6C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D946B2083E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W57sdEJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D946B2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388647AbeHAKJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:09:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50892 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387699AbeHAKJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rnYMVv5RaPjWuXEAvUJS7VeNLbJ3P6eiDem+JGZZnTw=; b=W57sdEJkIn7W/kKPt+mBqPG6j
        ExxQFOkJooicwSba8do5M7oRSGDSIuM5UCygdCujTxXLheXhqZ1J+vHHjpzPcibAKgDcFqZ6j7Fm4
        t/2R82gybA7f0zg02cESEjGleCFcT7jUdwYEbEpTFj2s2r4PptqGITqrEb4Py/8waOpMMBWIVCHjw
        dmm1M2Oj+wtpYQyOAYRKNpLCNaWOE9DiatOqjIqkk+HbKT3nUdiwR3t25OQi0q+1q1RLjAc3RJpIV
        q8950df77PRXWw5rg3Z5cWE1V4YxvUjJAo67qaTeokWrWs3DSMot7OW0OE9NMvnOecVT5OAacRu0O
        6a7zP0Fvw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkmQn-0000mo-Me; Wed, 01 Aug 2018 08:24:29 +0000
Date:   Wed, 1 Aug 2018 01:24:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
        Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Juergen Gross <jgross@suse.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vinod Koul <vinod.koul@intel.com>,
        David Kershner <david.kershner@unisys.com>,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/9] libata-scsi: Move sense buffers onto stack
Message-ID: <20180801082429.GD26378@infradead.org>
References: <20180731195155.46664-1-keescook@chromium.org>
 <20180731195155.46664-9-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731195155.46664-9-keescook@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 12:51:53PM -0700, Kees Cook wrote:
> To support future compile-time sizeof() checks that will be able to
> validate the length of sense buffers, this removes the only dynamically
> allocated sense buffers in the tree by putting the 96 byte sense buffers
> on the stack.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
