Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C419CC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AAFB21A57
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a1T5jdmg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AAFB21A57
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733246AbeHFSoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:44:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33966 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731469AbeHFSoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6Tx5ASxD79Eo36oz0h816NYhLWNJjVzjSKKKe+P+Ptc=; b=a1T5jdmgBVZY6HfaPpvYyjutD
        dPDbLhSBlCUrNq+xvU/kFGWrJecxjGeI1xbKX1xPa/mEF499VqcZ3t3NPnW8ePR8zbEp/59XmofGH
        UVbp77GUnWGZk6QaLQnpdl+WmUlGQQln4Y4CU2FyJvcM3Z345zdJhHdP/0kiRT6trqNwRWPDt7PKF
        Wv8xR73WKjlhzMbrNX4O4sWxxzs5dCXOAU2zhcgDe50tLnM1LvccZEr7Lv0kDDvcZHSEmC9cddTsm
        JmyWl070xYImD34J09HnMuSScXrruEsCjuWkrO3AcCQC9B4z8fNM3s4KslrQAJnlrL68nJGzWyYbm
        I7O9ldIrQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmiSb-00043M-5G; Mon, 06 Aug 2018 16:34:21 +0000
Date:   Mon, 6 Aug 2018 09:34:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        robh@kernel.org, srikar@linux.vnet.ibm.com, aik@ozlabs.ru,
        Jason Wang <jasowang@redhat.com>, linuxram@us.ibm.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, paulus@samba.org,
        joe@perches.com, david@gibson.dropbear.id.au,
        linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net,
        haren@linux.vnet.ibm.com
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Message-ID: <20180806163421.GA13077@infradead.org>
References: <b31d2162-884c-0ed4-00df-e7debe0cc0e7@redhat.com>
 <20180803220812-mutt-send-email-mst@kernel.org>
 <01c74680c4b3aa25d9b4375a9ab5e10046b7c71b.camel@kernel.crashing.org>
 <20180805032355-mutt-send-email-mst@kernel.org>
 <74a1e1b8-81e0-84db-6d0d-d8bd9caebb4a@linux.vnet.ibm.com>
 <20180806163440-mutt-send-email-mst@kernel.org>
 <20180806152406.GA29020@infradead.org>
 <20180806190321-mutt-send-email-mst@kernel.org>
 <20180806161040.GA4675@infradead.org>
 <20180806191111-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806191111-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 07:13:32PM +0300, Michael S. Tsirkin wrote:
> Oh that makes sense then. Could you post a pointer pls so
> this patchset is rebased on top (there are things to
> change about 4/4 but 1-3 could go in if they don't add
> overhead)?

The dma mapping direct calls will need a major work vs what I posted.
I plan to start that work in about two weeks once returning from my
vacation.
