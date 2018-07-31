Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E50C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 22:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBCF92083E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 22:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="vHRbNxB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBCF92083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732611AbeGaXpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 19:45:18 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38892 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732308AbeGaXpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 19:45:16 -0400
Received: by mail-ed1-f66.google.com with SMTP id t2-v6so5909066edr.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 15:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pj6b7/RsWBT0aQ+jchdnzHqrIb6BogBIBVUR0Iia8aQ=;
        b=vHRbNxB+AHgPplyqCsX5N0xKuzE471+lKPaF8UZP2JsNDifjbUSZr+tjjk0tHR13JI
         XG9qfYdLZQ0AzsUEfO4goxJf7bg+EMq1v4TUYnEtzd5s75iD8qVeKaviN7Nuh2PE/rlI
         Hpb0vzXnNds6BgZ8qKQPcAUVkJgKtGXKA48aspktdTtILlW4LYilI6LE7whj8AukB7Cq
         4mwaI77nAYcNzV7MfE3YJQRCKuN2UCO1ZhH1y6VKxS6CHmB+qzrxVAZQLYGPLMbuz307
         Gq2Es34Xi1GiBTzswrchDz5KyXI1FiHaY2UG95bC+BW0W1lmfT+oR/0JON2QnCwmmhmq
         l5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pj6b7/RsWBT0aQ+jchdnzHqrIb6BogBIBVUR0Iia8aQ=;
        b=hUhlGbMyV3RcmceFcIURS4jD9KnseMeVr6x0rO4nGBg/ZC6dbsPD3qiKE1YciPkp3M
         GeLeXycWEQbViijJq2WgayMgzDQNuD/WNj8E75jSlvNwlg+ZseuhJlNBfzl7hBujn/xF
         FuiW1Yln09ovrIZ37/pRysl1SAVcjnp8KLT+bOAYsihEvoAy6ORzZrNxkz4KiUdKwZz9
         E7CRQsVSGozmsg77HURSoD0qk8OZzNvLqRGRqQC8fenSPOc2Vse8iFDDne2Kfr3NZm68
         cN6Ce4J8YrdiE7qrJDtDMkRs9guNBuaDFdHasXNJDi2SSUSmrkfOnn07AsjoeOuePRZ+
         GHEg==
X-Gm-Message-State: AOUpUlHCczsSbSXXvbX/eDkc3LuUFZe2mpBl651Cs0sJi538JovJShoT
        MblASz+LtjC3CLOpMnOViU5m2nih/bc=
X-Google-Smtp-Source: AAOMgpfsqxAZSc5IoNRaWxAIqgct13uu6DStZ2qsJv6VOC63RAaGlyKifwoHQH7/qQt0HrjwmjCVjg==
X-Received: by 2002:aa7:d588:: with SMTP id r8-v6mr1301761edq.130.1533074570438;
        Tue, 31 Jul 2018 15:02:50 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1611:8fc3:703d:7635:5997])
        by smtp.gmail.com with ESMTPSA id g14-v6sm3431132edm.25.2018.07.31.15.02.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 15:02:49 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Salyzyn <salyzyn@android.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        security@kernel.org, kernel-team@android.com,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] HID: Bluetooth: hidp: buffer overflow in hidp_process_report
Date:   Tue, 31 Jul 2018 15:02:13 -0700
Message-Id: <20180731220225.159741-1-salyzyn@android.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CVE-2018-9363

The buffer length is unsigned at all layers, but gets cast to int and
checked in hidp_process_report and can lead to a buffer overflow.
Switch len parameter to unsigned int to resolve issue.

This affects 3.18 and newer kernels.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Fixes: a4b1b5877b514b276f0f31efe02388a9c2836728 ("HID: Bluetooth: hidp: make sure input buffers are big enough")
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Kees Cook <keescook@chromium.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: security@kernel.org
Cc: kernel-team@android.com
---
 net/bluetooth/hidp/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 1036e4fa1ea2..3bba8f4b08a9 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -431,8 +431,8 @@ static void hidp_del_timer(struct hidp_session *session)
 		del_timer(&session->timer);
 }
 
-static void hidp_process_report(struct hidp_session *session,
-				int type, const u8 *data, int len, int intr)
+static void hidp_process_report(struct hidp_session *session, int type,
+				const u8 *data, unsigned int len, int intr)
 {
 	if (len > HID_MAX_BUFFER_SIZE)
 		len = HID_MAX_BUFFER_SIZE;
-- 
2.18.0.345.g5c9ce644c3-goog

