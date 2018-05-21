Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp+vIVet9rcP+2IkSfoQHbhIe8ReE7a9g3VzsMBxg3Xgf437ToV5zGMKx0GgHtQdPBkfVAM
ARC-Seal: i=1; a=rsa-sha256; t=1526937469; cv=none;
        d=google.com; s=arc-20160816;
        b=rv3dK7gZRtefapS6fmegPdGEjqdm5Q0uNK8QKCeGdgWwx0tjR+Ns7jnq/SsFr/Il6f
         4urtzdPwI78PO2ZfrxyrTVi5RMzgZzQfoVJinUZpnMuVbJIeirOfAYzFAxZ8/re6S0MH
         WYd/j366Q0xjvCbhM/D8hq5E+9JP1OMMiNLHteftE05QyyBtV+npk592ScIK9a7Iklcr
         VqqHt9amk4DiQLhBk4NbMcVE64PZIq5yKKoogfLDqdx1DWAAmorGGnW9BnJB+NPFczHb
         i6LnYNw2D44uCHEPuCYfpP+TaohjibiKOp4uQjVd+BHHLt1aF+EWh1ubKksPajYDm4fH
         q5Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=fsXWTnUKLbiTCNcbpPwLibjYUl21XKJwXwKeoTZudlI=;
        b=cjnHAvc8JuWNtPvhBrxoD1dvp57ZcVhGaeAn7C6GXcd6a+i8wxzQaCtdL8oL6olKqj
         nGEEiDJLlb2EUYmuHLwT8dDlPcch7IGdTsFva7OQcaQ3Me66e6mEunnY6lqtsNx8eX2n
         6zyeK64dJHCXpODc5NPs16TNRIoaHDzV4xEq6r7kYKjeaghbX9CbcMBH9iG4atnT87Ss
         wSstde7znaJlg+MoyO3hp13gpSrOOCBsln1QngSf0Hh0N2CmnGF97a5RGZ1/n8ji6mUq
         JcMxm5j6lcGgIRAc6JqkDmAgnxwUP07jj8FJATMKBlCT5PYDXnsDfs2WVvt/v/miYs00
         FA0w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=lIAuOEIX;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=lIAuOEIX;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 60/87] seccomp: Use PR_SPEC_FORCE_DISABLE
Date: Mon, 21 May 2018 23:11:36 +0200
Message-Id: <20180521210425.535594367@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109984171479301?=
X-GMAIL-MSGID: =?utf-8?q?1601109984171479301?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit b849a812f7eb92e96d1c8239b06581b2cfd8b275 upstream

Use PR_SPEC_FORCE_DISABLE in seccomp() because seccomp does not allow to
widen restrictions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/seccomp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -226,7 +226,7 @@ static inline void spec_mitigate(struct
 	int state = arch_prctl_spec_ctrl_get(task, which);
 
 	if (state > 0 && (state & PR_SPEC_PRCTL))
-		arch_prctl_spec_ctrl_set(task, which, PR_SPEC_DISABLE);
+		arch_prctl_spec_ctrl_set(task, which, PR_SPEC_FORCE_DISABLE);
 }
 
 static inline void seccomp_assign_mode(struct task_struct *task,
