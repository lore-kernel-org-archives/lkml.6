Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1B4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFAB9214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 07:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T5igZ2bX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbeLRHbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 02:31:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60704 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbeLRHbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 02:31:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Cv0Z7iZRCUvgWID7QVEAzXouZ4i2YUyNYK3A0HzlV+k=; b=T5igZ2bXxgzfeI2nivsni49Gm
        iZZIPocBJqi+a1NDqiKa+TWhxvAz0GirW80bYZX0BXHQ4uCmjkVHB85hb+aYlB6UNnSFwLzuQNiv7
        28tvCiMgzyX9HEzpjLQaSHCJI/I6/GfepzDIcxA+wBMkdw31NUdUa1UXtyJ1WjNofz5m2Sgeq+o2T
        fBwEcRMBCesVhe6bijuPDmM3QamAwfYo/7GdPn2yUvB67qlWWUJq522Wk9P5lkeH45bvsnz7ntF1o
        3/m9SSQo1diUGf5hBJIthiKEObaQ5kbEi4OB1K5zv4rb5h7anju8cCbnyfE5VyumFBWS5/5HcAJU1
        H2gWNjGTQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZ9qt-0000sQ-Bt; Tue, 18 Dec 2018 07:31:39 +0000
Date:   Mon, 17 Dec 2018 23:31:39 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 1/7] ACPI: Allow CONFIG_PCI to be unset for reboot
Message-ID: <20181218073139.GA8612@infradead.org>
References: <20181218025606.32668-1-okaya@kernel.org>
 <20181218025606.32668-2-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218025606.32668-2-okaya@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#ifdef CONFIG_PCI
> +		unsigned int devfn;
> +		struct pci_bus *bus0;
> +
>  		/* The reset register can only live on bus 0. */
>  		bus0 = pci_find_bus(0, 0);
>  		if (!bus0)
> @@ -44,8 +47,9 @@ void acpi_reboot(void)
>  		/* Write the value that resets us. */
>  		pci_bus_write_config_byte(bus0, devfn,
>  				(rr->address & 0xffff), reset_value);
> +#endif

This would be a lot cleaner if this was split into a little helper
function.
