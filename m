Return-Path: <kernel-hardening-return-11782-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x2250MPs0Y/sbqq6v2R4xBnefCKx6PBvkQGdbV1h8sSuC0ujlb64fH7uyC6dQI5NM4G6xGgJm
ARC-Seal: i=1; a=rsa-sha256; t=1518639197; cv=none;
        d=google.com; s=arc-20160816;
        b=hJyDt2n8x+E012fIwh84a3osZSwoyCCT29gpOM/yGtVB33xJJVS6mZulZyrQRSZE+u
         VGW7xcPCTjA/6xutNLEwn6kaQnSSKnf4a4lgFz6pKAkXWg344rVePmP55Bq6KN0741nP
         YaxJJ/XrCfhiBOBqb0zWS9mFEluu8e2okbt4KS8vC4eOxiR5nUKQ41EKbWQhplwcjQ0u
         PvMkrpmLqYZlpZbXy0iYxh53LLGbVZ9SyiZbe42PjGkPFW0INpBxw06xOgAl3VeCgRyl
         20iyb5JVKxkrQ1HGgT4vd1BhC27RFjWb0ELCQFNL0+LwMJON2EwUcG3pFgfjiKBPq8Ud
         sgMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=p41W8TPKQfQSTAck/C3d5bTWDT6YCXIa+sGEUSNRcpA=;
        b=iRgsogtWTbEKLN31U696NxG5hR/WS1v6Ji5E+/UF9+lnyMV/juPyAxIdG8UbeKoKzS
         iFao7XEwPwMLskEUDmqUIeTkEtNrAxiDFX+nJCSvv1gqAJdJfBMqtRLq0ZiZGsxMP68G
         DIqK2NVMhnO+4WCbowrxsyS7KGyQtWM/0oaAT0D3kc50q+guM8uqoLSlkBX8DSmiJR2n
         ifG4okKWwHSGGAwsSqnh87eQqIHUAADhKU1v+QBJxAx+kLllTSh9+ZlUrYvhuxd9do7/
         Njya9JP0dfPu6L8WqZ5QtUMpVJv58m03Z3TRu0Jvb6MscVqXcMwJsXOYcXcxmAfuqlvH
         c/IA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=BwI/B++7;
       spf=pass (google.com: domain of kernel-hardening-return-11782-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11782-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=BwI/B++7;
       spf=pass (google.com: domain of kernel-hardening-return-11782-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11782-gregkh=linuxfoundation.org@lists.openwall.com
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
Subject: [PATCH v2 6/8] Convert v4l2 event to kvzalloc_struct
Date: Wed, 14 Feb 2018 12:11:52 -0800
Message-Id: <20180214201154.10186-7-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180214201154.10186-1-willy@infradead.org>
References: <20180214201154.10186-1-willy@infradead.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592408614546555727?=
X-GMAIL-MSGID: =?utf-8?q?1592408614546555727?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthew Wilcox <mawilcox@microsoft.com>

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 drivers/media/v4l2-core/v4l2-event.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-event.c b/drivers/media/v4l2-core/v4l2-event.c
index 968c2eb08b5a..20afb01301e8 100644
--- a/drivers/media/v4l2-core/v4l2-event.c
+++ b/drivers/media/v4l2-core/v4l2-event.c
@@ -215,8 +215,7 @@ int v4l2_event_subscribe(struct v4l2_fh *fh,
 	if (elems < 1)
 		elems = 1;
 
-	sev = kvzalloc(sizeof(*sev) + sizeof(struct v4l2_kevent) * elems,
-		       GFP_KERNEL);
+	sev = kvzalloc_struct(sev, events, elems, GFP_KERNEL);
 	if (!sev)
 		return -ENOMEM;
 	for (i = 0; i < elems; i++)
-- 
2.15.1
