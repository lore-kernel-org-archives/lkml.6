Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE79C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 13:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186F620871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 13:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kFS66LDb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 186F620871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbeKKXDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 18:03:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38244 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbeKKXDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 18:03:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QcfNAI18aA07sNspTze2U/q/d5iUkQTcdWp2IB6S2y0=; b=kFS66LDbOH2My+pLclDXfUP9v
        sevfTF+BqHirp2h+761uk6Qziips9/0yXactzyC7ForBINuJC5XdS+54khreiJ4OtpzLLJNs4Ej4w
        imdFq+kB8Ta2vbhMTePg2BoELor6wWdSsQETJEA5494+8LM+c8ZgwYazx0Q8jl65fnXVeHvJiwnGg
        Cr2wuhz6ArhuxaoX3wXDuk++9AIjAwiXLZW90sYhJvoweDLP70F3t85d+OLvW7ddyvGOhOrcNXAor
        ipEI8tsu+8++FTRYFyNV9pCBDkWndFVyU3QXSmrv531pSf2X5hZyAlAwKHMSiNMEFxa5z5Utsd4nx
        V7gh1+v+w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gLpZd-0001nW-QD; Sun, 11 Nov 2018 13:14:45 +0000
Date:   Sun, 11 Nov 2018 05:14:45 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH 0/3] SG_IO command filtering via sysfs
Message-ID: <20181111131445.GB25441@infradead.org>
References: <1541867733-7836-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541867733-7836-1-git-send-email-pbonzini@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think this goes in the wrong way.  There isn't really any point
in filtering at all if we have access to the whole device by the
file persmissions, and we generally should not allow any access for
partitions.

I think we need to simplify the selection, not add crazy amounts of
special case code.
