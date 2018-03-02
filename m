Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt1JjNVZXVsFTq39pHQoK+k35BW0st83beMgua8+3WyOUjc/7kI/i8SWEJwaTYK56JjpFIC
ARC-Seal: i=1; a=rsa-sha256; t=1519981140; cv=none;
        d=google.com; s=arc-20160816;
        b=xLJIXl9vSUMz1Kxsu02NgnQ/Ftrq23QP/TfUQrP1ICK2RYMVpJO50i4Exc1HFTq6ft
         +Ctbzu37X4Oi/A4oUgtHutTR+dFVlDkGbYYy3Oc3vgLxI4osFWRE9ZDjITFQ4hevVcIS
         xaStNQrDmG4SlFJ/ZiMt0d4D0H4Hp3Su1y9FVVDAYUZ4wqEMd3/mgkVAOdYXvIQlWqsw
         PJ/KaDS6lEj+3sU39AedxegrjhoJT2cW3fibda+EU1OYTxlHnIolo1kTMUxc7iSVv0nr
         kCKYyz+EkpOvCHQ1Yre7FvsVOy+rRr3bttGLDVBrEiDb0fkNyP/bADGewFAVe9eOETfw
         kmTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mhha/PAKBvjl7UScIGCuJcVi1fM4HAXgvOU2frgzIPA=;
        b=U8NnaCsDzYwnd1dI9jz1F3ZKBmcBeX/jw1j327hTzldKqPfx5u8wHcB763jcEyh2QP
         M9ek/R+919WiJiWYhd2odqUsDfdzSBDJIt8HnjogXouiFH2UialLmzUJ1HZMWUWgxR76
         Ig43WL/AvuvflYCgt/FrITFw43m3hIaTRx+wNfFdC45+sK8r20nsvHXa0+bvEdH8A/QL
         MThUIeuqu2QG1MkOFewd3wTKbEE65/Ie9Nh0ERel136JBO9defPQYegBN+AWS7oILLnA
         x3xr57uxpSyK60l1ofIwmpuoDL8teRK7EzFpE7maKCmToaVenv8+6HtQAjvwKd5x4ojQ
         ZieA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yangbo Lu <yangbo.lu@nxp.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 54/56] net: gianfar_ptp: move set_fipers() to spinlock protecting area
Date: Fri,  2 Mar 2018 09:51:40 +0100
Message-Id: <20180302084452.259285030@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815408893754625?=
X-GMAIL-MSGID: =?utf-8?q?1593815744331555060?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yangbo Lu <yangbo.lu@nxp.com>


[ Upstream commit 11d827a993a969c3c6ec56758ff63a44ba19b466 ]

set_fipers() calling should be protected by spinlock in
case that any interrupt breaks related registers setting
and the function we expect. This patch is to move set_fipers()
to spinlock protecting area in ptp_gianfar_adjtime().

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
Acked-by: Richard Cochran <richardcochran@gmail.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/gianfar_ptp.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/ethernet/freescale/gianfar_ptp.c
+++ b/drivers/net/ethernet/freescale/gianfar_ptp.c
@@ -314,11 +314,10 @@ static int ptp_gianfar_adjtime(struct pt
 	now = tmr_cnt_read(etsects);
 	now += delta;
 	tmr_cnt_write(etsects, now);
+	set_fipers(etsects);
 
 	spin_unlock_irqrestore(&etsects->lock, flags);
 
-	set_fipers(etsects);
-
 	return 0;
 }
 
