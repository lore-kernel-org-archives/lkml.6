Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvL4SsFVvlfKZqoOxb5zfSm6XwTi3lKwcm2u5mRaLmMYiL/DPGupaQjx2TImRi7fyuP7Xjy
ARC-Seal: i=1; a=rsa-sha256; t=1520451824; cv=none;
        d=google.com; s=arc-20160816;
        b=rP9DXdcR2/X6Xu/lDFzsACiq2fzREesUPNI40mrlsQDJqpO9+KAsxPfWAN9iKO2Y1P
         7YKoUKa0adhjbA7aAMblIy1S8ExrmHENrFY/W9wRAfVbHzvhLmAxtNV+kmDbPJa7GNKq
         lI8bacjDzxOXtBiWcP4EZgEyPONqs/cWeDuKMynZ5FY6t9XKvr8ZIvZdNC7PnFY6VM5d
         p8uv5+IRfE0kb6og7PbdOyDeCnz6h/sUb0bt+d2QO+79ZN8kyGyUkioI7JJ/jGuXIRNm
         dUKFAl8nXVO/XxAic/q7sO1NlrZSk+MGQtA/9qoL+GLPlcdtN7XUpqjNtZvDDcNhePrg
         RSAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FmaiPhXf+XRn8T2HJb+v+fLRFqPI8gl3Nu/8QNf4cZQ=;
        b=NGIRLEyaZxf4oqGu0jwz89/T10aagndrsBnL9Kzq7TIquH/ira3/c4zsJ62Cf/wcCt
         FBzKb2iHf+N8uI0OPfrX1ACam/2s0Vx2hN7QSjFT0ZoIvy8ZswSTLe6J0an03+WANok9
         p7CC2MWtV1eEepbYSufXpbwl6o/i9makTMhvMKRFbt2qWch6r/1yXg1SMU4j0TTZIgu9
         CLRz1vkH5IQUJ6iajsgVH2tjIsjSXUFgLCKcuK3mgXTlzg+BGenM+qFbQj+1xXtcCVrB
         emTAE5fnxMtFciJKkAS4DPFC8/jUEgfQg52XhbbEy3tlbR0zlbASEjtH/TyvNU7er0bs
         HRmQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Soheil Hassas Yeganeh <soheil@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Yuchung Cheng <ycheng@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 075/122] tcp: purge write queue upon RST
Date: Wed,  7 Mar 2018 11:38:07 -0800
Message-Id: <20180307191740.121639703@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309292043056777?=
X-GMAIL-MSGID: =?utf-8?q?1594309292043056777?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Soheil Hassas Yeganeh <soheil@google.com>


[ Upstream commit a27fd7a8ed3856faaf5a2ff1c8c5f00c0667aaa0 ]

When the connection is reset, there is no point in
keeping the packets on the write queue until the connection
is closed.

RFC 793 (page 70) and RFC 793-bis (page 64) both suggest
purging the write queue upon RST:
https://tools.ietf.org/html/draft-ietf-tcpm-rfc793bis-07

Moreover, this is essential for a correct MSG_ZEROCOPY
implementation, because userspace cannot call close(fd)
before receiving zerocopy signals even when the connection
is reset.

Fixes: f214f915e7db ("tcp: enable MSG_ZEROCOPY")
Signed-off-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_input.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3988,6 +3988,7 @@ void tcp_reset(struct sock *sk)
 	/* This barrier is coupled with smp_rmb() in tcp_poll() */
 	smp_wmb();
 
+	tcp_write_queue_purge(sk);
 	tcp_done(sk);
 
 	if (!sock_flag(sk, SOCK_DEAD))
