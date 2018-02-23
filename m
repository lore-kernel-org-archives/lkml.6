Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuiRQ9uab1TgYiM7f7clp+PuFZmhAIhaYaszLSwkVMurB328cLyv2Q/yTWCypAtBfcaZy2k
ARC-Seal: i=1; a=rsa-sha256; t=1519412144; cv=none;
        d=google.com; s=arc-20160816;
        b=YP+GDBoF60rSePuj1TRR90OVIorkU6+JEcyzFp4ssjsOEqzIssUCHYCZmCUZZr6Fxq
         HJjxay5OX7ata8ahbcsXOINXTBUTDB4EHKQYRRuCIPTjAHlz9EwHuLk1L8YncBC/Nlrj
         /Guy2RZdG3sWB66I+/HDGo4JPYD9ztg7J/js5a0WRWJeYeiyk0JTkn7gqpeZ4iW01qoE
         Kslr1qsEm0Yralh9yeRFki+n/uPSgo1+zB4zq4hzLExCxglHkFQ/A74sw9w2a1TpUEmK
         3oTM9fi2d/7UkuVKuL90DnysOj/Gt4TtXorKC6SErVZsw40ZHb79R4KVd42XsuF+AMPT
         VYYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8ayaxIabUW7nDTaAQQGxrnubpiHhfss1fsRh+4/n83w=;
        b=mC+3LS+ZiXB6VpsPwpfE+qZaFlSgssJd2UqNty9y1MWl/rQRKZDxv05Y5+TjSfM2m9
         xUu4sGWVBErvgfvIUBJgkwnTkE56z2eX2E7Lu+F1oV5p/yJ6H8CFnBH0hhpaq3Zy8kzu
         bS0sIM0duqRHTPsIMvTLDJUotDZiSC2ldN819zCVzOKUBFdhyCd53USxB20GWrUyzueF
         Vi3e19gT97ql3Ez1mOuViYxLs7fbzpQvKU3ZVnwLuHg9cBxVdzAkvCa+oQ9MoOd5uX4B
         14YbUztO2jtdr//Oh7kv/JmQESrqiy9uMpohZsWe2wV59k1bMsPI1WSGk4p7adHCyP+K
         4u/g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 140/159] xfrm: Fix stack-out-of-bounds with misconfigured transport mode policies.
Date: Fri, 23 Feb 2018 19:27:28 +0100
Message-Id: <20180223170759.959741207@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217618518643482?=
X-GMAIL-MSGID: =?utf-8?q?1593219109330352970?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steffen Klassert <steffen.klassert@secunet.com>


[ Upstream commit 732706afe1cc46ef48493b3d2b69c98f36314ae4 ]

On policies with a transport mode template, we pass the addresses
from the flowi to xfrm_state_find(), assuming that the IP addresses
(and address family) don't change during transformation.

Unfortunately our policy template validation is not strict enough.
It is possible to configure policies with transport mode template
where the address family of the template does not match the selectors
address family. This lead to stack-out-of-bound reads because
we compare arddesses of the wrong family. Fix this by refusing
such a configuration, address family can not change on transport
mode.

We use the assumption that, on transport mode, the first templates
address family must match the address family of the policy selector.
Subsequent transport mode templates must mach the address family of
the previous template.

Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/xfrm/xfrm_user.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1417,11 +1417,14 @@ static void copy_templates(struct xfrm_p
 
 static int validate_tmpl(int nr, struct xfrm_user_tmpl *ut, u16 family)
 {
+	u16 prev_family;
 	int i;
 
 	if (nr > XFRM_MAX_DEPTH)
 		return -EINVAL;
 
+	prev_family = family;
+
 	for (i = 0; i < nr; i++) {
 		/* We never validated the ut->family value, so many
 		 * applications simply leave it at zero.  The check was
@@ -1433,6 +1436,12 @@ static int validate_tmpl(int nr, struct
 		if (!ut[i].family)
 			ut[i].family = family;
 
+		if ((ut[i].mode == XFRM_MODE_TRANSPORT) &&
+		    (ut[i].family != prev_family))
+			return -EINVAL;
+
+		prev_family = ut[i].family;
+
 		switch (ut[i].family) {
 		case AF_INET:
 			break;
