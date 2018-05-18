Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpeRsaTyVtxTRPQBCc/6IXsW6ZYEvSHelpQ/gHJ/6oA+v1eSVi92Es6gW6pbRTe8jus7juu
ARC-Seal: i=1; a=rsa-sha256; t=1526631672; cv=none;
        d=google.com; s=arc-20160816;
        b=eka9Gi5yRDD47Cx+r8cTRTsmHS6rHw1zckG4/JgByKcHf6YRPrZjGjszP6tUwz1d8x
         UJnThzgOiq3IxU56OIcFO6kRc7Ihod/iI1WrAGUvNGcFJECaxx0IwvGulQdu8M797gvj
         ZhdTPmO2jtI63WDK3GcpGLF3G48QUyyiHeSVyjYbiNClHCNWGsujD6+vU5sPu6fME4QS
         khGu5MPznie0fY8lU2f4Oci3aZAxbTAQcjpGnAub106kEdRzEJ5gs2VAtOnUV4cdmw1J
         xytZttNdFUI6TD2T8w/yUeOiIUlF5HKe7KiGp9NPOY5M0fNLC2ZXBwvWO88iNBl7ZDHM
         BY7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=kWzLxBJJSmq+LRoT+dJh9r+mUgEtW8kmWYV/cB9eUwE=;
        b=dEwpQxPxNSi7fTWBKPlgMllUOf+eGIdesCxp4Cw2ArchGKtwZ8vFmKkB9iBYUmPPLR
         N1oTzna8cFDGkhTOZn/E05GPsgzKdVpGfMEOD+ZaHU6Evu+h1eu3rFk0eqlnH/2FCWMf
         F4wsRGH2z6i4gyn5J+mYbXz+iMPGIDaufVbJ5jJdTZbDBWbzvqsTYGY4PShg3c7H3ZhO
         qAp5M41SptUaENphUoH/vg7TIGRE/lY7p6ESP3uyn6XGh63oteCRj1GPoZeYGw3kFUrR
         5kNjpzqW9JXlca47nTJPhOxUlFW5TgivQ6667Jyj8vQ6S26nTrxYptgvjAXqJ3ix/X+k
         M1rA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=LpVGdqU2;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=LpVGdqU2;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Xin Long <lucien.xin@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 26/45] sctp: use the old asoc when making the cookie-ack chunk in dupcook_d
Date: Fri, 18 May 2018 10:15:43 +0200
Message-Id: <20180518081531.670259410@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789105798675271?=
X-GMAIL-MSGID: =?utf-8?q?1600789332572305717?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 46e16d4b956867013e0bbd7f2bad206f4aa55752 ]

When processing a duplicate cookie-echo chunk, for case 'D', sctp will
not process the param from this chunk. It means old asoc has nothing
to be updated, and the new temp asoc doesn't have the complete info.

So there's no reason to use the new asoc when creating the cookie-ack
chunk. Otherwise, like when auth is enabled for cookie-ack, the chunk
can not be set with auth, and it will definitely be dropped by peer.

This issue is there since very beginning, and we fix it by using the
old asoc instead.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/sm_statefuns.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -2009,7 +2009,7 @@ static enum sctp_disposition sctp_sf_do_
 		}
 	}
 
-	repl = sctp_make_cookie_ack(new_asoc, chunk);
+	repl = sctp_make_cookie_ack(asoc, chunk);
 	if (!repl)
 		goto nomem;
 
