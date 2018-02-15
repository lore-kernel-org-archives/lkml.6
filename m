Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224Azlg94fpTAlVN59H6qEsmwRbFgy+2FXvbbvxZVx8bUTGF20PZJ3ul/yf0tcBTFL0WdF4m
ARC-Seal: i=1; a=rsa-sha256; t=1518708389; cv=none;
        d=google.com; s=arc-20160816;
        b=bpUV8sOgFCjdCvRc5m3XUxTvPdL8qCLHk9tgDdiTLQdjAm+vWpk9qFgtdW6ijlhU62
         RrNKAUZpIPdvLVWbuvmFv7ls0tiItjifLK87hmWsqY2wvcWkyFc3j2iGoEn7nTjX2A2O
         AZjf9wtSYFUjjDGM+T5Da+Qw4/cOoD5OQddyg+B3piy2M7W7kK+4+kV7acsk05R1cnO+
         oZoSg8oxgoPk7bFtJZyrgKfvGbdI2Y1jQ7JIALeNbtPwRNDRsDeLPa8cs/jx2TH+8LZK
         HJwSkf6TRo1XmaWFMe9LFp1dL43JxY240z7NjZoK3A/liP1hIPZPSu1isPF8wGh7DnsX
         nA0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=H7EOt1s0WfO4KMmSnjLQSpeGmaeM088SEMMKRSjBjTQ=;
        b=j6g+/73vtrWO+Rpf9iw9t61K3jr7yxGhLZ9v5pS/0fiZiZfbsC2oPzBYwlispoR8be
         97PZQGEzi7ARqXvMymaNkHS2EzCy+hZ/nNzRrE30iEsi6NjN2X0EUofem92A6EdSfSCW
         c0wN43iDHyt0ro1osK9V6xsmNbU6/SHaPp24R0L01vYvuQ5sf1PO+MHXgP+OSG9KlM3C
         ahUmhZsA1yxM6DLp+ll81rUp0KNu6alULzWYNuEivEYCriNbBmJxJvQlVbi1vLAjIlpP
         qqrq9XpNK9DNaoB4X3V31vyd1qpm4R25mE2N5TGhgTB6yqKH+I6CKRDcvSqDf4VNZEy+
         CLtg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Miquel Raynal <miquel.raynal@free-electrons.com>
Subject: [PATCH 4.9 18/88] mtd: nand: sunxi: Fix ECC strength choice
Date: Thu, 15 Feb 2018 16:16:45 +0100
Message-Id: <20180215151225.271964778@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481054802877681?=
X-GMAIL-MSGID: =?utf-8?q?1592481168621102573?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miquel Raynal <miquel.raynal@free-electrons.com>

commit f4c6cd1a7f2275d5bc0e494b21fff26f8dde80f0 upstream.

When the requested ECC strength does not exactly match the strengths
supported by the ECC engine, the driver is selecting the closest
strength meeting the 'selected_strength > requested_strength'
constraint. Fix the fact that, in this particular case, ecc->strength
value was not updated to match the 'selected_strength'.

For instance, one can encounter this issue when no ECC requirement is
filled in the device tree while the NAND chip minimum requirement is not
a strength/step_size combo natively supported by the ECC engine.

Fixes: 1fef62c1423b ("mtd: nand: add sunxi NAND flash controller support")
Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/sunxi_nand.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -1835,8 +1835,14 @@ static int sunxi_nand_hw_common_ecc_ctrl
 
 	/* Add ECC info retrieval from DT */
 	for (i = 0; i < ARRAY_SIZE(strengths); i++) {
-		if (ecc->strength <= strengths[i])
+		if (ecc->strength <= strengths[i]) {
+			/*
+			 * Update ecc->strength value with the actual strength
+			 * that will be used by the ECC engine.
+			 */
+			ecc->strength = strengths[i];
 			break;
+		}
 	}
 
 	if (i >= ARRAY_SIZE(strengths)) {
