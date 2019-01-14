Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33958C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0287620656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okRSVG1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfANUmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:42:52 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36866 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfANUmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:42:51 -0500
Received: by mail-wm1-f68.google.com with SMTP id g67so1014900wmd.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 12:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vsoY6Z2RzPv76AJw97Rl7eieFNDjAMgdT+fidH+hV78=;
        b=okRSVG1GBQB9tJjAJGmIxCWR6LDF7H4yM4U8M7DI6fcRbvAFCsVnPHEUEWXN+HYsQI
         RtmKebROFwkNuFU8S/Kp4I+KZCox7L/ZH6tkg68GfHco3wooHgpccFF3byUvzA/yRN12
         fwx4gbvUaWs31rITnSmY0dcjonU660ToDObgSNduTc0AoBeKjD/uyFT/dQlSqNQRgbZf
         AKoi8SXyAI9QrYB7nqUMUnAkg2nIdT1c9z8PlqvkMpt+D8EdUe3KfDblU5nBKrgt0GX4
         a5r2ZUEjQFKtWmmR/zJiGbjXcQhjI6npdX6aSTEcQ13+S4+KfJxbFoskFwv0yYXSX97O
         PwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=vsoY6Z2RzPv76AJw97Rl7eieFNDjAMgdT+fidH+hV78=;
        b=B4qZKo2TOYfM3SYF3rEX3z5mlxotDXMIg3gAAcvVgWzaHR8Nha3qTw5OpOpdx9do0N
         ULkPhbeWCOjZdjWJSS0i/9zs+/Sr5Ww+v4eHUNc6IN/FUrQvzNAGzZvLTzcbTP75irsy
         DiBRTsaDI4bxyDBH+3s/qPdneFNPwoFrkIhVKW7JMYjsdqap9n5saBjCLEWa4D9HPd9i
         rwSH/E90qqcO6k9FHCFZ9Ed5VUwuVHPSCXttgBE8re3SVnyC6FdtU1oTMNyxZIcbMsNt
         e9vFl+5uqdR53sId27y38gpuV8aBphWJZZr6qcRO01XIzifxlDOcBbU/iEj6IKKiqMfh
         lH1w==
X-Gm-Message-State: AJcUukcDfB2RIVQfKm6WSZ2hvTng7g3SidMVpbjMOKbNwU+wTuk8Ipnj
        LInqTK6LMlNkUc4kuO9x0Bg=
X-Google-Smtp-Source: ALg8bN7juj9WySkv92VXCRJwb2t/co8PxBOyOmwL9DDHroS4/aHs4z7dwIRf8Zzo1B7b5vPIgMEcgQ==
X-Received: by 2002:a1c:f319:: with SMTP id q25mr658629wmq.151.1547498569748;
        Mon, 14 Jan 2019 12:42:49 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id n11sm18977753wrw.60.2019.01.14.12.42.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:42:48 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id DF29211422AD; Mon, 14 Jan 2019 21:42:47 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     Mathieu Malaterre <malat@debian.org>,
        linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] firewire: annotate implicit fall through
Date:   Mon, 14 Jan 2019 21:42:40 +0100
Message-Id: <20190114204241.21712-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
this place in the code produced a warning (W=1).

In this particular case rewrote the comment to start with the string "fall
through", so as to match the regular expression expected by GCC.

This commit remove the following warning:

  drivers/firewire/core-iso.c:308:7: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/firewire/core-iso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
index 35e784cffc23..d2d50bda5a5f 100644
--- a/drivers/firewire/core-iso.c
+++ b/drivers/firewire/core-iso.c
@@ -308,7 +308,7 @@ static int manage_channel(struct fw_card *card, int irm_id, int generation,
 			if ((data[0] & bit) == (data[1] & bit))
 				continue;
 
-			/* 1394-1995 IRM, fall through to retry. */
+			/* fall through - 1394-1995 IRM to retry. */
 		default:
 			if (retry) {
 				retry--;
-- 
2.19.2

