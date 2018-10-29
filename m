Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D61C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3036B2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ob/pQuW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3036B2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbeJ3C6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:58:13 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40445 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728333AbeJ3C6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:58:13 -0400
Received: by mail-pl1-f194.google.com with SMTP id b9-v6so4189292pls.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 11:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ju7DDjQ5EQgY2Vdm0x5sIc3hTRdV2cyAY2lMXK6mO8=;
        b=Ob/pQuW0UpUR0ay7nxqMBJYNktZXki659iJYgHVConzvPmS4IV1S4A1mYLzvtn/e0n
         8SnvPTjxAq8pcTjyTUuODUpOcVLuo1WWQKaKpY7bSOsYb+albnPRCAKUSTNJjvdkWT1z
         Ygt+TUn+pXlXb5W+RED/ZDNAdFk3/ObF4qEOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ju7DDjQ5EQgY2Vdm0x5sIc3hTRdV2cyAY2lMXK6mO8=;
        b=VwRWNAJHp0pVJACnDlosOYwMbNC2ivnVWPb3vbNIod3httnpGNfdSyOxwM7oRo3GDl
         fBjiG4Sb21j3Ne5JybNKsymV8GpQTt489xJ5NdWSX0rdhhjc2EtAv4WdrKJqoNENdvWI
         ZH3bjcJ8EkuyumTsGFlGQdk+UIx4kJ8G9ReTE5bSVwsJrtatanc2/3gPfs/XiQAgWpAH
         aZ8IAhZ6rrGdfgLRutpd/cogjQTFBGWuqiMLTqDEYA4EkkJX/OQFFWP+UppR5Kay9JPY
         LAVZr+jW+JdOU0Im2HkMfo9pz9s+GOmzJFv/fM3iACweEEEk6aSH0zKgpKVKnzA6so0d
         bB8Q==
X-Gm-Message-State: AGRZ1gJ0uAtxHzHEgD9QXikLojeiQ3KXPbJY60d2MzOBQY73IeuYUrV3
        h+BAGAd3e+AiT4XBhvvNGRmyrA==
X-Google-Smtp-Source: AJdET5cteK2WQHOfSq1+EMOWluU96jWlXmo+1IglaepbJu51Xp3UNnq7lyboax1VBvWL74SSH3OuYg==
X-Received: by 2002:a17:902:4165:: with SMTP id e92-v6mr15496837pld.209.1540836509720;
        Mon, 29 Oct 2018 11:08:29 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id u13-v6sm20537765pgp.18.2018.10.29.11.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 11:08:28 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        tglx@linutronix.de, mingo@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, jslaby@suse.com
Subject: [PATCH 4/7] serial: core: Include console.h from serial_core.h
Date:   Mon, 29 Oct 2018 11:07:04 -0700
Message-Id: <20181029180707.207546-5-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181029180707.207546-1-dianders@chromium.org>
References: <20181029180707.207546-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the static inline function uart_handle_break() in serial_core.h we
dereference port->cons.  That gives an error unless console.h is also
included.

This error hasn't shown up till now because everyone who has defined
SUPPORT_SYSRQ has also included console.h, but it's a bit ugly to make
this requirement.  Let's make the include explicit.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 include/linux/serial_core.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 78de9d929762..5fe2b037e833 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -22,6 +22,7 @@
 
 #include <linux/bitops.h>
 #include <linux/compiler.h>
+#include <linux/console.h>
 #include <linux/interrupt.h>
 #include <linux/circ_buf.h>
 #include <linux/spinlock.h>
-- 
2.19.1.568.g152ad8e336-goog

