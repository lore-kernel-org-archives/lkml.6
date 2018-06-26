Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0000DC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8766525CC8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AH5iHRj8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8766525CC8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933700AbeFZXA7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 19:00:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51866 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933304AbeFZXA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 19:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Mx5UGowW7YcLHJw5uH8dxZIUAxvl9Kzd/zVKwWW042s=; b=AH5iHRj8NX4R2cUbGo78MCQRY
        PRQi2oOLdDnn2demTqtCSmQpzG+srWdJxhYicwqRikjvp2iaqxNkn2UvQHZBJhLsS3Q4l5FA2ObFv
        2mj3Osb3ENa0VygoI47ioV6jVzyh0rhfPsUhOpxECWISQ9BzkXm7kkaUsOIVwXOk51OsDN4SybR2v
        MMR0+DDy0nLiyWyjKVxuUM6n+HINGkxh1uw/r+9u/mmrFmGlzAC7vHuoBtG8vFFLjFKILz1N2QTIh
        Z86VHVSyAMnufpZpTmGZgAqzb16kVpO6rghxzPJY5IwPO16jdKuLe13dqEzoZNoaemyDIJxpZGSUf
        uUCUYni/w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXwxF-0002hr-Ew; Tue, 26 Jun 2018 23:00:57 +0000
Date:   Tue, 26 Jun 2018 16:00:57 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Subject: Re: [PATCH 16/26] dmaengine: Convert to new IDA API
Message-ID: <20180626230057.GB17633@bombadil.infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
 <20180621212835.5636-17-willy@infradead.org>
 <c198586d-ab68-63f5-99fc-39401ee20cad@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c198586d-ab68-63f5-99fc-39401ee20cad@metafoo.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 24, 2018 at 09:57:45AM +0200, Lars-Peter Clausen wrote:
> > +	int rc = ida_alloc(&dma_ida, GFP_KERNEL);
> >  
> > +	if (rc >= 0)
> > +		device->dev_id = rc;
> >  	return rc;
> 
> This used to return 0 on success, now it returns the ID. That wont work
> considering that it is used like this
> 
>     rc = get_dma_id(device);
>     if (rc != 0) ...

Thanks!  I changed it to this:

static int get_dma_id(struct dma_device *device)
{
        int rc = ida_alloc(&dma_ida, GFP_KERNEL);

        if (rc < 0)
                return rc;
        device->dev_id = rc;
        return 0;
}

