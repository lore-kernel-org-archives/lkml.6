Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAC7C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 06:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D4B20841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 06:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ECvIjBqc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D4B20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbeJKOCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:02:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37420 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbeJKOCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 10:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4EUZ5NvUr3RuRYyGyxhgK2eondH8Yj++rWF97uemOro=; b=ECvIjBqcOokzAcuWzJLZ5QAPk
        5vymqjWvS+QQ6QuJ9yR9rREFAMR5djSE40rBaBw+S98gPhBGEWQDHlcb4n7rDo7Q2tv5Q8yjrc+Ay
        gxMbuAGNNpVq12SvEoV8bM0IoXG/hNlupaiGQEuIfrb6jVRY1Ur5tMfVO4MTfW0QfeLYOqAezYnNn
        h3DXPmzfLBSXc5ECEd3rQVHLcKZyIez/I0YFVHm6pZAq78IGuc9x3r/r9+micnQQXA0GolrKlbBqc
        Tcy5BO0/LE19/6sHif/uBnGw4KB+tIWYxwjxKcP+rXefcsH7Ci9rXAUa1j0UtEgtX3TBf9mIGAmmg
        huO1L5qSw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gAUZo-0002Ab-04; Thu, 11 Oct 2018 06:36:04 +0000
Date:   Wed, 10 Oct 2018 23:36:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     John Garry <john.garry@huawei.com>, jejb@linux.vnet.ibm.com,
        linuxarm@huawei.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] hisi_sas: Misc bugfixes and an optimisation patch
Message-ID: <20181011063603.GA3456@infradead.org>
References: <1537801594-207139-1-git-send-email-john.garry@huawei.com>
 <yq18t354532.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq18t354532.fsf@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 09:58:25PM -0400, Martin K. Petersen wrote:
> > This is because the IPTT index must be a unique value per HBA. However,
> > if we switched to SCSI MQ, the block layer tag becomes unique per queue,
> > and not per HBA.
> 
> That doesn't sound right.

blk-mq tags are always per-host (which has actually caused problems for
ATA, which is now using its own per-device tags).
