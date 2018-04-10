Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/EpYXINdQmgMCXMYo2Un8E+btrlTGOF/En6fyf0Zs4oDJVDlhsTsGBsQK+rpBPYTaN5vDz
ARC-Seal: i=1; a=rsa-sha256; t=1523399071; cv=none;
        d=google.com; s=arc-20160816;
        b=wUF40mlakn8CvOlOlcKAqOrOxnB22LtdAurBGEnZyBW+3eVBN+Deo0EXtaNPMD/fYa
         MqJDVHkXp6laeEmy/d3sZpzFdURU/irNro6t1GSRiT78auA3os8scxJTjp8zxz61S53A
         riCX+Mb15tOlDdgq3VbUx93fQRavEalQqabiDxQE+Gp8+pCifJAa2HEUW3m78ZM4JJ9L
         MxhkdAOL3RVpthAaYUwgdMBsizgzgTwsAP/qww6V90M37DMgvEVQ1oA9UGLvJ9zcmQSd
         2kAhpiY95EIGVtLaswneWg6AOThbQz4KvPRnts4qplBW4ZbC27ZkgVxDw/lcE6J9eJ2p
         Y1kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5oMlC43IYOKjEsCqfZFAeVn+eEz3bgWq9OIZq3PaGnI=;
        b=rpaSB/WUHLpQMIj3+ch08sIKkS9O2k7nwuqq0Z2h4sS60lobhuE8zTUa+GhIN/JrE4
         mhjmQfpCrAzbeYKVtXXt4e9C7rSCj7naTBwQSzUZ0c+9WX93jGAaMxjr8maacVv6zFY2
         EY2EzKnmRcUey3m6CZQw5GUnGcPZZXnbM5jXkzX0MPNKcjMq3BqyTIamkkH9yOWNEh+y
         Rw6TKGFqZkmlEv21C0E/PC/4Kf21bwfUdxkGpzXRGtDS7nsMbtg3Lwp2KdsjNAsVHibY
         Yy0g3JMdhE6710W0JssBx2QwXvnrIRqxkjzhXaR+1XzVLSERo47mT8f2D4i1iSIHr/VD
         MYBg==
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
Subject: [PATCH 4.16 17/18] net_sched: fix a missing idr_remove() in u32_delete_key()
Date: Wed, 11 Apr 2018 00:23:52 +0200
Message-Id: <20180410212759.488967528@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212758.564682823@linuxfoundation.org>
References: <20180410212758.564682823@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399704522433774?=
X-GMAIL-MSGID: =?utf-8?q?1597399704522433774?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -489,6 +489,7 @@ static int u32_delete_key(struct tcf_pro
 				RCU_INIT_POINTER(*kp, key->next);
 
 				tcf_unbind_filter(tp, &key->res);
+				idr_remove(&ht->handle_idr, key->handle);
 				tcf_exts_get_net(&key->exts);
 				call_rcu(&key->rcu, u32_delete_key_freepf_rcu);
 				return 0;
