Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEBBC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C4362148E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762612;
	bh=Vjs9q1q2GdRkev7pc0pjcZ/7g/qFtYft9wbHK6oy1go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ENnQtIFfyJgwOPJ3EyuJxnPsPmHo+eXr775RxO5I1GjIz7jR+5wTeOY/VxP5la0ax
	 ztfRkN9oLJDX+6WnLgfQL7oSVfEF/GtVcXPiy9X4D6GOwK3Ub4GP2nAgaNLby++yaW
	 rz3DAW/+GvJ9sRjk9Pq9GLHDcaGxe6K8ZDnoMpKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731611AbfA2LuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:50:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:41268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731598AbfA2LuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:50:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D80FE2083B;
        Tue, 29 Jan 2019 11:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762607;
        bh=Vjs9q1q2GdRkev7pc0pjcZ/7g/qFtYft9wbHK6oy1go=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZNa5iFs/plGgET48LglgVKt7xpGrMGUw8vaVAUEOaxoG1i1z9ZV9ynWqHomXRVH4/
         tJqm3F0stYR65hw/QyP92vSIpwSquwXiT+Vf/E+vARxYEvGsxgsnJe7/+sf8JEbpzh
         y3fGSmTVt3Lhl2VLvES+GjxsD8EfSY2VejMJcW+A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stuart hayes <stuart.w.hayes@gmail.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.14 37/68] acpi/nfit: Block function zero DSMs
Date:   Tue, 29 Jan 2019 12:35:59 +0100
Message-Id: <20190129113134.729898557@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
References: <20190129113131.751891514@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1503,6 +1503,13 @@ static int acpi_nfit_add_dimm(struct acp
 		return 0;
 	}
 
+	/*
+	 * Function 0 is the command interrogation function, don't
+	 * export it to potential userspace use, and enable it to be
+	 * used as an error value in acpi_nfit_ctl().
+	 */
+	dsm_mask &= ~1UL;
+
 	guid = to_nfit_uuid(nfit_mem->family);
 	for_each_set_bit(i, &dsm_mask, BITS_PER_LONG)
 		if (acpi_check_dsm(adev_dimm->handle, guid, 1, 1ULL << i))


