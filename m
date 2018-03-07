Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELthWHKlGZm0IhtoEYSLSUDqlgLLojHEUyrLKlvIHQG7pyWZnD7xRLWvWxs+B8LtPalhWmmS
ARC-Seal: i=1; a=rsa-sha256; t=1520451697; cv=none;
        d=google.com; s=arc-20160816;
        b=H0sE4aobFefzEWU2s1K8NP4WhkMcuUuccBCg7qfDKiaAoMxH1QYKXfuTY3UEPgHtmL
         wG+OqkvnXt2Luoyox0TiVFFDlfafsyc536fSFGgesl6zl1//hEuN6KHuDg24gkhchYsb
         ovtUXf1BTI+/iBKvBfU8Eh8D/VToiBtRneQ08+jng1BuCOHqSaQiPj5aiLTjPbHrw4tO
         aCsi9D2TLsEk/TTfaoTvLxupDiDtcrzjormL7s7OsdS9TbrG4GyKEfJPr3GWj2gfwndx
         rFOkH/yj+6owZs11kOXUl0GwsDSMxXk+3YMPwXprZ/y2KV8YHo2GLmZY13QZY6QAgwqJ
         hOOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TYhcRLNA5QuDjociTiJxLyMTzoqkd/p1fAa3KWm7xGo=;
        b=tgpTeymIogmUtmk9mzM+DztcfvrpGqgq/pq7GaO1zo/lrBF5xhob4RI/NH+RsImUZz
         7/UNUyTHaKfYDcneNXbAXEXwBZRssq+P5bq5iqd3/9icWGJnoMLVDuyQQ9zqsG7qz2yp
         dyPCSNp5OuzZotT6GaQU6USqurhpXkhz4ZuSpfKfsiZRs5i/cvinVTjxpFt47A/x5UW4
         DS/3JqDXqlWP+7oa3raWfiPlUhjwPdeeb4JrTK9VyLtW1gl0C6fXNxCTFHDWqO+HCczV
         Zt88PBSpkJZ2TkBZpN8xpW3GUvcbDHTWUeBOgPUbODiXV27VF6p2RpC38PJgzYjqmWeB
         kjwg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Marc Dionne <marc.dionne@auristor.com>,
	David Howells <dhowells@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 058/122] rxrpc: Fix send in rxrpc_send_data_packet()
Date: Wed,  7 Mar 2018 11:37:50 -0800
Message-Id: <20180307191737.620276949@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309159068259804?=
X-GMAIL-MSGID: =?utf-8?q?1594309159068259804?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>


[ Upstream commit 93c62c45ed5fad1b87e3a45835b251cd68de9c46 ]

All the kernel_sendmsg() calls in rxrpc_send_data_packet() need to send
both parts of the iov[] buffer, but one of them does not.  Fix it so that
it does.

Without this, short IPv6 rxrpc DATA packets may be seen that have the rxrpc
header included, but no payload.

Fixes: 5a924b8951f8 ("rxrpc: Don't store the rxrpc header in the Tx queue sk_buffs")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/output.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -445,7 +445,7 @@ send_fragmentable:
 					(char *)&opt, sizeof(opt));
 		if (ret == 0) {
 			ret = kernel_sendmsg(conn->params.local->socket, &msg,
-					     iov, 1, iov[0].iov_len);
+					     iov, 2, len);
 
 			opt = IPV6_PMTUDISC_DO;
 			kernel_setsockopt(conn->params.local->socket,
