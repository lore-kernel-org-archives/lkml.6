Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4789C10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9724E21901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499693;
	bh=m51NO63qifD/N2cT38M9UoVF7mAcHTaA48h/zT/arCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KVoGnGid+qjY4AzUPZ5kubpDOxlWRBPYg+jc5Htj1l9HiDRbN65CFfF10uMGtc57r
	 hsJXBh2o6goeFnRJAAdY+LZurBzkMx3w5fcbzsftqrTZ+B2bueYiV13IPfpt+JBfVC
	 Zgzfbu52I20fQp6QTmv4aqYxCsGA2/0Z4WVRDd3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390408AbfBROG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:06:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:49476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390387AbfBROGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:06:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09584204FD;
        Mon, 18 Feb 2019 14:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498783;
        bh=m51NO63qifD/N2cT38M9UoVF7mAcHTaA48h/zT/arCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1PNqOWyuR0nocwSzH7hdxN7j03jJfRjK90Ic4Gu4Ypb2KZdBLnbmrP6AaZ2lyV1g4
         mNR20ZuTR5zu/mJRon8GO3b8o9FNhlnmO8gqjtmWyUgeLpHJn3/n0cdBK856GsBybS
         dLo2lYi7mpSzNGDa7TXls8/D//h0XKUWbT0RACdA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        "David S. Miller" <davem@davemloft.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 119/143] uapi/if_ether.h: prevent redefinition of struct ethhdr
Date:   Mon, 18 Feb 2019 14:44:07 +0100
Message-Id: <20190218133533.355474548@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
index 064d2026ab38..cb490cd9376f 100644
--- a/include/uapi/linux/if_ether.h
+++ b/include/uapi/linux/if_ether.h
@@ -22,6 +22,7 @@
 #define _UAPI_LINUX_IF_ETHER_H
 
 #include <linux/types.h>
+#include <linux/libc-compat.h>
 
 /*
  *	IEEE 802.3 Ethernet magic constants.  The frame sizes omit the preamble
@@ -136,11 +137,13 @@
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
index e4f048ee7043..5da44c571cdd 100644
--- a/include/uapi/linux/libc-compat.h
+++ b/include/uapi/linux/libc-compat.h
@@ -184,4 +184,10 @@
 
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



