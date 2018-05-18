Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp8hr9DOJcpRpUyeLqG1744p2Q7M+suX+dNkvYrZ/mfdu4vitONBLsIhKjmr5FpDvNkTC8n
ARC-Seal: i=1; a=rsa-sha256; t=1526631525; cv=none;
        d=google.com; s=arc-20160816;
        b=SDxt5WpOuWRBybLozqKB72oinTM23ZS8LxGqQfQ539CL59pZkwgPXXZzSKBUO0yeC4
         Rfc7o19U3sXw9il9twqFqDZ5TnGV3tsnHANpdDnDaEGRUlih16hZtECxJHZ0kFaWDkZZ
         hfOB9YBnDyHXOTBIQrG0z1SHik1EtIr62C7Hs31rCukxP/rsHv267xHksPendrejrsAV
         872bssUCxF2Xvn21OUW+nNhlIOZyp+ANUzB+H57TN5reVJhJqyzyjzy9/02uwdH26fJP
         b0ShKWXTGzqs6lEdFWw1hrAnzDrCkiO6GFEdQQu4IhsPCEDbHU5ahyFIdyFpp6z937wV
         RuaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=6uH5fq4UJYDz+ZG2seLKTXNGmr1pn1p6o6ymXcNKoj8=;
        b=cumb3p4P5nJTH5SPn/OCbqtgI7NBwT0z7i1R284HHFO0vLLbf6Bjcq10/dYrndUV3Y
         7t9iFx/7+cLcCqYZxqrqC6L6oguMierv5jSvRqLEzfRUYBgAEPKoGuwxXRXUwYCx6bGL
         r9iBZt0IXnJ9spaaJPyerPnGfqOnDZfzeQ7A+BLakxqkskOb3GbljxSsfnrKwQ1ncSvN
         81bq3pbfnKdr2KNqMksVHAuFr9htQ6iW9JJzwSm7CijMz7QVx/WuQm8CzUYW7/c7W/gM
         o1Bj7N5OfAxW5C1QJ/4PVU/60xSvPfa/9JEuX8QKvtUmMOTt3UGsOiSmssld7oxcEFqi
         4c5g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=j1a7t6zY;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=j1a7t6zY;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andre Tomt <andre@tomt.net>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 18/55] net/tls: Fix connection stall on partial tls record
Date: Fri, 18 May 2018 10:15:14 +0200
Message-Id: <20180518081458.356029250@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789178768699679?=
X-GMAIL-MSGID: =?utf-8?q?1600789178768699679?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andre Tomt <andre@tomt.net>

[ Upstream commit 080324c36ade319f57e505633ab54f6f53289b45 ]

In the case of writing a partial tls record we forgot to clear the
ctx->in_tcp_sendpages flag, causing some connections to stall.

Fixes: c212d2c7fc47 ("net/tls: Don't recursively call push_record during tls_write_space callbacks")
Signed-off-by: Andre Tomt <andre@tomt.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tls/tls_main.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -128,6 +128,7 @@ retry:
 			offset -= sg->offset;
 			ctx->partially_sent_offset = offset;
 			ctx->partially_sent_record = (void *)sg;
+			ctx->in_tcp_sendpages = false;
 			return ret;
 		}
 
