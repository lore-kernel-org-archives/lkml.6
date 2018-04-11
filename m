Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/QZ8eSnXIfySmpXi03Qt9PKa8iFxnfx3e8Wlmu4ngprpES18nYt7OtFnAxxOwYITURn3nI
ARC-Seal: i=1; a=rsa-sha256; t=1523473280; cv=none;
        d=google.com; s=arc-20160816;
        b=QAQKDNY0dg5rPDOLnisjYJcqN5NPVMnT33YOctFwmvk13YnZifHi7ZzPF7OxfTEFnc
         93dLjodmgMRr46TkoX28HvFhph9tQHvASG3LS5Y31ue1fX7oli0GAZkRWz3jNEh7IUWy
         IEOoJvkLgKiMyxxDmxzoR99Vu/Ee0n/GvbLC+7VjJb/B9ENj2XfoL22n0txo9Wf6RSXk
         nKhAP+bQGMKkRvbyISWf9plP0BKyM8LE7ose1dcidGVW8X2ojFednXToUxUz1MrNJ+fK
         zL6fR/O0ttOV3A1RYUGgHdmQpjFY7lDGplWmahZrKdtv1r4d0PfHYn4q3R6yfU0+KKnW
         1xdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JK748M8XVyn2qwqBywLLqlAFsfpat+KtBhnJ7KfUE9c=;
        b=gW989zFawNeuhh6hagfXHeB+1bnrufrXD6JMoxTrb7rHDyik2XVXMV7fdNxDfeO/kU
         tM83jkgHF/QS+4oRNSXnKaheT6qtlD1vAmew8T8czflHwJXHKZn7U2jWNN0z+anZ/Kl4
         06tOSc08Y87d2etdP9BO1MELLinzapfSNT8O1kkuV2dckYAgDXl13sLbjSgKX3w81jGK
         TWumlr3vTm4TsCm9YJcUgC4B1BVnDBDVX/WbWv07GaC+ZjSu/FfxtG4MDtLkRnAxPgOT
         r/52un/+sq3nlptOr7TC8cWDJwjm3aixxHmTaaPjf/35MGBD4N3zPhpSmz1AsUveLG7A
         Fcfg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 191/310] macsec: check return value of skb_to_sgvec always
Date: Wed, 11 Apr 2018 20:35:30 +0200
Message-Id: <20180411183630.815104577@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477518884175245?=
X-GMAIL-MSGID: =?utf-8?q?1597477518884175245?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Jason A. Donenfeld" <Jason@zx2c4.com>


[ Upstream commit cda7ea6903502af34015000e16be290a79f07638 ]

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/macsec.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -742,7 +742,12 @@ static struct sk_buff *macsec_encrypt(st
 	macsec_fill_iv(iv, secy->sci, pn);
 
 	sg_init_table(sg, ret);
-	skb_to_sgvec(skb, sg, 0, skb->len);
+	ret = skb_to_sgvec(skb, sg, 0, skb->len);
+	if (unlikely(ret < 0)) {
+		macsec_txsa_put(tx_sa);
+		kfree_skb(skb);
+		return ERR_PTR(ret);
+	}
 
 	if (tx_sc->encrypt) {
 		int len = skb->len - macsec_hdr_len(sci_present) -
@@ -949,7 +954,11 @@ static struct sk_buff *macsec_decrypt(st
 	macsec_fill_iv(iv, sci, ntohl(hdr->packet_number));
 
 	sg_init_table(sg, ret);
-	skb_to_sgvec(skb, sg, 0, skb->len);
+	ret = skb_to_sgvec(skb, sg, 0, skb->len);
+	if (unlikely(ret < 0)) {
+		kfree_skb(skb);
+		return ERR_PTR(ret);
+	}
 
 	if (hdr->tci_an & MACSEC_TCI_E) {
 		/* confidentiality: ethernet + macsec header
