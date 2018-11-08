Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2CFECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B19421019
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNqt6W2g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B19421019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732713AbeKIHqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:46:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:40110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731192AbeKIHqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:46:16 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71D1720989;
        Thu,  8 Nov 2018 22:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714924;
        bh=kC2FUFXsoF+YZQC/vy5cGUprEt7/gDSYLpd1qjqQwrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NNqt6W2gyjhIekXof57oZXJxhnMFMNKO8bMPJEu6zLm6Alb/vyCHJSpC8XzZcSCrF
         L7UGL4uBT3+ByTpQw4jgoNW41UfHzHhHrB6MWa5XyNpi+3C61cfH6LPnGRanm+UAZo
         Yyxcxa5LuZ5ollsD2BrPJ6USHWVf+HUA3gxtGADg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Felipe Balbi <felipe.balbi@intel.com>
Subject: [PATCH 4.14 22/31] usb: gadget: storage: Fix Spectre v1 vulnerability
Date:   Thu,  8 Nov 2018 13:52:46 -0800
Message-Id: <20181108215131.515278793@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215129.641434673@linuxfoundation.org>
References: <20181108215129.641434673@linuxfoundation.org>
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

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit 9ae24af3669111d418242caec8dd4ebd9ba26860 upstream.

num can be indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

drivers/usb/gadget/function/f_mass_storage.c:3177 fsg_lun_make() warn:
potential spectre issue 'fsg_opts->common->luns' [r] (local cap)

Fix this by sanitizing num before using it to index
fsg_opts->common->luns

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Acked-by: Felipe Balbi <felipe.balbi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/function/f_mass_storage.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -221,6 +221,8 @@
 #include <linux/usb/gadget.h>
 #include <linux/usb/composite.h>
 
+#include <linux/nospec.h>
+
 #include "configfs.h"
 
 
@@ -3170,6 +3172,7 @@ static struct config_group *fsg_lun_make
 	fsg_opts = to_fsg_opts(&group->cg_item);
 	if (num >= FSG_MAX_LUNS)
 		return ERR_PTR(-ERANGE);
+	num = array_index_nospec(num, FSG_MAX_LUNS);
 
 	mutex_lock(&fsg_opts->lock);
 	if (fsg_opts->refcnt || fsg_opts->common->luns[num]) {


