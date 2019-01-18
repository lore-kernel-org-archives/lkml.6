Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CD3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9BB208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfARMzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:55:03 -0500
Received: from verein.lst.de ([213.95.11.211]:43463 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfARMzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:55:02 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 63E7368CEB; Fri, 18 Jan 2019 13:55:00 +0100 (CET)
Date:   Fri, 18 Jan 2019 13:55:00 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Zigotzky <chzigotzky@xenosoft.de>
Cc:     Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        Darren Stevens <darren@stevens-zone.net>,
        linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Paul Mackerras <paulus@samba.org>,
        Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
Subject: Re: use generic DMA mapping code in powerpc V4
Message-ID: <20190118125500.GA15657@lst.de>
References: <20190115133558.GA29225@lst.de> <685f0c06-af1b-0bec-ac03-f9bf1f7a2b35@xenosoft.de> <20190115151732.GA2325@lst.de> <e9345547-4dc6-747a-29ec-6375dc8bfe83@xenosoft.de> <20190118083539.GA30479@lst.de> <871403f2-fa7d-de15-89eb-070432e15c69@xenosoft.de> <20190118112842.GA9115@lst.de> <a2ca0118-5915-8b1c-7cfa-71cb4b43eaa6@xenosoft.de> <20190118121810.GA13327@lst.de> <eceebeda-0e18-00f6-06e7-def2eb0aa961@xenosoft.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="xB0nW4MQa6jZONgY"
Content-Disposition: inline
In-Reply-To: <eceebeda-0e18-00f6-06e7-def2eb0aa961@xenosoft.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 18, 2019 at 01:46:46PM +0100, Christian Zigotzky wrote:
> Sorry, it's not possible to patch 
> '257002094bc5935dd63207a380d9698ab81f0775' with your patch. I also tried it 
> manually but without any success.

Weird:

hch@carbon:~/work/linux$ git checkout 257002094bc5935dd63207a380d9698ab81f0775
HEAD is now at 257002094bc5 powerpc/dma: use the dma-direct allocator for coherent platforms
hch@carbon:~/work/linux$ patch -p1 < dbg.diff 
patching file kernel/dma/direct.c

I've pushed the result to

git://git.infradead.org/users/hch/misc.git

as a new powerpc-dma.6-debug branch

--xB0nW4MQa6jZONgY
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="dbg.diff"

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 355d16acee6d..e46c9b64ec0d 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -118,8 +118,11 @@ struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 			page = NULL;
 		}
 	}
-	if (!page)
+	if (!page) {
 		page = alloc_pages_node(dev_to_node(dev), gfp, page_order);
+		if (!page)
+			pr_warn("failed to allocate memory with gfp 0x%x\n", gfp);
+	}
 
 	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
 		__free_pages(page, page_order);
@@ -139,6 +142,10 @@ struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 		}
 	}
 
+	if (!page) {
+		pr_warn("failed to allocate DMA memory!\n");
+		dump_stack();
+	}
 	return page;
 }
 

--xB0nW4MQa6jZONgY--
