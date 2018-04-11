Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/Q3GxdlguuKi8z40q0ZHjOompSMq5X8nX6Cp3ZTWljmFIKEabUbULtEcXmtH9jLO+TjIr+
ARC-Seal: i=1; a=rsa-sha256; t=1523473346; cv=none;
        d=google.com; s=arc-20160816;
        b=qVgM6Jn0tunN4hv5SBcVbVU+OSwGo9CNXxU3yEWOIxHvRUkz40goG4LZzLNSZOCX4E
         HDSNICzvZ3W9x+epI9OGxV0Nt+nwcZg+HQ/GTUt7fosfhzM12gV4p3C1svU0eY53W93F
         gRYjMW0anJ5HTIVrsU8rhvTA54lJow8A4eYapKB0EoWQgtPNUTLRugTb7D5BPredPd6B
         uEpPtUKx5JAapx07Znb7zyMbfTYyT8slq4h8zBf5Ob9LKHXM54aT2RFU2seUZfnRI1ql
         C+KBSoHVr/S+bkD+mjJFHQn3mgxOcxjPHXkkAbPMiTkZUESTw3JhD2GUe+cefr9IIOxS
         iBlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ib+XvU8BfSKcyJAxuCd8aLgdpHlCyz9FPKzfmek60PM=;
        b=vZ7mjOZCgtSqkBC51RVcvrjaNOxZj5KXL+Fpqzo11665b6SeQ75V9DAhd7ellyZ2X6
         lsOjo2cxXOwEi99aVZjKXS6MOndbRhBpcZ+fMti/cisumNvSGiAgkVFtBteSFC28/XqR
         UIejPDj55H6bmTmxVLt2xnB8d3+CI4Thph70di0c3UKKoIL/bJTsAUjsy49ZLcm1ay4o
         7DzywhsnkRantE6eZqDoUihA56wG2c+L9NfIOKgNlr1vPlby1fD0/0rnoT9/VT5CWooT
         4xKpauRNVmlY51Ywh8x4F9kFsDYwJW2pBJANTizd2ZJzH24T20MEvS4BtHzb/NpS25S4
         4J+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jia-Ju Bai <baijiaju1990@163.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 180/310] mISDN: Fix a sleep-in-atomic bug
Date: Wed, 11 Apr 2018 20:35:19 +0200
Message-Id: <20180411183630.351103149@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476207361902573?=
X-GMAIL-MSGID: =?utf-8?q?1597477587439961457?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jia-Ju Bai <baijiaju1990@163.com>


[ Upstream commit 93818da5eed63fbc17b64080406ea53b86b23309 ]

The driver may sleep under a read spin lock, and the function call path is:
send_socklist (acquire the lock by read_lock)
  skb_copy(GFP_KERNEL) --> may sleep

To fix it, the "GFP_KERNEL" is replaced with "GFP_ATOMIC".

Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/isdn/mISDN/stack.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/isdn/mISDN/stack.c
+++ b/drivers/isdn/mISDN/stack.c
@@ -72,7 +72,7 @@ send_socklist(struct mISDN_sock_list *sl
 		if (sk->sk_state != MISDN_BOUND)
 			continue;
 		if (!cskb)
-			cskb = skb_copy(skb, GFP_KERNEL);
+			cskb = skb_copy(skb, GFP_ATOMIC);
 		if (!cskb) {
 			printk(KERN_WARNING "%s no skb\n", __func__);
 			break;
