Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C704C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C1C2172A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V7mgYnod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C1C2172A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbeHCJBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:01:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55096 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbeHCJBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DSazAx+/m05vrq2/RcGe6D1zl7+O39Y0CcGFHj6u9fk=; b=V7mgYnod2ytNUUPK6Gahqd+SC
        Lf9QMEwIoUc3pwDnCY8R8s8luXeWHl3Un/f1jKd/woBVuTF1SUr8gbfIpUAa/wAUG+HGwX9VHqrkt
        y6tWvduoe8HV1eDpGUuPoF32CI6l+9xBN0B+pIq/qdaYGl/cyUCDkOZgxhPhZ9XeS6nR66Rjgam1w
        cfHtKcLlmPPjRkAUtdscwUehZfoysBJ2awNOg12Aln0aWBfVoFmcs3v4fzS39KopRvWGBx/xniECd
        yotVkzfGojuWWfdBzaW/IBgFq6VfwVLOwvpuXLJBmSMIjXOz6zDbuiN/2ZX/pK4gxKVFVNDIUv0hd
        oLC5WGNMQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1flUAY-00025R-AE; Fri, 03 Aug 2018 07:06:38 +0000
Date:   Fri, 3 Aug 2018 00:06:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
        jasowang@redhat.com, mpe@ellerman.id.au, linuxram@us.ibm.com,
        haren@linux.vnet.ibm.com, paulus@samba.org,
        srikar@linux.vnet.ibm.com, robin.murphy@arm.com,
        jean-philippe.brucker@arm.com, marc.zyngier@arm.com
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Message-ID: <20180803070638.GB1344@infradead.org>
References: <20180727095804.GA25592@arm.com>
 <20180730093414.GD26245@infradead.org>
 <20180730125100-mutt-send-email-mst@kernel.org>
 <20180730111802.GA9830@infradead.org>
 <20180730155633-mutt-send-email-mst@kernel.org>
 <20180731173052.GA17153@infradead.org>
 <3d6e81511571260de1c8047aaffa8ac4df093d2e.camel@kernel.crashing.org>
 <20180802003823-mutt-send-email-mst@kernel.org>
 <7779442d7889ee943b3e4ff6c63ec90b4a58b79d.camel@kernel.crashing.org>
 <20180802235233-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802235233-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 11:53:08PM +0300, Michael S. Tsirkin wrote:
> > We don't need cache flushing tricks.
> 
> You don't but do real devices on same platform need them?

IBMs power plaforms are always cache coherent.  There are some powerpc
platforms have not cache coherent DMA, but I guess this scheme isn't
intended for them.
