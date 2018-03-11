Return-Path: <kernel-hardening-return-12402-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuQBmMFL5Xt1pLC1orq/sn0Ni0JwAg21MrMBHBH20rg76M0sAxJA4i5Aya2QEOFT19nxCwu
ARC-Seal: i=1; a=rsa-sha256; t=1520802770; cv=none;
        d=google.com; s=arc-20160816;
        b=Px8NO5kLyvRrFnmMm6oyVXucjCmD1Pq+/8UH1mePLRV/RZrXWdmdxA62D7oSWj9LYU
         1UmxB/+KqRYYZoW3mPlmt8k8j9d8AEYsqIvX/1m7XWKwFk8js2E8zOVRg7IjcXydkDyb
         ykmv+uqrC+RSgtWF7E337rTgXisoA4KKNl9aPjXrVJVwYqsRgStShi8jCE/5nlY/Rg6E
         zgCU14B8GHoXjFz1+61AxQ9o4ZT2JKU9RHjN8APrjJHso9mB08++HpVcBjvnqqkTAIik
         wfN/60SLNhk8ODeau3jvH/8W8vtHesJkV5mEgNrgH9id/5MRraBqJIKmQS0pQ5o5zeSt
         2n8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=1+qsJTWP7XdEFSMlpRKCt0Nx+Dc+WSNeR+5PJXt3fgU=;
        b=kl7UPc95BbyUM/zBmxkPwSM+bhJjdXbiMzbH0Pd/wjGbftDnZuuIguk43R6LI9llQD
         arMfTq38J8oXshF1rGwVOyMmkMDwaNJpCiCErwVGeW/bSbyC5Iz0+YG7obWUUaWFALu5
         nQP78OuRIKVqIB7S/oDpvBRvekQIWsAHTSYZ1nMTm3ZhjuKNsq0Sc2xNg92NoQT0VyDM
         DGo6r6B5oA2NLsm+XNq7Y1XYLnLqQaB8IUd6mFHcO2+tPa/97LNeTIEwkJCcuamXxlft
         npqRCiRlVhnz3nOglm9LUbQpvoMMoWsyKzYnDpnhP+ug6VTZFmGzREXvlLA8ttG0QEMU
         dBbw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=clZ2aTeo;
       spf=pass (google.com: domain of kernel-hardening-return-12402-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12402-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=clZ2aTeo;
       spf=pass (google.com: domain of kernel-hardening-return-12402-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12402-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com,
	netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	David Rientjes <rientjes@google.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Hans Liljestrand <ishkamiel@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	Salvatore Mesoraca <s.mesoraca16@gmail.com>
Subject: [PATCH] net: llc: drop VLA in llc_sap_mcast()
Date: Sun, 11 Mar 2018 22:12:04 +0100
Message-Id: <1520802724-17509-1-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594677285477224056?=
X-GMAIL-MSGID: =?utf-8?q?1594677285477224056?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Avoid a VLA[1] by using a real constant expression instead of a variable.
The compiler should be able to optimize the original code and avoid using
an actual VLA. Anyway this change is useful because it will avoid a false
positive with -Wvla, it might also help the compiler generating better
code.

[1] https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
---
 net/llc/llc_sap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/llc/llc_sap.c b/net/llc/llc_sap.c
index d90928f..a7f7b8f 100644
--- a/net/llc/llc_sap.c
+++ b/net/llc/llc_sap.c
@@ -394,8 +394,9 @@ static void llc_sap_mcast(struct llc_sap *sap,
 			  const struct llc_addr *laddr,
 			  struct sk_buff *skb)
 {
-	int i = 0, count = 256 / sizeof(struct sock *);
-	struct sock *sk, *stack[count];
+	int i = 0;
+	struct sock *sk;
+	struct sock *stack[256 / sizeof(struct sock *)];
 	struct llc_sock *llc;
 	struct hlist_head *dev_hb = llc_sk_dev_hash(sap, skb->dev->ifindex);
 
@@ -408,7 +409,7 @@ static void llc_sap_mcast(struct llc_sap *sap,
 			continue;
 
 		sock_hold(sk);
-		if (i < count)
+		if (i < ARRAY_SIZE(stack))
 			stack[i++] = sk;
 		else {
 			llc_do_mcast(sap, skb, stack, i);
-- 
1.9.1
