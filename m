Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBAFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C0B20866
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JoGIpmZl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C0B20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732635AbeKLJuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:50:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:35400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732312AbeKLISC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:02 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AA69223D1;
        Sun, 11 Nov 2018 22:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975286;
        bh=8UJpUTfTmmg/FBMNAQD3hJKCWniytA5WdMHoyYtCMCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JoGIpmZlgddPJAi3qmluKjNljfdPSMWiDNtAw3PRmRO2x12vaxBQMpAbwooqwzb7A
         +plOFYfdKyYjO0+TQkyrNCZ6vGO+d1fdQK79vHTvnPAOWsNNfo3DlucMOSRooJoOaL
         Xqv9WKqDQFPTYC8iXOkWCUQjdkg00SlHPPSmU+RQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jacek Zloch <jacek.zloch@intel.com>,
        Krzysztof Rusocki <krzysztof.rusocki@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.19 219/361] libnvdimm, pmem: Fix badblocks population for raw namespaces
Date:   Sun, 11 Nov 2018 14:19:26 -0800
Message-Id: <20181111221650.554129114@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit 91ed7ac444ef749603a95629a5ec483988c4f14b upstream.

The driver is only initializing bb_res in the devm_memremap_pages()
paths, but the raw namespace case is passing an uninitialized bb_res to
nvdimm_badblocks_populate().

Fixes: e8d513483300 ("memremap: change devm_memremap_pages interface...")
Cc: <stable@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Reported-by: Jacek Zloch <jacek.zloch@intel.com>
Reported-by: Krzysztof Rusocki <krzysztof.rusocki@intel.com>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvdimm/pmem.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -421,9 +421,11 @@ static int pmem_attach_disk(struct devic
 		addr = devm_memremap_pages(dev, &pmem->pgmap);
 		pmem->pfn_flags |= PFN_MAP;
 		memcpy(&bb_res, &pmem->pgmap.res, sizeof(bb_res));
-	} else
+	} else {
 		addr = devm_memremap(dev, pmem->phys_addr,
 				pmem->size, ARCH_MEMREMAP_PMEM);
+		memcpy(&bb_res, &nsio->res, sizeof(bb_res));
+	}
 
 	/*
 	 * At release time the queue must be frozen before


