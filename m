Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E9AC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381A32087F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="XesMQ/KO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfA1JWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:22:54 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25301 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfA1JWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 04:22:53 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548667254; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=INd2rZmXqpl/IbaOOF9KJv/cLulPERjjK6XHbbZNC64OGyTsq82KpS/cpxyiDTPiTr5tm4+P9PXCNCu+o5O1V1MQMnbkHsRJ6cZ/Vaaw3jlV1slFntf4kEauniEIF08pglWHFf6i0PGSZDOYzw86gqV35tySF5Uz/7GV3gxAG3o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548667254; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=6c85eo1+rpTKeHmS6CYmp7FTc9wE6zW/vlreIvgtLgk=; 
        b=n78oKJxLbI9oD8I89095IJOb8HddRufoT0Y4Uj2mkTenZkQjUTkN3MyV+yisx9YatSIx9CTHeWoXX/MDjlyPta8G7iJTu8YFSDNkM271tZsDRS83AgLM9VtBPKHzihHDjKvDYHsVUy/wRE8vztNLJE1GzS0Y+ZS8GH9JN9Ml9yE=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=euoN36KkhqKOhB5nB5BFnVjAHiPPFASvuKbVNOPeEGXuMyqqrM+9/VbRor2MHSFpwcGxjVtBb/6H
    rjM/0Np9Z5czwLC4WrsZ82jlererRDhGroX56kfnOS7Wr8WbXgW6  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548667254;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; l=926;
        bh=6c85eo1+rpTKeHmS6CYmp7FTc9wE6zW/vlreIvgtLgk=;
        b=XesMQ/KOaieH2+ZjSxfjzpbOoqXq9UIROBnv3+jEz+w55xVBhJfXChlwEJ4nJW02
        gAR+ZmtF0vl5adGCssnEWjV37mSDuj9iDXJ4A6crUenNZHsnW+Gz6F8h2BaV1+Ioi2V
        5Nsaheoeuet07Vxld6QFHc+nCtaxm6rrGANTyfrQ=
Received: from localhost.localdomain (171.221.112.7 [171.221.112.7]) by mx.zohomail.com
        with SMTPS id 1548667251967233.11790720555655; Mon, 28 Jan 2019 01:20:51 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        paul.burton@mips.com, gregkh@linuxfoundation.org, jslaby@suse.com,
        mark.rutland@arm.com, syq@debian.org, jiaxun.yang@flygoat.com,
        772753199@qq.com
Subject: [PATCH 2/2] Serial: Ingenic: Add support for the X1000.
Date:   Mon, 28 Jan 2019 17:19:36 +0800
Message-Id: <1548667176-119830-3-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548667176-119830-1-git-send-email-zhouyanjie@zoho.com>
References: <1548667176-119830-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for probing the 8250_ingenic driver on the
X1000 Soc from Ingenic.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
---
 Documentation/devicetree/bindings/serial/ingenic,uart.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/ingenic,uart.txt b/Documentation/devicetree/bindings/serial/ingenic,uart.txt
index c3c6406..24ed876 100644
--- a/Documentation/devicetree/bindings/serial/ingenic,uart.txt
+++ b/Documentation/devicetree/bindings/serial/ingenic,uart.txt
@@ -6,7 +6,8 @@ Required properties:
   - "ingenic,jz4760-uart",
   - "ingenic,jz4770-uart",
   - "ingenic,jz4775-uart",
-  - "ingenic,jz4780-uart".
+  - "ingenic,jz4780-uart",
+  - "ingenic,x1000-uart".
 - reg : offset and length of the register set for the device.
 - interrupts : should contain uart interrupt.
 - clocks : phandles to the module & baud clocks.
-- 
2.7.4


