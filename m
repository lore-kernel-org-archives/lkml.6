Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53C6C282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F342075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="rWXNsjXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfBKMZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:25:57 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37499 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbfBKMZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:25:28 -0500
Received: by mail-lf1-f66.google.com with SMTP id n23so7582925lfl.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JYcMZJWwnYjs5lNvrgyZLyaYKBt0sZAp/myA2P7sIbo=;
        b=rWXNsjXbmZRuP4V37SAe41A7qIqA7ZErIo6Hfvpds9wsuH7zdPODlASLsSnE7yWdHE
         8K89N6rsJVc3pIr+yUi9Mk9h8xjcTe39T9A80gmusY+M4/WPD8hIJ3HC1kxv05biOCZw
         cZQhVEsE2ZV/ESxWaEkDAQG9nh1+9s6w0r2MfcqHm41uCvGjkDksgDWaTV2kF5xb5l/S
         QUcCsQsCQcXuT4xJtL1K7vpF6KETYUfT8S9NmQoniden8HUrS+XqBtRJ7QeImtQ9W7gS
         +L69bITr6NV/dIRAbzx9qQhBlqiJLNZtpcnMDq6twhHzADTRhiOYChFOvwVRXlWSZImk
         eMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JYcMZJWwnYjs5lNvrgyZLyaYKBt0sZAp/myA2P7sIbo=;
        b=dUKyo8V8Rl7iPT9/UUFEWSt4vdoXyt3uxKqLJiShM006GP79/MZIh0lTHO8CkH0KDp
         kljXzHo+rVXN/C6P8uGh1Ij3DnoZ5ifa7i8Qp7yHBbrdTz6AFskWQRdzC3+DKaWtiz4O
         p8G068a8LgO2OolKL7kDcLfdFbIGNluD9xmlwvNp/sr4HRznxHqB0KtprNDMhUQ8bUqU
         7FNmyrTGUpj3wLWmjalh3uQoHfv3FjecZp6KZkstkX9a//41YFWDsPZwpEhpBYMRx50E
         PSyTLHRXrBra+6WETOu+1Ye1JTGHmVX+XraPnEnmh1ec45jlc4vBp8mnmkPoV4sD2UVv
         NP2Q==
X-Gm-Message-State: AHQUAuZyJhidwWUPkd20GsmSSpGrBJoi3552vKecJPAPHCjAHp0MggHa
        76KSBmriGF32dfZuvzfoLXXT6w==
X-Google-Smtp-Source: AHgI3IbaVOEWADoPTXHQsqYo7sf9mLdjXcq0ZGzfX1pYex22caB4DgD6cJDkjqcm1Vr1zG7p+xBQ+Q==
X-Received: by 2002:a19:f013:: with SMTP id p19mr3370775lfc.154.1549887926166;
        Mon, 11 Feb 2019 04:25:26 -0800 (PST)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id d70sm2278481lfe.14.2019.02.11.04.25.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 04:25:24 -0800 (PST)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 5/8] lightnvm: pblk: fix TRACE_INCLUDE_PATH
Date:   Mon, 11 Feb 2019 13:25:06 +0100
Message-Id: <20190211122509.19910-6-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190211122509.19910-1-mb@lightnvm.io>
References: <20190211122509.19910-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

As the comment block in include/trace/define_trace.h says,
TRACE_INCLUDE_PATH should be a relative path to the define_trace.h

../../drivers/lightnvm is the correct relative path.

../../../drivers/lightnvm is working by coincidence because the top
Makefile adds -I$(srctree)/arch/$(SRCARCH)/include as a header
search path, but we should not rely on it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-trace.h b/drivers/lightnvm/pblk-trace.h
index 679e5c458ca6..9534503b69d9 100644
--- a/drivers/lightnvm/pblk-trace.h
+++ b/drivers/lightnvm/pblk-trace.h
@@ -139,7 +139,7 @@ TRACE_EVENT(pblk_state,
 /* This part must be outside protection */
 
 #undef TRACE_INCLUDE_PATH
-#define TRACE_INCLUDE_PATH ../../../drivers/lightnvm
+#define TRACE_INCLUDE_PATH ../../drivers/lightnvm
 #undef TRACE_INCLUDE_FILE
 #define TRACE_INCLUDE_FILE pblk-trace
 #include <trace/define_trace.h>
-- 
2.19.1

