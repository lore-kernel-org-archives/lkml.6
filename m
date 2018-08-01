Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7C9C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965EB20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 965EB20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407534AbeHATPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:15:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52304 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404772AbeHATPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:15:50 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 454ABD4A;
        Wed,  1 Aug 2018 17:29:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mathieu Malaterre <malat@debian.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 090/144] nvmem: properly handle returned value nvmem_reg_read
Date:   Wed,  1 Aug 2018 18:51:57 +0200
Message-Id: <20180801164956.100305152@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801164949.023217860@linuxfoundation.org>
References: <20180801164949.023217860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathieu Malaterre <malat@debian.org>

[ Upstream commit 50808bfcc14b854775a9f1d0abe3dac2babcf5c3 ]

Function nvmem_reg_read can return a non zero value indicating an error.
This returned value must be read and error propagated to
nvmem_cell_prepare_write_buffer. Silence the following gcc warning (W=1):

drivers/nvmem/core.c:1093:9: warning: variable 'rc' set but
 not used [-Wunused-but-set-variable]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvmem/core.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1031,6 +1031,8 @@ static inline void *nvmem_cell_prepare_w
 
 		/* setup the first byte with lsb bits from nvmem */
 		rc = nvmem_reg_read(nvmem, cell->offset, &v, 1);
+		if (rc)
+			goto err;
 		*b++ |= GENMASK(bit_offset - 1, 0) & v;
 
 		/* setup rest of the byte if any */
@@ -1049,11 +1051,16 @@ static inline void *nvmem_cell_prepare_w
 		/* setup the last byte with msb bits from nvmem */
 		rc = nvmem_reg_read(nvmem,
 				    cell->offset + cell->bytes - 1, &v, 1);
+		if (rc)
+			goto err;
 		*p |= GENMASK(7, (nbits + bit_offset) % BITS_PER_BYTE) & v;
 
 	}
 
 	return buf;
+err:
+	kfree(buf);
+	return ERR_PTR(rc);
 }
 
 /**


