Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqFVDFC6b0hivSAOo72oglrym257avWtJW+4kWFesDOMstcSi1WWAZUxhR0XoAb8T9kE7jM
ARC-Seal: i=1; a=rsa-sha256; t=1524837594; cv=none;
        d=google.com; s=arc-20160816;
        b=AtmR/Vx0gQGHcieS+8jP4bbTWxTN93nmAdj+hRTsW2wBfdwkkeQF/4Lx3+vCj1QnZv
         A+BNbRkYhpDdqlUjOfEDe8NdAH1inTq6j9oLAxlL98UDjrRtDjOqCUBxFQe5W1VAjOYO
         qjwpUxkZfLnRi7u+lHeEsfrpy3Or9ngrrEGWerFCGupvtd8rH5bMF0D8g770y2hsYbww
         RH2QlXGKN0CEksqZoSJxBEqnCwoxHD/HBv79Oa6ovKH1sOQKdS3xzmeV2BdQI98SsVmK
         XZumlJUT2PUGP6dZ+Uc6aNL3f5fAXguCQt+8bJQTY9aCR0122+HlLpAmNo5sR/8Er3DM
         rDyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=cFGWUCURNKAp03+E8GJdCkA5QhI01bTC5XaOHuwErJY=;
        b=FFYlgReN/kBw20RBJfgSXq0BhKLOgNoDtW+4g2DNitZraEZo9e4LOXV9jcm+4c79UG
         tDj1mAXHjzha0DuUousCgIE5Er6k5cqjMg6lP0SRH0ujUAdsgaNIkkJcJpAMYxwleN1J
         yN0FpybTgXFsHPpKLZXyBVUZIRdPpInzCm/sLsqA5ZPYg8jgVcGzari4tWrRf857Zi9y
         NVRC5QWiNUJqa6/foe1ITgel0D+G6EPgc0FbnDHsqvGX+7r07WgxAkrijFJN4YMN/77L
         RwY0uGASxUPsV07LqL+i7OdlvedXHJ9b0A7ZexV6g1AKUk43fv3zIoff74NZBk6gM5Pg
         e5lg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A99E721890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 17/24] llc: fix NULL pointer deref for SOCK_ZAPPED
Date: Fri, 27 Apr 2018 15:57:52 +0200
Message-Id: <20180427135632.293874446@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135631.584839868@linuxfoundation.org>
References: <20180427135631.584839868@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908105270702201?=
X-GMAIL-MSGID: =?utf-8?q?1598908105270702201?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>


[ Upstream commit 3a04ce7130a7e5dad4e78d45d50313747f8c830f ]

For SOCK_ZAPPED socket, we don't need to care about llc->sap,
so we should just skip these refcount functions in this case.

Fixes: f7e43672683b ("llc: hold llc_sap before release_sock()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/llc/af_llc.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -187,7 +187,6 @@ static int llc_ui_release(struct socket
 {
 	struct sock *sk = sock->sk;
 	struct llc_sock *llc;
-	struct llc_sap *sap;
 
 	if (unlikely(sk == NULL))
 		goto out;
@@ -198,15 +197,19 @@ static int llc_ui_release(struct socket
 		llc->laddr.lsap, llc->daddr.lsap);
 	if (!llc_send_disc(sk))
 		llc_ui_wait_for_disc(sk, sk->sk_rcvtimeo);
-	sap = llc->sap;
-	/* Hold this for release_sock(), so that llc_backlog_rcv() could still
-	 * use it.
-	 */
-	llc_sap_hold(sap);
-	if (!sock_flag(sk, SOCK_ZAPPED))
+	if (!sock_flag(sk, SOCK_ZAPPED)) {
+		struct llc_sap *sap = llc->sap;
+
+		/* Hold this for release_sock(), so that llc_backlog_rcv()
+		 * could still use it.
+		 */
+		llc_sap_hold(sap);
 		llc_sap_remove_socket(llc->sap, sk);
-	release_sock(sk);
-	llc_sap_put(sap);
+		release_sock(sk);
+		llc_sap_put(sap);
+	} else {
+		release_sock(sk);
+	}
 	if (llc->dev)
 		dev_put(llc->dev);
 	sock_put(sk);
