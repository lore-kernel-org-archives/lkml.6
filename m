Return-Path: <kernel-hardening-return-13127-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZokAzrtkOGA3qOTK7nxsIjDlVmmeZqdqTB/EQRciHTousgm0/Jw2r2zMlrEDAdmsVlys5lC
ARC-Seal: i=1; a=rsa-sha256; t=1524613702; cv=none;
        d=google.com; s=arc-20160816;
        b=DJGgOsZzDOhiZujhnxfGnzIMHMPJPBeGqLDoPQmKCAjFiZKs3ALE/3Y4tS5y+j+053
         wOcKNyHRbeYXmaF8DilA6432BiuPPU1pFKZG6s3P4ardsSYEwMtF96WBIvYWO3U9Mvl0
         reLDq3/PtOilXA0LGuLhe1tyeh6X3ZNiw/4hvgzmv7XN5NstBpMKLJTogzyvmKKx4b0R
         mWzO/2NJfePxGZdl0IxiuwPvX4C19HRJc1dEMHlNQmiSmfXQl/WGeUsN54B/gn7uOil4
         n3OwcFQv+dRSvBdOisvXppXKgpDIxlXPtmeOEfiHZ5z8GqZuak4UcP1wTyX7nyjzsDC5
         Dxjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=rLqPTM14KUrVSYqU+/iO1vPmNuFVMIrEdGPtuePmyEw=;
        b=UhOpb31pW4DDcAb9q2lfSg0VzUvZ8wzhZQgPnaGcqltuZxPQwrsXZq4CGfEyAZQ1Rv
         BcOIVlEfqBXx67Ym8O47FfZjo3rgHCtrmsh+9NgkY5LaCPrFkQ66pjqJ2kPR66pxBHDO
         4qUANMQn0R6BKpD27Zlq80RLhkwrrSWYoF9KUmGgo13tfMiYTbMSVnsJMqZM0d9eUnOh
         4nbzKfBHv0TnUVanmtYXv2JFf3SHFEKhLTb+P2ET0jVVe/fTtTsiU6bPpc3/Bb4cyjaP
         E+dWtRvSQ7hE+sdyasbgRcWWzo4bDTHT5fLK1c1Z9lupQg8DUclGFDrkWjz34li/0AJi
         usWg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=NQC9ygiu;
       spf=pass (google.com: domain of kernel-hardening-return-13127-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13127-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=NQC9ygiu;
       spf=pass (google.com: domain of kernel-hardening-return-13127-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13127-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 24 Apr 2018 16:46:51 -0700
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
Subject: [PATCH v3 ipsec-next] xfrm: remove VLA usage in __xfrm6_sort()
Message-ID: <20180424234651.GA30225@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598673337526933945?=
X-GMAIL-MSGID: =?utf-8?q?1598673337526933945?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In the quest to remove all stack VLA usage removed from the kernel[1],
just use XFRM_MAX_DEPTH as already done for the "class" array. In one
case, it'll do this loop up to 5, the other caller up to 6.

[1] https://lkml.org/lkml/2018/3/7/621

Co-developed-by: Andreas Christoforou <andreaschristofo@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v3:
- adjust Subject and commit log (Steffen)
- use "= { }" instead of memset() (Stefano)
- reorder variables (Stefano)
v2:
- use XFRM_MAX_DEPTH for "count" array (Steffen and Mathias).
---
 net/ipv6/xfrm6_state.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/xfrm6_state.c b/net/ipv6/xfrm6_state.c
index 16f434791763..eeb44b64ae7f 100644
--- a/net/ipv6/xfrm6_state.c
+++ b/net/ipv6/xfrm6_state.c
@@ -60,9 +60,9 @@ xfrm6_init_temprop(struct xfrm_state *x, const struct xfrm_tmpl *tmpl,
 static int
 __xfrm6_sort(void **dst, void **src, int n, int (*cmp)(void *p), int maxclass)
 {
-	int i;
+	int count[XFRM_MAX_DEPTH] = { };
 	int class[XFRM_MAX_DEPTH];
-	int count[maxclass];
+	int i;
 
 	memset(count, 0, sizeof(count));
 
-- 
2.7.4


-- 
Kees Cook
Pixel Security
