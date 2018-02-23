Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224M9NH6NocmdlJE8wx9TrwkSl+hY0bTXLkv/yeOBmYlfFt7hREWoengcq9CpKCdbrQRpQb6
ARC-Seal: i=1; a=rsa-sha256; t=1519411836; cv=none;
        d=google.com; s=arc-20160816;
        b=tvMUYEixdeSVo0T1LBDe0MaCoZG3HOV8RWZ0DjW6oAzmSPxqY+XuLnlRF0AbMMr3P4
         u8otKM56cu9hltTH1YZ68TBd0HVtevaauXjGugXiTh1yoK9OzLNKt5FxLgnOSaKsZ9Gh
         9v2trEfrFjLP7Rt+wiSMFHyHNO+aH0PqJ79/LQaDYgxx5Mfl9vZmzT34xCUI9w88AJbB
         vheBpe/q9b8noo1cXZsKRpl+mc6BRUEjYzR8vJcjYLvznHfevEBnzqYNe3TDNMTbbNtI
         Eo9N6ZTkf7Ufa6T0jchvyUbe3Rfb1ZEUBc8E/Rr3j6RO6Zuz4C+JdV8Sw5NoGIs4PZm6
         YEog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZwHlVguxbwnXUW5gjNOuADdTNAlwRhvEvrcB819S7rs=;
        b=wjdxE6sZtDWzhu0eY309r4b/RjhlEIZvfduegfLxW1mG5NKkmsTmoW4SkK+f4bu9ue
         bHcnk1N75pJLTK6n6HyUPf6itNmcpUQd06lC5gSQ1keSDvu/hxluuHf0JS4xAkqoJv3v
         A+f0axPLBDmQLzVIZMf1GzqsxbIPiLdqHK8SCOhqt+jyax2yaIXhm26yZr7/BhKrOLew
         VYxXI2bnbPtUsVkNKsTlAZG+Gwz8YjCmE+HDmEg+q90CDFz4AP+m57numOb+k61EBxdu
         al+UMD2xx/IlNZC9MZcZux9U2ZgwFt4uBtt44MK/nCFUPWxck3L9KD+/zl5fgpLMnpzZ
         PJkQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+8865eaff7f9acd593945@syzkaller.appspotmail.com,
	Tom Herbert <tom@quantonium.net>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 004/159] kcm: Only allow TCP sockets to be attached to a KCM mux
Date: Fri, 23 Feb 2018 19:25:12 +0100
Message-Id: <20180223170743.619638064@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218270128290967?=
X-GMAIL-MSGID: =?utf-8?q?1593218785248637365?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tom Herbert <tom@quantonium.net>

commit 581e7226a5d43f629eb6399a121f85f6a15f81be upstream.

TCP sockets for IPv4 and IPv6 that are not listeners or in closed
stated are allowed to be attached to a KCM mux.

Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
Reported-by: syzbot+8865eaff7f9acd593945@syzkaller.appspotmail.com
Signed-off-by: Tom Herbert <tom@quantonium.net>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/kcm/kcmsock.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1387,8 +1387,13 @@ static int kcm_attach(struct socket *soc
 	if (!csk)
 		return -EINVAL;
 
-	/* We must prevent loops or risk deadlock ! */
-	if (csk->sk_family == PF_KCM)
+	/* Only allow TCP sockets to be attached for now */
+	if ((csk->sk_family != AF_INET && csk->sk_family != AF_INET6) ||
+	    csk->sk_protocol != IPPROTO_TCP)
+		return -EOPNOTSUPP;
+
+	/* Don't allow listeners or closed sockets */
+	if (csk->sk_state == TCP_LISTEN || csk->sk_state == TCP_CLOSE)
 		return -EOPNOTSUPP;
 
 	psock = kmem_cache_zalloc(kcm_psockp, GFP_KERNEL);
