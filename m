Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3F7C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D9C2098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZBl+vmo8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7D9C2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeJCVuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:50:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40100 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbeJCVuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=x7f6LU10c53UVSgLF+WE4/BpBRc9UAOnYAYmYYMXwI4=; b=ZBl+vmo8HrtRpC6b4RlIYYqQZ
        eSHMRvz/+QQUEdj11X0fwrPJ6JqM/Bcpw9R1lhSE9am0Qn2PvLk5k1JZo0K1tVYbWh2V29PzYkp/C
        YymGaXVtkgHx0dwVpPvJZe4ABFEXl6w//k0uEb6fm4VpRIX6R5ZuJSuYac/bXx/u4ZHVIEWdAem2G
        9bsNAeoPGn8vNSCgR9MJRFJNgQiIEUPTXD6S3yyuMLvkTjwHKR7JwfIokfYochhBoPebERVLanBEI
        NUJJUWQSQYQ7v4u9l5Kpsy5rbXPcbhT/6M9ZUcFLi0Ml7W76d3QSyUXIxNG6lncozI6RC4PMkMnFp
        5P+Lm6xcw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7ieZ-0001zE-MO; Wed, 03 Oct 2018 15:01:31 +0000
Date:   Wed, 3 Oct 2018 08:01:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jan Kara <jack@suse.cz>,
        "aherrmann@suse.com" <aherrmann@suse.com>,
        "mgorman@suse.com" <mgorman@suse.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bfq-iosched@googlegroups.com" <bfq-iosched@googlegroups.com>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] block: BFQ default for single queue devices
Message-ID: <20181003150131.GA7306@infradead.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538550325.14984.108.camel@gmail.com>
 <CACRpkdaLZXGKMQGJPH02p2QPkxUDA03Y=cu_wBR_+rFaLWTw7g@mail.gmail.com>
 <BN3PR0401MB164003C967C45F2681F503A7E7E90@BN3PR0401MB1640.namprd04.prod.outlook.com>
 <20181003125146.GA9313@infradead.org>
 <1538578732.205649.0.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538578732.205649.0.camel@acm.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 07:58:52AM -0700, Bart Van Assche wrote:
> Has the work with the T10 committee to standardize the SCSI equivalent of anonymous
> writes already started?

No, and I don't know of anyone who wants to do that in the short term.
