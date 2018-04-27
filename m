Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZppmdzF9yXukugGXkVzf2JawbC9jfIBfiLu0uv/VXcyVWmp2A0gWTm3xN+wjDlCkvonA8Re
ARC-Seal: i=1; a=rsa-sha256; t=1524838030; cv=none;
        d=google.com; s=arc-20160816;
        b=Kul7djaOqqn9MM5B6E2NDC4uplpjsyjZrLBCT2wSLuytiSClUc9ZoiAsE+usGt24Ib
         8ALWMfdnhDLw/C23QdRDv8yG89qbDC/kjdJcdlXaLcfHOqfPmdfJFOciIZr3riLRinxU
         LGluMZ3ZEnFj8I/UIbMEfZyZm08gr/GBb1oi6axvpjrDCyHv4dB2LtL02RvTb1mqnedE
         SafNjajpSUeoWTc1yyh9Byhzxhjsl+D22LpjcPyHDFtlNnmC32eHEOR2BXJr+IAnyH0l
         rrUWKWr8iA/9vq76ngYcGy133bv+jZj0HOVOHst5bIPapKTnUSQ70kbvYfOiqvhBUXO9
         7bXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=A/SVSk+QznjKDN8saOqztItpIqs/wLJe7MFcWU7wt60=;
        b=oJ+rDcRuc7S8XAZs5yGSQsIlcpVmfIV7ssVd5m+aI2PnLjYN0fae7FBddj0aLRd28Q
         5AoYfFs5Lr6DhF1Kr7VK2DQkS4WZ2uArZFLxAyhejsGUsWqLNOv5QAVero0hc5hZ8WwF
         1+xhmjeAW3qNz5kWaRfhIUu+E9Wwja4yUCzxE4SoxDBEFlJqf7mYvNefsz7aFeMDLkgz
         TIrZRyhm6Di9u0faNVAfP5IVty2MMR4uTShPg93KpTYlnT8+Jh1YbUUYZytE+HMHuTzF
         bDk2VaTELI94hq2yBpubsvXERNZ5AxRJJ8wMeFdjOY66x1jWoxiEOQEdK6n5kN6EI4WJ
         T/CA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD2A621864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
	Sami Farin <hvtaifwkbgefbaei@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	Yuchung Cheng <ycheng@google.com>,
	Neal Cardwell <ncardwell@google.com>
Subject: [PATCH 4.14 33/80] tcp: clear tp->packets_out when purging write queue
Date: Fri, 27 Apr 2018 15:58:26 +0200
Message-Id: <20180427135734.655295347@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908562961999511?=
X-GMAIL-MSGID: =?utf-8?q?1598908562961999511?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Soheil Hassas Yeganeh <soheil@google.com>


Clear tp->packets_out when purging the write queue, otherwise
tcp_rearm_rto() mistakenly assumes TCP write queue is not empty.
This results in NULL pointer dereference.

Also, remove the redundant `tp->packets_out = 0` from
tcp_disconnect(), since tcp_disconnect() calls
tcp_write_queue_purge().

Fixes: a27fd7a8ed38 (tcp: purge write queue upon RST)
Reported-by: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
Reported-by: Sami Farin <hvtaifwkbgefbaei@gmail.com>
Tested-by: Sami Farin <hvtaifwkbgefbaei@gmail.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Soheil Hassas Yeganeh <soheil@google.com>
Acked-by: Yuchung Cheng <ycheng@google.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/tcp.h |    1 +
 net/ipv4/tcp.c    |    1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1616,6 +1616,7 @@ static inline void tcp_write_queue_purge
 	sk_mem_reclaim(sk);
 	tcp_clear_all_retrans_hints(tcp_sk(sk));
 	tcp_init_send_head(sk);
+	tcp_sk(sk)->packets_out = 0;
 }
 
 static inline struct sk_buff *tcp_write_queue_head(const struct sock *sk)
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2354,7 +2354,6 @@ int tcp_disconnect(struct sock *sk, int
 	icsk->icsk_backoff = 0;
 	tp->snd_cwnd = 2;
 	icsk->icsk_probes_out = 0;
-	tp->packets_out = 0;
 	tp->snd_ssthresh = TCP_INFINITE_SSTHRESH;
 	tp->snd_cwnd_cnt = 0;
 	tp->window_clamp = 0;
