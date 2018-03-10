Return-Path: <kernel-hardening-return-12372-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsds/HUmJCgsEhbg8QL79fyERn9YyFPuNO51/zFGM6fpSTqpRZiZ5aF5U/gesjKqm12sD/E
ARC-Seal: i=1; a=rsa-sha256; t=1520668027; cv=none;
        d=google.com; s=arc-20160816;
        b=vZKLgCiUHcNPhjg32hnlVaasql2rpFnTJnxw+kV67hHUhcHKWMMjsUU1hQwLZ1QT3x
         yL2f4h/x9+Cy2MHMLTRv3+x4yTr0xPUoIl176VjdMrAG8q4FL7qzf4ubdU1n6O757pP5
         FrN6D7wt3opdaz6ARzPWkv8IPkm8glKdqxM/t9XsLjACyfBFg1gXEdSgh+1ERDhg+Kb4
         KHzwCxrw17hcCsjevup34kujEwvLI9QJJCsY5RbRTmCJai0x7O06PgLl7CH96pqMgWl6
         U+b7xzj0/KbJ3+CiwSNjO6/hHcAWD7wGKra/alZKRBpCD94gSudAd8GfXzmu3BWWOamU
         PY3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=vp8TB+Wcyvv8moPQGo6/RPcCsEvC3KZjuWDfaKRM9Ak=;
        b=FNqKXO94T2q6lolD0wdogi+kE83PJtSgh4YRpzX5ZFDw6SXLpCkRrv7C44koSmjV4C
         MHrYOouFpcluuEN2Jzr6sDrHRThUvulJh2VSedl3VoFvCaqgUcLTHmdL0OHN86aL6yf9
         Okxmy4F8dXTzxTOOrf0TEUfzsEMPvnkKdwElpfdtrdqZly9K/eZt5Xaz95q258IGSHBm
         O9gK270dDF33A8Qdzd2zXyH+wKTQSymFmu4qWBJV1EgHbQCySFNt5eohWuowx2xH6c3c
         mIPsbVDKVASGeQCa43pQaaYH8Io+S1lFK89EC0Z3Kn6x4kEXMziWQRG2wDXhEbe5geEG
         O2ow==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=jmiyP5R1;
       spf=pass (google.com: domain of kernel-hardening-return-12372-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12372-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=jmiyP5R1;
       spf=pass (google.com: domain of kernel-hardening-return-12372-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12372-gregkh=linuxfoundation.org@lists.openwall.com;
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
Subject: [PATCH v2] net: ipv6: xfrm6_state: remove VLA usage
Date: Sat, 10 Mar 2018 09:40:44 +0200
Message-Id: <1520667645-21975-1-git-send-email-andreaschristofo@gmail.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594535997865166060?=
X-GMAIL-MSGID: =?utf-8?q?1594535997865166060?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The kernel would like to have all stack VLA usage removed[1].
Instead of dynamic allocation, just use XFRM_MAX_DEPTH
as already done for the "class" array, but as per feedback,
I will not drop maxclass because that changes the behavior.
In one case, it'll do this loop up to 5, the other
caller up to 6.

[1] https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Andreas Christoforou <andreaschristofo@gmail.com>
---
v2:
- use XFRM_MAX_DEPTH for "count" array (Steffen and Mathias).
---
 net/ipv6/xfrm6_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/xfrm6_state.c b/net/ipv6/xfrm6_state.c
index b15075a..270a53a 100644
--- a/net/ipv6/xfrm6_state.c
+++ b/net/ipv6/xfrm6_state.c
@@ -62,7 +62,7 @@ __xfrm6_sort(void **dst, void **src, int n, int (*cmp)(void *p), int maxclass)
 {
 	int i;
 	int class[XFRM_MAX_DEPTH];
-	int count[maxclass];
+	int count[XFRM_MAX_DEPTH];
 
 	memset(count, 0, sizeof(count));
 
-- 
2.7.4
