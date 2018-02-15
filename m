Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224lQJPO2ciWW+LUEPp0SkQ92N4uHXcQc9V/BrbMO3vknflerJI9KN9jcO2KmXK5GBp9H3Y7
ARC-Seal: i=1; a=rsa-sha256; t=1518707985; cv=none;
        d=google.com; s=arc-20160816;
        b=jqyYpdwdOH8ZB7S1afr7VcmBdZHv0k42lRovtSohLPrXLnEbTygOMHTVzOfy9BN4cb
         YOzyFBB+p2JanXDLngGsNbaZVYhQo91mOZa3xrtpD8KN+dpPVc5QMRMjLTmk5uPNmm9c
         g05PAFdF4U3/IIgxOkiJvTTgL8wSukI3AOJMm0heQdNvmCpYEyceLev/fopam69aF8In
         DrzZ9XaXKR+Cwr4ASCLpIkpxBd0hgIc8nJSEKaEiHuY7lY/OuT/1zxxBvyYTRmrUA60J
         2FRn4Ke66Apcu2/LgXe+S0vrtV53zbfx2dVMlDU1/RQRGX5HId56Fjv175CosJJ+GTzn
         jsEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KSnLaeIYVJt0grlyMt7MuXkgRkpnUZ18Nt3zSGQDD8M=;
        b=OdabHWT0EoiSlRMxDUJzFwpD7zbsyjhkhZJ9wEKJwWkiPr20+5wu+laE0dpOSvDBM/
         VnoC9wBAkwqGU2cj3r84G+CE+JR7Uk0AIqKM9MrT3Xa+nSzgJOZywYSYaYRsiYSJcZN+
         +7qZ+oouH65V6RnfkrUFxxtjQSz2yYRDvFbCT2gqrRoJnfInir5uV0Kp4UnJHdqgbQja
         0dM83y015A44PlLxkXX8xCj/0wSzkwRzyYLiVrpM7BfTaxYIGB0Rc99xXaHf5HUowu2L
         RfYvYpVrlVYAd326z0Gb57xERt0O1cnmTtva1eJ/LYwdwgfbrlHekIqRGnV8PO8LXFRU
         aBHA==
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
Subject: [PATCH 3.18 33/45] crypto: caam - fix endless loop when DECO acquire fails
Date: Thu, 15 Feb 2018 16:17:24 +0100
Message-Id: <20180215144122.975431197@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480744127321065?=
X-GMAIL-MSGID: =?utf-8?q?1592480744127321065?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -209,12 +209,16 @@ static int instantiate_rng(struct device
 		 * without any error (HW optimizations for later
 		 * CAAM eras), then try again.
 		 */
+		if (ret)
+			break;
+
 		rdsta_val =
 			rd_reg32(&ctrl->r4tst[0].rdsta) & RDSTA_IFMASK;
-		if (status || !(rdsta_val & (1 << sh_idx)))
+		if (status || !(rdsta_val & (1 << sh_idx))) {
 			ret = -EAGAIN;
-		if (ret)
 			break;
+		}
+
 		dev_info(ctrldev, "Instantiated RNG4 SH%d\n", sh_idx);
 		/* Clear the contents before recreating the descriptor */
 		memset(desc, 0x00, CAAM_CMD_SZ * 7);
