Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3C8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E8C2177E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297581;
	bh=NcC+nBPl1lAP4xUTCPeXZmAxkLleUsL2rEFi5pPjLSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t4iL2w3lGkQNujx3oH8YkM4I80WWBgnogixMM6f+wMq61H+2+7hKjk/1OsdKzRw7s
	 raRcELnAp5etv9EC2Ag3Xx4BwhQ7qtAqsHKLx2u3Q7J5Ue5NI8bK4uwKAw58jLINxo
	 xKDdWtjM1Dr+LNVM2rI/3RV0SKRJAZXWApcgspAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbeLTJTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:19:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:43974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730184AbeLTJTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:19:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9474A21720;
        Thu, 20 Dec 2018 09:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297575;
        bh=NcC+nBPl1lAP4xUTCPeXZmAxkLleUsL2rEFi5pPjLSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2FWjws82ZPWQvcYtVF4vmrOu9QBNnQYnyhIoYeipgqO39mAHcgCyHGP91b9P+WD4Y
         6oDa5IZEzMOLFNG8Gcq3CqsqldWkWrv4m1HOnOS+EG8ZznLon9KcRADGXuS1WVv6j4
         uzt6NFW+jyWNSkGkp0Pm6RwNIt5p3eH9Seu8oFX8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rob Herring <robh@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 3.18 11/31] powerpc: Look for "stdout-path" when setting up legacy consoles
Date:   Thu, 20 Dec 2018 10:18:23 +0100
Message-Id: <20181220085743.044119274@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085742.601260254@linuxfoundation.org>
References: <20181220085742.601260254@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit bf3d6afbb234156749b640b6c50f714967a85964 upstream.

Commit 78e5dfea84dc ("powerpc: dts: replace 'linux,stdout-path' with
'stdout-path'") broke the default console on a number of embedded
PowerPC systems, because it failed to also update the code in
arch/powerpc/kernel/legacy_serial.c to look for that property in
addition to the old one.

This fixes it.

Fixes: 78e5dfea84dc ("powerpc: dts: replace 'linux,stdout-path' with 'stdout-path'")
Cc: stable@vger.kernel.org # v4.17+
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/legacy_serial.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -370,6 +370,8 @@ void __init find_legacy_serial_ports(voi
 
 	/* Now find out if one of these is out firmware console */
 	path = of_get_property(of_chosen, "linux,stdout-path", NULL);
+	if (path == NULL)
+		path = of_get_property(of_chosen, "stdout-path", NULL);
 	if (path != NULL) {
 		stdout = of_find_node_by_path(path);
 		if (stdout)
@@ -593,8 +595,10 @@ static int __init check_legacy_serial_co
 	/* We are getting a weird phandle from OF ... */
 	/* ... So use the full path instead */
 	name = of_get_property(of_chosen, "linux,stdout-path", NULL);
+	if (name == NULL)
+		name = of_get_property(of_chosen, "stdout-path", NULL);
 	if (name == NULL) {
-		DBG(" no linux,stdout-path !\n");
+		DBG(" no stdout-path !\n");
 		return -ENODEV;
 	}
 	prom_stdout = of_find_node_by_path(name);


