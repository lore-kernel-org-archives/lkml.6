Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsuZjHQLgV090MdNRoH3vNQKb4olaH63m3fQottr3VUn1dX44dfdFD9sClmEG+0V4iiZRlI
ARC-Seal: i=1; a=rsa-sha256; t=1519981125; cv=none;
        d=google.com; s=arc-20160816;
        b=FL14EtwlVWQKPaqIS6WaeA1gh5xRQzZCanrbGOgvOdL4hPYAL1IHzG+vKbohfrcVtW
         VBdJ2YFct2el9V6A4cPwZ916mTPKIP9YdMcmUUcA2XmYWR7D0wNV2/+exOjtDd7YAMla
         wU87jENsvCMtxDai7UrjrX0fh/1QxIoMLpiSaEmyxQX6jgBDvYsCXhSNobecCeN0eRy3
         C8Ly7teu4S/UKDz7f30LwGCvf759h00zYU/vkZun/ZQgHaGSk2pH4E/Z1+gR0oRdHH/S
         osxIJsDmqrU/zAScI6yW2SCQouFDKnULha9Z1i9UAY5XrkJownc+9cj5ZJ0a1YIjN6Sy
         VJ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0WLnDu0L0GK0EIIijYWPLlrluJ1rXIyTZvHk+JUCRUw=;
        b=Ffg6hSqcvCuDqsS3ep9MsZjfILhQXSELQwRX037cTAJD3Txm3EaIztzw08ba8WSLap
         rHEsTUUMBNDehI/kY4HrpDQ06s1unumh0tsW9phrPKz7ZVU+dwWt4jPhv/bDXqq9NYQl
         auip5gUci+FXLXc6XAc3AoC9NsZEBIRVm3jH2KYQiLvb472DlT1kTOZSkrnT8q1w9d+k
         VWHsAwdCcIT0IBdqivVuHQT8Snsrk225BkwAU/j68QIfgkYWe47EoDNRfvZW5Nw/5tkx
         XpiAkzkNX6V5JFn2ztu6FIbH5NX34f4g5FFXHfc93/TxxVCmExq48SDPmjZkzWzxBA2b
         dg5w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 49/56] mdio-sun4i: Fix a memory leak
Date: Fri,  2 Mar 2018 09:51:35 +0100
Message-Id: <20180302084452.027864759@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815310363107750?=
X-GMAIL-MSGID: =?utf-8?q?1593815727877192916?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


[ Upstream commit 56c0290202ab94a2f2780c449395d4ae8495fab4 ]

If the probing of the regulator is deferred, the memory allocated by
'mdiobus_alloc_size()' will be leaking.
It should be freed before the next call to 'sun4i_mdio_probe()' which will
reallocate it.

Fixes: 4bdcb1dd9feb ("net: Add MDIO bus driver for the Allwinner EMAC")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/mdio-sun4i.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/phy/mdio-sun4i.c
+++ b/drivers/net/phy/mdio-sun4i.c
@@ -118,8 +118,10 @@ static int sun4i_mdio_probe(struct platf
 
 	data->regulator = devm_regulator_get(&pdev->dev, "phy");
 	if (IS_ERR(data->regulator)) {
-		if (PTR_ERR(data->regulator) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
+		if (PTR_ERR(data->regulator) == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			goto err_out_free_mdiobus;
+		}
 
 		dev_info(&pdev->dev, "no regulator found\n");
 		data->regulator = NULL;
