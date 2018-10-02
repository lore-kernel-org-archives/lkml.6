Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDA0C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E88206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E88206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730948AbeJBUOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:14:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34054 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730930AbeJBUOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:14:39 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5E08DC2B;
        Tue,  2 Oct 2018 13:31:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianlin Shi <jishi@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.18 226/228] powerpc: fix csum_ipv6_magic() on little endian platforms
Date:   Tue,  2 Oct 2018 06:25:23 -0700
Message-Id: <20181002132512.668266008@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit 85682a7e3b9c664995ad477520f917039afdc330 upstream.

On little endian platforms, csum_ipv6_magic() keeps len and proto in
CPU byte order. This generates a bad results leading to ICMPv6 packets
from other hosts being dropped by powerpc64le platforms.

In order to fix this, len and proto should be converted to network
byte order ie bigendian byte order. However checksumming 0x12345678
and 0x56341278 provide the exact same result so it is enough to
rotate the sum of len and proto by 1 byte.

PPC32 only support bigendian so the fix is needed for PPC64 only

Fixes: e9c4943a107b ("powerpc: Implement csum_ipv6_magic in assembly")
Reported-by: Jianlin Shi <jishi@redhat.com>
Reported-by: Xin Long <lucien.xin@gmail.com>
Cc: <stable@vger.kernel.org> # 4.18+
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Tested-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/lib/checksum_64.S |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/powerpc/lib/checksum_64.S
+++ b/arch/powerpc/lib/checksum_64.S
@@ -443,6 +443,9 @@ _GLOBAL(csum_ipv6_magic)
 	addc	r0, r8, r9
 	ld	r10, 0(r4)
 	ld	r11, 8(r4)
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+	rotldi	r5, r5, 8
+#endif
 	adde	r0, r0, r10
 	add	r5, r5, r7
 	adde	r0, r0, r11


