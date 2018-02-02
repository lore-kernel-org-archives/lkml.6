Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227g2UOSRLTx00xpd8mTwQ0DtSeS/EuCP/tDpSLs2K1eJ+tbI2GmZvQtIQSeFFC6muA3S+G4
ARC-Seal: i=1; a=rsa-sha256; t=1517591116; cv=none;
        d=google.com; s=arc-20160816;
        b=0B26jR7v1efJ9G/GmMp2u1+rbZTSm9gnZw97Wt+36Onkr8TQLOuAGWSJANPHd4DbrZ
         kGhArAw+ar8AeJiKmC9ttGZEZm/kesrBlHgtPGny+CpZZ8GAhr/JMURZIvZ4k8eyTOj+
         /jK4H0qs96t/dSVd75JkRD+TRv2uvyqUE+xY19HbxV8xKAEGpiecP884jjY8rSIzZU/Z
         4FQ4P7Yy6/fvmLLICt9yiGGyeZfRKVOgpRd7oCXNKIkp2E5ZC4kZUuRZQK6RlpiWEjTP
         BHl7x2AGBVo/VI6fncJjskdd5VI/pyPlHFis0YhvVGOB/Y6H0X9go8fEZLjeGgADomFY
         6eug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6+bSU8fIro0Z8xrSwZflLGQ8GvwHUf7jYKupcN0GpB4=;
        b=ayOt0j/6wrxlzwHZpZND/fyEqPfjr+m0fQw9wVgdzCwUaY5gafYek7mvinFVIoMCOq
         u//8kQoB23w5g9SSPkCtq0Y1m3tJ5DFlQYDThJDqWakrqt4RPijRvh5iW80K+zN3uVVV
         8qkF9pr6EbyvDhkyW+GPoY48gsKi4Ieg0RUcWjzmD5JfcBQeygWbckg1+/Nf9c8omm2V
         dDmYIiTdDcloB/FAxFSDRKEI7x5PROGSuSx1GEhq15mX9f5kzpLQn57mkLYRCbE49XUa
         MHW8qsN1lG14sgTKFVtlps6EdR7xFLvWY40bks6oAQIQO5HQhXziGvTpskYEGY7cWrBk
         DfbA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
	Andrzej Hajda <a.hajda@samsung.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 58/86] drm/bridge: tc358767: fix AUXDATAn registers access
Date: Fri,  2 Feb 2018 17:58:18 +0100
Message-Id: <20180202140827.826456609@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309622015901921?=
X-GMAIL-MSGID: =?utf-8?q?1591309622015901921?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Gusakov <andrey.gusakov@cogentembedded.com>


[ Upstream commit 9217c1abbc145a77d65c476cf2004a3df02104c7 ]

First four bytes should go to DP0_AUXWDATA0. Due to bug if
len > 4 first four bytes was writen to DP0_AUXWDATA1 and all
data get shifted by 4 bytes. Fix it.

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1510073785-16108-6-git-send-email-andrey.gusakov@cogentembedded.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/bridge/tc358767.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -318,7 +318,7 @@ static ssize_t tc_aux_transfer(struct dr
 				tmp = (tmp << 8) | buf[i];
 			i++;
 			if (((i % 4) == 0) || (i == size)) {
-				tc_write(DP0_AUXWDATA(i >> 2), tmp);
+				tc_write(DP0_AUXWDATA((i - 1) >> 2), tmp);
 				tmp = 0;
 			}
 		}
