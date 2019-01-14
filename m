Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7F1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8340120657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KmyuuGrp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfANP3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:29:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54884 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbfANP3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:29:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8bJ5x4QhH1lSLXEmkoF26Xy+Uw4AGp/rjF1C8MY36Ww=; b=KmyuuGrp3yqk0dpcSMP0v1gWP
        jO31ViLRfjOrB4J7BRgnYbqEVz+KvOemC4Asa3o9ZpA3mpNunLVRH3xUG4AtZ/hett1HECe1Ug6Xz
        cV687EAkmQfPFWLvHdG/UomkDwxWOLeK1WI86OF3rQ9BOGK/Rpw99c6WbSFaj/9HWQt5Re1Yo3kfz
        ewh+BqJpqGzq0YzjP/pECYKJ2bKLkw95SaQDldu59kApCuDa2wqBkpLPYr3+6oKgaeqF5XbzqAQ5u
        Mwl2e1AOPVpgOPDFymHozwnDjvnIUbN7NQm74i2j45w96pqTo4OU6RSQix9K8CsjTwCXhZMf6WEab
        TdYL8CeZQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gj4BL-0003Wr-Mo; Mon, 14 Jan 2019 15:29:43 +0000
Date:   Mon, 14 Jan 2019 07:29:43 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     wangbo <wdjjwb@163.com>
Cc:     linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, wang.bo116@zte.com.cn,
        Ondrej Zary <linux@rainbow-software.org>
Subject: Re: [PATCH] scsi: wd719x Replace GFP_KERNEL with GFP_ATOMIC in
 wd719x_chip_init
Message-ID: <20190114152943.GA10454@infradead.org>
References: <1547479489-11560-1-git-send-email-wdjjwb@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547479489-11560-1-git-send-email-wdjjwb@163.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 11:24:49PM +0800, wangbo wrote:
> wd719x_host_reset get spinlock first then call wd719x_chip_init,
> so replace GFP_KERNEL with GFP_ATOMIC in wd719x_chip_init.

Please move the allocation outside the lock instead.  GFP_ATOMIC
DMA allocations are generally a bad idea and should be avoided where
we can.

More importantly we should never actually trigger the allocation
under the lock as far as fw_virt will always be set already
in that case.

So I think you can safely move the request firmware + allocation
+ memcpy from wd719x_chip_init to wd719x_board_found, but I'd rather
have Ondrej review that plan.
