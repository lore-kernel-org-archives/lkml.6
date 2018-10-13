Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCBBC71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 04:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331B321477
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 04:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9auGlgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331B321477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeJMMa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 08:30:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36379 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbeJMMaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 08:30:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id f18-v6so6757318pgv.3;
        Fri, 12 Oct 2018 21:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zdOcjsQSagxh/0ytfqlFE21zp3hEcz2hdT+yMst4gNc=;
        b=O9auGlgy9Z0x96YJvAYLdz2ST9vhVjlVWQVyAFSXEZqJqvQgoJSMX7PUxtVv1htyyn
         j6MdDUExsrb+fu88348j/h+zw7BCl5yhPdLFjcEkrNSH1Skg/Ts0bqF6I8ef0P9rkG0Y
         4DbhknmzACpRxV1Gi2+1QuiTBqjX3xoXRGk3TMrb/nRl2JfSMvRwWTwZLxkxe+SOkD/I
         Zi7Ot06wyBOXbR/93+NNuhw/zpkVy/N1wS5lFroZjDp19WXcpzEjinIKuOpz18QDVgZu
         4amOrTXFE15X6J8FYLvgmFFR9R2qZZATrL/ozteZDrt4glo8NVTOnCqLOJC3W7VhUPVP
         B3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zdOcjsQSagxh/0ytfqlFE21zp3hEcz2hdT+yMst4gNc=;
        b=Pi8zuKRHCrM1j1f63eS6XY9SEcK6tawwSz+9VbdE8sshhDhyEt1KvNuBpVd8dku6Hv
         4lIwXb7l9pLegwlkge8F4rWnExxRAhTyEXLHUX2S7mD0r2OJAcl+0AdUFJE798S6rNZg
         3wWs8jbIUfZiZ3Xqz32kYh22GCofKk724vv6pDInFkrrl8/LAoex4NVE0I9I3t09cQpf
         /n0SD6fH/qD2DI1Vq6nKliY4NxQ1XzivTFYVV5gsJiZevhsHMN525gRrPRIIG91NauWq
         LShiIKCijjRD+9GuckB7z87TorY+h0wJcrCgfrRM2IrKxDr1smTipctezDn/NhEhtkhl
         covg==
X-Gm-Message-State: ABuFfojV03pxymOJ5nTWbTFPdIFirax+eBP53hUyomoQU0hvQ6GVPEjd
        m2i4AFgKImyfeyf7DXG/Lac=
X-Google-Smtp-Source: ACcGV62/3cjHH3VSCDcqLdDQDe1vjv4RkZlK643dZfhmlauhKbpks3bxf0tdhPRVcJpdfMly1+U6Ig==
X-Received: by 2002:a63:40c2:: with SMTP id n185-v6mr8236018pga.116.1539406514759;
        Fri, 12 Oct 2018 21:55:14 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id h87-v6sm6959462pfj.78.2018.10.12.21.55.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Oct 2018 21:55:14 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [PATCH v2 08/18] of: overlay: reorder fields in struct fragment
Date:   Fri, 12 Oct 2018 21:53:28 -0700
Message-Id: <1539406418-18162-9-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
References: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
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

