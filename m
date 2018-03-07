Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvyVg2GJ4ejM1Sf9Zqw5c0VCUyh5Bh8kvoikNr0K5GljQH8P7FPTlf593NxcgYE8WOo7i4y
ARC-Seal: i=1; a=rsa-sha256; t=1520451830; cv=none;
        d=google.com; s=arc-20160816;
        b=krC9vbN3ghhwAKbQjwZY8gwuHDUV9eyaWeP21D35oMtSNmTqKQek6n67F3c1co12Oh
         ctcNiJ4N9JJyBNcjqR048Utd4u1jLHe3WiRxixXg5htDNYkFY/azZOwBw/c0VZu2CuR8
         WiW1PA7/+HGJD+Gk71wuMeLr9oN0/KkOZ162dAb0n+FFqN9WjPPeNjW090VBihjNAJRb
         VL5ZuSYyyEJ3o9Iwtpv6vX0djl2YecG588giJyE4lzSs7jDuP8vLG9It6BqL6GahDJu0
         qJZOBOGhWPka7lb0JbN1SR81XEHbux77KhPvgPRrPFlPY284uPzDpw1bV7a/ESyWm+sG
         ABZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7pTRNb/m4M83nbCtNApy174zyCEIDErXeXiWFKS7vMU=;
        b=YWcDSms3+fZUU5HKU73z4Zz5FTIvr3Phhif3kWzz/y5AGur2wFOwyd89xejLXW26sW
         yl9CiwyVBP8gmR3cDqrQj/y9IVj/1tBy/1Ycqbf43a4LRdF2QHhnLDBlPxwTrkMsK6Jh
         I7zNd0ZW5RxUuGvYvCe6SdOMbuuuZ29EklzxohhG18ydyQjaPy3dAay4ZDBSyV3f2h6x
         n3EWQtQfy0Nx5x+4RMJn4UGb/dufwWTF+c28VOkoGCNu8GYfm/De5hDxH5Yp3x67xMb/
         FvOkFaQG3sJ7fjHaMTauaY6NezFB8jzLea7ti8jdHmA+/p1pchnLmatrN2/VgYXtUd7z
         Yt/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 077/122] tuntap: disable preemption during XDP processing
Date: Wed,  7 Mar 2018 11:38:09 -0800
Message-Id: <20180307191740.398230186@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309298402256288?=
X-GMAIL-MSGID: =?utf-8?q?1594309298402256288?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Wang <jasowang@redhat.com>


[ Upstream commit 23e43f07f896f8578318cfcc9466f1e8b8ab21b6 ]

Except for tuntap, all other drivers' XDP was implemented at NAPI
poll() routine in a bh. This guarantees all XDP operation were done at
the same CPU which is required by e.g BFP_MAP_TYPE_PERCPU_ARRAY. But
for tuntap, we do it in process context and we try to protect XDP
processing by RCU reader lock. This is insufficient since
CONFIG_PREEMPT_RCU can preempt the RCU reader critical section which
breaks the assumption that all XDP were processed in the same CPU.

Fixing this by simply disabling preemption during XDP processing.

Fixes: 761876c857cb ("tap: XDP support")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/tun.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1471,6 +1471,7 @@ static struct sk_buff *tun_build_skb(str
 	else
 		*skb_xdp = 0;
 
+	preempt_disable();
 	rcu_read_lock();
 	xdp_prog = rcu_dereference(tun->xdp_prog);
 	if (xdp_prog && !*skb_xdp) {
@@ -1494,6 +1495,7 @@ static struct sk_buff *tun_build_skb(str
 			if (err)
 				goto err_redirect;
 			rcu_read_unlock();
+			preempt_enable();
 			return NULL;
 		case XDP_TX:
 			xdp_xmit = true;
@@ -1515,6 +1517,7 @@ static struct sk_buff *tun_build_skb(str
 	skb = build_skb(buf, buflen);
 	if (!skb) {
 		rcu_read_unlock();
+		preempt_enable();
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -1527,10 +1530,12 @@ static struct sk_buff *tun_build_skb(str
 		skb->dev = tun->dev;
 		generic_xdp_tx(skb, xdp_prog);
 		rcu_read_unlock();
+		preempt_enable();
 		return NULL;
 	}
 
 	rcu_read_unlock();
+	preempt_enable();
 
 	return skb;
 
@@ -1538,6 +1543,7 @@ err_redirect:
 	put_page(alloc_frag->page);
 err_xdp:
 	rcu_read_unlock();
+	preempt_enable();
 	this_cpu_inc(tun->pcpu_stats->rx_dropped);
 	return NULL;
 }
