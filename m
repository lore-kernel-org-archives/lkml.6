Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C7FECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778EB204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pJhcH+gD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 778EB204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbeKEQYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 11:24:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43298 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbeKEQYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 11:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rDlJU+avhBOOkAlmmbw6yFBIrMoK91VCCurFwfqfiPM=; b=pJhcH+gDkouRh20G82UFsRqTXf
        WobjTX8Qpj8VzhTdskRFkj4jSILYitBJE31qLdilKxhF0orYLw6nWIzUWW4bqm1A5o9sCNapazKQj
        PDWtrG69fB/AYPeUEeTvKGz4pIVjWCMaA0oEhq+E4OWw5LH6noPJyL8FGmqAugfdVl9Qongik7xrw
        bGkdhwv/QThwdZvxbvJlM5F4zzgqNtpQhgOXvQtdX35IQS6D5AU7oMMkq8Rns0s2bvcziMI6d4tlQ
        LP1oHCFOlz9SUyug1DzUvwk0OHnXVBrfbyb1fnzHDuzfSz3QyJovNmQ4/IWAOI+AQAfenRE3Jbn9v
        wVfoggpA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJYxM-0003CI-2o; Mon, 05 Nov 2018 07:05:52 +0000
Date:   Sun, 4 Nov 2018 23:05:51 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Vincent Chen <vincentc@andestech.com>
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu, zong@andestech.com,
        arnd@arndb.de, alankao@andestech.com, greentime@andestech.com,
        linux-kernel@vger.kernel.org, kito@andestech.com,
        linux-riscv@lists.infradead.org, deanbo422@gmail.com
Subject: Re: [RFC 0/2] RISC-V: A proposal to add vendor-specific code
Message-ID: <20181105070551.GA7274@infradead.org>
References: <CAAhSdy0Y_jdc=2Lf8epof_+7HigCfhDxMNe8EF0fHfncqhs-zA@mail.gmail.com>
 <mhng-01f0ac6a-c2fd-41be-9d53-44d1c139d453@palmer-si-x1c4>
 <20181101174857.du2zu4vnrhpu5asf@excalibur.cnev.de>
 <20181105065807.GA1286@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181105065807.GA1286@andestech.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 02:58:07PM +0800, Vincent Chen wrote:
> Many thanks for kinds of comments. I quickly synthesize the comments and
> list them as below.
> 1. The kernel image shall include all vendor-specific code.

I fundamentally disagree with this… and think it should be the contrary.

1. The kernel shall support no vendor specific instructions whatsoever,
period.
