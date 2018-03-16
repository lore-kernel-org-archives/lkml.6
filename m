Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuWeInzVfaIvhZnHrrhBqkLBgI+grfTiwEgDoxQfo10C5qfVzKCJOv1hxLeJoRtEmpTFTRd
ARC-Seal: i=1; a=rsa-sha256; t=1521214434; cv=none;
        d=google.com; s=arc-20160816;
        b=pqCwqt2UP2XtEgWOGt8vQfY8epP7ijKhPenNGiPsWMuuwiUR44ZpDEDjrwtr1fDlJK
         wPVCaw2sMn/KPOeZEBVv0wVxzCZbusc5HGGkz3uKWQs0TLTD/SlHAp8fGsBnoePW2DkY
         XMCh6JhY0OnwrsBIJfLnj2QG9rqvfRSXgd3KipxWnGerpX47E1WI8Agfhb0jfTLhfQKk
         Qv2NwiPoYwL1AsLrAZr5AHAiu1/p8p+l7XpUno3T6tjDlj10Fgcb7EV07I2QPnsRSKvr
         /2JGz8Jhop0zszkAzwWQTng7NZxhkrrz81rt5qLwIk7TTCaxioNhKG5QtU4c7T9RliUp
         GhJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CwdaxBQYhbbp6xOEImINjx84LLgEcLjglJrQuNZ2A0I=;
        b=lnG4Og1isB/2NcqG0O8TO4LSEKIqb3cB3/tutLMWjlyPO32//Oqv03hgWaYrISMMKe
         FfxC7gaR76S0LBVdKPl5bI8rQtF2dLYI8we9D6uo0+Tia+La15BnNSoXjstywVpTP7ns
         elE72PXiSWYtFBBMBZYk9+kYkxIiFipdg7QPM1a2hYk92+rojNrUhWghQ7sAVikkg3sA
         YEwqJqVRm+1hxGYSdmXeZrT872DDWj+Jtoc+nrEvbsC6OJoKVC1yLcu4WPWjj8S1DW8P
         9l5me6EFh/yJiqPoUiO7V2b8efjoWEnvR5ZsApwhYrbhCUSa2BmHkpXMK41WCYyipRmc
         dfDw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Greentime Hu <greentime@andestech.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Peter Hurley <peter@hurleysoftware.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH 4.9 85/86] earlycon: add reg-offset to physical address before mapping
Date: Fri, 16 Mar 2018 16:23:48 +0100
Message-Id: <20180316152323.074686007@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108946951536205?=
X-GMAIL-MSGID: =?utf-8?q?1595108946951536205?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greentime Hu <green.hu@gmail.com>

commit 1f66dd36bb18437397ea0d7882c52f7e3c476e15 upstream.

It will get the wrong virtual address because port->mapbase is not added
the correct reg-offset yet. We have to update it before earlycon_map()
is called

Signed-off-by: Greentime Hu <greentime@andestech.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: stable@vger.kernel.org
Fixes: 088da2a17619 ("of: earlycon: Initialize port fields from DT properties")
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/earlycon.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -253,11 +253,12 @@ int __init of_setup_earlycon(const struc
 	}
 	port->mapbase = addr;
 	port->uartclk = BASE_BAUD * 16;
-	port->membase = earlycon_map(port->mapbase, SZ_4K);
 
 	val = of_get_flat_dt_prop(node, "reg-offset", NULL);
 	if (val)
 		port->mapbase += be32_to_cpu(*val);
+	port->membase = earlycon_map(port->mapbase, SZ_4K);
+
 	val = of_get_flat_dt_prop(node, "reg-shift", NULL);
 	if (val)
 		port->regshift = be32_to_cpu(*val);
