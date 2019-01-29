Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79770C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC8420882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548761913;
	bh=EwEBn10kCVP/9zbuqJTzSLhxvI1prX1FCVg/cWl80h0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PrfOUaFZ9NrwNkYh52eSp9uJJ6lwfnvRJSbqYbS9K0gANGnChYdyfIGQ3A9B7WxPC
	 R/A7r8gerCtM9XnTY80jpcU6VH7tQ7J09vaomC+QT8cAtWtId4t2lwME+cVx+QNNB+
	 GKR8Zi+iYbqN/W4wfXXQM6jIbCkldmDCG1E/GSI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbfA2Lib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:38:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:55112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729131AbfA2Li0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:38:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4BD120844;
        Tue, 29 Jan 2019 11:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548761905;
        bh=EwEBn10kCVP/9zbuqJTzSLhxvI1prX1FCVg/cWl80h0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F/3BYB09LcTbIMB9SCLS72BCQZuDkK6nMpuIoX6dXeqaa0mF5K2lzHO1dowzZN80k
         DCeSLbb8dRjWDqFzuzcKpN1TxKojV1zkuO6I+qU8AdXSDVnkl90gnuS3hl7ZTfskO6
         GZ+0avQMyx7sr5MtnZLxgR0EaMKK0siBq+qwSTYU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 4.20 042/117] ARC: adjust memblock_reserve of kernel memory
Date:   Tue, 29 Jan 2019 12:34:53 +0100
Message-Id: <20190129113209.707690065@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

commit a3010a0465383300f909f62b8a83f83ffa7b2517 upstream.

In setup_arch_memory we reserve the memory area wherein the kernel
is located. Current implementation may reserve more memory than
it actually required in case of CONFIG_LINUX_LINK_BASE is not
equal to CONFIG_LINUX_RAM_BASE. This happens because we calculate
start of the reserved region relatively to the CONFIG_LINUX_RAM_BASE
and end of the region relatively to the CONFIG_LINUX_RAM_BASE.

For example in case of HSDK board we wasted 256MiB of physical memory:
------------------->8------------------------------
Memory: 770416K/1048576K available (5496K kernel code,
    240K rwdata, 1064K rodata, 2200K init, 275K bss,
    278160K reserved, 0K cma-reserved)
------------------->8------------------------------

Fix that.

Fixes: 9ed68785f7f2b ("ARC: mm: Decouple RAM base address from kernel link addr")
Cc: stable@vger.kernel.org	#4.14+
Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arc/mm/init.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -137,7 +137,8 @@ void __init setup_arch_memory(void)
 	 */
 
 	memblock_add_node(low_mem_start, low_mem_sz, 0);
-	memblock_reserve(low_mem_start, __pa(_end) - low_mem_start);
+	memblock_reserve(CONFIG_LINUX_LINK_BASE,
+			 __pa(_end) - CONFIG_LINUX_LINK_BASE);
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start)


