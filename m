Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/b5hejCapd3+wjSNLnVKUArpYB1falI8Gv5cmLFwCMMbbtE1iTjeLDU1aJviB7EzFax4Ce
ARC-Seal: i=1; a=rsa-sha256; t=1523472719; cv=none;
        d=google.com; s=arc-20160816;
        b=TnRN17HPqoSjuyQgup/5yqOgWnkGrzB8ZUmFqZLple4eJT0CCUKNrVcy6OhWzZgr4T
         wIFG3KDnTDcWCUq2mNLbDXoX1I4JKsdd0F55+IYv3/rqj6fSaA+nTmvkBPrXO7ZVT27O
         KTdH388nHWjRa6nLb2/2rRUKDcL1mkRJwLTuT1fySTpiY69If7KmtY7tjuJWWsy07L4k
         /9sWK1Z/Fp9wp6OvFXfDlKSJn8kNq6e09/v0r8cwbeWTlrLg4PPM2PuQqN3QUuIfMeBx
         SrJCgfQkkM6QO1c3eAkWLVrB1gN7Ts73EUIOsx6zaND9QFcAOHkxmNCUFQ4luw/z0tF7
         jsTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gH5suDdb6CMzXvQ8ZjC0bjxXYYbql3RtUJ+UpYOccuc=;
        b=fO5TSit2SfHCUnBOTKlVWci6mF4iL2x8GhRb2SJMCLvkq0JHtVLos4POvnBOfsa0Jd
         wUEH8W7dmgRlHKqqlrmIxYCRUneXRMTSqhXbYC7y4GpZrc7kqBMKfnGMw7GlcASEMCeE
         67lVmmfJFB8KJ3CdBr5W7tWJyhRCbHtEpouawRT/8B1cJoaDNyUL2dWDBwY0U90NgAiR
         gnKnXsejKuUXcncGSreqRPrNK2H8yFjhN07+YnwEbFpLVhWfA+wNuhr+wum+D42YjSIf
         MQzJeu0EX+FfmJ8w43cbC3ds+0yAoExMEmxrHYG4FfZg8555j6i8V+lg5Xrc/vHA2iAV
         aLuw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 185/190] vti6: better validate user provided tunnel names
Date: Wed, 11 Apr 2018 20:37:11 +0200
Message-Id: <20180411183604.361023907@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476372304410809?=
X-GMAIL-MSGID: =?utf-8?q?1597476929976269367?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit 537b361fbcbcc3cd6fe2bb47069fd292b9256d16 ]

Use valid_name() to make sure user does not provide illegal
device name.

Fixes: ed1efb2aefbb ("ipv6: Add support for IPsec virtual tunnel interfaces")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_vti.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -212,10 +212,13 @@ static struct ip6_tnl *vti6_tnl_create(s
 	char name[IFNAMSIZ];
 	int err;
 
-	if (p->name[0])
+	if (p->name[0]) {
+		if (!dev_valid_name(p->name))
+			goto failed;
 		strlcpy(name, p->name, IFNAMSIZ);
-	else
+	} else {
 		sprintf(name, "ip6_vti%%d");
+	}
 
 	dev = alloc_netdev(sizeof(*t), name, NET_NAME_UNKNOWN, vti6_dev_setup);
 	if (!dev)
