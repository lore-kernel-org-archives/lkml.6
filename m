Return-Path: <david@lechnology.com>
X-Google-Smtp-Source: AH8x227R5BfzYLxfYWvBPGhVHHG4ZUHodNOkaBwORDxRXgolXFcffuCL6rtlpFGJ9jkNk9bBudh6
ARC-Seal: i=1; a=rsa-sha256; t=1519076588; cv=none;
        d=google.com; s=arc-20160816;
        b=otRkv6qwoqPQ0leeijE5xfmNJK8+R1hg1ZMuShSSbGw0SYo7tfUKPUh0wT0PSaZuuD
         R3tec7vnU5fuixNlA9Op7Hp9QFMi2TGGTavqWNfHupNDJKe0DuCSeWbWtC75ww8s+Unz
         QEnhjERMbm8SgnQYj5ZgRumzVshUJrblO8MVef44FQwVg4XbrKjbMlvAKz16rOX1hRxb
         1a9djYv/AbrmZJ1zIq1vrIxpyy+JX3dIlhpIqkhohukn/bD7P0i9GQRTTmQcXSj8GXxR
         7FtfntsCaSRTgbD27JxkDb/zfXUZSy9FboY3RDniIo2hIQZC42ncjDOuAFIJ2kPfIwFu
         qbaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=BhPDIN0c9F9boRgQiH5d+qiGsjLmudUhlqPZ3+YITEs=;
        b=i8YEA1nQ8bGBbw3qGK3ATgX0XLtyAMOEjAKA4jVWsYhdpl1WKBwo5V2aDa4vvKM7ku
         ZBXgmzMbJ5Z4L+C72WMe16R5LIUww3YWCN4EZbV2wYsginn3sJQktKVQFStHkfGVYJtP
         U4Dbd6GRCQrFQKW6U7Q8tmBSpQcDQlqdsTj+g2P+wfVoU24wpaTVtvQdR2/UoPPVViqf
         JoEY4srakN9GMgRZ/86DHuLdfWzdH8fhJd6oXeRYCfMfrZ6iS/s1BOTjN/PMWcE46Htr
         dX9nZD7tQEqSzuQWYtuoiZHogJKm0pvtTovH9kXgOrj1tnDjEMegeDCyz0+XXJtM/7Dj
         5l2w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@lechnology.com header.s=default header.b=m6HQ7Gvq;
       spf=pass (google.com: domain of david@lechnology.com designates 206.190.152.46 as permitted sender) smtp.mailfrom=david@lechnology.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@lechnology.com header.s=default header.b=m6HQ7Gvq;
       spf=pass (google.com: domain of david@lechnology.com designates 206.190.152.46 as permitted sender) smtp.mailfrom=david@lechnology.com
From: David Lechner <david@lechnology.com>
To: linux-kernel@vger.kernel.org
Cc: David Lechner <david@lechnology.com>,
	Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 2/2] regmap: use debugfs even when no device
Date: Mon, 19 Feb 2018 15:43:02 -0600
Message-Id: <1519076582-7687-3-git-send-email-david@lechnology.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519076582-7687-1-git-send-email-david@lechnology.com>
References: <1519076582-7687-1-git-send-email-david@lechnology.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - linuxfoundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592867251259492596?=
X-GMAIL-MSGID: =?utf-8?q?1592867252444158741?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This registers regmaps with debugfs even when they do not have an
associated device. For example, this is common for syscon regmaps.

Signed-off-by: David Lechner <david@lechnology.com>
---

v2 changes:
- none

 drivers/base/regmap/regmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index ee302cc..f5fa1dd 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1116,6 +1116,8 @@ struct regmap *__regmap_init(struct device *dev,
 		ret = regmap_attach_dev(dev, map, config);
 		if (ret != 0)
 			goto err_regcache;
+	} else {
+		regmap_debugfs_init(map, config->name);
 	}
 
 	return map;
-- 
2.7.4
