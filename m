Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELujdZiFcsbiWeaVKVimSy6Gi+7PNTwQKsA2jb+g1hlhFSMduiCOoFqz79TAA9czsoakh9S7
ARC-Seal: i=1; a=rsa-sha256; t=1519981483; cv=none;
        d=google.com; s=arc-20160816;
        b=pczT6yImpseKKkYcSB9h+NGLn7wOnyAFXrc5eGwCa2gEwfNI4e2LyVxUBTnlZ437Fl
         EjBQf9wJsO4frrgCrnu1UsvvkNpa8+7/kxrUnpF+OU1j7/TmAETZ/yiuMYUO0OP8OyFr
         zkkwNpbnyjzbcaDBuvuS6w3x87A+wmZlXIE2+GngBxtdfm79xfPNST56qCcKdVl/sax9
         W9Kv0MtBFgNX0qsZOAmR7j9AXdRpXsmyBBeZXfRdB2tYf6/cBeqb2YSuyFN2FXiVquZb
         XcviWfZX7RNhnGjC9+EoiTJsOQwG4SunvNLtk9H3mzaZKe+Rpjo0rEyQE18nVeYS6LKo
         tnrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wPrVZyNd3MhuryyUnDfJVue1X0RibhqgjCV9SFW5QNk=;
        b=aiOpbFyLMCN2b+2Liotrol2Bvt70yEUMklxAcoxm2LA1tVSzT8PLBZ0hwc9peBNFeG
         4WwSDgj69kxMAkt5fdKz779cqp2l/N2Qzq2KqjnZmnWgEkC6NrsQCrHuCwDRQrCik3xS
         CkgmBO643MsCqHU++bOZXOUwRxCbNN1jVfTEmX+N8rZ2iytSUM+JHcHPCmnrTtXFb9ga
         7Q74m2AuJjcvxrP2FneSIVm8ZvADNKezDvmJZpoxDGpNgFX9ECIFJWzkSiFamP1VxhOS
         ga4uFH7STh00qpCNyt8fRDE81mdecdIrz/3zQMrwZ2pa9PD6b3ifL4+CIlfdTpVhIYbY
         bGdw==
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
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 098/115] mdio-sun4i: Fix a memory leak
Date: Fri,  2 Mar 2018 09:51:41 +0100
Message-Id: <20180302084507.808402845@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815310363107750?=
X-GMAIL-MSGID: =?utf-8?q?1593816104493138675?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
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
