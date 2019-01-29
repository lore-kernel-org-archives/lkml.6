Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD19C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3AD120989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762702;
	bh=MhRN4e7d3ZxNm88IZGbzoawpkmdHJOeSzns2GkEy2t0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=blP9SHs+ovvDce4GqMOzonTpKylWTzy7PZAhTl69Ejzm6Is93un692VPY8d2MaE82
	 gFFxX6zZGK5dMFMXnBETQVqEPZu5tlsOBJA8k2FzyQObZkZjXWEzYbwSVsYOgFQipm
	 SIpcYfxeKAQ1KHS8BJFj4d49v/dVdOXyGnaqZoZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731435AbfA2Lvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:51:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:43124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730948AbfA2Lvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:51:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1DDE2148E;
        Tue, 29 Jan 2019 11:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762696;
        bh=MhRN4e7d3ZxNm88IZGbzoawpkmdHJOeSzns2GkEy2t0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uxjKdG3MJz3ml/FsyeitaFH6Mod6T0XEjfG7vIJBIemOdenrjFWOZfc+jcZKCHxmt
         /BDpf8LRVGEqo55TEyz9O3mhEsyFNQJKbcSq6A/bKuTdPhatIkKpdXoV2wtPw9wswP
         vp4EhF3FBsBRkQh9DsdKytZ9YWsP/93i/k9YhrSE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stuart hayes <stuart.w.hayes@gmail.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.9 27/44] acpi/nfit: Block function zero DSMs
Date:   Tue, 29 Jan 2019 12:36:22 +0100
Message-Id: <20190129113142.108013804@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113139.826927690@linuxfoundation.org>
References: <20190129113139.826927690@linuxfoundation.org>
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

From: Dan Williams <dan.j.williams@intel.com>

commit 5e9e38d0db1d29efed1dd4cf9a70115d33521be7 upstream.

In preparation for using function number 0 as an error value, prevent it
from being considered a valid function value by acpi_nfit_ctl().

Cc: <stable@vger.kernel.org>
Cc: stuart hayes <stuart.w.hayes@gmail.com>
Fixes: e02fb7264d8a ("nfit: add Microsoft NVDIMM DSM command set...")
Reported-by: Jeff Moyer <jmoyer@redhat.com>
Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/nfit/core.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1433,6 +1433,13 @@ static int acpi_nfit_add_dimm(struct acp
 		return 0;
 	}
 
+	/*
+	 * Function 0 is the command interrogation function, don't
+	 * export it to potential userspace use, and enable it to be
+	 * used as an error value in acpi_nfit_ctl().
+	 */
+	dsm_mask &= ~1UL;
+
 	uuid = to_nfit_uuid(nfit_mem->family);
 	for_each_set_bit(i, &dsm_mask, BITS_PER_LONG)
 		if (acpi_check_dsm(adev_dimm->handle, uuid, 1, 1ULL << i))


