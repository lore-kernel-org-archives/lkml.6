Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49VXutHr1dgHjta6MdYAKM0VbdKlyq17uPd9EfLKZdc3OX7tPUjk+kMH+afReuIasKDBtqF
ARC-Seal: i=1; a=rsa-sha256; t=1523399553; cv=none;
        d=google.com; s=arc-20160816;
        b=fXKReUWgEDmq7+M8ucLgMYXOE0QiglH0v1T/02zXtBnoZpLjoRcR3up/PxRV3d6IHH
         yi049U5+sRCZ8A4x8VBWV//I3WBCyYs8BIhBF7aq1YNyQQQxtsgHlvHTVS4BhRxOdrVE
         WIvxI3WgL6FqkEQjDjjgdYf/cqkiM0yzaMqBRRTcu/L6WZ/00Zrd+eHJS59ziatmoexV
         2KLUP4NQ9/+gja7gw891Flevcy1zXJPqUbPTKpRRBlG1q57h/2GPyNCnGdCB35jzEJYb
         07hD3+s7faLqoZxGoIhbMgWyMVjxeL0EzMKHoxjd5gXEV02txDv4jFEWup58vwLEYcmZ
         TlOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=l6GCdkd8gtDjFwmVyiH88Wv6N0vO+wEEWf3FC8RaBTw=;
        b=XyS9BtxIO12LlYeHyeb55ughf3VIcNcgWi1lxImaiN2Akn0N8oCC9WMxTZ+vJgImZM
         aVixutgZmwj1owU4+CaUe7Cku7Lp8LytdOrM7/weqvlyqVl1CqxMKWGL/3eQR8X5kVOK
         u1DSZ0BuJVGcuY5K1cJ5EWFWuzFuMyeRPLW4YZmGeMKeJs+mD7r2lfWQ9YXR5mfwFQtU
         HtWKXzwMFJbsTw2tueb78RfofwxnS+yDot477KAQ8T71czDw/nMsoqTUWPXBmQd553WX
         YDqayN/4WRwpjmpnC4DJE5jb1BNwW9YCyvSwKgdbTBiS6VT4nbVUA9kv47pG7rcTDJOR
         0XJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Marcin Kabiesz <admin@hostcenter.eu>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 150/168] net_sched: fix a missing idr_remove() in u32_delete_key()
Date: Wed, 11 Apr 2018 00:24:52 +0200
Message-Id: <20180410212807.458895663@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399704522433774?=
X-GMAIL-MSGID: =?utf-8?q?1597400210032884757?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>


[ Upstream commit f12c643209db0626f2f54780d86bb93bfa7a9c2d ]

When we delete a u32 key via u32_delete_key(), we forget to
call idr_remove() to remove its handle from IDR.

Fixes: e7614370d6f0 ("net_sched: use idr to allocate u32 filter handles")
Reported-by: Marcin Kabiesz <admin@hostcenter.eu>
Tested-by: Marcin Kabiesz <admin@hostcenter.eu>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/cls_u32.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -478,6 +478,7 @@ static int u32_delete_key(struct tcf_pro
 				RCU_INIT_POINTER(*kp, key->next);
 
 				tcf_unbind_filter(tp, &key->res);
+				idr_remove(&ht->handle_idr, key->handle);
 				tcf_exts_get_net(&key->exts);
 				call_rcu(&key->rcu, u32_delete_key_freepf_rcu);
 				return 0;
