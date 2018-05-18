Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqai75j8IwtMzABXnZLfSquzusefmupvSzhvfUbTTKZSRVOcHJwkqjDlAsIhMonItPPjf89
ARC-Seal: i=1; a=rsa-sha256; t=1526631738; cv=none;
        d=google.com; s=arc-20160816;
        b=LXuU4+6//AxxKgwTumYPXCNj0w667C9F2h5HnsP6UYaFAIZJyd/Ufoe5U5jTBzOq96
         fCaHSlf6PZ3UWZYu+VLBqMgFw7qqykVG2Qigllgps7+cnkYBBK44V6mEHmwy/CWc4y3O
         6Z244n4DCLZoPNZ3LEbbrZfmI+g8/tetHzh9EdN3EL6ZFt4dY4uoaKu3bwKRfuEZOH4L
         xgB2K0jpIFKp0eVn9wBHqQ8SYmnxT6/RZFLPC3wtDNIMiy6eRopDNNjGewXqAM8UDaqg
         GEgA1sWARgVPCd6j67KdmqNc5Ai3N2DPDn0ACCF2Cv3kBP8eW0WGwzLT/C5AKz3p04Wx
         W2gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=PdrVA5qJcXM8tAWgLXQmACLYPJXGsK+CVrid2pseCjg=;
        b=omArbFrhB9cnedOdlnQpH+oJlLh4dGTeGQn3ND/x0Qmn577oS6SCMVHywhCbUo4+kn
         6q32a8O24GvcMigqO2z7aeD6l7xtJQO+ro9StKdNfap5x0QlF8SuMeC0E3I13TroUPvv
         d9wHHoewHGiUFz71R7T54tKO6W2F0gDQFIaBKPrv4PRcfc2MH7HOYP5KX3lw7p261krh
         NYiFb0lZZ/9C0oMAA6nQp5di1M/H8OUcATZbxp6ou1cT5EN2qPoogmZxd1OUflmRYW1x
         nbJVgHn0m1wRcthKSXr8VJLBppk8pAp2qX8JNKVopN9O7sVWnpBhApd47OX5sBFRB5Vo
         w8qw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=096KD90m;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=096KD90m;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot <syzkaller@googlegroups.com>,
	Yuchung Cheng <ycheng@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 23/33] tcp: ignore Fast Open on repair mode
Date: Fri, 18 May 2018 10:16:02 +0200
Message-Id: <20180518081536.019518344@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081535.096308218@linuxfoundation.org>
References: <20180518081535.096308218@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789110988167227?=
X-GMAIL-MSGID: =?utf-8?q?1600789401866655254?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuchung Cheng <ycheng@google.com>

[ Upstream commit 16ae6aa1705299789f71fdea59bfb119c1fbd9c0 ]

The TCP repair sequence of operation is to first set the socket in
repair mode, then inject the TCP stats into the socket with repair
socket options, then call connect() to re-activate the socket. The
connect syscall simply returns and set state to ESTABLISHED
mode. As a result Fast Open is meaningless for TCP repair.

However allowing sendto() system call with MSG_FASTOPEN flag half-way
during the repair operation could unexpectedly cause data to be
sent, before the operation finishes changing the internal TCP stats
(e.g. MSS).  This in turn triggers TCP warnings on inconsistent
packet accounting.

The fix is to simply disallow Fast Open operation once the socket
is in the repair mode.

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Reviewed-by: Neal Cardwell <ncardwell@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1118,7 +1118,7 @@ int tcp_sendmsg(struct sock *sk, struct
 	lock_sock(sk);
 
 	flags = msg->msg_flags;
-	if (flags & MSG_FASTOPEN) {
+	if ((flags & MSG_FASTOPEN) && !tp->repair) {
 		err = tcp_sendmsg_fastopen(sk, msg, &copied_syn, size);
 		if (err == -EINPROGRESS && copied_syn > 0)
 			goto out;
