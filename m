Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqns/24LDQXVCV8bFIVpHTuyHtMQ2X2Lwo52erzvn035pK7o2PyWNhuyb8POBH2t2Baxu8c
ARC-Seal: i=1; a=rsa-sha256; t=1524837643; cv=none;
        d=google.com; s=arc-20160816;
        b=JvodBBQenalPKGOED+RV1DsBOKjy4Z275FS0ScvtmSOI28yPMlcam0BM1t7l7y+zG0
         DbHiv7yCkTIJQIepHRne1CqZYfVfWitmjbOdsVXS+dJAP2e2nIS0amhaS7vFWR6ctNmR
         26kxhQ/kVcVxdtNl9x6kevl5WBEdQSQj5MBUfSRBX5mcGqEnqRFSdfyo/XVdt5E1hvjb
         rciNixpBiwLmVi87pj6jL/W3pTCOwbHVqWvNu6tDwB4aMgWd7CCzFM0IPDPrX9Gq4mY2
         Sphdu9lf80AT6BaDBXXx5TXGyskTcDXLlwau7hol9lbDt9yP9MCwNT4uLHHJTHWuv2EJ
         KPkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=8OuOqsvVnhl1jAUC7UQiK4zCCuqoxJ95257DoZxvGKY=;
        b=dqh+K89C8VdJb0Cs+dXNt5TEWnHkdETl78WKrDAoE73bHI4m7h0HPOnS+hMZBDIPXp
         ZUA2DupBCEsgtX+U8RtO2ZVvS/OzOiIxgDSLupOmSZCQVk88BRxFbZNvA0xP68Bim6i1
         u5cGk86yBI1WL/uTvvWP7WjB+HkgB+p0T/Dm8QkUtSAjYaZI4NvuqFN9udHh1RNP5w3o
         rR08do55IWxT6DEFr+g/gK4c8NO6US9mto8+FOwE4GKJTUCHBVL+3lTfhKynR3c0gTGj
         27v65pA6oYKY91EGkFEkHW950/1g85TOUsQVMJtXK/9Ed8aDcv6YiuZe6j0fh/+mMCrs
         VpKA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD20F21895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chen Feng <puck.chen@hisilicon.com>,
	Lu bing <albert.lubing@hisilicon.com>,
	Laura Abbott <labbott@redhat.com>,
	Greg Hackmann <ghackmann@google.com>
Subject: [PATCH 4.4 04/50] staging: ion : Donnot wakeup kswapd in ion system alloc
Date: Fri, 27 Apr 2018 15:58:06 +0200
Message-Id: <20180427135655.905352203@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908156901734645?=
X-GMAIL-MSGID: =?utf-8?q?1598908156901734645?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Feng <puck.chen@hisilicon.com>

commit 2ef230531ee171a475fc3ddad5516dd7e09a8a77 upstream.

Since ion alloc can be called by userspace,eg gralloc.
When it is called frequently, the efficiency of kswapd is
to low. And the reclaimed memory is too lower. In this way,
the kswapd can use to much cpu resources.

With 3.5GB DMA Zone and 0.5 Normal Zone.

pgsteal_kswapd_dma 9364140
pgsteal_kswapd_normal 7071043
pgscan_kswapd_dma 10428250
pgscan_kswapd_normal 37840094

With this change the reclaim ratio has greatly improved
18.9% -> 72.5%

Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
Signed-off-by: Lu bing <albert.lubing@hisilicon.com>
Reviewed-by: Laura Abbott <labbott@redhat.com>
Cc: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/android/ion/ion_system_heap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/android/ion/ion_system_heap.c
+++ b/drivers/staging/android/ion/ion_system_heap.c
@@ -27,7 +27,7 @@
 #include "ion_priv.h"
 
 static gfp_t high_order_gfp_flags = (GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN |
-				     __GFP_NORETRY) & ~__GFP_DIRECT_RECLAIM;
+				     __GFP_NORETRY) & ~__GFP_RECLAIM;
 static gfp_t low_order_gfp_flags  = (GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN);
 static const unsigned int orders[] = {8, 4, 0};
 static const int num_orders = ARRAY_SIZE(orders);
