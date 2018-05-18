Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo0b1kXrIIqHR5MrKBGIGwG+JHzaQi95EdVlEisbIcaRHD8XXb+a5YLXhuaVl2a58NUJ5p1
ARC-Seal: i=1; a=rsa-sha256; t=1526631475; cv=none;
        d=google.com; s=arc-20160816;
        b=kXSyRr76i/lpAoDNl44Ywg0niNDf+vJWYZvwbE4+zYkkVBUSeL2Vzkaoj1SI212fo2
         HmR/VZ8H53aGLS4eHRcPXZfzgjP5F+WMgYQGnHvd5OHPgp4GfsXh3L/b9vx1UZmhj6/I
         wBHMOeHkFxQdg9M4kl7V/jVvucHoQeY7tYdgP332fw7LgqC2DNRP2zyUqi4FYbeBpZjH
         OkvRhSAe0eFCxx6rpaQBgc4XkeAspgQsiPRvwbyZkgb1zlr/nmF6f9jZdCnLuPUUYEa2
         ZrNAcMh9TeS+SXV1ggZrn4ceEd16x1sAINAWwSNBTGNrfPm+Xb1Jg6/5WQ+8i7A4tpFW
         0rGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Z+cjpSgIrf4qKVhO8+uejD9wsTLAy9nKxf5/rhJCcSY=;
        b=ChzVu3mbLT8BR+kB9ZHA1ExWlaVt4AnfAh1rmRFsupfHxzloxD6lqEIvDOiWOqe7mw
         9xG1LY1GtRBhspWodKB0mE1UJPOG2woLM1kTOUbPeXpq9z2lxbTciV3BbSxUAtU/qN0n
         C4ZkAEy05qvnSY+siMx/81Dkf7zqU6k+g0DCSiK/FTKx3O+plXRRaVIjWY+JCOuuwhXZ
         w3M/JTLbX7IuIk7Mwe5RXquO5YQBYMq8DaY2FVl7YyN44UthWF82QdLCJflXrIg2TwQA
         bLSnAge3qz90B2RE9pzeFCl2LS42L3qHX+9USeCgKJKt79gMbWdbA5NWDf1z/MFEMCLa
         d9bQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=GZ1ZZZqA;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=GZ1ZZZqA;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jiri Pirko <jiri@mellanox.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 33/55] net: sched: fix error path in tcf_proto_create() when modules are not configured
Date: Fri, 18 May 2018 10:15:29 +0200
Message-Id: <20180518081459.048479648@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789125560771598?=
X-GMAIL-MSGID: =?utf-8?q?1600789125560771598?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -152,8 +152,8 @@ static struct tcf_proto *tcf_proto_creat
 			NL_SET_ERR_MSG(extack, "TC classifier not found");
 			err = -ENOENT;
 		}
-		goto errout;
 #endif
+		goto errout;
 	}
 	tp->classify = tp->ops->classify;
 	tp->protocol = protocol;
