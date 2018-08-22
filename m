Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA67AC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 06:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 662C0214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 06:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EvedmypN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 662C0214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbeHVJnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 05:43:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35580 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbeHVJnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 05:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=u6E1f7as2JOKYtb+GLX+v9A1/h7lIwwkHpNzry0isTw=; b=EvedmypNYv0qnMvrkA7qin2To
        wXWNGCM4AnXzZ91iGvATB+bP/III05bV6qNltOGIvacnOE+sZOOrrqu/5W4FZ+CngrUuxGEKlk3j9
        jdfVw8BnL/Hr0zqZjyy8Y1RVm091GIqg7God+PV77YiVRb+TfAdqXBhPuCMC+BzRCjR2MClQTVvvD
        iz5Zf3BtXeXtEwxyUHLOLiL4pGAIB+33eGSwYr2/qI2OYzNfjPR9CiTupeUvMFjK/g60ul0NB03ED
        QaGH38eUr3ilvgC22/tBt5ivxBmi2GDcjcxoTc7dP7ApXFywaAM8h87Jxo2edp8Xsg02oU7yJmI29
        x438laHNg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fsMV6-0006Dc-Eo; Wed, 22 Aug 2018 06:20:16 +0000
Date:   Tue, 21 Aug 2018 23:20:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jeff Lien <jeff.lien@wdc.com>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, herbert@gondor.apana.org.au,
        tim.c.chen@linux.intel.com, david.darrington@wdc.com,
        jeff.furlong@wdc.com
Subject: Re: [PATCH] Performance Improvement in CRC16 Calculations.
Message-ID: <20180822062016.GA10356@infradead.org>
References: <1533928331-21303-1-git-send-email-jeff.lien@wdc.com>
 <yq1in4gq5jf.fsf@oracle.com>
 <yq1lg8zb2lp.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1lg8zb2lp.fsf@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 09:40:34PM -0400, Martin K. Petersen wrote:
> When crc-t10dif is initialized, the crypto infrastructure will pick the
> algorithm with the highest priority currently registered. Both block and
> SCSI will cause crc-t10dif to be compiled as a built-in so this
> selection happens very early.

Ouch.  This might actually happen in a lot of other users of the crypto
functionality as well.

> However, it seems like a bit of a deficiency in crypto that there is no
> way to upgrade existing transformations if higher priority algorithms
> become available. btrfs and a few others work around this issue by not
> using the generic lib/ CRC functions (which defeats the purpose of
> having these in the first place). Instead they are registering their own
> transformation at a later time where any accelerator modules are more
> likely to be loaded.

If we can't fix this in crypto (which doesn't seem that easy), we
should at least clearly document the issue somewhere, and fix this in
the t10pi code by initializing crct10dif_tfm in a lazy fashion only
once the fist block device starts using it.
