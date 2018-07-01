Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09DDC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3404255CD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3404255CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031260AbeGARSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:18:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36802 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031659AbeGAQiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:38:55 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7B936AA6;
        Sun,  1 Jul 2018 16:38:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.17 053/220] powerpc/fadump: Unregister fadump on kexec down path.
Date:   Sun,  1 Jul 2018 18:21:17 +0200
Message-Id: <20180701160910.551321291@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

commit 722cde76d68e8cc4f3de42e71c82fd40dea4f7b9 upstream.

Unregister fadump on kexec down path otherwise the fadump registration
in new kexec-ed kernel complains that fadump is already registered.
This makes new kernel to continue using fadump registered by previous
kernel which may lead to invalid vmcore generation. Hence this patch
fixes this issue by un-registering fadump in fadump_cleanup() which is
called during kexec path so that new kernel can register fadump with
new valid values.

Fixes: b500afff11f6 ("fadump: Invalidate registration and release reserved memory for general use.")
Cc: stable@vger.kernel.org # v3.4+
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/fadump.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1155,6 +1155,9 @@ void fadump_cleanup(void)
 		init_fadump_mem_struct(&fdm,
 			be64_to_cpu(fdm_active->cpu_state_data.destination_address));
 		fadump_invalidate_dump(&fdm);
+	} else if (fw_dump.dump_registered) {
+		/* Un-register Firmware-assisted dump if it was registered. */
+		fadump_unregister_dump(&fdm);
 	}
 }
 


