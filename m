Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227tmXj90gWBnmlsH0pLYLevnN3/GVehxQsS8uVo9iN2Mwj1o1rrb3clVPJnfssCAFuMG7Ts
ARC-Seal: i=1; a=rsa-sha256; t=1518708934; cv=none;
        d=google.com; s=arc-20160816;
        b=ThKNRNKqkw+kAaoENh/ZgQKTzwKAdaR8zl+qlV2Hpl5vWqCcwkMv7xSIe6/Kq4xyv/
         TaVQ4jW6nMzJDoEnoQ/QJzsEaKMDnooylc62KQnHV9BBGpj9bTIr/GQQam5IBMDO4MMH
         lLSeYLHpsdLe3RAWSnMC6WE4H9+wWGHGH/3a0FT3X0Pl1DX7XGhMdlSqek3GiSLNjYUR
         fJFS66DLojhfnWYNiLZrNckMO43zyIol1/hVdlysaX97DeV2FEptWhIZgb4dYx8UvYAg
         K3tnDkabCKL0dfmkxDjvZpwjaCsmtlYqZyi+ULRRVA0m2uUsritQ81XOtNpZHuMv4z3P
         ycdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XhVdhJrJshlQslUkZpvEyozgYI0BZSJbQwEKWzYdAFM=;
        b=hyzPYv5PGQHhAy0mlQcSnF8wtKkmatEQIukqjVUy7y+fan4quUP/tvA+pyFlLYh7/S
         qRoQlfdDow6Oljx3qFNV84tTRGwAYno3/hkR66olP4EGW7ZUe/n3pxi4z7FCV2wKAhEl
         ywiL8RI0x5CldxEmclAeqI8ETMkb4WpzR6g8X6sHCQEXeDwQZQCGIiklxH19F16s9aX0
         K2PnvO8ZXz2bhdu9j7rIz48aGl534TlQ4KSTO1EC9vHBG2cJkUfZzW0FBdaUPmLntITt
         g5UdcGgr7mnrPDdMEBr3MLkg7VEs0eo3h5Kj741Uzvh2qIp+zvSpFP9v+DqhuZOnA6J2
         SR8A==
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
Subject: [PATCH 4.14 133/195] crypto: caam - fix endless loop when DECO acquire fails
Date: Thu, 15 Feb 2018 16:17:04 +0100
Message-Id: <20180215151712.419038767@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480744127321065?=
X-GMAIL-MSGID: =?utf-8?q?1592481739974970721?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
