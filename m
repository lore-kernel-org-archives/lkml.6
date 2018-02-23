Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu+Cfm2qHDEk04v0jhoNdH7Rv2OYON53dNLdy7ogQJgvBzirgfFb1V0T20+F7OdQ6J13J3K
ARC-Seal: i=1; a=rsa-sha256; t=1519411199; cv=none;
        d=google.com; s=arc-20160816;
        b=Q8zAdD6DAYwQN160ajkZiiPotF1Dh6YWQwhkG6K7ZjffgPkTlX/MJUajgnHH4dRjnU
         kOFCLI1TNj6AkDX0/99w8TxQJVh8cx0TA+UhArOIbrrXHox0n6w3ppaDZDmWjQU6oJ6f
         HynsRRGiCCZF3p74u30LW906aDVbmbG43KRWo8xbtXfPhv6fMMa9SwAvpWcJv0tlmppy
         sQJ2KhzWpG8zWRMR0Wxn0OLMnWNBFjbplF9W8ulsGeCmgMrgXr6YmYPGPXNcqX90reCv
         zyMeJOG9duDmPRD4CsQeaY+FJyHgVhgFEUxPwvD17m3lZKHpssAvYh37YkkLQw9EYf6X
         zXtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=d3MEDZwMUmYnv/E96DFeC3d/3+QNtWdalrf1QzSusgQ=;
        b=FIO56QledfkJifM1soV8L55eL2zAU7HqccBNB7IXq8Ektfw3PY2kN6+pCrY1UslVVw
         MrSiQ9RKxXPZw9BQjq8J6ZBzHvw4aPFjLJmqTjRo+8MKlcF3RGxPfQzF8UHvJgqIrhbl
         dFlJLqgEzN8PHhe0KdDeYkJGhR+6AELRcrtoufmdz6bmH5VyGMgiGasqO/H4cMJW9L4P
         35NkFFE0KisYUVdLhglHyTQ7bYhPvfpmuy2PsdqwDB7z7lJPCAFewzIl2NNyfO5wCGt0
         W9CmtcXHT6AVwY118A6wMP6/mgk3WpC/lJW3fxbDoGo8YPUm+fRa3iQmvK0HhBnDqMkV
         OWcw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 118/193] ipv4: ipconfig: avoid unused ic_proto_used symbol
Date: Fri, 23 Feb 2018 19:25:51 +0100
Message-Id: <20180223170344.332616740@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218118384471296?=
X-GMAIL-MSGID: =?utf-8?q?1593218118384471296?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 52b79e2bdf92b07b37c805c50811eaf69a33683d upstream.

When CONFIG_PROC_FS, CONFIG_IP_PNP_BOOTP, CONFIG_IP_PNP_DHCP and
CONFIG_IP_PNP_RARP are all disabled, we get a warning about the
ic_proto_used variable being unused:

net/ipv4/ipconfig.c:146:12: error: 'ic_proto_used' defined but not used [-Werror=unused-variable]

This avoids the warning, by making the definition conditional on
whether a dynamic IP configuration protocol is configured. If not,
we know that the value is always zero, so we can optimize away the
variable and all code that depends on it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/ipconfig.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -152,7 +152,11 @@ static char dhcp_client_identifier[253]
 
 /* Persistent data: */
 
+#ifdef IPCONFIG_DYNAMIC
 static int ic_proto_used;			/* Protocol used, if any */
+#else
+#define ic_proto_used 0
+#endif
 static __be32 ic_nameservers[CONF_NAMESERVERS_MAX]; /* DNS Server IP addresses */
 static u8 ic_domain[64];		/* DNS (not NIS) domain name */
 
