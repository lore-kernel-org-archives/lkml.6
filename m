Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D30ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532812098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pbj7F0ml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532812098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeJSGvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:51:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36049 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbeJSGvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:51:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id l81-v6so15555348pfg.3;
        Thu, 18 Oct 2018 15:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CCjwtqQtCAOwIXfabE6A59py+g67jCSp+upDI4OtmXg=;
        b=Pbj7F0mlm1BgSQnOhWBMy0EmScJ1rGAPVbM1ESkPvgz/QYnjeV6n3/X708Q27A+3Ky
         gnjSjL1ZkosSHjqbqF2rVB7ENb0LzyxV3m1KAxDIAyy/garAd6h5XWMlL0gJ2XmBY3iO
         6TQoyvAXl72WXezqI/AqXqDnF7hyY3AiTNXJNANgr1CKjZp8JnnM/CgWHIDt+7QXZNJR
         0PP2PssKe09PvuVRX4lXRUefrCzY6kWsGN7xtcBhUj84n6FTdN7hc80As7ZWpaPoHAjV
         jbSrBIrpVTPJue6eB6unNRIAr1A3BXteo90te8718midsNcSEX5BLdNYLVOYisIOnl08
         H/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CCjwtqQtCAOwIXfabE6A59py+g67jCSp+upDI4OtmXg=;
        b=Nf+2fSvzUF7JfZSuyrmUsS8yR0U7iWcrNcSfR+aRlnBMLfglA1WnV6sE6E8+ZoHD92
         bOi7dnxHGh/dZ+6IQN0iacobegZey1e1+MrZSP90ymqQdcsadFDDFvnGpMfSmWFn+7hv
         2q+GWJR9g/l/j3+vpkMTJdy4PG1hHi2JZ3xCnM7fgu3osgfTSP02B7QHOe5BIywoCz45
         uU+jsfexTB7VHEX9hAg5zJKcV2lM+Ev47vN026fzL06zS++HkbnFGyOdBdl9shkvtwYQ
         KzlG+R4T5yOHPqC9IP0Po56UHxPewJ6jEXAM82PjIJ66rhAr+WCsqCIJDSjwouXx1pmt
         denA==
X-Gm-Message-State: ABuFfohzLF7zwMfiz3/E8010LCzv1stK3ub9nAtdlSGFxylKsuuVw1VB
        Dpsq6XhyTbCAivyCIywJiOk=
X-Google-Smtp-Source: ACcGV60XEeNoeLiDaAGNjfUHWznT5NSnonm0FxYO4wnp575TXwjcJoFz5ZDNhov90TtKuboI5CU/1Q==
X-Received: by 2002:a63:c251:: with SMTP id l17-v6mr2804256pgg.146.1539902889847;
        Thu, 18 Oct 2018 15:48:09 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id v81-v6sm38129268pfj.25.2018.10.18.15.48.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 15:48:09 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v5 04/18] powerpc/pseries: add of_node_put() in dlpar_detach_node()
Date:   Thu, 18 Oct 2018 15:46:22 -0700
Message-Id: <1539902796-8382-5-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
References: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

"of: overlay: add missing of_node_get() in __of_attach_node_sysfs"
added a missing of_node_get() to __of_attach_node_sysfs().  This
results in a refcount imbalance for nodes attached with
dlpar_attach_node().  The calling sequence from dlpar_attach_node()
to __of_attach_node_sysfs() is:

   dlpar_attach_node()
      of_attach_node()
         __of_attach_node_sysfs()

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

***** UNTESTED.  I need people with the affected PowerPC systems
*****            (systems that dynamically allocate and deallocate
*****            devicetree nodes) to test this patch.

 arch/powerpc/platforms/pseries/dlpar.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index a0b20c03f078..e3010b14aea5 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -272,6 +272,8 @@ int dlpar_detach_node(struct device_node *dn)
 	if (rc)
 		return rc;
 
+	of_node_put(dn);
+
 	return 0;
 }
 
-- 
Frank Rowand <frank.rowand@sony.com>

