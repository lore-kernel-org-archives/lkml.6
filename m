Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B326C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E4D2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eQPVGZae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E4D2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbeIJQUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:20:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54710 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbeIJQUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Mk1HL1H+7x4g6lTZivnPI31Ajh6Emm2JYk8arraEwyM=; b=eQPVGZaeEGlAmOaRLd/AKMpCd
        QyvSCBbT4ZImvu3chBRwmKTq3TgmLCaedNGsnlrPeTQxTjeofRMFHGccB5k/yPTnIcuOsYIOsdmmu
        aHRO1D2zTW5xdVwXnvX4jRW+KEmuWuTFCKVSeZ4363u4ubKaLRxVoN8njUCjDQWAiPkYHEk3oCTqw
        eQhA+hgcg51/8Hgv0pJOO+2Ek++B+KdeePWTCxiU2+5FG6VIxgB4lqcpRaY3xLOqPGq2dVB8qJ021
        CYmSqPQBOrT9FEo79SbxEWguGuuVOjG5e4LCimUN0bmeRh3OdkKJhVelIPbtMOa1UT3UNqarOWKgu
        H/l2LPEng==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzKLV-00079C-Gz; Mon, 10 Sep 2018 11:27:09 +0000
Date:   Mon, 10 Sep 2018 04:27:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        hch@infradead.org, anup@brainfault.org, mark.rutland@arm.com,
        Damien.LeMoal@wdc.com, jason@lakedaemon.net,
        ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
        gregkh@linuxfoundation.org, dmitriy@oss-tech.org,
        linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
        catalin.marinas@arm.com, tglx@linutronix.de
Subject: Re: [PATCH v3 09/12] RISC-V: User WRITE_ONCE instead of direct access
Message-ID: <20180910112709.GH12979@infradead.org>
References: <1536221135-182613-1-git-send-email-atish.patra@wdc.com>
 <1536221135-182613-10-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536221135-182613-10-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 01:05:32AM -0700, Atish Patra wrote:
> The secondary harts spin on couple of per cpu variables until both of
> these are non-zero so it's not necessary to have any ordering here.
> However, WRITE_ONCE should be used to avoid tearing.

We normally pair WRITE_ONCE with READ_ONCE.  But it seems like the
reader side is in assembly code, so this should be ok:

Reviewed-by: Christoph Hellwig <hch@lst.de>
