Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELta+50tnw2AMe1Z3FG5Or1qWWBHa2mp6r7y5UBWFmBG81RvjApElGCY7TM7yrdfrRFXg6MJ
ARC-Seal: i=1; a=rsa-sha256; t=1519980953; cv=none;
        d=google.com; s=arc-20160816;
        b=OoHiAAndOjCM0Ya+GJ6xsa/uEFxQDVXSWbWzoLlHs8mPgw4D8kozJH21eNBwmp76MM
         kz//EGB4JKeHzJipIso2I43UHBvxszDS9HxRRl54wl50QWRIWUoncbxXfufzaMrmO8sf
         425I9IywFfNEFfeybmCddRRrk7EQvyxgUNB/AiwSg0KA0UHo7FbRULJ3yUInoTvEuYfF
         o1Lo5PVkMRKg2ogio9koIfz7hViYfaBN/RXV+MH7SSWq6Nbd7cQwE5iKU2NSXA/mTlEr
         62KGzW1u9CNapqgA5D0aZDOn1n+8CpzouWjBxTzt32f33zIdRqR9lmc7DGrp3aLimH0D
         A/WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=d5WSi2zAP/FIAtqyal6muCSOQK5v1fxat1OOhSQnuE0=;
        b=YlYInQzpr2Nx/HH7GqoX7PSOtMMCDuhqjJ8StigMxUW1riah4g8Ib6qxiOwNkhB95V
         Bu8Y+z5GlGDuZo9/eMMJTll4jkveUIhQLppvKPvUxiE9mXS1/clYlHj4jw6JgocJpjlJ
         T+UMYvtrMwuTjfE8A6Htj9fiMpHGVIHLG+1BfQPzjaG0O5bkZK8YCeCLXrX78P+bcC0O
         vf6yH2x5aSfkMTzHEQkzvfN9sOQE45wP3pfB7BcgEDVD1bpT+3NUigYQ9p2ffurfDN8E
         WEKYv/M9+R4LRBRf2BNi0bBHeNgRdzHBzI/JwZHz0xfPZ3Zpszpise5X5idY2Jf4NtOY
         U+qg==
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
Subject: [PATCH 4.4 33/34] net: gianfar_ptp: move set_fipers() to spinlock protecting area
Date: Fri,  2 Mar 2018 09:51:29 +0100
Message-Id: <20180302084438.152077394@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084435.842679610@linuxfoundation.org>
References: <20180302084435.842679610@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815408893754625?=
X-GMAIL-MSGID: =?utf-8?q?1593815548705248073?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 
