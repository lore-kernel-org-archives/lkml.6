Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x226pGSnTaRMZndcXXqBFL3pN/JAAoQPgd35UwdmVle+ld320numSqxYYKFkKhFZ/x6aZNYIL
ARC-Seal: i=1; a=rsa-sha256; t=1518323641; cv=none;
        d=google.com; s=arc-20160816;
        b=lzDwQEGfeYXY6EfCtKeXyMglVNVb9XyUplJLXBVm/CQttAI4oEOkHx5qNCvd5D+L4X
         k94HJAZpDBojtsOc1n8knOyXjzCFQKr+sGL/6NmMP/Bp+leSLka/qhraMrQKrKehxnRP
         DYLXSAP0AITH6/x5ALsIQQRl3Tf+pCK9of/SvECWfvNOEdrbE7ecm2/fB5r6JHN+0YQi
         /E/4jtmH/8gnFBXOWaPmHgj/q5LmM0w1J2m/s7QS+n7FgA7Zl1TQOGmyREBOddHDNG9J
         X/WB5ZVSdHw1c9SclFoAY/unTe9K18e4MX4nc1BiQOXOMpwNFWHx4FNLMpaweBRd4bUy
         Todg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=zAGwTg6n0dP7tv8indL/Y6jHw8rseiZKROU7UjsWTsY=;
        b=C+7JUV55gz+iJCVXG4+eeKTYbv2Td029CmAtcgR1hcKKo9rO648V3fx8/7S08UX2eh
         9aRElvdAJewFM6/tbo6mfPiKSTT1Z8mkgE0Mwouvml3ao/m0p2Zc5gNdQFMM7cLxzdHy
         CoGIAoI+T5FRMKUkIaVSxiTGEzvv1RyXuk/dx6vNy3r3H/dBv2HjsvHhxAiCe8Cm/EUA
         9u5t141jYOq6y0HlhCNXyU8o8x48MfEL1F+o7t3ee7lrWbG+1rwQrfOH1zadH++YhZHJ
         cELySf3LbsCIlwvXqKdOFdpzEuxCNL4kniJ5lA+YkPdld1XXJP00pbq0UGnzPawe/eC7
         Cckg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Colin Ian King" <colin.king@canonical.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.46040531@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 048/136] staging: rtl8188eu: avoid a null dereference
 on pmlmepriv
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592077730466739636?=
X-GMAIL-MSGID: =?utf-8?q?1592077730466739636?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

commit 123c0aab0050cd0e07ce18e453389fbbb0a5a425 upstream.

There is a check on pmlmepriv before dereferencing it when
vfree'ing pmlmepriv->free_bss_buf however the previous call
to rtw_free_mlme_priv_ie_data deferences pmlmepriv causing
a null pointer deference if it is null.  Avoid this by also
calling rtw_free_mlme_priv_ie_data if the pointer is non-null.

Detected by CoverityScan, CID#1230262 ("Dereference before null check")
Fixes: 7b464c9fa5cc ("staging: r8188eu: Add files for new driver - part 4")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -120,9 +120,8 @@ void rtw_free_mlme_priv_ie_data(struct m
 
 void _rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
 {
-	rtw_free_mlme_priv_ie_data(pmlmepriv);
-
 	if (pmlmepriv) {
+		rtw_free_mlme_priv_ie_data(pmlmepriv);
 		if (pmlmepriv->free_bss_buf)
 			vfree(pmlmepriv->free_bss_buf);
 	}
