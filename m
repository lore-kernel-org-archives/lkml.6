Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr88RT9q7flChdRx9azXdy5ZI3EQIknX7RY43XQ+SsjpsHSULu+7FUeaBfQG+WxafqATIJ7
ARC-Seal: i=1; a=rsa-sha256; t=1527156069; cv=none;
        d=google.com; s=arc-20160816;
        b=CuXmQcseu/Sv20MAt46PIEojFHJ597rdjqWS2zwIQvwTE175J/yFNaSHlrjuFEJsOE
         skVij1zoZxw1ayvX+U6rgCP5nT5ucIoCQJM7dCcHCxYfHkFF7b2IHPHkV4Gk4AmpLz75
         LdJGPVZYMR9xyH6/v6zZsIZ5fSgRlsv2XaJ+U1/HJ6xOy+yHKOWl1SVr+H7KhgeG4NmU
         3EbLaN4Ejhf3dyoVBu4eDtpEhI67tzXN3NBOibD5UFjm9d0DR+5Nqzzz5NxeC1GMgDq1
         AG4KDOuCxIo1wN7ZnfeOnHjOpK0XQZ+cwNIFkXHnekiWnVwiYzjoPgxVdNn4jrAzICMV
         X99g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Hkj8cA0eOyx8iQFIqB+A9QQ5Y0E2gEUDBcr9/BpmoZA=;
        b=Pz3lkUE2HLNMusHeqCKpi4cj1bw2RRhxOrO/g1ywA1fDO33g1SiQ4Sqo86+aK088o6
         F7LnBrePfuys5oEtnyM5o26oFY2ov7VDsFeExIB2wMjYhTvktg8XCCVCo8catureKQMe
         hKLj6GnX0QNGXH8w/aBcbiB8EuQ/YKK0QxIi8cZZhaymgtuH2AcJYou8yPc42cJsHjuf
         EquzHWyfIeos0K2ql/jhopFR9CEjlXfHgrGtka5QqvQZRRIxK0EvoCWhVq0BotkMElCd
         ueIap1VZU/eVxABYzakhcDAdPdkaT0rQRgIwrVbWVAuxb3mAY1f7VVKtA6oKD0vUAHjG
         MmsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=SfH7rhtf;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=SfH7rhtf;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Petr Machata <petrm@mellanox.com>,
	William Tu <u9012063@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 025/161] net: ip6_gre: Split up ip6gre_tnl_change()
Date: Thu, 24 May 2018 11:37:30 +0200
Message-Id: <20180524093021.371976848@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601339203001612379?=
X-GMAIL-MSGID: =?utf-8?q?1601339203001612379?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Machata <petrm@mellanox.com>

[ Upstream commit a6465350ef495f5cbd76a3e505d25a01d648477e ]

Split a reusable function ip6gre_tnl_copy_tnl_parm() from
ip6gre_tnl_change(). This will allow ERSPAN-specific code to
reuse the common parts while customizing the behavior for ERSPAN.

Fixes: 5a963eb61b7c ("ip6_gre: Add ERSPAN native tunnel support")
Signed-off-by: Petr Machata <petrm@mellanox.com>
Acked-by: William Tu <u9012063@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_gre.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1106,8 +1106,8 @@ static void ip6gre_tnl_link_config(struc
 	ip6gre_tnl_link_config_route(t, set_mtu, ip6gre_calc_hlen(t));
 }
 
-static int ip6gre_tnl_change(struct ip6_tnl *t,
-	const struct __ip6_tnl_parm *p, int set_mtu)
+static void ip6gre_tnl_copy_tnl_parm(struct ip6_tnl *t,
+				     const struct __ip6_tnl_parm *p)
 {
 	t->parms.laddr = p->laddr;
 	t->parms.raddr = p->raddr;
@@ -1123,6 +1123,12 @@ static int ip6gre_tnl_change(struct ip6_
 	t->parms.o_flags = p->o_flags;
 	t->parms.fwmark = p->fwmark;
 	dst_cache_reset(&t->dst_cache);
+}
+
+static int ip6gre_tnl_change(struct ip6_tnl *t, const struct __ip6_tnl_parm *p,
+			     int set_mtu)
+{
+	ip6gre_tnl_copy_tnl_parm(t, p);
 	ip6gre_tnl_link_config(t, set_mtu);
 	return 0;
 }
