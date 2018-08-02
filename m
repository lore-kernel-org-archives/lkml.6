Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8CEC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A04A20C0B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b5kZjsAs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A04A20C0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbeHBJkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 05:40:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55104 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbeHBJkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 05:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZfFfeyfxw1X6rMLHiiOgi4RGAnnh958Axl0LerbW3rY=; b=b5kZjsAsr0LAQQfsYeCvzSQwK
        CABpOl7z4HFnT2NrljA8FfdkIMQElTZwrTWGvog/OCDT+YSPsL7GvN2nL33qPXHrS3ZydoyImjOd0
        SIMGCxuisVzbRsx4da2CDPoDx3zOPY1fBk/D12YwFOjHy9mOMzy0wAOmeTBnQg/FScGdKiT1Q2N4j
        p4eFRT4rs7DMKs2hSAPIKXpRmmi8Ws9n6DXKfJiwbecdYfJ/vduKEvc90VOmKCMX2NIIKdpui385V
        wDx2ZeJL8xZGSsX5PTUk7gyfthLY4kgg53vDjblVBWf5orpeDUZeENriDeEwrm84CeHGKhJzd8OOb
        EmQ/TLBsQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fl8Nn-0006HQ-OY; Thu, 02 Aug 2018 07:50:51 +0000
Date:   Thu, 2 Aug 2018 00:50:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, rgummal@xilinx.com
Subject: Re: [PATCH 1/3] PCI: xilinx-nwl: Save error IRQ number in
 device_node private data
Message-ID: <20180802075051.GA17566@infradead.org>
References: <1533141889-19962-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1533141889-19962-2-git-send-email-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533141889-19962-2-git-send-email-bharat.kumar.gogada@xilinx.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#ifdef CONFIG_PCIEAER
> +	struct device_node *node = dev->of_node;
> +#endif
>  
>  	breg_val = nwl_bridge_readl(pcie, E_BREG_CAPABILITIES) & BREG_PRESENT;
>  	if (!breg_val) {
> @@ -744,6 +747,9 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
>  			pcie->irq_misc);
>  		return err;
>  	}
> +#ifdef CONFIG_PCIEAER
> +	node->data =  &pcie->irq_misc;
> +#endif

Is there any good reason for these ifdefs?  Always assigning the node
data would seem harmless and much cleaner to me.
