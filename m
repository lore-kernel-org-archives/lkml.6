Return-Path: <arvind.yadav.cs@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520747778; cv=none;
        d=google.com; s=arc-20160816;
        b=Q2eTt4s2yBmqYbNPYV5dlRSpjEQtmFFrc4licy4+jLNNlZFyeHtdCTsa5cSbilCn7i
         sPk/OfVzwFs2YDWodqvSi4rQtKFz98eT/XlwvKxH1ykm5Z/oRFtfh1D7zMRIyxT+GdXn
         +xtnpNaTZZN6u1vOWGuCap+0YnoMKokecSt6a9vM3weA0URyhaVHa0W8HSTVo9oL+qae
         ohmqw1gvaYEqELTtfwYFYcVpE0I3GfpQfkOAQUqTo1f6CfEOZKJtUbsVe7+GUhL1Xqrc
         +1M5eq1x3qX/rmvBOMDUaq4k3IRPpl2+vo5OIA2M9A33MoOuDjQVzWBz3S5Mhjtlm/Jl
         6IFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=xGEPx0+pk8HbrW216HMDt7fFG3uNxoukemKM9i9hd+Y=;
        b=Z4APJZ3TGrx1fawDx6vmHutmkgGVSt0kDHY/Ka8VZSm8ADyb+LR3m7GoEYpBcrZTHT
         3X/eoJy9acXXCwKMSFa5kU8kvaH8pf9eQPYukEECZaoOEggCRkZB4NxuNEGbeBP7xDO0
         3sEXeAG6kddXN04JS9wVz5JghWNI5UnSlq/d4rkCNbmGbzvNRvuihS1iCUneWy6CSm+r
         xEe15j2ufK/uDQXRTClE5NULn1yAZrAAlyvND7s+S12FbbkAl3pwSSWaWj1Q5sqm8Wyo
         ED4YIzs7FHVink4NR+wfR3vlmdq2DW77F4+gNmB4Aj6x3bbR2FE1Np/++ZxYLoUb/b6q
         g+/w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Kel7/spI;
       spf=pass (google.com: domain of arvind.yadav.cs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvind.yadav.cs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Kel7/spI;
       spf=pass (google.com: domain of arvind.yadav.cs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvind.yadav.cs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuRTPQ27YULmwIICK6Sxb9TkT+0C9tJEiBnU6PFI8zAqWHto5kPfarAl12qmgIDX/xCdfmk3Q==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] driver core: platform: use put_device() if device_register fail
Date: Sun, 11 Mar 2018 11:25:49 +0530
Message-Id: <3118280595730def453e9ed89a16c9a8783490f3.1520747459.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1520747459.git.arvind.yadav.cs@gmail.com>
References: <cover.1520747459.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <cover.1520747459.git.arvind.yadav.cs@gmail.com>
References: <cover.1520747459.git.arvind.yadav.cs@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594619622388975451?=
X-GMAIL-MSGID: =?utf-8?q?1594619622388975451?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

if device_register() returned an error! Always use put_device()
to give up the reference initialized.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/base/platform.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index f1bf7b3..8075ddc 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1153,8 +1153,10 @@ int __init platform_bus_init(void)
 	early_platform_cleanup();
 
 	error = device_register(&platform_bus);
-	if (error)
+	if (error) {
+		put_device(&platform_bus);
 		return error;
+	}
 	error =  bus_register(&platform_bus_type);
 	if (error)
 		device_unregister(&platform_bus);
-- 
2.7.4
