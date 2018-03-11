Return-Path: <arvind.yadav.cs@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520747776; cv=none;
        d=google.com; s=arc-20160816;
        b=U2SDMkXPgfhOx7yPzPUCZd90kQvMqmGgOULiiddXOfddCQHaTy/TI/+VSDcStgJ5tY
         lIMjd78F61Hl5/tIHUjWN/tOBqPGz3FpEyxFOJNxAuIetWtXf1lS9GP7aYB/jyj3YWXd
         s+9D1Oa1+/F59/z/WJnNPBDzCN0/nlp5txRSKy0WrhvwfO1uz9caXroJKGp9yzB5shY+
         JQOS1csExQYgSriwkaZ/dYQP4YKMnnG2JCeGPfJFdiXLr+WYOUZfgK6EQZLp6RLin4pa
         EtiyHE7bnHAUyYB+MseXaFK5Z/IOfj1ZAUqU6bCR9k3YSgGw9gjdF5m0z88t9WPvt6tt
         c6kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Bed9ywE2+nYJEKoggZM90kNrX2F8ic0tzHIHmoNZUYw=;
        b=Mw862qrVqk0ZOzRlj9Zih9OPL92D8V4Rw3FEb5/VDE2v5Lv7x2gnXHpcvdWAUH2UI5
         HNknaNW4UfWsjME7rvfBKD9n1n1WlANub1vA9jaLfOtdU+W4vf/BCrOA7hY0fRVoW8I2
         JS8LFhMCXjkqycYYUQN8YEYHCgRIJUTL0UW+FvU7JQDPy7nxrWtCnWymMAi9kqsTEA79
         JHCqHJeSKkkQOjI6BZgKxLe02NpYYzFcPOnoMnpv8tqROz/L9pICcrQ4Trtbjuko3gzg
         Od1I2zwfHzBLEYu8xqFlN8PIChbWWKe4zGGERktr/+Fq5s5bY1DqeZiz131oWMtkCr8m
         L9pg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=jvQjF29L;
       spf=pass (google.com: domain of arvind.yadav.cs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvind.yadav.cs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=jvQjF29L;
       spf=pass (google.com: domain of arvind.yadav.cs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvind.yadav.cs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELsBawIRXOJEIxTakxIfl2dHpCK2DIcrFTB+q2V/gZa17XrR9fHy/hvesvF0b2OjZrbrbhE2PQ==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] base: soc: use put_device() instead of kfree()
Date: Sun, 11 Mar 2018 11:25:48 +0530
Message-Id: <9acdde3143458faf8cdc5cf6eae08c3c306bf025.1520747459.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1520747459.git.arvind.yadav.cs@gmail.com>
References: <cover.1520747459.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <cover.1520747459.git.arvind.yadav.cs@gmail.com>
References: <cover.1520747459.git.arvind.yadav.cs@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594619620507770937?=
X-GMAIL-MSGID: =?utf-8?q?1594619620507770937?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Never directly free @dev after calling device_register(), even
if it returned an error! Always use put_device() to give up the
reference initialized.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/base/soc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index 4e80f48..10b280f 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -150,6 +150,8 @@ struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr
 
 out3:
 	ida_simple_remove(&soc_ida, soc_dev->soc_dev_num);
+	put_device(&soc_dev->dev);
+	soc_dev = NULL;
 out2:
 	kfree(soc_dev);
 out1:
-- 
2.7.4
