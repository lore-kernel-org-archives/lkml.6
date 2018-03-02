Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsAieIZf1tJawknEum7hvE3mlh90JQbVzzfjawG1wlX7+DjVu7ANiio4CDayVdW9anwtEQX
ARC-Seal: i=1; a=rsa-sha256; t=1519981321; cv=none;
        d=google.com; s=arc-20160816;
        b=IGwc8XPmwxJOQ4pRyfJte12yFATANupIHP18hnCdDr0wY4qFBlYuhTigNqrwRcqH13
         OFYn/W63966AJSQvEZcZItf4fkjTMBrMfMv61m4WRlOst4ofmyw3f9v+7vgLjSEJSw7q
         wbR/t87d0J8rKu0cKb/+51Bl59owy4Cla9MXjDH7FjgFDHkv1WeYSAweQ8jXkOKdPfTf
         WdQhbC0eTagHCw/YEc429VC4aJPc2Q9kuGEeKgY3UiMiASqwNeRmSsZ4m1EZzx4z8X8Z
         ZaiK/FEu3skC7Vm9n06Iojeo7M6rnIH3U4MfAWhKyG5ceVtzwGlr7VaeXTzEBSPvRD1w
         tJMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7n6lJobQr7qr/tMxXuB6Fe2UKX9i1TUThptR8n/N+68=;
        b=txsUlL4DIY8vxDzqwLzq2ToF1OC9xfvRdGDmOAdmGKaEKLSb716Ht+UxKZpnK5cvXR
         w1KmotvkzmQ3I4ap9Z9IwPHrQly4JKILgtXr5IudARfAbcavPr3DNPxcWRqNwGkqLAIw
         XN8T3LWtqLgXT8i+xIyiuv0QDc2iprXhV8+K1KS0seOLhY8P5Ya6WTL1yZjpfmVtrU/2
         UVeEoKIuyfEIO3G+lIuahPYvE+O0qM42bmfI4LU0PuhlV1JERUS0unlVN8OGE9dY/YiB
         wZr1OllEBcIyX0H3bPvZGpQAu3l/yKvCl8VFXi/JHD7Pysi5YfOwmqLU6NPEFS6iKGJ1
         s8lw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ying Xue <ying.xue@windriver.com>,
	Jon Maloy <jon.maloy@ericsson.com>,
	Tommi Rantala <tommi.t.rantala@nokia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 056/115] tipc: error path leak fixes in tipc_enable_bearer()
Date: Fri,  2 Mar 2018 09:50:59 +0100
Message-Id: <20180302084506.152029437@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815612315964266?=
X-GMAIL-MSGID: =?utf-8?q?1593815934477082558?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tommi Rantala <tommi.t.rantala@nokia.com>


[ Upstream commit 19142551b2be4a9e13838099fde1351386e5e007 ]

Fix memory leak in tipc_enable_bearer() if enable_media() fails, and
cleanup with bearer_disable() if tipc_mon_create() fails.

Acked-by: Ying Xue <ying.xue@windriver.com>
Acked-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/bearer.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -324,6 +324,7 @@ restart:
 	if (res) {
 		pr_warn("Bearer <%s> rejected, enable failure (%d)\n",
 			name, -res);
+		kfree(b);
 		return -EINVAL;
 	}
 
@@ -347,8 +348,10 @@ restart:
 	if (skb)
 		tipc_bearer_xmit_skb(net, bearer_id, skb, &b->bcast_addr);
 
-	if (tipc_mon_create(net, bearer_id))
+	if (tipc_mon_create(net, bearer_id)) {
+		bearer_disable(net, b);
 		return -ENOMEM;
+	}
 
 	pr_info("Enabled bearer <%s>, discovery domain %s, priority %u\n",
 		name,
