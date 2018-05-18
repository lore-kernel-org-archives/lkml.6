Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoWU1cW/695SIXBhtVEWQ8Blx+RubHRfgLNlJ9EbDtnXEt38fgspr3gjPRrToqXvhmtUrRL
ARC-Seal: i=1; a=rsa-sha256; t=1526631493; cv=none;
        d=google.com; s=arc-20160816;
        b=sHEuklx0yrWEdbGD6EhiJgycjxqvDLTplJkMHlW40JZm4ivmwuQfOs+MygF3NwWwIn
         hFtZ9AOJLgeDThDVHNjuMJWBZhlSYTbrbAmSgFqQJl/uXYNLUA2euLoB15jrN5Ridu6L
         MV1QALX4Iyq6PisynZQrLCH5E6gZokQDxXXvqrbgtoLjvlWbCFYqQTqHaGqrdS6YsYgD
         xk+ILiD0+PVswlWF7Ykt+LbHeHsNJhhgEr4ZPmiM7sUVETnlKvoJC50GLRsIaDpVjRSv
         2iaLZGXWgu0eA4EYZung0Xl7RPG7dtggIpAMkDHfTUgDKtjXokGnHv3qpE8rJzNlCaUa
         Jcdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=KG2cmAohdtbqSSDXwIbpZcgslKU7AF+A6PRGvkVACoc=;
        b=dVDjLkBeFs5GL32ImM9qe2zNsYnMyI+UX+P8jxO/wn03lxyMvM/zeuv1vz8D8rthsG
         WI2CggzeCEhet9AsexsVn1g0CmVEdH2OuOfU9XSgeWoBw23fGJ8kH+jFthAM8BlY/35o
         PHZLwUrOb4kjcpaAFX+DLA607WXYvdYirXzdMTQDUzXiHcnr98b18LffUjer/mvArbWX
         h78KfaY3UTfZXnVYdwr7jxKaEUirBb6tHChJ0uPRnu5AzSLTVptOJu23rfHZe5wv5En6
         SNYNfdriVMR/p7OBNZrrHSLWZMvrJJu2JptK7oBigXC4ZvlNtKOESCsL9jKVjUT5tkwK
         DPPg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=oUc6UMss;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=oUc6UMss;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Damir Mansurov <dnman@oktetlabs.ru>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 40/55] udp: fix SO_BINDTODEVICE
Date: Fri, 18 May 2018 10:15:36 +0200
Message-Id: <20180518081459.351309135@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789145041813810?=
X-GMAIL-MSGID: =?utf-8?q?1600789145041813810?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 69678bcd4d2dedbc3e8fcd6d7d99f283d83c531a ]

Damir reported a breakage of SO_BINDTODEVICE for UDP sockets.
In absence of VRF devices, after commit fb74c27735f0 ("net:
ipv4: add second dif to udp socket lookups") the dif mismatch
isn't fatal anymore for UDP socket lookup with non null
sk_bound_dev_if, breaking SO_BINDTODEVICE semantics.

This changeset addresses the issue making the dif match mandatory
again in the above scenario.

Reported-by: Damir Mansurov <dnman@oktetlabs.ru>
Fixes: fb74c27735f0 ("net: ipv4: add second dif to udp socket lookups")
Fixes: 1801b570dd2a ("net: ipv6: add second dif to udp socket lookups")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/udp.c |    4 ++--
 net/ipv6/udp.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -407,9 +407,9 @@ static int compute_score(struct sock *sk
 		bool dev_match = (sk->sk_bound_dev_if == dif ||
 				  sk->sk_bound_dev_if == sdif);
 
-		if (exact_dif && !dev_match)
+		if (!dev_match)
 			return -1;
-		if (sk->sk_bound_dev_if && dev_match)
+		if (sk->sk_bound_dev_if)
 			score += 4;
 	}
 
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -148,9 +148,9 @@ static int compute_score(struct sock *sk
 		bool dev_match = (sk->sk_bound_dev_if == dif ||
 				  sk->sk_bound_dev_if == sdif);
 
-		if (exact_dif && !dev_match)
+		if (!dev_match)
 			return -1;
-		if (sk->sk_bound_dev_if && dev_match)
+		if (sk->sk_bound_dev_if)
 			score++;
 	}
 
