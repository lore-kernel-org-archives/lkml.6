Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrt1uGg/eamxMfWaRNPHh8Lc/BiL370sTGtfnDnc5QLwG5MqK5kZUENXGSjLtuwnVJiK/hd
ARC-Seal: i=1; a=rsa-sha256; t=1526631511; cv=none;
        d=google.com; s=arc-20160816;
        b=hTf8ZSwm82hn3zFs3zCOozrx4KrdU8CCWPMLV+KsKp1sxYlecuwvEQZf4jsX6LAIqG
         DspyJUMtmWl4MXZ4yKQDct0vtkibpUKvMXi9AJZ62/cQq0MwFYVqNNIDRszMef3JlhHg
         DfVfFl13Y94Oi7gDB887gOATgYdva795Y2E5u6hT7x/jTUWpcquPLZFWG5d2lRCBlj+M
         77gx6NxThFi5hJuWjOUR4zl2ZNBlPjVxbChGsPs/nBKYNbRgb+lNoF8nzgZxF2QQ1Y6j
         Lbzal6fODOzKZMdkDFs7FlWmrRREZDeDSBb+j4+QW5KU+yhdLDnKEUedYcNR/Kvreuj6
         oEww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=B/3jz6TgeYsPVdH0CdbAmsfcIHZSDHUuKBFGIwRt/bI=;
        b=UnKzbm6OReUEREdl4oIdlMW6Yk+X8RVqYhW5O16daCIJ5P8w+pChfOnGLhy9D6PazL
         JVXTUeXhOVhxiI0UjcEGVZamKZJHMQ3XbLy/T8uk2oruPvuxOClm3QdfnahEQKEywpDR
         hIzzmPPMSi5OV1Xbj1wF/in36/212axN68nKRYILF+fh0Bq60QZjhdGA9iSvUf+buozm
         jE33fr7XmC4PSe4zZxfYCRx3x+6znSs4il9j6niUFA5qnFzo304hWpFxMuDrzU+Y+OWY
         KCdlZsvSKQztLr8clNWv3eLI4spAtcwB920donOROruswVJ9bBsSWHBLGcUBZ8l//kLi
         YnUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=bPi39UBT;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=bPi39UBT;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Michael Wenig <mwenig@vmware.com>,
	Neal Cardwell <ncardwell@google.com>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 46/55] tcp: restore autocorking
Date: Fri, 18 May 2018 10:15:42 +0200
Message-Id: <20180518081459.596047132@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789164156736922?=
X-GMAIL-MSGID: =?utf-8?q?1600789164156736922?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 114f39feab360e6c7b0c4238697f223444d662a1 ]

When adding rb-tree for TCP retransmit queue, we inadvertently broke
TCP autocorking.

tcp_should_autocork() should really check if the rtx queue is not empty.

Tested:

Before the fix :
$ nstat -n;./netperf -H 10.246.7.152 -Cc -- -m 500;nstat | grep AutoCork
MIGRATED TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 10.246.7.152 () port 0 AF_INET
Recv   Send    Send                          Utilization       Service Demand
Socket Socket  Message  Elapsed              Send     Recv     Send    Recv
Size   Size    Size     Time     Throughput  local    remote   local   remote
bytes  bytes   bytes    secs.    10^6bits/s  % S      % S      us/KB   us/KB

540000 262144    500    10.00      2682.85   2.47     1.59     3.618   2.329
TcpExtTCPAutoCorking            33                 0.0

// Same test, but forcing TCP_NODELAY
$ nstat -n;./netperf -H 10.246.7.152 -Cc -- -D -m 500;nstat | grep AutoCork
MIGRATED TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 10.246.7.152 () port 0 AF_INET : nodelay
Recv   Send    Send                          Utilization       Service Demand
Socket Socket  Message  Elapsed              Send     Recv     Send    Recv
Size   Size    Size     Time     Throughput  local    remote   local   remote
bytes  bytes   bytes    secs.    10^6bits/s  % S      % S      us/KB   us/KB

540000 262144    500    10.00      1408.75   2.44     2.96     6.802   8.259
TcpExtTCPAutoCorking            1                  0.0

After the fix :
$ nstat -n;./netperf -H 10.246.7.152 -Cc -- -m 500;nstat | grep AutoCork
MIGRATED TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 10.246.7.152 () port 0 AF_INET
Recv   Send    Send                          Utilization       Service Demand
Socket Socket  Message  Elapsed              Send     Recv     Send    Recv
Size   Size    Size     Time     Throughput  local    remote   local   remote
bytes  bytes   bytes    secs.    10^6bits/s  % S      % S      us/KB   us/KB

540000 262144    500    10.00      5472.46   2.45     1.43     1.761   1.027
TcpExtTCPAutoCorking            361293             0.0

// With TCP_NODELAY option
$ nstat -n;./netperf -H 10.246.7.152 -Cc -- -D -m 500;nstat | grep AutoCork
MIGRATED TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 10.246.7.152 () port 0 AF_INET : nodelay
Recv   Send    Send                          Utilization       Service Demand
Socket Socket  Message  Elapsed              Send     Recv     Send    Recv
Size   Size    Size     Time     Throughput  local    remote   local   remote
bytes  bytes   bytes    secs.    10^6bits/s  % S      % S      us/KB   us/KB

540000 262144    500    10.00      5454.96   2.46     1.63     1.775   1.174
TcpExtTCPAutoCorking            315448             0.0

Fixes: 75c119afe14f ("tcp: implement rb-tree based retransmit queue")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Michael Wenig <mwenig@vmware.com>
Tested-by: Michael Wenig <mwenig@vmware.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Michael Wenig <mwenig@vmware.com>
Tested-by: Michael Wenig <mwenig@vmware.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -688,7 +688,7 @@ static bool tcp_should_autocork(struct s
 {
 	return skb->len < size_goal &&
 	       sock_net(sk)->ipv4.sysctl_tcp_autocorking &&
-	       skb != tcp_write_queue_head(sk) &&
+	       !tcp_rtx_queue_empty(sk) &&
 	       refcount_read(&sk->sk_wmem_alloc) > skb->truesize;
 }
 
