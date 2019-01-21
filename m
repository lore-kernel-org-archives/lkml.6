Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA701C67875
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B17920870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="TtViGTvw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfAULBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:01:34 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43196 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbfAULBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:01:32 -0500
Received: by mail-ed1-f68.google.com with SMTP id f9so16203544eds.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 03:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QZ2CPjy7IlGoDls62PJ6M9VTltf7smGdYPcjaWrBAIo=;
        b=TtViGTvw1+UU0dO+tt7jCRlpRmZzVUopfnASFA/T6DNlZJbPNjrKIouCY8DTtj5xDS
         KH2GLEMezROXyGPMM9NPJr6zQlKHKuPo9AIkg/n6Fvmzgc4dVr/vM5RIjc0hS+QKZDCw
         s8tg0iHarkA70VXKiWCbSKPzFDi9b7PWfwpzZY5asAil6MClCKPuzB6qxF2j3BWhyEaH
         0lTSXIiR2YVajAPZQuWTVxHm+SANITabZytrqVXLj3s7y4ql8NNROAEI2evVuzutm9Jv
         hpYwy3jGV0jHRiwKBkTizDSmHfdNKMqQWjRAgnRyUSO7i4C079AlM7sD4ns3jqhDYRRY
         Wgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QZ2CPjy7IlGoDls62PJ6M9VTltf7smGdYPcjaWrBAIo=;
        b=gEiPHEzO9g++5aYIGH5Pn7hFepG6cjdCa5I1iOFfHophg92686nGZ74A/mBw4Gqfgq
         SMcQXPGylTCtHegRUNzjiIfWmv7y0YArLyqMJFuhj/4t/Zgora4gLA5XblBrGFpHZ+Vd
         o4zI70nTJZWt7045MTzQTkHE+xtuauZ7Fhw5ze1xzi1gH1lscNZvpeAxGZwExQ7rcjWE
         RVatMH9HEyhHZR2oi2l6KVw8tOjH/72Y/mAJB2vpAtPZ47gSzrXDnUwJW/K0QuSbY9r5
         g6cNKPJp+lW3Y3bDKR5ybMpKmeuw3kJf5jWcIf9xK1XjiI4m3J1jAbun4r249SQrmDMY
         RDrQ==
X-Gm-Message-State: AJcUukeH2/+favV0dBv76afkJpMe2sn3uZRPbBxUke8mv5MdU+K6c4MF
        4Tubc30f4wwLSYHTmZ0ohRtL+A==
X-Google-Smtp-Source: ALg8bN7GdkWbsl6yptlQKhorGkub5cmlRxkobu3Y732Sd9FCClvzbLCMk5gJ3pWCmS+Umc73ceg5nw==
X-Received: by 2002:a17:906:b297:: with SMTP id q23-v6mr23691352ejz.147.1548068490775;
        Mon, 21 Jan 2019 03:01:30 -0800 (PST)
Received: from localhost.localdomain ([2a02:8109:b6bf:f9e4:9473:6b39:afaf:14d4])
        by smtp.gmail.com with ESMTPSA id t24sm8970080edb.7.2019.01.21.03.01.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 03:01:30 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     gregkh@linuxfoundation.org, tkjos@android.com,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tkjos@google.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH 2/2] binderfs: use __u32 for device numbers
Date:   Mon, 21 Jan 2019 12:01:20 +0100
Message-Id: <20190121110120.27003-2-christian@brauner.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190121110120.27003-1-christian@brauner.io>
References: <20190121110120.27003-1-christian@brauner.io>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We allow more then 255 binderfs binder devices to be created since there
are workloads that require more than that. If we use __u8 we'll overflow
after 255. So let's use a __u32.
Note that there's no released kernel with binderfs out there so this is
not a regression.

Signed-off-by: Christian Brauner <christian@brauner.io>
---
 include/uapi/linux/android/binderfs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/android/binderfs.h b/include/uapi/linux/android/binderfs.h
index b41628b77120..87410477aea9 100644
--- a/include/uapi/linux/android/binderfs.h
+++ b/include/uapi/linux/android/binderfs.h
@@ -22,8 +22,8 @@
  */
 struct binderfs_device {
 	char name[BINDERFS_MAX_NAME + 1];
-	__u8 major;
-	__u8 minor;
+	__u32 major;
+	__u32 minor;
 };
 
 /**
-- 
2.19.1

