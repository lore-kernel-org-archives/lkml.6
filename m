Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226KxsSRmeYKB6pH7uTvgH3IX28oVYLIlEhHmyRlQ4QAxfM2P/DpnZsP852lvSwGGHWF4d/5
ARC-Seal: i=1; a=rsa-sha256; t=1518709541; cv=none;
        d=google.com; s=arc-20160816;
        b=AyHIWLXQPj7B8qgw7memx6TtpxBqOpe716AJvS+rytxYSIRFRTGPiU9+qtpkUOqr8h
         zRDMozKu25Uig2dklX1xwt6hPYE2vPN8Skus+TE/NawLmfc65BBEKrMAwVjZZ2Qq4tZ4
         JDYfzxyf4Gt8qtWSbev8xCuI08q1tL4U4R+OS+uSpJKu0rsp0hWjpPVu+lnmgy0nOlWC
         oOS4gTOotrLzKDp8A4AiBxdG9QJFYdYjlxTa/HfW95+65PvzZKlDGAxiO0rZxN1l+uLX
         J2xo8qaFzZ1MktjC04g4TEHa/vmlgzTTrBh8woE7WvrDscYp33Mek71Evv5Pq70ebVhY
         bnvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zQKzpzI8Pw/YSD5LjhIcw4DcXShDTd6B7dizkQojYFo=;
        b=mbM9/xFZi+R4xGu53uVmXX6sJD6VIN0LKaEdr9Mf5OhzdKncY7HYgmVCgyjIU0z5y4
         tZHlson8w+BYZT5VJb0k6Cm1wK8jJPfTzutRZ9jPA2GUl8lOWxf0Vu2YWt9W7ILnGwhJ
         e4fkDT0XrX26QzOZvkThWD6VbMHe3syH/VqanCdPt3BXV2qFjwJ7c4v9jFtPf5Vlokeb
         jMYQ3DmrwtBiA9GXGkMCFVw5L+cqwBwYrUGZkaiQ/UREJ+By64Qz1kcz3XZgi9wP/sC8
         RuYoTJ5c/mga+NNCLiAJu2WQkybhSV/fcV59DSzZ/1wgvA+2x9RGXGoIMNaW8h+UUDZi
         zsDQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bryan ODonoghue <pure.logic@nexus-software.ie>,
	Auer Lukas <lukas.auer@aisec.fraunhofer.de>,
	=?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.15 127/202] crypto: caam - fix endless loop when DECO acquire fails
Date: Thu, 15 Feb 2018 16:17:07 +0100
Message-Id: <20180215151719.860775458@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480744127321065?=
X-GMAIL-MSGID: =?utf-8?q?1592482376580369469?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Horia Geantă <horia.geanta@nxp.com>

commit 225ece3e7dad4cfc44cca38ce7a3a80f255ea8f1 upstream.

In case DECO0 cannot be acquired - i.e. run_descriptor_deco0() fails
with -ENODEV, caam_probe() enters an endless loop:

run_descriptor_deco0
	ret -ENODEV
	-> instantiate_rng
		-ENODEV, overwritten by -EAGAIN
		ret -EAGAIN
		-> caam_probe
			-EAGAIN results in endless loop

It turns out the error path in instantiate_rng() is incorrect,
the checks are done in the wrong order.

Fixes: 1005bccd7a4a6 ("crypto: caam - enable instantiation of all RNG4 state handles")
Reported-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Suggested-by: Auer Lukas <lukas.auer@aisec.fraunhofer.de>
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/caam/ctrl.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -228,12 +228,16 @@ static int instantiate_rng(struct device
 		 * without any error (HW optimizations for later
 		 * CAAM eras), then try again.
 		 */
+		if (ret)
+			break;
+
 		rdsta_val = rd_reg32(&ctrl->r4tst[0].rdsta) & RDSTA_IFMASK;
 		if ((status && status != JRSTA_SSRC_JUMP_HALT_CC) ||
-		    !(rdsta_val & (1 << sh_idx)))
+		    !(rdsta_val & (1 << sh_idx))) {
 			ret = -EAGAIN;
-		if (ret)
 			break;
+		}
+
 		dev_info(ctrldev, "Instantiated RNG4 SH%d\n", sh_idx);
 		/* Clear the contents before recreating the descriptor */
 		memset(desc, 0x00, CAAM_CMD_SZ * 7);
