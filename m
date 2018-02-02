Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225wfCF7X0Mo46VS6fID1xzJh4AZrO6A87mzqdPYlO3+EFjXxNR1TG+9lRnoxDSDWBp9XLOr
ARC-Seal: i=1; a=rsa-sha256; t=1517591742; cv=none;
        d=google.com; s=arc-20160816;
        b=xhhcRpa4Qopsj7M01j47LDVqlfbhM1NWKRog9oWHOXikYVAQUZebOpWvBlZ+o90wPd
         xwB/+ySbAVo2aMChd7nlJoohOMhWDxEx62Jpt5Y4a3VmVaDALTWh6wD7CEoZ60iXebVY
         tXAE9JDZxlhxn4xg6LmGi6pgsx+t8eg3HOyYSG67HG9MiMLFhLhJnqWjXkjIVLRuRK/8
         UN3U1DJ1lG50fic944E9c7dmdM5z8B4aPysQmkRV+VkvlOfZ/ixeVNr1N5KhlhF1pS8v
         SNboZJddC7/LBjWUjkgu9Ox5QVNFJkEYJxwmhVmFhf1kY9HeDwN3cUiCNk1VPL1ZAhg9
         SkEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=k8Prb4eaIsfDG48I416I0t0oj1A+5hT9BwMRwLeQWEU=;
        b=Fg30MlyoTZEKSc6mmV6GKf6YWSrJJ3tMX+NhYQf2zMVYJTPASCYJigOiOY1H9m4U0q
         dJ1GDJwigkILcutfl7C4eZrdbgjqEAKa+/atcYLUGJBoHtRy32mnV8AgQOzj/fQ59gGJ
         86h7NQGBvmo6ku5EXFDOMDfuTG7puQ0MG1DaGfVdBlnffRpmN+dxFVOSjm4mFBPlxgWz
         q1jhdKKGXsSa7i6OJElHbC1MbSnpUkKb7GQLQnOS+Z705B1MZyRM69H3Oybhs2l8D9aq
         R83w9wrklS2C2Nz0VRGcdtbMD/uu443zesRrH7b6z/TPuUY7620J3BmCwSca/SwZBhBR
         9XTA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Gilad Ben-Yossef <gilad@benyossef.com>
Subject: [PATCH 4.15 28/55] staging: ccree: NULLify backup_info when unused
Date: Fri,  2 Feb 2018 17:58:46 +0100
Message-Id: <20180202140829.082285149@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591310117118385319?=
X-GMAIL-MSGID: =?utf-8?q?1591310278422371853?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gilad Ben-Yossef <gilad@benyossef.com>

commit 46df8824982e4fb0198776078d4a8c3e2d531464 upstream.

backup_info field is only allocated for decrypt code path.
The field was not nullified when not used causing a kfree
in an error handling path to attempt to free random
addresses as uncovered in stress testing.

Fixes: 737aed947f9b ("staging: ccree: save ciphertext for CTS IV")
Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/ccree/ssi_cipher.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/staging/ccree/ssi_cipher.c
+++ b/drivers/staging/ccree/ssi_cipher.c
@@ -908,6 +908,7 @@ static int ssi_ablkcipher_decrypt(struct
 	scatterwalk_map_and_copy(req_ctx->backup_info, req->src,
 				 (req->nbytes - ivsize), ivsize, 0);
 	req_ctx->is_giv = false;
+	req_ctx->backup_info = NULL;
 
 	return ssi_blkcipher_process(tfm, req_ctx, req->dst, req->src, req->nbytes, req->info, ivsize, (void *)req, DRV_CRYPTO_DIRECTION_DECRYPT);
 }
