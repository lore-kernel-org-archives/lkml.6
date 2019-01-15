Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3E6C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6AC20656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LDmnOvpE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbfAONbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:31:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57734 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfAONbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:31:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WgbgoAZdXNB2yNgsOaH7IMbytM8LKpkXIm+QG1ONC+8=; b=LDmnOvpEAya2ZQrvh+ROv5036
        qQ+khj9df4ruNh69/ahdnhr09BVIWTdeAGMjQwFrMtQAo4kDOda7NMf4Y5fTAYW0r8D1izy+k6o9w
        s+6EFGNP9QYxkKIbJp9GnTiUSHnB3pquXubKuadwNiZLLkr9FDOBCwTtIoUYeRFcQWdunR/5ilfqh
        eFklEYHT5EbjSgIKRYcPPWWXWGpN9eVkxZg7Py3YmaE25OR3jE8yjZZ2Ijygv0Ue/ewS+tOUq6efB
        /TjT5RLBieKq/iIKjI7Cgxf+nlw5EQ4R0e3z5Kz5OgR+UzZGcPVJi+u2jvI/OjL1rKT15NjXgTkrZ
        XOdJlzLuw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjOoJ-0001BM-2W; Tue, 15 Jan 2019 13:31:19 +0000
Date:   Tue, 15 Jan 2019 05:31:18 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Guan Yung Tseng <guan.yung.tseng@ni.com>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] 8250_pci.c: Update NI specific devices class to multi
 serial
Message-ID: <20190115133118.GA31202@infradead.org>
References: <1547547005-2149-1-git-send-email-guan.yung.tseng@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547547005-2149-1-git-send-email-guan.yung.tseng@ni.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 06:10:05PM +0800, Guan Yung Tseng wrote:
> +/*
> + * NI Serial devices incorrectly identify themselves
> + * PCI_CLASS_COMMUNICATION_OTHER, instead of what
> + * they really are: PCI_CLASS_COMMUNICATION_MULTISERIAL
> + */
> +static int pci_ni_probe(struct pci_dev *dev)
> +{
> +	dev->class = PCI_CLASS_COMMUNICATION_MULTISERIAL << 8 |
> +			(dev->class & 0xff);
> +	return 0;
> +}

This looks odd.  dev->class should just contain the class code read from
config space.  I think you need to work around this in the places that
check the classcode instead and add a quirk for these devices.
