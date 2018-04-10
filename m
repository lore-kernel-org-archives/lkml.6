Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/kIdXEFJATI9/j4FkwP2zUTcv+L6/2Ck3X5G2AH3MQoYbWiO0Cnk7kExhj4pAhvi1gMufl
ARC-Seal: i=1; a=rsa-sha256; t=1523399377; cv=none;
        d=google.com; s=arc-20160816;
        b=EmdjxRhHwSbWzR6z75Dj/9nSfgzBPQJE00iUNsB904hPIjrdwiQ1JBVqbQVPvD9d9v
         3dyIVtJpLFg5A95yJ55V01Z5PGVSgdUWqJPiLk4GPeC9Lb6QZBHOI+T7Co4OWBVskYvB
         HI706Wj1iHHJmltXuXnKAmvN8CeYwjTn/L8ZHM9iCLhe+T05pxg7I4ieafsl8djhbru2
         ZnW7Zag2+3DKWCm233mDeyKnY1PO8HFv+aMI6hF2L3bcMWp2k5BG20XzvIOJ4Kcpi2fn
         yyTzGSIAVg4fF0aWMTUq2amJ8oxQLmm98XrYIN97Wa/JJlYEr7CUcAmfiOJYurE4uTfu
         QHMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GPV9gNGXYoYQt682c9qExkSZIqGzn8tootpIHD5bn/o=;
        b=y/BnnRkBoR6h6OLLRb7oDx1FQo7LiacTLxTUc2972JoNtO44XV+AoihhXFN9ShnkW8
         MJEN+fniaGl2e8ldIoRXKkTtjNPeD/8NZED672G7uXJWpumfuJ6OjNZSAfihMu2Eslar
         aR1l2pHBPq5K2/7/xdFQnmvJqCcQ8LoCgDqVBiLrzt7I2jhkfdVRt6+GctDEK39SRTlz
         ZP8Cj8ngQC/WdjbxSX/vU5zVskPTd3357il2iHQlJ/DVvu3akz+hTV9TG6by2HPmKqDu
         pt7ztfj04QXQ5Df3YCuPzyjIQTm1b81yS51ITHL92rk37kbN0wMvc/aQyC/f60qEZ0fh
         fXsw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-edac <linux-edac@vger.kernel.org>,
	Borislav Petkov <bp@suse.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 085/168] EDAC, mv64x60: Fix an error handling path
Date: Wed, 11 Apr 2018 00:23:47 +0200
Message-Id: <20180410212803.880324905@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400025524274247?=
X-GMAIL-MSGID: =?utf-8?q?1597400025524274247?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


[ Upstream commit 68fa24f9121c04ef146b5158f538c8b32f285be5 ]

We should not call edac_mc_del_mc() if a corresponding call to
edac_mc_add_mc() has not been performed yet.

So here, we should go to err instead of err2 to branch at the right
place of the error handling path.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/20180107205400.14068-1-christophe.jaillet@wanadoo.fr
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/edac/mv64x60_edac.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/edac/mv64x60_edac.c
+++ b/drivers/edac/mv64x60_edac.c
@@ -758,7 +758,7 @@ static int mv64x60_mc_err_probe(struct p
 		/* Non-ECC RAM? */
 		printk(KERN_WARNING "%s: No ECC DIMMs discovered\n", __func__);
 		res = -ENODEV;
-		goto err2;
+		goto err;
 	}
 
 	edac_dbg(3, "init mci\n");
