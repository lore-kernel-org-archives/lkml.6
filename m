Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvfFzW0lkyFi8+YgZKgYJPzuFzOBzwj7GIhtmp9oSNliFuKhMKatg0yaqBiVrD/Cir/haWX
ARC-Seal: i=1; a=rsa-sha256; t=1519981207; cv=none;
        d=google.com; s=arc-20160816;
        b=sOeBY30GZslZ7Std0tOzZkOvL0O9/FPisOXO6YLHxzaJt/hPyv+nai0Aywy+TXA3Se
         Acgw3WcCwxwDk0JId/OUQVGfuR1XjgZAaEJ5bfddl41wueUsDY164JGWNvsvPs9WvD6g
         pIJ8RyOqQUhVRNU2LhZ1EL2wmR3M2TMwnqknJP/qrnAINnyjMjx6wyUKoahheHz9dgiM
         m90VscSPmgxq5kz4nLT6gFwFzXY9jkJuFgI8QhJWSwxvI4BsfNCFBjSmRz1TVqt3zzxb
         5T0sg9WBzvkuIquTveRUXDIVQLLZlXjFVHOWPobfyKCkTAkC0lSrl7DsgG46QlMESVEq
         71Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CevOA+J7yqKmUgLgP1185z0A9CqkiCNdJCQmi+J8HAE=;
        b=xmSCfE+rlu4n+xxJFrwUfN9en25nWLFEwbrbGFXMuVsKfIlhWn9Tv4tFT8dM2Z3URx
         6JBL1ZKhp30G+BsJfspzUi3vcVE2P5J1rdeP3LkwmfO8/co5QqI7FkTo4cFfXoLw6BWi
         ymnF7s3mz/2GsYZW2AxgrdrX9FDlZkzx0ALdHw71cuNOuEvx5qjQ1EWrnPup4Ui+clmP
         VlLq4vL4KzPAzo7I3drYVnuMZSBUhL3Fb51UzMc5a6/OkjOHhGJWSTeT+FxtAnw+nvPz
         FgW2y0D8BJjgQQBqjrQ/xSFPed5DTgXzd7V+dtmLOdYuyw5dA2JBG2o+ZQTM8qO2ggk6
         Bhpw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arvind Yadav <arvind.yadav.cs@gmail.com>,
	Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
	Tony Lindgren <tony@atomide.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 006/115] phy: cpcap-usb: Fix platform_get_irq_bynames error checking.
Date: Fri,  2 Mar 2018 09:50:09 +0100
Message-Id: <20180302084504.113541904@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815814578214104?=
X-GMAIL-MSGID: =?utf-8?q?1593815814578214104?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arvind Yadav <arvind.yadav.cs@gmail.com>


[ Upstream commit e796cc6a3a9186c92092e2f5929cf8f65b56cf01 ]

The platform_get_irq_byname() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq_byname() error
checking for zero is not correct.

Fixes: 6d6ce40f63af ("phy: cpcap-usb: Add CPCAP PMIC USB support")
Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/phy/motorola/phy-cpcap-usb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/phy/motorola/phy-cpcap-usb.c
+++ b/drivers/phy/motorola/phy-cpcap-usb.c
@@ -310,7 +310,7 @@ static int cpcap_usb_init_irq(struct pla
 	int irq, error;
 
 	irq = platform_get_irq_byname(pdev, name);
-	if (!irq)
+	if (irq < 0)
 		return -ENODEV;
 
 	error = devm_request_threaded_irq(ddata->dev, irq, NULL,
