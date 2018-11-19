Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF79CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1DA820C01
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRq/ZU6U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1DA820C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390295AbeKTDPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:15:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:53280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388976AbeKTDPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:15:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 632C121104;
        Mon, 19 Nov 2018 16:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646284;
        bh=NFTAlqOm3CNhrPW097BdSYQkk3pTnK0hzBLye1OUn1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qRq/ZU6UFY8PBHXftpxBITIq/cwnVlEbnPV0Zzfz/4GJ+c0+xROqFks6JRMQnsjF2
         0BZKba2dhAbHv6+XSx95coFH+r7P5hnTTBlwmGild3idxMUzp85xV17P+Cq9wJhq1b
         T/NsYdg/VnX8lfO1Gkk+ZAdMUKrzIhcmdvbBPmvI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 106/124] efi/arm/libstub: Pack FDT after populating it
Date:   Mon, 19 Nov 2018 17:29:20 +0100
Message-Id: <20181119162632.045038306@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.951907286@linuxfoundation.org>
References: <20181119162612.951907286@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

commit 72a58a63a164b4e9d2d914e65caeb551846883f1 upstream.

Commit:

  24d7c494ce46 ("efi/arm-stub: Round up FDT allocation to mapping size")

increased the allocation size for the FDT image created by the stub to a
fixed value of 2 MB, to simplify the former code that made several
attempts with increasing values for the size. This is reasonable
given that the allocation is of type EFI_LOADER_DATA, which is released
to the kernel unless it is explicitly memblock_reserve()d by the early
boot code.

However, this allocation size leaked into the 'size' field of the FDT
header metadata, and so the entire allocation remains occupied by the
device tree binary, even if most of it is not used to store device tree
information.

So call fdt_pack() to shrink the FDT data structure to its minimum size
after populating all the fields, so that the remaining memory is no
longer wasted.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: <stable@vger.kernel.org> # v4.12+
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Fixes: 24d7c494ce46 ("efi/arm-stub: Round up FDT allocation to mapping size")
Link: http://lkml.kernel.org/r/20181114175544.12860-4-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/firmware/efi/libstub/fdt.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -158,6 +158,10 @@ static efi_status_t update_fdt(efi_syste
 			return efi_status;
 		}
 	}
+
+	/* shrink the FDT back to its minimum size */
+	fdt_pack(fdt);
+
 	return EFI_SUCCESS;
 
 fdt_set_fail:


