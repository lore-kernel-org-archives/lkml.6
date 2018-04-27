Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZosGwjdak2/BsgQ5BzrOQyZuRZ5EoVw1ESvKrUpCt7SBCa3+0vBP063vgaT0z16sJatgQqA
ARC-Seal: i=1; a=rsa-sha256; t=1524838352; cv=none;
        d=google.com; s=arc-20160816;
        b=dsm8pqCVANBo2uO+L+eCQi6LNOnfQDgOC3eGv1qNV1zKbHABE0Shk21qBYFgdVq3M5
         JWlNrNCfwWmVr4IXdB3pCXPlQECJb4K9dhQz2lbtYBP7prjOPPgLSgUX79tLweEVUJoP
         d7sxf5zcaDZTlcPBjaRsk7gggoxRCvmB1ZGq6YhgjtyW7VUT1/cKT4oNHf7VpZ7Lm0HJ
         JAyW9I47pA8QICj6/PPq8P/Kd3gOe/5yycWP/4gSAp4eu3uKI4PSAIaav6bmfnP+Q7e3
         b/hwwAwrIJQldhjc5rB/BnCbYSrfqWT8j8Hu8aVFAJUpXH4XBcuCXMrq4m2SOc4mVo6U
         1Kvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=QXcID8nxE4WiOrmCgpdOn8zwaSlxe3LpIdjSH/eK0+U=;
        b=idwFLARuDqTfQG4cvA/87lSyJrKYLit0yuRd6A9U0fw+yFhHqBytMSPpLNyu4oPW50
         z/dMcKj4ERgCzmh1tm7IDGBZm62G/RErKeWT5fF63P2qV31XE8sVmnUNlvcoU1n1RFqA
         IyZ2MNacTJtPqbEtwFH+bZk5zqKCzBX23ljVsZgDt80Fg4n3VZYV37JCmcK70uYtJNDe
         LBWKKu0HS1FVlDVf0UCzReix/x6mun6NAoJQroMn2F1GVA7rUFJoY423eGNa/TfzkWau
         KtJzUXdI+xt1ot8+jENTAVDGttzbAjOLseS6hBMOVsAWRGwwfevUciJqlGZuudi8Uf8x
         lBAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 550B321897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexander Aring <aring@mojatatu.com>,
	Yotam Gigi <yotam.gi@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 40/81] net: sched: ife: check on metadata length
Date: Fri, 27 Apr 2018 15:58:42 +0200
Message-Id: <20180427135745.421240664@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908584716221780?=
X-GMAIL-MSGID: =?utf-8?q?1598908899899389839?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Aring <aring@mojatatu.com>


[ Upstream commit d57493d6d1be26c8ac8516a4463bfe24956978eb ]

This patch checks if sk buffer is available to dererence ife header. If
not then NULL will returned to signal an malformed ife packet. This
avoids to crashing the kernel from outside.

Signed-off-by: Alexander Aring <aring@mojatatu.com>
Reviewed-by: Yotam Gigi <yotam.gi@gmail.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ife/ife.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/ife/ife.c
+++ b/net/ife/ife.c
@@ -69,6 +69,9 @@ void *ife_decode(struct sk_buff *skb, u1
 	int total_pull;
 	u16 ifehdrln;
 
+	if (!pskb_may_pull(skb, skb->dev->hard_header_len + IFE_METAHDRLEN))
+		return NULL;
+
 	ifehdr = (struct ifeheadr *) (skb->data + skb->dev->hard_header_len);
 	ifehdrln = ntohs(ifehdr->metalen);
 	total_pull = skb->dev->hard_header_len + ifehdrln;
