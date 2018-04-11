Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/pZNvgxiJk7PZGdO5oGFl6yjIcvc8NcXj2ReQk3FnO/mzujrOK0odAodGUMJy+uNpe22CA
ARC-Seal: i=1; a=rsa-sha256; t=1523472992; cv=none;
        d=google.com; s=arc-20160816;
        b=Uno604fHQX9mbpho2vnlWILbIqyO5gJP8fyOluG+lpBkhT/Dr67pGipyS+ppWGkgaC
         x4ZDW6HRk7hJaUOGMfg42MeyCok+I+kikEwEuBhHYqs30fMt7slaq/OWF8gR8kwfayco
         rxj06WxzuhKlOdBVu+QcfRg3JutcPq3N5M0AQMdMvB2dOesKXsXqp204s+zF5Ebnt6up
         Fm5bsZ+kI5hHb3CwJPATB3r6t1OdXH3IKBO8ZPELyWH3uCoc8Il2Rku/HMBuEFsMg7Zn
         vdVUFclidgMtVmIau6Pktd5toctZGWuZyo5DgAAReKd8Gw6S0Zl/E9b/4cwDyYOP7pZ7
         GetA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rqxEoWrCrs9Cezg26grIr70SAx2u9gGWTNj85xJ4r4c=;
        b=xveYdscpBme3nu7k9h8gBT2tXGBtbn372/DgxpRRWG6cXzz70tIPsYv+YPqR3N78+/
         /l25TPQsI6ArE4BGBfMaKS1wDj36KndWV0hJfCcVqSSsRBzqg50RD8vvKODqUfOVLyPI
         7dyrp6neA1UR6FCW/l943IKHyXe19XLrXAujsyVYRRQ6zM/MvhFf+ij7czZst/Yv8zP7
         D192qX3IB43dJZwiWC93ggrikQZ52iGdq2Ei+Lg/H0TKjF7vtsZ2aF6wCTfedqUo2akp
         4p4Uq7dOATc+T0kpv8GmUeliwJZ/gcD5WMcQo8FWVlyE6jrcmoIVC/+eL+oCKAHAvAYM
         OOmQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Holger Brunck <holger.brunck@keymile.com>,
	Zhao Qiang <qiang.zhao@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 090/310] net/wan/fsl_ucc_hdlc: fix muram allocation error
Date: Wed, 11 Apr 2018 20:33:49 +0200
Message-Id: <20180411183626.121210585@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477216424129680?=
X-GMAIL-MSGID: =?utf-8?q?1597477216424129680?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Holger Brunck <holger.brunck@keymile.com>


[ Upstream commit 85deed56032b6c98b541895bfda9bdd74f6ed987 ]

sizeof(priv->ucc_pram) is 4 as it is the size of a pointer, but we want
to reserve space for the struct ucc_hdlc_param.

Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
Cc: Zhao Qiang <qiang.zhao@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wan/fsl_ucc_hdlc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -158,7 +158,7 @@ static int uhdlc_init(struct ucc_hdlc_pr
 	}
 
 	/* Alloc parameter ram for ucc hdlc */
-	priv->ucc_pram_offset = qe_muram_alloc(sizeof(priv->ucc_pram),
+	priv->ucc_pram_offset = qe_muram_alloc(sizeof(struct ucc_hdlc_param),
 				ALIGNMENT_OF_UCC_HDLC_PRAM);
 
 	if (priv->ucc_pram_offset < 0) {
