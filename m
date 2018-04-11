Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+JoYAcNqIY9zqJpJ8GK2tO+dLXy+luiwCy09R+h3B52xM+2iJS4UzEA1+PVB2Y63H6ASIa
ARC-Seal: i=1; a=rsa-sha256; t=1523472124; cv=none;
        d=google.com; s=arc-20160816;
        b=po4Fr6gl4YE1pWDyUcqib3VBNNj301tIG+ma6gpZl6tDYidXcSaaAO8Gk1iBc0FL91
         KCqIXUGpw0HHqGsd+Cu+N2j5owvdS9gP4tkrWAdJrMYwmCisba2k0pHrbbj0WxYtiCUU
         Qmh3wtKjUz1VyQ6oAATKeBb4a1KydZszez7KPToom+YLtKX51m7EqNVHTTPl+IITzmCb
         +gqEJyJ6aAMQMXRb1jRXp2+GR1BurBVSl8I0icKoiwrrtIBTtKuNyQ5vVQCUwqnCsukT
         Bu68b+OHBr0sHTJyY4tpowMVLvR4Eyg1ntY6dfo343pPnud9RcYVfwJCCigtQ46LcZ4U
         no7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NfxN0BgOs1xBcDTyt2xIe/PsTNBaZvOIU8ohkBJEpsE=;
        b=pRrQJSHQIUGwilZ26rSVyNuakwxih3XIL7lENXc0PYHNc7ht4yKfqkaAw5b1updFcc
         OjKlBgF/gxdKkzcRV8FlW7IHkBF6v04gybfXRCk6zaw+vV+OrEz3I6WoHLkJ5kYz5X/j
         o23DzLF20P91UXE6rPAhgsjAJe3Qcz8t4WeAN4SmdtFWKmwnxIqyFx3yJzjs13647ifN
         mdmkzzSCi76iLMQjJg12mJ6cp0H8SRHmMr7XUCHzcoOvu6UIjgjH7Asf13WLR4WFyHDj
         ln7NF626lnAgza89C4LSy7sWo2yat5SXkF790R1joRej82zv6xAvOCVYRTtxMCAe604g
         55XQ==
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
Subject: [PATCH 3.18 096/121] EDAC, mv64x60: Fix an error handling path
Date: Wed, 11 Apr 2018 20:36:39 +0200
Message-Id: <20180411183502.467774227@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476306178591836?=
X-GMAIL-MSGID: =?utf-8?q?1597476306178591836?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -763,7 +763,7 @@ static int mv64x60_mc_err_probe(struct p
 		/* Non-ECC RAM? */
 		printk(KERN_WARNING "%s: No ECC DIMMs discovered\n", __func__);
 		res = -ENODEV;
-		goto err2;
+		goto err;
 	}
 
 	edac_dbg(3, "init mci\n");
