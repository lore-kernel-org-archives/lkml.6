Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED9BC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B05B25267
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B05B25267
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030529AbeGAQbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:31:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35008 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030482AbeGAQbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:31:33 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8A36E92B;
        Sun,  1 Jul 2018 16:31:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Frank Rowand <frank.rowand@sony.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 4.14 054/157] of: overlay: validate offset from property fixups
Date:   Sun,  1 Jul 2018 18:22:06 +0200
Message-Id: <20180701160855.345406874@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frank Rowand <frank.rowand@sony.com>

commit 482137bf2aecd887ebfa8756456764a2f6a0e545 upstream.

The smatch static checker marks the data in offset as untrusted,
leading it to warn:

  drivers/of/resolver.c:125 update_usages_of_a_phandle_reference()
  error: buffer underflow 'prop->value' 's32min-s32max'

Add check to verify that offset is within the property data.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/of/resolver.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/of/resolver.c
+++ b/drivers/of/resolver.c
@@ -129,6 +129,11 @@ static int update_usages_of_a_phandle_re
 			goto err_fail;
 		}
 
+		if (offset < 0 || offset + sizeof(__be32) > prop->length) {
+			err = -EINVAL;
+			goto err_fail;
+		}
+
 		*(__be32 *)(prop->value + offset) = cpu_to_be32(phandle);
 	}
 


