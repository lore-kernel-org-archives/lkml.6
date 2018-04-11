Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48zXBLREILxbzxucPUudw33pzXUPcMseArMijDRv1nhj+eqYQbo2wrJBRsPzn7lK9QiJNoQ
ARC-Seal: i=1; a=rsa-sha256; t=1523473480; cv=none;
        d=google.com; s=arc-20160816;
        b=gGDx92kIaY0GZOehP7jWYl4LmCCUaHSAzCrffIuln9PHJFf6AE+liWoJkfuMbd9APr
         kKxGDimuepOzhc1xSS1CiAJ9w8Xsln4NCXMO5v86f+dk3vBFs32GtRpW/NPJ/eKCBmfg
         OjYuPh7+R0DFg3RUIxkDBjt2uOR1c2xk7K/CP03UQb3F/kkUILPGQsyDEuk6HTtoWb8w
         Lb5fbl2vyKd2WEyDslYmYOTCJQ8NpO+jazvdfPD5273NvNlzVpjsHvBW829f7Zbl7nOY
         yyV1OTpkWlVZX5gTyFQn99y467uHoKB981M1POtd6fdBGdiqqli6z6MwMYpTotn9IpZQ
         F9KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=c5mrnJ94P3NLeSTi4ZxayKKmkPFUvioEbhWSVFRkvj0=;
        b=Re5EXM626zN5U1iC05xXaUD1/BY1UtP9fw1tfatylLNkmtyrizevB+nicLprpKAJcE
         jk9acv/b8YvQn3zH0VANY9ZxS4Izgjo4xAlis85tMXRaMyNzzSXByKZszKfMrzrOVYjY
         GjKahwrEdd8uDsGdcrFcgu5CKXBkB8YrUoOp7hwW0/IG+cEXdCkpBW/FcxFg/pHk8ECw
         /nLygINo4uz5Xx99f7NoH5+wc9tk2sMfZEF+SCOpC2lijNn2uvTpv5ylzL9I6qYvJqZN
         FWg664zHf7V2NABT7SzNGL6OL8bhEeGyWLHFZRmGWRtWw5r4BbddndohXnq5IQl1/0SK
         ae+Q==
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
Subject: [PATCH 4.9 264/310] EDAC, mv64x60: Fix an error handling path
Date: Wed, 11 Apr 2018 20:36:43 +0200
Message-Id: <20180411183634.020982805@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476306178591836?=
X-GMAIL-MSGID: =?utf-8?q?1597477728209581670?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -759,7 +759,7 @@ static int mv64x60_mc_err_probe(struct p
 		/* Non-ECC RAM? */
 		printk(KERN_WARNING "%s: No ECC DIMMs discovered\n", __func__);
 		res = -ENODEV;
-		goto err2;
+		goto err;
 	}
 
 	edac_dbg(3, "init mci\n");
