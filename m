Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC7FC61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 16:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B672084F
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 16:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLiTw/CX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfASQSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 11:18:51 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40360 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbfASQSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 11:18:51 -0500
Received: by mail-pg1-f195.google.com with SMTP id z10so7499182pgp.7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 08:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p2JF6kCxDVwm8ztbo8DbVkB8buCPaFSdA3+ZOMTjwkM=;
        b=ZLiTw/CXvBtjwyP+b3HA/yOdrHasdukHyaN6/wZirWWGx9OG3v+a30Py2h9jHoJ7Ry
         /rSnbzrzDwQuD94mhLoVlk7PrhHb+uzYi8BtA4exDWbI+2RKHspc8EQAP8iYaz8dVJ1d
         YZutH9PtQd0wDltZuooF6B83Oz7EYRFMxbTQdLhaj2MvnC7sy4p+N7cUz384f3mlYg8X
         JT4FmSyt1YIjy1Gled6wthM43OhU8JggppJnBQ+xLEaSoFdiHFkFh0EMYJxJSlcPulNo
         EpAOqActKeYTd8IAR7r/hECfF2YhBgJw00kYBjpgJedOQIKgHSOA/zYTNviXA/UknD79
         qJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=p2JF6kCxDVwm8ztbo8DbVkB8buCPaFSdA3+ZOMTjwkM=;
        b=sS+Em9CmrpBdlXx8uaU+4lUpgabES7C4C//AM1bTvjorw4+cp3CDylUX9OqzJXhFyx
         k7YbJidNbS/m8mv6gOPLLdVpLfSehtNrsBZ+Y8/O3FLHnyKwxG5/UZQ6Q0vVw7Pb9sbn
         1/QZJdfRKRdLPXrZrsHQapjLlZs/4jTnLCVKHwaYchr9a+B/ZaSEmrJOa2FEcKhFZSmB
         HYxlJ9SjQOGWuiy5HAIWN8o3wDcH4YEfFAg+Vj6iNBH07+3X9R6PzQvkdDA+68BZPDoX
         HzehHsOiyyh8KjFLjw+N0fbWK6kwmLECC9jB8NZ0JQ0gWaK2MiXaeYcVjCKTWKvrS7en
         3YgQ==
X-Gm-Message-State: AJcUukf4mrmHVmXkDzh2lQv97acVJX90TO6C2pOz6phaYV3BBkqFOsQ7
        PlvOG8umPsf+2VIty8sxznQ=
X-Google-Smtp-Source: ALg8bN4HtuFQjUdq0KEw4xzV43Dbambc7GeLtCaeSodr71/pe2oY5aBPk6qJM9PbTzbp1CLLaMQCSw==
X-Received: by 2002:a62:2cf:: with SMTP id 198mr23792285pfc.67.1547914730497;
        Sat, 19 Jan 2019 08:18:50 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d16sm8748888pgj.21.2019.01.19.08.18.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 08:18:49 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2] powerpc: chrp: Use device_type helpers to access the node type
Date:   Sat, 19 Jan 2019 08:18:45 -0800
Message-Id: <1547914725-12125-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node type can no longer be accessed directly, resulting in the
following build error. Use accessor function instead.

arch/powerpc/platforms/chrp/setup.c: In function ‘chrp_init_IRQ’:
arch/powerpc/platforms/chrp/setup.c:541:33: error:
	‘struct device_node’ has no member named ‘type’

Fixes: 8ce5f8415753 ("of: Remove struct device_node.type pointer")
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: of_node_is_type() checks if the node pointer is NULL, so there is
    no need to check it before calling the function.

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
2.7.4

