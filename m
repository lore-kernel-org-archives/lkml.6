Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpAXJ7koKnfezCqous1DOzlZxdTTZMNlD37JxXuNN+V/+HQoYORvq/88pqNrjPisH3nCakb
ARC-Seal: i=1; a=rsa-sha256; t=1526631619; cv=none;
        d=google.com; s=arc-20160816;
        b=U1JIvbeu990PevIF6IrflGMrX+RogXn7UKOwnyWs0xAAJY4pi9yXNAt7pGucg0NM65
         bW1hvuZmlmq7GuicJT/g9mpY3ItXZylAqi5TyU+ZF3X2fkeu6K8lgAHIGA566JEuAAbj
         bO6Nr5p1JIm5CmRMkkM/CjnS3dbSwVYn/RtgptJnL9OUn/1JfW3ozp+a9FXbzct2+tbD
         CJlnMQKC/ftuyXOV5CiwNnUcC68tFsQqMcsiThiznV7aAsFg+XC+yfducwI6tGkOLkdR
         0grw3fn3FRD1FdPNDkjT0RaEl2qX+YMQdmkJlGbN7M4fyFB31HrKjhzsGs/Tp1qiOs2S
         Wqig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=/CuESfKoQg5OSGiN9wctYx5pvEkELIXuKrpGdVc2zD8=;
        b=Ir62SlNbKmTWVFGlmWP/UffbvVl84H0KxMY5k/HX6wvw1Dw5G9d7ym4fjCsZInyfrB
         4wTLir4u+SCl9psOIXfdVpbf5dd2tnhZo4zvxXOJf9qeza7o8f6LkH1PhHSkWIGPqdg+
         Y66lZv1dZauW6Qw+rZplq2CzZ//LpE4aXcwsjfiT0bBbMxOXGd39Qg0P2Y7cofOMhFVK
         9jdRMQHn3/+x+HhIXf6TblaR/EnbWlo9wUB8HbPvir9s6IDo1BTARPns01R/24pPYk2p
         89KntaP98Eet46w0+DHQ0JCCdbdzNngkQ9VAeU3I6aWBp7lkWsbnqWtFJcjX/Dkyd1K3
         3P5A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=TlXkvA/u;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=TlXkvA/u;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jiri Pirko <jiri@mellanox.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 32/45] net: sched: fix error path in tcf_proto_create() when modules are not configured
Date: Fri, 18 May 2018 10:15:49 +0200
Message-Id: <20180518081532.002957063@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789125560771598?=
X-GMAIL-MSGID: =?utf-8?q?1600789277041693293?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Pirko <jiri@mellanox.com>

[ Upstream commit d68d75fdc34b0253c2bded7ed18cd60eb5a9599b ]

In case modules are not configured, error out when tp->ops is null
and prevent later null pointer dereference.

Fixes: 33a48927c193 ("sched: push TC filter protocol creation into a separate function")
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/cls_api.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -151,8 +151,8 @@ static struct tcf_proto *tcf_proto_creat
 		} else {
 			err = -ENOENT;
 		}
-		goto errout;
 #endif
+		goto errout;
 	}
 	tp->classify = tp->ops->classify;
 	tp->protocol = protocol;
