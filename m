Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB7EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39B8A2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547822133;
	bh=ildADY/7GB3zc7Vp2tUolWchOR0BZmsMtsfAzTBpZiE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=e0lNaFZj1MkFzgnG3+MAs3Xt7GDvSK/ImFvexaCojysEHnu8DuKtHI87UuxVoXK2X
	 yuADtXZnCkxK2m/mXSksR3f8OXneQNVEnuQ3G07bjFS/EDvlgGAeajFTfANRCcxLTZ
	 GOSKVkIGMvUD2yMZ52EIJ9Y9YfdEMag7qDL3cao8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfAROfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:35:31 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42036 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727342AbfAROfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:35:31 -0500
Received: by mail-ot1-f65.google.com with SMTP id v23so14511964otk.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 06:35:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DVGhT6BU39gUhAH6M0jr+uNLemL95swoAvyl8eRJ6FI=;
        b=eR0p+o9ai3AcTn29+nA6iZ37R92D9HhUHyonmNgYrg1Omcftq01+hEbK2O6kLwHUBO
         gzToJYY00EeNrK/QXm3GXoLGp6GiFRaagZ3xM9b0RxQf/nGxnrYHooYhTZKQG0nLaZvM
         Hr0VaNUrb9QbOEt9Ieqpm24JfF26ezYPaXIbjd8hK5Oeut75ddSllnoaqurx2Fudmxia
         hUuLrwM/zWZxGHd863Oh3i5YSXLGcF06UjLZpmglUSUzAgKyT7hqMYmLJNcPodJEnUsT
         e6dlfZocrQST0xjN6RjYCSOrMGUdTm5nFTveqNY27yJ7u+gc+zpbrxA/HZhrfF7gIEOx
         RFCQ==
X-Gm-Message-State: AJcUukceXFkSQI8RcCsK/5ed2MT56cThp2wYpMw6b5fi4r3pSYM+xoDa
        s5t5UYggFqV9vQeNK/4F+2wfXDU=
X-Google-Smtp-Source: ALg8bN5Ptq+PNy/kuvFbCq58AbfrygjnpbikMXrpb1CD1H1RjCNXP08oP04eJ0y5V7mwGBr3yAaLhQ==
X-Received: by 2002:a9d:6a1a:: with SMTP id g26mr12418915otn.172.1547822130556;
        Fri, 18 Jan 2019 06:35:30 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k13sm2101711otj.19.2019.01.18.06.35.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 06:35:30 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, kbuild test robot <lkp@intel.com>
Subject: [PATCH] powerpc: chrp: Use of_node_is_type to access device_type
Date:   Fri, 18 Jan 2019 08:35:29 -0600
Message-Id: <20190118143529.13347-1-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8ce5f8415753 ("of: Remove struct device_node.type pointer")
removed struct device_node.type pointer, but the conversion to use
of_node_is_type() accessor was missed in chrp_init_IRQ().

Fixes: 8ce5f8415753 ("of: Remove struct device_node.type pointer")
Reported-by: kbuild test robot <lkp@intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Michael, I see you just sent a PR of fixes. I can send this to Linus if 
you prefer.

 arch/powerpc/platforms/chrp/setup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index e66644e0fb40..9438fa0fc355 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -538,8 +538,7 @@ static void __init chrp_init_IRQ(void)
 	/* see if there is a keyboard in the device tree
 	   with a parent of type "adb" */
 	for_each_node_by_name(kbd, "keyboard")
-		if (kbd->parent && kbd->parent->type
-		    && strcmp(kbd->parent->type, "adb") == 0)
+		if (of_node_is_type(kbd->parent, "adb"))
 			break;
 	of_node_put(kbd);
 	if (kbd)
-- 
2.19.1

