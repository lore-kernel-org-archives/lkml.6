Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89792C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558782081B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550500286;
	bh=VfWgv5G+wbGnPVv9rJSsjGJbc3lqBOebaM+ZFQ1GwLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TNcdohg/csYO9fbJa67Hu9AnZ2bqhJksI/0ksj1FKsMmRVaEmReNz522O5v1ef4Vp
	 2UU0EY+S1T230HIN7Vz5rQySGqqa56TbyE/FCfD8gM9hOcxarI0HXA/sse215jUM8B
	 1eK4TKxjXzggnw0PrhBzKRNS302E7AH6xB9xOl50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388007AbfBRN6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:58:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:38594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388225AbfBRN6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:58:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34CB72077B;
        Mon, 18 Feb 2019 13:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498282;
        bh=VfWgv5G+wbGnPVv9rJSsjGJbc3lqBOebaM+ZFQ1GwLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kZrIYB/sd86YIkbyIxmF4lJYt4HKagVksWLHMAFiEDUHv8ZaHxHVnmJpyYlQjkSsJ
         /3/5+g2MRyXkWhYn9rT5NkwEujreDJfs8euDZBRq4d714yxUbwA+p2LKHJ2KtflkYL
         tT6linaf6damb1HBo9xaHHVY+ixO2Io4/B3zx24E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        "David S. Miller" <davem@davemloft.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 03/58] uapi/if_ether.h: prevent redefinition of struct ethhdr
Date:   Mon, 18 Feb 2019 14:43:24 +0100
Message-Id: <20190218133508.832709636@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133508.567416115@linuxfoundation.org>
References: <20190218133508.567416115@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 6926e041a8920c8ec27e4e155efa760aa01551fd upstream.

Musl provides its own ethhdr struct definition. Add a guard to prevent
its definition of the appropriate musl header has already been included.

glibc does not implement this header, but when glibc will implement this
they can just define __UAPI_DEF_ETHHDR 0 to make it work with the
kernel.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/if_ether.h    | 3 +++
 include/uapi/linux/libc-compat.h | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/include/uapi/linux/if_ether.h b/include/uapi/linux/if_ether.h
index 659b1634de61..b31e2f836317 100644
--- a/include/uapi/linux/if_ether.h
+++ b/include/uapi/linux/if_ether.h
@@ -22,6 +22,7 @@
 #define _UAPI_LINUX_IF_ETHER_H
 
 #include <linux/types.h>
+#include <linux/libc-compat.h>
 
 /*
  *	IEEE 802.3 Ethernet magic constants.  The frame sizes omit the preamble
@@ -139,11 +140,13 @@
  *	This is an Ethernet frame header.
  */
 
+#if __UAPI_DEF_ETHHDR
 struct ethhdr {
 	unsigned char	h_dest[ETH_ALEN];	/* destination eth addr	*/
 	unsigned char	h_source[ETH_ALEN];	/* source ether addr	*/
 	__be16		h_proto;		/* packet type ID field	*/
 } __attribute__((packed));
+#endif
 
 
 #endif /* _UAPI_LINUX_IF_ETHER_H */
diff --git a/include/uapi/linux/libc-compat.h b/include/uapi/linux/libc-compat.h
index 774cb2db1b89..7c098d68d5e5 100644
--- a/include/uapi/linux/libc-compat.h
+++ b/include/uapi/linux/libc-compat.h
@@ -263,4 +263,10 @@
 
 #endif /* __GLIBC__ */
 
+/* Definitions for if_ether.h */
+/* allow libcs like musl to deactivate this, glibc does not implement this. */
+#ifndef __UAPI_DEF_ETHHDR
+#define __UAPI_DEF_ETHHDR		1
+#endif
+
 #endif /* _UAPI_LIBC_COMPAT_H */
-- 
2.19.1



