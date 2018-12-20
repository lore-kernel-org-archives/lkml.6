Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73381C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF63218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="bCHMPea4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730986AbeLTKlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 05:41:23 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35135 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbeLTKlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 05:41:23 -0500
Received: by mail-ed1-f66.google.com with SMTP id x30so1316130edx.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 02:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qrnoWVRgBMFgFz3oKgCnWbXHJsB70kEiZDeudcCynpM=;
        b=bCHMPea4ZOU60yKwFSYruzYTdcD/sXnyNsNARIiJy/qcRQ+Vj53j94J/JpvLJ+RUx0
         T5oIY7QxARMjoJEHqkRQxoMJVQtNTKEIJlbexjxWj4Jr/py8jhRPWnXndAI+6uHrZGDx
         2qT3E8sf5FgywUPnxGwCjYVzq38ntjgxixzGHTIzLb7aT+PtYefscKd6q0OGqHBuMuXl
         XRRX2dVpxc01COsbWJHeNe59Q1bDrH7DV/1Qbzxyd3gINmsxplKfyWgTVtWeIyhHtr1T
         l3kwWUa6kcvVnkQDLmT9L5Nr+EyhppiQaGPIrS6iCcGnRcDPyVD+P0FwJtgSx9PoBchy
         zELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qrnoWVRgBMFgFz3oKgCnWbXHJsB70kEiZDeudcCynpM=;
        b=g2jxfO36uXz9zQy/FD014mUGqZdZqK64/fPQeFrRWJ9kPBTXdbzoUSuDesADIVO70v
         jyO0bzaWlabtxYh45V8oSxdOHW0nn6GbjBFk0hhdKzW6ceTf+PgB1sNyo1nKagjL8Dmr
         o9gpNN8UMfogAUxJCIQTloMcCGeIUOoU9H4s2lKORWtmWbsEl9PnmJKKL/FxCu1bCiaU
         pxwOxttUQuCyto7NsspKUZvduMkaPrV935OAbnou9sPfez78SSrrKedJ7gIUrNIUlayI
         gPkRc91hBMadtZr0tenjUNJ4XcSSceknV3PR2NaS/XXfdxcKnTpkExN9Ipoi+s+jCtRV
         PKqg==
X-Gm-Message-State: AA+aEWZtJF425TlReLGTI5feE3+Q0aDA5DmWY7hclIeDse9VOYKhM8Do
        R1StGzKC5rf7ynASgBLvzpDYCA==
X-Google-Smtp-Source: AFSGD/WJXRq0aaV/dsd3mxt9DFB8Lwem0H/fifRUZegF5NBmgZmv9ZJYTG3LmwGE5wcruaCEVXwpEg==
X-Received: by 2002:a17:906:6d59:: with SMTP id a25-v6mr19224451ejt.54.1545302481752;
        Thu, 20 Dec 2018 02:41:21 -0800 (PST)
Received: from localhost.localdomain ([2a02:8109:b6c0:6c14:58a0:c7b2:d756:db85])
        by smtp.gmail.com with ESMTPSA id q3-v6sm3081404ejz.30.2018.12.20.02.41.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 02:41:21 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     gregkh@linuxfoundation.org, tkjos@google.com,
        linux-kernel@vger.kernel.org
Cc:     Christian Brauner <christian@brauner.io>
Subject: [PATCH] MAINTAINERS: update Android binder
Date:   Thu, 20 Dec 2018 11:40:57 +0100
Message-Id: <20181220104057.18628-1-christian@brauner.io>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As briefly discussed with Greg and Todd, add Christian as maintainer for
binder{fs}.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3318f30903b2..3c78cfa08c47 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -950,6 +950,7 @@ M:	Arve Hjønnevåg <arve@android.com>
 M:	Todd Kjos <tkjos@android.com>
 M:	Martijn Coenen <maco@android.com>
 M:	Joel Fernandes <joel@joelfernandes.org>
+M:	Christian Brauner <christian@brauner.io>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 L:	devel@driverdev.osuosl.org
 S:	Supported
-- 
2.19.1

