Return-Path: <kernel-hardening-return-12315-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuOzCQEoavUfYFPcw9mWTaVsML0FgL9dteCfGbc6bFZtHBCggxJ75BEt2yFjZ6WZpJ3Skjb
ARC-Seal: i=1; a=rsa-sha256; t=1520599146; cv=none;
        d=google.com; s=arc-20160816;
        b=QbKWwGhH0uZC6LiZKYz12uK8GPujAzXHAXTtRfnhP2yBAgURhjH12gke7yhUGZgW1R
         CCJFI6YhvtKM2u/pORSP2UVk/pZca9JzemfFd/yw9x+iFgcRqAk1yrO5oMhiuPmLBSyG
         as8T9xbiELkQfliF8GfhVU3AzMMEPGrwU9BhyaSgSZ/IzF/zny94M6pMreAnWgDzH35Z
         eqvThLZDTzhJi37Wkwr0ISwYGfbH9DCVavtABhnAMePFKvJ2rsPMpTc375IjQ1hH0n7r
         +ykUJtq4wefD2WrshqfSrT6UAafVgaEPNh44CLkTk9B4Qf8UJuE2vfBlEoC0QaN/6/bP
         ghOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=PpJhd5F9hEY2ZzbN4hddMxG0w/j6Geg+LH0C6ryn7ME=;
        b=UBIWbO/i4Y6zGWmJoZ+0s1wxIPq2AHLvL4txyZ6/xEtp8TVxMxWXNJMNPbTqYbphJC
         PFnmZsecDGKp9165BKzaVEWm+zubrsNW3mzuxhSXCkvQO83nwq0LM+LBCUvOTsU6/FEv
         AWxT9SqzVCB09XthtROaXWicb1aljtE1osQUk49CCoZeqjwzcENRqYmmo5cT6z7+HfOt
         TkjLgIhMaPddhU0zZ3YT36hhBlsfFMKCYDa4P5UnfUWQBax9aRzyw5NbcoHMMQAJxUee
         TaW3FdYfj/pZNWDSxvZpNx8uT9sfE1dyg+aNCqP246QSBUKL6hA8kgyIOVWm5iPA0mVb
         mQlQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=eXjFKSt9;
       spf=pass (google.com: domain of kernel-hardening-return-12315-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12315-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=eXjFKSt9;
       spf=pass (google.com: domain of kernel-hardening-return-12315-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12315-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Andreas Christoforou <andreaschristofo@gmail.com>
To: keescook@chromium.org
Cc: kernel-hardening@lists.openwall.com,
	Andreas Christoforou <andreaschristofo@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: ipv6: xfrm6_state: remove VLA usage
Date: Fri,  9 Mar 2018 14:21:46 +0200
Message-Id: <1520598106-3271-1-git-send-email-andreaschristofo@gmail.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594463771060382720?=
X-GMAIL-MSGID: =?utf-8?q?1594463771060382720?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The kernel would like to have all stack VLA usage removed[1].

Signed-off-by: Andreas Christoforou <andreaschristofo@gmail.com>
---
 net/ipv6/xfrm6_state.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/xfrm6_state.c b/net/ipv6/xfrm6_state.c
index b15075a..45c0d98 100644
--- a/net/ipv6/xfrm6_state.c
+++ b/net/ipv6/xfrm6_state.c
@@ -62,7 +62,12 @@ __xfrm6_sort(void **dst, void **src, int n, int (*cmp)(void *p), int maxclass)
 {
 	int i;
 	int class[XFRM_MAX_DEPTH];
-	int count[maxclass];
+	int *count;
+
+	count = kcalloc(maxclass + 1, sizeof(*count), GFP_KERNEL);
+
+	if (!count)
+		return -ENOMEM;
 
 	memset(count, 0, sizeof(count));
 
@@ -80,6 +85,7 @@ __xfrm6_sort(void **dst, void **src, int n, int (*cmp)(void *p), int maxclass)
 		src[i] = NULL;
 	}
 
+	kfree(count);
 	return 0;
 }
 
-- 
2.7.4
