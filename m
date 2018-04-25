Return-Path: <kernel-hardening-return-13140-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZpRrGteqkpHVOd6sgOqjCrqNb9rRuV3cgkf9MiM1qyjmNttyabGk2dKUP9LGy6VyijTfk1k
ARC-Seal: i=1; a=rsa-sha256; t=1524667620; cv=none;
        d=google.com; s=arc-20160816;
        b=W80iVaIrZoEUx0uZBSMLWAOLvGQW9G8nYsuQJBPXd33FWkXa1pi8R6kLdjowAX1H9n
         vFv77KBBwmXZHPtKtnJLVyk1mm2WdMsVGf7vYYGidrDYnGf9Rf3KOupvZvo/PUs+FCSU
         F05O40no9mnZC3G7puDghvOZoGNgB5XPar7JLWaY88faVnEW/btevmMuL1aXd6YlHAqu
         PUox3gRQAvwbJkeA8ET7TqmkZis+ju6QPJIJLnTsFKySR/XyQkxp5ySsO1Od+DRC6HV3
         PDmbnWu7RUP3MreqUHWT4yQvH/aVRBnFqxN/Kt/vScjfuBYK07iyujLnW3kHOGTmKn9T
         +sYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=2tQsBi2Tvy9BONFoyp+Kg7ZktJ0b81Z5QNCojos7+ZM=;
        b=zT55o0GHvusIeOzaADrsuThxP+AuV6WGJYOz2dlOrm9VjPv0Ajw23d/Zub6j0BLM5r
         eT1fPXXWugmZ2sTFoKJ0i6ozFRGxJyoc6JsBmNCBj/ipxqDjeWA+7JwdwHphLaVCe3Se
         zyOkiuJGQFI4UP5Kgt5b1KsLvB4sONOzCLO5gx+ppCZVCOz0TCXZQOeBM7MApzBOPAae
         ZvLSDYDQ+lTUDZveDWHsSqDX7F2ZWpA7ibQcFQEDJTlCF0aKKHt0TlW/6tuzEeUvcwAi
         yAqd6PjxFS7qUcYjDLVhpVCDEa1P7+TnuQ2UjKMdfG1M6Rve3RlMKkj0DKb3XknNtHTE
         NP+w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=Iv0LWIpJ;
       spf=pass (google.com: domain of kernel-hardening-return-13140-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13140-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=Iv0LWIpJ;
       spf=pass (google.com: domain of kernel-hardening-return-13140-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13140-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 25 Apr 2018 07:46:39 -0700
From: Kees Cook <keescook@chromium.org>
To: Stefano Brivio <sbrivio@redhat.com>
Cc: Andreas Christoforou <andreaschristofo@gmail.com>,
	kernel-hardening@lists.openwall.com,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 ipsec-next] xfrm: remove VLA usage in __xfrm6_sort()
Message-ID: <20180425144639.GA38350@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598729875203857448?=
X-GMAIL-MSGID: =?utf-8?q?1598729875203857448?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In the quest to remove all stack VLA usage removed from the kernel[1],
just use XFRM_MAX_DEPTH as already done for the "class" array. In one
case, it'll do this loop up to 5, the other caller up to 6.

[1] https://lkml.org/lkml/2018/3/7/621

Co-developed-by: Andreas Christoforou <andreaschristofo@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v4:
- actually remove memset(). :)
v3:
- adjust Subject and commit log (Steffen)
- use "= { }" instead of memset() (Stefano)
v2:
- use XFRM_MAX_DEPTH for "count" array (Steffen and Mathias).
---
 net/ipv6/xfrm6_state.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/xfrm6_state.c b/net/ipv6/xfrm6_state.c
index 16f434791763..5bdca3d5d6b7 100644
--- a/net/ipv6/xfrm6_state.c
+++ b/net/ipv6/xfrm6_state.c
@@ -60,11 +60,9 @@ xfrm6_init_temprop(struct xfrm_state *x, const struct xfrm_tmpl *tmpl,
 static int
 __xfrm6_sort(void **dst, void **src, int n, int (*cmp)(void *p), int maxclass)
 {
-	int i;
+	int count[XFRM_MAX_DEPTH] = { };
 	int class[XFRM_MAX_DEPTH];
-	int count[maxclass];
-
-	memset(count, 0, sizeof(count));
+	int i;
 
 	for (i = 0; i < n; i++) {
 		int c;
-- 
2.7.4


-- 
Kees Cook
Pixel Security
