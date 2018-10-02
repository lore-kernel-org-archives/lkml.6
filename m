Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EC3C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6862064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6862064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731434AbeJBUkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:40:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34066 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbeJBUOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:14:40 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6C4A6C3F;
        Tue,  2 Oct 2018 13:31:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.18 227/228] powerpc/pkeys: Fix reading of ibm, processor-storage-keys property
Date:   Tue,  2 Oct 2018 06:25:24 -0700
Message-Id: <20181002132512.712182289@linuxfoundation.org>
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

From: Thiago Jung Bauermann <bauerman@linux.ibm.com>

commit c716a25b9b70084e1144f77423f5aedd772ea478 upstream.

scan_pkey_feature() uses of_property_read_u32_array() to read the
ibm,processor-storage-keys property and calls be32_to_cpu() on the
value it gets. The problem is that of_property_read_u32_array() already
returns the value converted to the CPU byte order.

The value of pkeys_total ends up more or less sane because there's a min()
call in pkey_initialize() which reduces pkeys_total to 32. So in practice
the kernel ignores the fact that the hypervisor reserved one key for
itself (the device tree advertises 31 keys in my test VM).

This is wrong, but the effect in practice is that when a process tries to
allocate the 32nd key, it gets an -EINVAL error instead of -ENOSPC which
would indicate that there aren't any keys available

Fixes: cf43d3b26452 ("powerpc: Enable pkey subsystem")
Cc: stable@vger.kernel.org # v4.16+
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/mm/pkeys.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -44,7 +44,7 @@ static void scan_pkey_feature(void)
 	 * Since any pkey can be used for data or execute, we will just treat
 	 * all keys as equal and track them as one entity.
 	 */
-	pkeys_total = be32_to_cpu(vals[0]);
+	pkeys_total = vals[0];
 	pkeys_devtree_defined = true;
 }
 


