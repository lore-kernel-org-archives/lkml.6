Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227EUDtIRG52NjJaEL1hxlszwqe/MpJl7z8bbTAoJyaER1LyEpXj2SUM1JSRIzpGwc4xYKiH
ARC-Seal: i=1; a=rsa-sha256; t=1519217664; cv=none;
        d=google.com; s=arc-20160816;
        b=sN63wJ40U4ciWZtOva+RjZlwFsSFNEfvvNvhph3o3KkyNJf7fezqQzdjES+MHVbVQ5
         ilAMrC0Q7iYG3fYwADru52T2R+Mt/FvWSeUZ9cWHB48hsWWNpjKIcThD8Z8w33FzanOc
         ySs0ZXnqXmDYpMygy6jRrrXzqflHt6bT4v1VYJ18mo7/Oik8Xgk4fNRU/D8/hftJMFH1
         IKC9dzkQ7dYg0RiUce6hGvFxi8gGaNmsBqG5adJ/otj7NdBJCkxpFvUo4sXRERALP5d4
         nbVfzEjfH4nLz9gZIPmTRD2+CuNHJIqG90bOuMRquE3TLrFa92bUIjNDdm52jSnoHw+X
         0oNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WQ0blSun6cd75f9zciRX/5zAbG+XVbdJNf5LfJC7qlI=;
        b=msqygjbv+ZA+I1+UefAx86fg55L3W/XVpWkTbrUiXh6lt1pJxl8Zxbl3Suilg6Krm4
         H3eZcu/fVjsL0jYinwp7bqsubpaid1SiHL/lN1djJuHSiIqZWZAVX4LWU/3FI6N6fWBZ
         YvbWjcOqY2per2qO0bZKWFUCXN2YdaGlkUBqlzsZaEk7qHS3dxkmOj4fjuZDrNqfqNxZ
         V7WCfobHn2HdeEz6S57vsYrgQxpcc+712ZB+Rp63QIjl1LeKZmPlOutatM1cCpNpYVFL
         AOCLG+Prq8ksSwtnEt/+NyXEy1EFQ8aZbAmWr3+qGhLXxguu/5P1A7EFDiAE72NuybdT
         WucA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.9 03/77] drm/radeon: adjust tested variable
Date: Wed, 21 Feb 2018 13:48:12 +0100
Message-Id: <20180221124432.309508161@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015181472475587?=
X-GMAIL-MSGID: =?utf-8?q?1593015181472475587?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julia Lawall <Julia.Lawall@lip6.fr>

commit 3a61b527b4e1f285d21b6e9e623dc45cf8bb391f upstream.

Check the variable that was most recently initialized.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression x, y, f, g, e, m;
statement S1,S2,S3,S4;
@@

x = f(...);
if (\(<+...x...+>\&e\)) S1 else S2
(
x = g(...);
|
m = g(...,&x,...);
|
y = g(...);
*if (e)
 S3 else S4
)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/radeon/radeon_uvd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/radeon/radeon_uvd.c
+++ b/drivers/gpu/drm/radeon/radeon_uvd.c
@@ -995,7 +995,7 @@ int radeon_uvd_calc_upll_dividers(struct
 		/* calc dclk divider with current vco freq */
 		dclk_div = radeon_uvd_calc_upll_post_div(vco_freq, dclk,
 							 pd_min, pd_even);
-		if (vclk_div > pd_max)
+		if (dclk_div > pd_max)
 			break; /* vco is too big, it has to stop */
 
 		/* calc score with current vco freq */
