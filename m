Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2259XKBegMpHhlunEwdOqtnDwKQ669asO5SJfAREe4UK3UJqMGIHJSB5zeQr8nFQP5F2rtEJ
ARC-Seal: i=1; a=rsa-sha256; t=1518708259; cv=none;
        d=google.com; s=arc-20160816;
        b=lj9BTLPWHtmo4QxHxYZ8jMy7LTHNX/t7PkDlYcdnaimMmB+nG3jGaElj0Qdqw/CyrX
         wWm9FinEZEeSopf9UutZiG2kV6/hqTNb456wVWuWJFxsO0Xm9frH2L1qKW7hMVk/FCQe
         32Ckfa/VB4hkEhSaryOp+BBV3JrNAALIbamIwArWZ07+0FpIMIt+QruSQTLKmlRyHjN8
         /ffe9aLaWokfNzKnsAc43a4NYpWDk6uIXBT1z3o7nenV/J8+0sI8PUTvuTpOfPFAfrBM
         hEwtkqRY1Fnx6r/6YesFjmQseyn36bEF0jxgjGltoq9Ak5h+1ihI9bC375HJgbsAJ8aJ
         R8GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EzsN3BEP9B9gwHxSjOUfD7P8c6oZV0UFwue1npDTATY=;
        b=gC8qR11RrCHxNGxMKVzTfkvTAwzrZEWgAe8Agq2nZaAfj2Qke/3hmvW9J0nFr053pn
         mD6QjHyG4AAM5SudeMQN7hfESk9dQPWc6bdaYN7XkShXfYMZUwZQccce1bmjzlNajPTk
         lXn8IU6T5jX6lPHIbD7HZJbMK1DBhhTm4CRdfqtJPkU85VX0xaUCexQGHJ5VYKDXge3U
         v5bg8u+ibGdg7AXHBELT3TfbRaz6HxPmPbq+dy2MJMbe+w7ZRztiZxW67M/aqW1KrgyU
         WPBIZG8qmkmbA/BN/SgEI3qV5m2FtMXTsmcsFEkQ6UkHoQ90Yn0nlYaMKdHrgkEFRilZ
         v4Qg==
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
Subject: [PATCH 4.4 085/108] crypto: caam - fix endless loop when DECO acquire fails
Date: Thu, 15 Feb 2018 16:17:22 +0100
Message-Id: <20180215151234.199881431@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480744127321065?=
X-GMAIL-MSGID: =?utf-8?q?1592481031909868403?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -224,12 +224,16 @@ static int instantiate_rng(struct device
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
