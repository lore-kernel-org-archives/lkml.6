Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1225ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74CB6214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3rdN/+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74CB6214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730824AbeKIHij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:38:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:58010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730799AbeKIHih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:38:37 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 923562146E;
        Thu,  8 Nov 2018 22:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714468;
        bh=jkB59swUCrDCDkeglrJdCguzb444iD+LCObfdxPEYdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n3rdN/+0y10TadVllDZRWlkDLOSCxfdcSQUsE3lOuWdfmJ/qTDmNxShF136GpRCB7
         IJBYPyG6gNAZIptYOlHwGRE56mPFI/X98gbdCdotSuhmEvLHNt0PmhOXEhdvHKvEHf
         FDcK2utJo3HY6uEM/kLr9OZyR13lA2DdmKQmkj7g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Richard Cochran <richardcochran@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 105/114] ptp: fix Spectre v1 vulnerability
Date:   Thu,  8 Nov 2018 13:52:00 -0800
Message-Id: <20181108215110.278036964@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit efa61c8cf2950ab5c0e66cff3cabe2a2b24e81ba upstream.

pin_index can be indirectly controlled by user-space, hence leading
to a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

drivers/ptp/ptp_chardev.c:253 ptp_ioctl() warn: potential spectre issue
'ops->pin_config' [r] (local cap)

Fix this by sanitizing pin_index before using it to index
ops->pin_config, and before passing it as an argument to
function ptp_set_pinfunc(), in which it is used to index
info->pin_config.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Acked-by: Richard Cochran <richardcochran@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ptp/ptp_chardev.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -23,6 +23,8 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 
+#include <linux/nospec.h>
+
 #include "ptp_private.h"
 
 static int ptp_disable_pinfunc(struct ptp_clock_info *ops,
@@ -224,6 +226,7 @@ long ptp_ioctl(struct posix_clock *pc, u
 			err = -EINVAL;
 			break;
 		}
+		pin_index = array_index_nospec(pin_index, ops->n_pins);
 		if (mutex_lock_interruptible(&ptp->pincfg_mux))
 			return -ERESTARTSYS;
 		pd = ops->pin_config[pin_index];
@@ -242,6 +245,7 @@ long ptp_ioctl(struct posix_clock *pc, u
 			err = -EINVAL;
 			break;
 		}
+		pin_index = array_index_nospec(pin_index, ops->n_pins);
 		if (mutex_lock_interruptible(&ptp->pincfg_mux))
 			return -ERESTARTSYS;
 		err = ptp_set_pinfunc(ptp, pin_index, pd.func, pd.chan);


