Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A48FC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 07:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39CA20877
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 07:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tiiZ1Vn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C39CA20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbeJMOlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 10:41:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39106 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbeJMOlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 10:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=K8BHExVW3bR1nDzdi6l323qQBna0JsdwY1S1MqiCjsk=; b=tiiZ1Vn2Pg+EZKpUu6R0piEcP
        6Pp3PFj8jAciTUi32oxPUI8sF+T6bJEj/Mo6Sr4M6+RRk14ylD4XLpEXegeBp6rJYi1L6hOKpHBIP
        cz/kWomx6L3j3PGCzNp/oyPY30R6pBr8TXaxZx+8+lRma8iM+9vgB6ELbw10hv5Uklyh67nwAI6dN
        81nSQgVy9Ac8J+F7X1HVRzTKyH/4qj8U8sfPGoVA+45GNyN0hsiqgCeBT42SzrpyF5hn+QrWdk2N1
        BsSciXAWACcJt6COtWc6lQ5VZglODTnDrb8h82SEmEFz2WTIyXmyfmfefft8d5ZISZTSehVNpcxbA
        bT982I7sw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBDz2-0001he-Tc; Sat, 13 Oct 2018 07:05:08 +0000
Date:   Sat, 13 Oct 2018 00:05:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] esp_scsi: De-duplicate PIO routines
Message-ID: <20181013070508.GA15008@infradead.org>
References: <cover.1539391876.git.fthain@telegraphics.com.au>
 <09d3a141dc16af63921f5414263069e9b4f97222.1539391876.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09d3a141dc16af63921f5414263069e9b4f97222.1539391876.git.fthain@telegraphics.com.au>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#if IS_ENABLED(CONFIG_SCSI_MAC_ESP) || IS_ENABLED(CONFIG_SCSI_ZORRO_ESP)

Please add a new CONFIG_SCSI_ESP_PIO symbol that is selected by
the mac and zorro drivers instead.

> +	pr_err("FIFO is empty (sreg %02x)\n", esp_read8(ESP_STATUS));

This should probably use dev_err (at least with my series).
