Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2274rAqIix3v2LOgkBKL6tyCxly+s8ZRjE85BWOm3/0fhzu06WNkAb9j+U78h/xwJR5S/e38
ARC-Seal: i=1; a=rsa-sha256; t=1518184025; cv=none;
        d=google.com; s=arc-20160816;
        b=SS5Dv5IIldeH7wsl9q6hpQCqOk6yR9V2MSixXJ4MTxjRhBVlHRJ5Xl4W0qpb7lngzV
         E/pCem13VtWVY+ndu6lWi/zR41QEQtHMpxyRiUHzTM0M3l7CJy4KoIHX0cnNWByMn7Hd
         D0yLmK+y9eYGRV4IkskuPUg/TNb6LezlqIx7HNkfoQSMV44qaLS2nseE/tLM4XuJRYox
         gf9nPkPFtEx7CBIfC3NY0GZSSIEAlCQMl/6Jr+12n1DZsEZeafzQQveiPiT2RgDrX/du
         16c71YShMmZTakIWMY/JkbH8/uv57ICsGo/lDIkj9W3s8dSDFTejPRxyQps/YDv4KRD3
         Cmeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7rbFDwZPEzXwr49GjubqOF2705EUwBP7P0Y5j3lbGSI=;
        b=g7dNnbb7k0eP7ulwHTIpamTIRR+0gNXOfFXEMzXYrASI/8dKGX8y2cKbz1xBo0J8E5
         bCGwJ+QRKGefNUA3aiZFG7a2Vib3WAmYXfi9b5iIm3xzWj31Zsrxs+2tI2WPJa1wvhC2
         ulUyQcXZsvlJ4kNkSLKY3UlI75yb3tvQi6lMtjjUid26N8gLi4Kf/bsGehInJZusLdap
         f8mWT99Xi0KxkcYlzLaiONxVFfgAWYmJvG09zQzwRXSgkc9hHVsqP9BSkWEsK1swPBry
         YC3QOORKU+lYSDO8vvGeJcqRJpynbgl+Z3aqhCQyT4Y8dDkH1uF49+Ai+ueYf56VVDHl
         hmEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Li RongQing <lirongqing@baidu.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 06/23] tcp: release sk_frag.page in tcp_disconnect
Date: Fri,  9 Feb 2018 14:40:04 +0100
Message-Id: <20180209133938.708757960@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133938.366024920@linuxfoundation.org>
References: <20180209133938.366024920@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591930968605820473?=
X-GMAIL-MSGID: =?utf-8?q?1591931332780482411?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li RongQing <lirongqing@baidu.com>


[ Upstream commit 9b42d55a66d388e4dd5550107df051a9637564fc ]

socket can be disconnected and gets transformed back to a listening
socket, if sk_frag.page is not released, which will be cloned into
a new socket by sk_clone_lock, but the reference count of this page
is increased, lead to a use after free or double free issue

Signed-off-by: Li RongQing <lirongqing@baidu.com>
Cc: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2434,6 +2434,12 @@ int tcp_disconnect(struct sock *sk, int
 
 	WARN_ON(inet->inet_num && !icsk->icsk_bind_hash);
 
+	if (sk->sk_frag.page) {
+		put_page(sk->sk_frag.page);
+		sk->sk_frag.page = NULL;
+		sk->sk_frag.offset = 0;
+	}
+
 	sk->sk_error_report(sk);
 	return err;
 }
