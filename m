Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634DBC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD6520676
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hbqexAHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CD6520676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbeI1Wko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:40:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59784 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeI1Wkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pWEuDD3qaUukmH4G8pD3vcrUGpAOjKGscymgfguadtY=; b=hbqexAHh6eULxV9StjlMSz9UT
        QHmfcdjZNk/Dp0JBesnkQeEkXnebaPolR4QWNRSXaLCZb2s6YOpmot6Ygj2GN4VYYuPehSmoEu5bG
        NY0NZNI+0Yot+0UPQAgf36g7c41999scE5rdZqv8FYmNQryZG++3TwNqNTa6LHX2zktPVbtd/0xVq
        mun9sDX0nz06u7eLH2BqTblqkZfygz+NZOHEFRDRaSFQmnHSHD2qDdaYXQ6bR/lIoKTEftE1l79RY
        bCpOnJVJ4sDfyhJNeZDoIiBVThGiT5FJFptYXChpo/tlgdbd14hLDW/6aH+7IvwzcugbnGTEFfQWo
        V7sgb2k7w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5vR3-0000Yy-CD; Fri, 28 Sep 2018 16:16:09 +0000
Date:   Fri, 28 Sep 2018 09:16:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, green.hu@gmail.com
Subject: Re: [PATCH V6 05/33] csky: System Call
Message-ID: <20180928161609.GD19827@infradead.org>
References: <cover.1538058840.git.ren_guo@c-sky.com>
 <c98f0fc0103196e839bdc016f50f227fce8c54b1.1538058840.git.ren_guo@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c98f0fc0103196e839bdc016f50f227fce8c54b1.1538058840.git.ren_guo@c-sky.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +
> +static inline void
> +syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
> +		      unsigned int i, unsigned int n, const unsigned long *args)
> +{
> +	BUG_ON(i + n > 6);
> +        if (i == 0) {

Please fix your indentation - again checkpatch.pl will be helpful (even
if it sometimes is a littler overzealous).
