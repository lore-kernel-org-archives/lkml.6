Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp1itXeR2aZYxMsEGonPfkJ0BSSGNAsKe6HZaUEETbfhm6YSFqXypnaXaKdEgfGDxJaEtrv
ARC-Seal: i=1; a=rsa-sha256; t=1524837900; cv=none;
        d=google.com; s=arc-20160816;
        b=jrzxPYEgBSI8y5AYCzm5vzg/c6eLCCfSski9Nqfafve9tbMGhQ1bmtY/Hzio2uTxnU
         Ke6/0NNrR/IaKiEUEQF4Xca7wAY7JJ3fSV2me5OcQQqXpfW0x5P3PcZJGANBglx8717M
         XODcFjEBdgIwipJw4Z8Agpst2aeYQi0hX050K0nn5xs94uaBDRyCxJgt+fVlPL36xnhP
         P1EsVwm9NOuNPD54XBrMtTYEKAxzym6oXeqpiF+X8fNyi8coC1yHmw4PIeSfzSEJZfAx
         BnYsM4GwKf4a49HMGgrD9hZj8+WXWIPmKLFTpdo8B1yrFSFy4ECR9w7QyZVTAFSEh85L
         repQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=NAp3HKAtprDxdFqZdKoRA+dYFIWT+4ZO28cfNIjw5DA=;
        b=O3zvU2KlrQ0ZLDZsd1DcdaetE7wzaScpZ4QK53A4tkjr36Mlrm1ueY7lgV2Tuxn//a
         OqnK4w5oBuzmw7A6QbUkmwVbzZyqAwG+jlOawLqQcjmsc909EYagqiMeO9XWu1yNYZvC
         Pap71xFhqCv0+gRFdGZAyrkGTRBQRwnUaDo+Ab3WdzwwwvmJaMfexRVB2CL940kav88r
         hcho8gjthvNYocM9ZVYsUJX7eTiWwUGwpS2mwYJOzYshun1hHrhlWYLY1UCaNMLeBI62
         PhSD4muPOWn0k8x3YGwEuOkXWCMnaW0j3YwUJpSv38g37HzP97ue6ApTNsW5SgpDBVqU
         TBeA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0511C21892
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
Subject: [PATCH 4.9 60/74] net: sched: ife: signal not finding metaid
Date: Fri, 27 Apr 2018 15:58:50 +0200
Message-Id: <20180427135712.430630779@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908426646306967?=
X-GMAIL-MSGID: =?utf-8?q?1598908426646306967?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Aring <aring@mojatatu.com>


[ Upstream commit f6cd14537ff9919081be19b9c53b9b19c0d3ea97 ]

We need to record stats for received metadata that we dont know how
to process. Have find_decode_metaid() return -ENOENT to capture this.

Signed-off-by: Alexander Aring <aring@mojatatu.com>
Reviewed-by: Yotam Gigi <yotam.gi@gmail.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_ife.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -634,7 +634,7 @@ int find_decode_metaid(struct sk_buff *s
 		}
 	}
 
-	return 0;
+	return -ENOENT;
 }
 
 struct ifeheadr {
