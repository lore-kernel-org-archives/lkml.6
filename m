Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/FPEtLMvekfiwmiGPquVFqZ0iacvKULT+kLl409z8t3hzaPI8ooqOG6Trf3a91Q9+onbdt
ARC-Seal: i=1; a=rsa-sha256; t=1523399405; cv=none;
        d=google.com; s=arc-20160816;
        b=g5eKxg4mMRTRrLtQVhcbP5MUOe6u5j7YelYYy0NR0eNKKt7WCIE9xp+W0IjWUitmGf
         xsMpFcPAJteueJHqy1OXbUqQ5oqFCrEo2qdD2eRxY7SPmfR1GVq9AbGm6LvcxMOtd/6+
         ikCCT4IJBxSn9rAqkkCQFnqW3jGt2sSi6KBEhDHgTXjOovtjlCctKEnZTCTySMi9JrU3
         wXggpOOB5f+snzLAltqOg3uKdlZQ3z1ALiKe1cq8A1mZ+ErXWQGL+Y/DMrXCUuNGl6nh
         uCA+0HMwYNIBWW4UhR3N7NL7EXa1I4+Ad+iRlIxX8jQxu6OLJDwBHnFarKl/La5f03w7
         UmVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xKwnQ9bPhmo7kBryyIaCCvxmW20DDO4P9CxfQ0Qu9wU=;
        b=HIvGV4ic65H0crDXtALnzRt/Ys7uknf8wT22z+GcXIlCWrfjGuXItg1t8UiPjlHFwX
         Xx+LDfmlRZnsi52f7aEI/MHmEN33n/LH1ZiPuNkv7o72/Dk4UV59nkLzAg6R7CNwdCXv
         6CYhzPDwfFxTNwVgEbucdZA+v6awrLmSPGnAy4pp3/7BUr8JjmxcarutyrSWKx+evdIz
         xDdC0rL25s9mXa5l0XmGx25J9OR30P5rOnTXB9QsgYhUU0GGWwo5AzkT/mUjPagRYopJ
         LQTXMIgzWEzy+KvJo5ZHEVSG3b0vAqIvE5FUM5e+Eo3sYT5hJDLYO/esA3TanYPf5wUc
         Y6KQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Gal Pressman <galp@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 076/168] net: Fix netdev_WARN_ONCE macro
Date: Wed, 11 Apr 2018 00:23:38 +0200
Message-Id: <20180410212803.513922398@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400054126401407?=
X-GMAIL-MSGID: =?utf-8?q?1597400054126401407?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gal Pressman <galp@mellanox.com>


[ Upstream commit 72dd831e24cc9487a9cd534fdd675fe97e3c1839 ]

netdev_WARN_ONCE is broken (whoops..), this fix will remove the
unnecessary "condition" parameter, add the missing comma and change
"arg" to "args".

Fixes: 375ef2b1f0d0 ("net: Introduce netdev_*_once functions")
Signed-off-by: Gal Pressman <galp@mellanox.com>
Reviewed-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/netdevice.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4402,8 +4402,8 @@ do {								\
 	WARN(1, "netdevice: %s%s\n" format, netdev_name(dev),	\
 	     netdev_reg_state(dev), ##args)
 
-#define netdev_WARN_ONCE(dev, condition, format, arg...)		\
-	WARN_ONCE(1, "netdevice: %s%s\n" format, netdev_name(dev)	\
+#define netdev_WARN_ONCE(dev, format, args...)				\
+	WARN_ONCE(1, "netdevice: %s%s\n" format, netdev_name(dev),	\
 		  netdev_reg_state(dev), ##args)
 
 /* netif printk helpers, similar to netdev_printk */
