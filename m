Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227PgQZSYwYjQMEKZeoH3toxjVnuAy8UKMA3xVRLMTeBA/ixetXvuTfyWyQUdNGWgC+JxZC7
ARC-Seal: i=1; a=rsa-sha256; t=1518708460; cv=none;
        d=google.com; s=arc-20160816;
        b=ztGw7AGU4LDx/lLpszWc7NMeKsXS/fWscD22H4w5wcy1Hx9Ydt6J9yBFYC0Hz5XRJ2
         66wnRuT9pOfacf54LRIi8mkrNHlu/bbjXlG1zivnd3r/Oy2iWVeSEa4YfVzDEgjhyCHL
         N1zrUYpDG7G4jNKHH9q5juETQVsSHSIlz2TMvwOwzF7qU3BjtyG5AChpMgYGxz3G8P49
         5XzF0f2KQHX2rLRLnnyAuB4L2oHVQVpmOrU1x6nMEBtUV/74j72SlupaxYZfrw4xE43/
         u5KZq+j2a57a7XnpZ6regjCXhniffNqjhS8NtlDa89JCiuK6C/utN9RV4Yqy26reyGK3
         kOVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=K0IuQ8pW5OgnxDQdspqNWUd0UZJoDlmlAF308CkA7F8=;
        b=gRBFzGxCLiuoz7Hr6p2+bka/Vy8GZ19L+r6+QXxDJO/Swy+yCQN0Yn/2xvG99SZy90
         8qbfTOC8nTKWCvr/TYiUFphO07JAe0BAoZ0ihxejbyMWf2UJMNPJzV+E3Rvqw4wlPWQc
         qJliGz8dekFFaa9BE85mip2czgvvgkDHMFvmXtIbj0kNdKjSSQ+kFBvzRHJPvpafpqU0
         oVl8CP040mbbYQMHcxnEiGmadwaCtn51/CZyXgzy6mRrs0Im9pIVsaWixdxeorQ0bDaZ
         5eWY4mXg0R+m2dCShwA/9qOvcGA5GmBivUSqn+YmucUOskSxk6kqj8hJTPaqujvwg9fx
         isgg==
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
Subject: [PATCH 4.9 49/88] crypto: caam - fix endless loop when DECO acquire fails
Date: Thu, 15 Feb 2018 16:17:16 +0100
Message-Id: <20180215151229.522109346@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480744127321065?=
X-GMAIL-MSGID: =?utf-8?q?1592481242883561759?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
