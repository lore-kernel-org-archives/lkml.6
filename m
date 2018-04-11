Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49okHUTmzYhZr9ymkGVwF13BAPUcGTOsJxv0TAucs3ER51ew0DeDQy4+GUOq+2flptzjgss
ARC-Seal: i=1; a=rsa-sha256; t=1523472187; cv=none;
        d=google.com; s=arc-20160816;
        b=IPDv1GjE42kVhlB93jRb0NPKvCmhMclL9hGvvYKxVZdGbPdbkV0kouX5fxQswCRa56
         BHi73g6GGChb0lFkTt6kw1Dg47U6DdWfWwB1DF96ZsVq5TQtyjVgSQuEZtX2cdo8HgSG
         JSxJqrbUdmYftIxnIwNmH4SFMdfC+ybJNuULOrjRSaPpBBx43rcsHhmsgcBwjiimnOqs
         ToZIphCqFozE+nWmId/Jolf3fNJe+fsAbCcnlB7rJ4ADneR0b5UmiVwQi4Ip3A+FldPH
         EILwLwz69vxLnd9+15MDR8Vk0GVyLZtc8vdc9uyRrXICD+5bINPY68bhvSQJeh/u0ys8
         PBIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7AATbMDNRk5zJ3QO7KGa0fTV8BmTUWEr6rqjKFpjBVI=;
        b=sN0TVvt8lmT0dnl6Haby8yeHY/Qa7tGiTDRMYaYo1t0Pwg1E9ONxNZMa2OdVvgGBqS
         wcJ6a+3wAIY66QF0jKe/J9xqVxlK1ea21MFmvUEFzad1/Y1oUsftlUOtoKEJEsGeLcpG
         4I40qo3+1TVJ32JOcONrT6nBKJC6rRXh4zVOjwbC+JN/irUCKKoy6dFZgoWIqFNE8mJq
         o4YPevibaC1tu11QNtG63pu6+TTQTKJQEKoejiB3/pYVAaxrydcJZcucs4jJB4dgpCXp
         UtSuNqP3P9jnDIXYepmByqSd+2sQcfk9JaBy/8TkGSEhomx6dKwgO4oUgu7L7LDLvjMd
         +SXA==
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
Subject: [PATCH 3.18 117/121] vti6: better validate user provided tunnel names
Date: Wed, 11 Apr 2018 20:37:00 +0200
Message-Id: <20180411183504.035563612@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476372304410809?=
X-GMAIL-MSGID: =?utf-8?q?1597476372304410809?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -195,10 +195,13 @@ static struct ip6_tnl *vti6_tnl_create(s
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
 	if (dev == NULL)
