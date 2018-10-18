Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0746CC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02F62145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TekopGdQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02F62145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbeJRUmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 16:42:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41598 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeJRUmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 16:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BbCoSgNmevvgmxCCTgwkYBHerA8NR3F72BNH3r91svk=; b=TekopGdQalCMYPZZw32Gm7/T4
        FVjsft4peNWAYy9jG0jcVjMmu2J6XTLZy/8L++QseK1fnDrxLaPeKXzw1heBphf2iN92D1QwQj13d
        ABVDG+D46O4zRnvzOY0coJMNZwJMYMzDN9DlIag+Rlh9wfrwnH7NbAEhII6H7hoio0IEMJ4umFkAr
        g1iqEhdpbjOlM9IIp5yFbYjo9e5SYbsg0ikxqvQ9pmjP9Hf+OKtnnxNMUOhQbqE4gWwImEzUevXKi
        4wyFuRw4pm4wqTOF7r7csucNk4RIKquA1Cl+SDCKxVhO3zxgfOhx/KyRw+GGWPllwFvw4dhwCkfvb
        4IgmkPkMQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gD7c6-0004en-MA; Thu, 18 Oct 2018 12:41:18 +0000
Date:   Thu, 18 Oct 2018 05:41:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: add Buddha PATA controller driver
Message-ID: <20181018124118.GA10376@infradead.org>
References: <CGME20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457@eucas1p2.samsung.com>
 <20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457~es8dn4Tg90035600356eucas1p2H@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457~es8dn4Tg90035600356eucas1p2H@eucas1p2.samsung.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int __init pata_buddha_init_one(void)
> +{
> +	struct zorro_dev *z = NULL;
> +
> +	while ((z = zorro_find_device(ZORRO_WILDCARD, z))) {

I'm not really an m68k expert, but shouldn't this implement a
struct zorro_driver instead?  (or maybe two of them as xsurf
seems sufficiently different).
