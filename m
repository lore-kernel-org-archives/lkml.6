Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F833C71122
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A5620652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 00:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOMyYo7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A5620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeJOIJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 04:09:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46010 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbeJOII6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 04:08:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id u12-v6so8742842pfn.12;
        Sun, 14 Oct 2018 17:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zdOcjsQSagxh/0ytfqlFE21zp3hEcz2hdT+yMst4gNc=;
        b=iOMyYo7cQGkHcR4M21tMOuqmXENQrywNbXP/BiYtiQjNER4f7ceGq8FB9+tO5XgKsp
         PGa1zDu659YIwqT1kEcV1QR6bDtpD2lJY9n0rPCXI9qDi2z2lI+vl08sK/EpKQFF0kYf
         Ol4SmKQxwNBJCIu0MbhfEnQBcjakp6tlEHBv9Sj1SVc1aQSvlYdXF0enIIC+QJrUwius
         6youP2KEfv2hs+JuDsitUvzR7Us5qRBbbrlUcXMj+EgbUHRm6w45y8mFn8I6Y0B5AWDM
         UEreYywyhJcK8TL0jqKOGl3Fxdt3827T3CEI4wACtyz1mvFLS0u9rPnGm82sVgXImBbc
         +PGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zdOcjsQSagxh/0ytfqlFE21zp3hEcz2hdT+yMst4gNc=;
        b=fkJUiWQytjZ8UOGM7rHC7GGCVWNRT4+TPbME1S/MCtdO4jhzduRnzqjmfDuQNsBqDj
         pJNrUnODDJVKW06HyPlJyiE3N/LUUvgc/OsxSWcDlqnw5M5JAknye+Yq1z1000HoJ2BA
         b/7u5CV5HvrunQ+V46BVbA1f7XYl5H5P/0ZD0xpgpfVBHmgpxnRFNbY/70tRHoW/wr0o
         r8TexXSLfhLdoPN8s20lQfgtyffZhpsq6rxmX9At1rR5iSt1FKBFQaHOoKEvyDqLB4aj
         xrKJ/YWtSevGtuPkiV+LOZ59kCRQkM/ttKiCjRp45xn0O72cnMIHocQD/HzqTNVooN4Z
         smlA==
X-Gm-Message-State: ABuFfoi0qt7SBfvBe3viONeUkgO71zm7gN5p91oCjXuoNEkysfkoqY8B
        EckHT6IsTWzc5YCbOCx/v/g=
X-Google-Smtp-Source: ACcGV616gXF14EvbCBZbigcydPI5LsDgstZBQWiK9CyU4KDlnfDthsmeNvoELqh5MZIYjt/CKZNGgA==
X-Received: by 2002:a63:455e:: with SMTP id u30-v6mr14101901pgk.30.1539563169975;
        Sun, 14 Oct 2018 17:26:09 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id j14-v6sm11387110pgh.52.2018.10.14.17.26.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Oct 2018 17:26:09 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v3 08/18] of: overlay: reorder fields in struct fragment
Date:   Sun, 14 Oct 2018 17:24:20 -0700
Message-Id: <1539563070-12969-9-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
References: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Order the fields of struct fragment in the same order as
struct of_overlay_notify_data.  The order in struct fragment is
not significant.  If both structs are ordered the same then when
examining the data in a debugger or dump the human involved does
not have to remember which context they are examining.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 7fcf4a812d06..272a0d1a5e18 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -49,8 +49,8 @@ struct target {
  * @overlay:	pointer to the __overlay__ node
  */
 struct fragment {
-	struct device_node *target;
 	struct device_node *overlay;
+	struct device_node *target;
 };
 
 /**
-- 
Frank Rowand <frank.rowand@sony.com>

