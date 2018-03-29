Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49ySx6+TpUlN9BpRN3XWbpGAWRPG8YwmjJnlbT5AWYqb7rPvFeaSJSJwRQeYuhqelCO7aBf
ARC-Seal: i=1; a=rsa-sha256; t=1522346506; cv=none;
        d=google.com; s=arc-20160816;
        b=k4/ypYtM2ZIO9h77Xmd0rrKBKKgXITs8cA+BmUZYq6QXMvsjJ1AsEtBA32mRf4nwft
         +oFQwpfROXm2daEl6rxDUYB8UB73HLTQKapsPzdLyvg06r8RiQ1uckDE99mNyL4GjA50
         at5qDjOqQNXY8GdvPIqU2GfRkrxL0fK+H1oYGEDWQnOU/fVak3g4ngAP/Y6ZUk2uCjjw
         IBcPduCk8YDKCVTuMji6019PpaLEkwagjaP8Y8oeSvsg27Q0CdBu9C9OdS4uGpBfPUs3
         v5n+MRoyg2zOp1v0czZuvcZMzKpp/F8sFrazeSMYp5jhhgpaqHgkbR20wDoTlR3U29fG
         KWGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vT2hMwxzvQQdUl0DN+Q94L3kXeHgSABQjC7xrmmdgik=;
        b=rLL4cKP5pRZARWxKY7Puk0o4OmMUCJFJSwUBeaP1SshP4jh6lbYtEPo3zJGA7MzHkA
         Nq1ML/xznqtyiVEA1ekUf/aphgPr10BLjh6gldTJRpsweAILy0vInF39YshWscNBmSGd
         tTYjtMcLOfSB9LRa6azg23awixWx83J1n3lEMLjbZufKAFjQU/3XooPB1H1hRbSSORB2
         GcTjD1Hm+Tlszfq/UGXEJRmj8B5Hc95/ikFI52tRG12oHrY+c1nON3Gg2Y4uDN2MeQsq
         biEldqnet2fFgE8HaREXg2PWL7pewkgL4B5Qv+Y/HjA1vp23ufK+yECXK+jcXGyUDgQG
         zjKQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 01/47] net: dsa: Fix dsa_is_user_port() test inversion
Date: Thu, 29 Mar 2018 19:59:42 +0200
Message-Id: <20180329175729.308934364@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296010588558889?=
X-GMAIL-MSGID: =?utf-8?q?1596296010588558889?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <f.fainelli@gmail.com>


[ Upstream commit 5a9f8df68ee6927f21dd3f2c75c16feb8b53a9e8 ]

During the conversion to dsa_is_user_port(), a condition ended up being
reversed, which would prevent the creation of any user port when using
the legacy binding and/or platform data, fix that.

Fixes: 4a5b85ffe2a0 ("net: dsa: use dsa_is_user_port everywhere")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dsa/legacy.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/dsa/legacy.c
+++ b/net/dsa/legacy.c
@@ -194,7 +194,7 @@ static int dsa_switch_setup_one(struct d
 		ds->ports[i].dn = cd->port_dn[i];
 		ds->ports[i].cpu_dp = dst->cpu_dp;
 
-		if (dsa_is_user_port(ds, i))
+		if (!dsa_is_user_port(ds, i))
 			continue;
 
 		ret = dsa_slave_create(&ds->ports[i]);
