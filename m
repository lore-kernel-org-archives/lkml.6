Return-Path: <mika.westerberg@linux.intel.com>
X-Google-Smtp-Source: AG47ELvAuYJyGjplfY9xjn1fdgxAGZOJBfyuB9HavOnlkedXRITFx3ANGUaN2hEIdbIMohmVIeXZ
ARC-Seal: i=1; a=rsa-sha256; t=1521476827; cv=none;
        d=google.com; s=arc-20160816;
        b=Ak7wKkLbj7HY843Q0s06Yz/1RKd5Ss/l/Mk7237C2f0PcaTAeM227HBYY/XvfF2PbV
         19O31l6LWxroxZ0WD8AnObYdvLZczZZMDhbqc0ep2QnhNx1sVWVDzIwbalsUVH9oRYmb
         0urqdKttUaQUxP4UB35piRQa7KWuX8mfgHWSJr6bJwfGdIvvpeFuSfdxDS0FOB0gfsym
         opxHkq+aF/djW3TLMGKLgch21t6rM4U+D3jwVfTn63O9CcY4FmVDgtY/qeqTdIFBv5uu
         A7slxbFJF7Ezn/quo3E5FB4/BNVZHLAbFALZe7lw1hfyta96pZ6qCsrA0Rx97Q2owT+9
         fSSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=AXJ3x/Ni8JNMvnvUSlz775HP7/Znx8an3MXnCpw1fqM=;
        b=jUgtgeJSoZzk25yloo2QOS+y45ngH2szIlLxKmOvCzY1AUQSLMVnnKWu1yGO4NX5H8
         S+hfKy0OWO1exVwjbJjj5qhroWcigyA4Enz8u24uYos2tbqejuEZv7L98jQc0PMnmvEV
         rH1cZpe7FdvJ0iF3fKP80bb5h+fu2c/PbYyaMnEYRm4bKPKfJRn3lJXZQ+W7g53Zp8lv
         RlPaxOT1qi6jFGjUmz00gorWfWxOZgTrqpYFdmKmBNG6+OXbbWSWN46x50LNe8OKCZyC
         Idxr3f2QtkcBd9l5hHzJcOjiJSdxOzVQ/HPRnHKcBLdcSzPvbtDgzm6pybi9ErhXACxR
         Xnfw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,331,1517904000";
   d="scan'208";a="35080666"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <yehezkel.bernat@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/19] thunderbolt: Do not overwrite error code when domain adding fails
Date: Mon, 19 Mar 2018 19:26:48 +0300
Message-Id: <20180319162703.5331-5-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
References: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595384086230284571?=
X-GMAIL-MSGID: =?utf-8?q?1595384086230284571?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If the Thunderbolt domain adding fails for some reason we currently
always return -EIO instead of the real error code. To make debugging
easier return the actual error code instead.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/thunderbolt/nhi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 80c33c7404f5..9e58d09f6029 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -1036,7 +1036,7 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		 */
 		tb_domain_put(tb);
 		nhi_shutdown(nhi);
-		return -EIO;
+		return res;
 	}
 	pci_set_drvdata(pdev, tb);
 
-- 
2.16.2
