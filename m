Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+iOqYxa15auq+bq7qN5SFCSUcqUDnmEUoNOughegtxarJVfK7Zc3lfdYSzNK+dQCQN4tHs
ARC-Seal: i=1; a=rsa-sha256; t=1523472189; cv=none;
        d=google.com; s=arc-20160816;
        b=vbDy2WygHPzw9FR/QWtZIA0kSz6lIRK6tXsqyd5uOCIvwHKH8U2CLz9eFKeYwMjiyP
         jNpSFxJhw8ctJMEVKOLJ5l26KCbAHv0UHPBmSE/kiWhLXcitgb1asCRVPwsSq/p1fhZX
         92+cWnplB4gVfvGYucquyCb9faubkyP3PeKHPuVBBWPuRwssSK7sMHghcMprLGOob3mH
         cul5/YkRVIEicZ5AF4T3VveF6ymre0lStGGRFddwORQI34yY/GW+q2f5RtfyvI867jS+
         KAyFQRnW9hfveL9hIu1rNMOllr26yNlJp94o0u4lSjbY6aaCIlT3ULIR0g0zkWliU1wV
         VnGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nBqKwYXL5apwNwnvvTNlbYfcRxx3vyeyuKENcChM1Ok=;
        b=GK8rCJQaJDf0aj/VsYmdcNDZAWofNJ7GQw+pBjANGDPenO1Szabu7fS1iIbGRcI0dz
         JhTRRRAvFF0nZLe22+4/2Q7zfR/sm1UxxVxNhyWbJ6A7xXH2hlUPigpH7fMP14cyt3IU
         qV+RXVQElLHyqlLyRNAA1unbO5d6i136aZ/8SrzFXGuxy//ksxm/ontqLOFyEPAlbUvi
         jP45A8fgsDqfvuAXoe8Ch9H9fzdryB+EJeq3Y+vSNeppoFaCc8e0ePt3lY9PqdocgsHO
         V1l04b8HX5oSfvB5/nCZoWwx9C5bkYLRZsxiIbOcK2RK+j/nA8Z7AKAvmec6IzbpNSBN
         Vs7A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 118/121] ip6_tunnel: better validate user provided tunnel names
Date: Wed, 11 Apr 2018 20:37:01 +0200
Message-Id: <20180411183504.105080908@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476374644156023?=
X-GMAIL-MSGID: =?utf-8?q?1597476374644156023?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit db7a65e3ab78e5b1c4b17c0870ebee35a4ee3257 ]

Use valid_name() to make sure user does not provide illegal
device name.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_tunnel.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -307,10 +307,13 @@ static struct ip6_tnl *ip6_tnl_create(st
 	char name[IFNAMSIZ];
 	int err;
 
-	if (p->name[0])
+	if (p->name[0]) {
+		if (!dev_valid_name(p->name))
+			goto failed;
 		strlcpy(name, p->name, IFNAMSIZ);
-	else
+	} else {
 		sprintf(name, "ip6tnl%%d");
+	}
 
 	dev = alloc_netdev(sizeof(*t), name, NET_NAME_UNKNOWN,
 			   ip6_tnl_dev_setup);
