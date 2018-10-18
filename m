Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F10C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA21F20866
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsEqbp5m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA21F20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbeJSGwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:52:39 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39727 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbeJSGvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:51:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id r9-v6so14866376pgv.6;
        Thu, 18 Oct 2018 15:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y8f+zX4OUAoqVg/3NA0TrDwr4Zjok9K4JF3715XNZDg=;
        b=DsEqbp5maz0a9jQB9S6km5gyjg9OMujfKYuRvlTgDSfBuZK/Gxk4tGs1787JTxgdAW
         oP6UWhSyWmT6q5iQJ4R+NuF+rbuVOOIK8Z8J1wTk8YIARA9MUIrj+Y+SHbeobtpJ78wd
         sZcuXIrP3/ArgSICLC0vHTo2eCGTdaMhGjPu5H1FCGIm0vyUufdQBcL3fXINZ6z+Rtmx
         8ZHmSyd616uqO/IVWb8Uv+sWEWo+5N3dcalWAU79QTxZrchh+1CwBL4kx798OpOJzHzQ
         dwkF1Uyv7G+P8WfTXoTzKFG3VncN+Qq19OiaHVtE4t0HpeBeB9orgSLqofAv3k7ILKIZ
         kCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y8f+zX4OUAoqVg/3NA0TrDwr4Zjok9K4JF3715XNZDg=;
        b=UrsljCUr0Oc6AcGCy2kKeFI3I5QyH+OQp0sB7JHUYJD8FSYTupFQnumhBQ/ub/BC3I
         4VtrdkGuabhH/moUkprmhZOP8wHQzBqDOKZJ33EbxmhpDJX/XSW9+a+a7QrhDqEY+ll4
         NyhUeoJaGdoxUgW71dnJnjgUSRhpAG2nZ8jqvE2WFkN9HYv+MSGYJ/AXhBrljlXettOD
         FUicJOOUQE18WqxmrXGXdr2voDMqXFbgBuOA/1Q3Sm6TAzTGUWU2F+QQmfLwf2DuaTqc
         FUp7w4Nqyc3TaY415FCEUG9iGqqP/qCzE35DEzWSpSzdH9/QZlHYPmw/497ssGEtiR3X
         /BjQ==
X-Gm-Message-State: ABuFfoiZ08RYtlWnmLd6Fkp07+kHLQC6OX28W9ihlCajQfwTkHabY/un
        ynZ80A12BEJ4wZydRdOJ90Y=
X-Google-Smtp-Source: ACcGV63HjomW5BejkyH0P48UtnxAoYZqja5t4Qt2H3pTR0wep7TuXb+qMrIeSbRzgAKu5mJvSDtKEg==
X-Received: by 2002:a63:4a0e:: with SMTP id x14-v6mr29542038pga.34.1539902892048;
        Thu, 18 Oct 2018 15:48:12 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id v81-v6sm38129268pfj.25.2018.10.18.15.48.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 15:48:11 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v5 06/18] of: overlay: do not duplicate properties from overlay for new nodes
Date:   Thu, 18 Oct 2018 15:46:24 -0700
Message-Id: <1539902796-8382-7-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
References: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

When allocating a new node, add_changeset_node() was duplicating the
properties from the respective node in the overlay instead of
allocating a node with no properties.

When this patch is applied the errors reported by the devictree
unittest from patch "of: overlay: add tests to validate kfrees from
overlay removal" will no longer occur.  These error messages are of
the form:

   "OF: ERROR: ..."

and the unittest results will change from:

   ### dt-test ### end of unittest - 203 passed, 7 failed

to

   ### dt-test ### end of unittest - 210 passed, 0 failed

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 94740f4ee34c..7fcf4a812d06 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -393,7 +393,7 @@ static int add_changeset_node(struct overlay_changeset *ovcs,
 			break;
 
 	if (!tchild) {
-		tchild = __of_node_dup(node, node_kbasename);
+		tchild = __of_node_dup(NULL, node_kbasename);
 		if (!tchild)
 			return -ENOMEM;
 
-- 
Frank Rowand <frank.rowand@sony.com>

