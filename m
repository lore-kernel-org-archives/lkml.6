Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49r947LezqsQFkoLpKCg0H9OkHI1D2hlfGVlBApCLe/OPJfg73E/AzpsPrcXQYpxsOyicxt
ARC-Seal: i=1; a=rsa-sha256; t=1522346511; cv=none;
        d=google.com; s=arc-20160816;
        b=NLgQTb+nIbv4ETFYMFcHd+UOo3c8v7eXFzjzfD77GP1Fxmangl6XQBlZuoCOF5SGiB
         lq5JYDb6wqmiqnbw9Ntz3hIEWP9TGsw10vtyYYI9DLjmgS2wTxjhtAQhgNnwR68k3X+L
         IF7Lr78BwIjFDwm7Kw2+5c3I0ScBwpNg1gnNykjDGW2h0OrLWc1inyUbjNIg0NLAyig7
         7h34AEgqb6wlOyv/skiXPlUBwN75/FIGBqmFaFrZXvq6SmXoFnQhztBvjBBNwE7/HNGu
         FIAYwSAA56Hznv89Zlu7UkvoGrOlQpwIfwiNJZ+QldF4SeAX8aGvYEE5eax/p9l/SQrN
         rrjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=s7qLJS17Ca3n/rG4ttHNviA0QBjzc6ivZ58WmgYOkSg=;
        b=Ov/nI4lNRguPXdqm6n3uLnhmbL6mEis13BuX5AeWRZalsUS53YD5p/vVyytvDstTZh
         oQM+Pboce4VwuhZFCohmlA6Y5uZKtwRFnN+hOk5/WKsAVzbPIjLphU8aJn1pJmf2aVfP
         RfU1Z51ScgAmVIasTRLwoqniNsWtBZoU7FV/51fpjfcW3XbsaZAb3QgPQ+31lhas+1KQ
         Inu1IVA5BkHd7awKY029JQWKWccEhd5C0CHIfmXkERjlm5ntSIL2BCnXFSSMb7ctyTnI
         CPx8s5d0vgdppOin3VT9hKiRIe/6nxIVNF3AFZJpVXf3S3wKVDxiBca1Z8heioW1Xsyt
         5EKg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michal Kalderon <Michal.Kalderon@cavium.com>,
	Ariel Elior <Ariel.Elior@cavium.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 03/47] qed: Fix MPA unalign flow in case header is split across two packets.
Date: Thu, 29 Mar 2018 19:59:44 +0200
Message-Id: <20180329175729.415925739@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296015582016535?=
X-GMAIL-MSGID: =?utf-8?q?1596296015582016535?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Kalderon <Michal.Kalderon@cavium.com>


[ Upstream commit 933e8c91b9f5a2f504f6da1f069c410449b9f4b9 ]

There is a corner case in the MPA unalign flow where a FPDU header is
split over two tcp segments. The length of the first fragment in this
case was not initialized properly and should be '1'

Fixes: c7d1d839 ("qed: Add support for MPA header being split over two tcp packets")

Signed-off-by: Michal Kalderon <Michal.Kalderon@cavium.com>
Signed-off-by: Ariel Elior <Ariel.Elior@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qed/qed_iwarp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
@@ -1906,8 +1906,8 @@ qed_iwarp_update_fpdu_length(struct qed_
 		/* Missing lower byte is now available */
 		mpa_len = fpdu->fpdu_length | *mpa_data;
 		fpdu->fpdu_length = QED_IWARP_FPDU_LEN_WITH_PAD(mpa_len);
-		fpdu->mpa_frag_len = fpdu->fpdu_length;
 		/* one byte of hdr */
+		fpdu->mpa_frag_len = 1;
 		fpdu->incomplete_bytes = fpdu->fpdu_length - 1;
 		DP_VERBOSE(p_hwfn,
 			   QED_MSG_RDMA,
