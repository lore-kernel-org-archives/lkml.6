Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv8HmpCWbKwRjeaKf+I2RIEss6VXpAkwtg+FvoYeB/l0Buhz3rjmFK6AtxUiB+01oUMBMtW
ARC-Seal: i=1; a=rsa-sha256; t=1520452055; cv=none;
        d=google.com; s=arc-20160816;
        b=HYGCclI7ZCMRJn1WlqBAx7ngqTN8JfTEcTDQfGH60fEaxDI7uLKtWSiom/dHgI15Ec
         7PuE0f88Dw1INtnjpTyaX0JxMhqfsK9GfpajTqxQbcdldsPbHN+eykG0H9wDxs2bJcNO
         07+EDVpIeFCF8+8H5iX5V/wjuJ+2Cc37aRzQsEqZiSyOIb2g7GEarJnu28WVsQLEuhQH
         VaOCCHRzm66Mtdd0KTeCJvvYvkmpNpDdqILeyS7ugH5sjBcXPAt4sO1H/8EhcnbW85IH
         J8rf447yHqJFgBWh+FBsjoRzwVSLhwXk3LA+zF5Z9UsGNtMUbRKdXIws1xhcQUvpV/zi
         oglg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=e9M1gqDRhLVz6I2V6qlbZjJwLKy6DTM+h6UM/7SDwM8=;
        b=CKGNlBZjHFOf6JNysI9HMzeR79hIBry/GnFOYYr4rgQZC33HbqhTPbjSOGyaY18RjW
         +fs0ByZG4lulBsnwXRYpIYETJub0AZ2jkCGpe9iD9tAiWBDo7ZUOXjPVhY1BOmTpSFww
         sRioWCnuHZZX1G0OfmUYm62K7dPI+Y9gEyiwPx73L+84d4tGrsh67SMEP/6C6UqMOL8H
         isH33rj/eKX76E0esX6gKkVQGfoIV3qAA4Zkis3XiiSWEDKf7ZrcPG0nGrFPug9quJDv
         wHayr7vwHerw07z1JhSxf39hfCiEYtXBW6oTpFkv+qmiFF4F9SLbMXsZCzaL5yV7jlLS
         gHrg==
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
Subject: [PATCH 4.14 053/110] rxrpc: Fix send in rxrpc_send_data_packet()
Date: Wed,  7 Mar 2018 11:38:36 -0800
Message-Id: <20180307191046.458173019@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309159068259804?=
X-GMAIL-MSGID: =?utf-8?q?1594309534795293680?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -395,7 +395,7 @@ send_fragmentable:
 					(char *)&opt, sizeof(opt));
 		if (ret == 0) {
 			ret = kernel_sendmsg(conn->params.local->socket, &msg,
-					     iov, 1, iov[0].iov_len);
+					     iov, 2, len);
 
 			opt = IPV6_PMTUDISC_DO;
 			kernel_setsockopt(conn->params.local->socket,
