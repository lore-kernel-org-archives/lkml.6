Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226JFs/GPA8OPSCWS6yN2HevNl63vPilEoAvaezMgNV8sxCKn3T6sM109jWUM9QI79Lb0ek4
ARC-Seal: i=1; a=rsa-sha256; t=1519410911; cv=none;
        d=google.com; s=arc-20160816;
        b=Dtl/tavGtREUxx1Co374rDx3WyuORgwtZUn8E5GCReNx5Z/U1dE0zKrxdH3Qczbyip
         8ce512MESEBHM1ax20OzHMCg754cr3t+0eKa1BEVEI7Km/y9zhboVFF3olXMibu+UPfv
         CH4+659JYnXdLXh/63Yc2JG6I8+MR0wLpUpDJjQBQfIVvNy85Jw2UZyZ7uA5ZFWr/lK9
         KUNLEG+SWL7FBZkUtowWzJIMbQGeHFnpsU10xHzppBA5f5Csi6aHC5Q/327pLhg3kU8n
         AIHDlxg/4KTdXYEbMz+3MeDODamfvBV5HGOPjTbmKddtc6pI7XFuvjZJsdcY0AKHworO
         MvXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RuFfwSj04lyCB694mBAsAu8SvVdGgxVM5npkUFApswM=;
        b=M2/yrCYGcoPMFy+r71cS2Vkm4xWuqF6WjqXcYyRoQPC0Pwf718HNgBKSSwqQJq8fmH
         Tz28oSIPc6gWRqJ8nQjyv0bt5qFsVPugWKmta7gNW3lCxhgeeW4q3d2pZFQkbkS7bIAx
         AEYljKQ4WTjy9yuUzOEBqYIawo3tAkypnLzaKOXEPmDv1QaGqmmJlTdP6cpAm23Jl3wL
         J28tCHYI7zcSzQTaIST6U0s8NW9bN1tqRqztVyuulWAcrpJYfi1TjO4wp/G0cJOT25kf
         PSGg8nFWmGpVMoGQomj089tNLcNh3kHgAkIhsiyPYj0Vd14qiSW3CaNZMMlz+1X7+PLJ
         /vXg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 055/193] xfrm: Fix stack-out-of-bounds with misconfigured transport mode policies.
Date: Fri, 23 Feb 2018 19:24:48 +0100
Message-Id: <20180223170334.611498608@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217618518643482?=
X-GMAIL-MSGID: =?utf-8?q?1593217815716686311?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/xfrm/xfrm_user.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1376,11 +1376,14 @@ static void copy_templates(struct xfrm_p
 
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
@@ -1392,6 +1395,12 @@ static int validate_tmpl(int nr, struct
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
