Return-Path: <kernel-hardening-return-11780-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x2258FI+oWgkApK8+2YxcUCU/A79PaBW2747c57Ft/s4vNt444EeSMm4V0CHdH0Akglx/s4nk
ARC-Seal: i=1; a=rsa-sha256; t=1518639174; cv=none;
        d=google.com; s=arc-20160816;
        b=qjwIpl8DlSplLx9adHGXx71vEf2RIR2N/G+nIKEqIRD+1TVTUuWOAdX9+q5Y2b0l79
         zhBBT3oULvJJn5Zul3iLByb/joU6ndrpWX7DV2Udq2FNnJdH/PSr7gzjbVe69GAtVXOS
         Guk3FcGVbri92rhr34mED0zpeWF/zamtiNrHpMh4g2PDBJq7+UwlVzJ4kYWdMlbnN7mj
         /SrKt33JlzPmuz55vBIvGmLYdeT8y3orHXB56M8tHYTxApEMlDx9ZDfPtIpa7cMbTOJs
         UBqSUHA5jHaBXt8LxbB9A4Rqt7yabpAmEqJt2wHc5DZ0x2GI5tKw4tptdX4D7EzphkJK
         gmJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=BaAze7teYSI65z39a63N2W2mofnTWFTM3LnOeS1JLDw=;
        b=Su1yIDPCAQ3KnIstM5d6s9+pk5d/KE+h2GG4nrSGuDBh+dC8F9YNSJBVUraJYTYvfY
         Hd+xmhzpuyri/BrkW9DOa/x/OATVfP0BnH0BrJbWE/A+xTAaguVoFK7rmh3Q7OzOkLtA
         zGfl2a+0t+cbxOselyutIHh0nTW69p2bK6QGYwCYod4OlOznIhMqK3nGCYFbOv5qI6M7
         2FsSXKipRjrhU6VYoWObunsbBRc0fCmf2BAD0c3A8DL66maNOT2Wm0jN7URJ4MrKsGDD
         wCf1ACnBpvirfhX4BZJ9qBf6QFLPQaxmO+GrbMtGuYszQ+dIUs0xKJNAYM1wJWhNyJ0n
         gemQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=YPL3Xa1O;
       spf=pass (google.com: domain of kernel-hardening-return-11780-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11780-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=YPL3Xa1O;
       spf=pass (google.com: domain of kernel-hardening-return-11780-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11780-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
	linux-mm@kvack.org,
	Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Joe Perches <joe@perches.com>
Subject: [PATCH v2 4/8] Convert dax device to kvzalloc_struct
Date: Wed, 14 Feb 2018 12:11:50 -0800
Message-Id: <20180214201154.10186-5-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180214201154.10186-1-willy@infradead.org>
References: <20180214201154.10186-1-willy@infradead.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592408591122150535?=
X-GMAIL-MSGID: =?utf-8?q?1592408591122150535?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthew Wilcox <mawilcox@microsoft.com>

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 drivers/dax/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 2137dbc29877..5821cde340f6 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -586,7 +586,7 @@ struct dev_dax *devm_create_dev_dax(struct dax_region *dax_region,
 	if (!count)
 		return ERR_PTR(-EINVAL);
 
-	dev_dax = kzalloc(sizeof(*dev_dax) + sizeof(*res) * count, GFP_KERNEL);
+	dev_dax = kvzalloc_struct(dev_dax, res, count, GFP_KERNEL);
 	if (!dev_dax)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.15.1
