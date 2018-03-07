Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtkRsxlYDa73f5zBfeD0xLNES97DYrvaAiJ+FoepXc6wHi7O7mSuxuo2iBitu0yyAue0SLq
ARC-Seal: i=1; a=rsa-sha256; t=1520451819; cv=none;
        d=google.com; s=arc-20160816;
        b=wbQofbZEZU53v5ZwbKOl9Xcol3S34YKBYGYEA7rVX5xcL67Zn14ONhEY2Z4SR534M3
         drdy/kjy264U8bPcChwbWA3D9dvk9tXqGQNaYSGqwyLhQdwN2YOnL1SQLrLDsXphBuaU
         CYStHCsHTc9TE9lt+5ZWexViS/kjODJioSxq5StF0lsTmykZH6RhKW2Iuv/Sh/4/3QmS
         IQdwFnifegZGHWbLRZXnXa+bplqWj9BhaTgunYGEmbwGd0BAw9vaoHv4t2hFO7pGWZEw
         c9NIBmjP/Z7u+G4xswcULDl6g7FAz4YYRlx23YvbqXdCUbhFSX6MeMNQn+VSoZGG5IHR
         tZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Tvndk3W9eFZDOsnHHXNC3RVfhU+uL9WpUUyQL+Mxj60=;
        b=kJKVhesMlkK5zCU2Z3kOJu8epbieRJIgbSuvyvdUmJzzDXXOY6tUSQbgKmVPCFdNFy
         mZ1ASTeFIggg9S6HXcudVzeCTt5qMSabJjHRiIeE/+S1j9Zy5AL/eRvWUUgjJpZlzBOx
         nfgy/JdbGhNSs8vUjKx0wbtHb/W/yBMR4QVnrXWRjjrrackB17XC0QtnX/qfqJMbb02M
         rSp6IIapknp2+6UJ0kSmSuZw8tO1zDduAjp5gU8nUZ6+//zI/SD0YuHn5Ae26WHMilkN
         4/aeIIVjS3nLVmeKdE8eWYFskpG7knN1VHzG185SwxPdrJWCUhpDwXYgqVptfE0kfKGI
         NqAw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.15 107/122] ARM: orion: fix orion_ge00_switch_board_info initialization
Date: Wed,  7 Mar 2018 11:38:39 -0800
Message-Id: <20180307191745.049545718@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309287292591217?=
X-GMAIL-MSGID: =?utf-8?q?1594309287292591217?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 8337d083507b9827dfb36d545538b7789df834fd upstream.

A section type mismatch warning shows up when building with LTO,
since orion_ge00_mvmdio_bus_name was put in __initconst but not marked
const itself:

include/linux/of.h: In function 'spear_setup_of_timer':
arch/arm/mach-spear/time.c:207:34: error: 'timer_of_match' causes a section type conflict with 'orion_ge00_mvmdio_bus_name'
 static const struct of_device_id timer_of_match[] __initconst = {
                                  ^
arch/arm/plat-orion/common.c:475:32: note: 'orion_ge00_mvmdio_bus_name' was declared here
 static __initconst const char *orion_ge00_mvmdio_bus_name = "orion-mii";
                                ^

As pointed out by Andrew Lunn, it should in fact be 'const' but not
'__initconst' because the string is never copied but may be accessed
after the init sections are freed. To fix that, I get rid of the
extra symbol and rewrite the initialization in a simpler way that
assigns both the bus_id and modalias statically.

I spotted another theoretical bug in the same place, where d->netdev[i]
may be an out of bounds access, this can be fixed by moving the device
assignment into the loop.

Cc: stable@vger.kernel.org
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/plat-orion/common.c |   23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -472,28 +472,27 @@ void __init orion_ge11_init(struct mv643
 /*****************************************************************************
  * Ethernet switch
  ****************************************************************************/
-static __initconst const char *orion_ge00_mvmdio_bus_name = "orion-mii";
-static __initdata struct mdio_board_info
-		  orion_ge00_switch_board_info;
+static __initdata struct mdio_board_info orion_ge00_switch_board_info = {
+	.bus_id   = "orion-mii",
+	.modalias = "mv88e6085",
+};
 
 void __init orion_ge00_switch_init(struct dsa_chip_data *d)
 {
-	struct mdio_board_info *bd;
 	unsigned int i;
 
 	if (!IS_BUILTIN(CONFIG_PHYLIB))
 		return;
 
-	for (i = 0; i < ARRAY_SIZE(d->port_names); i++)
-		if (!strcmp(d->port_names[i], "cpu"))
+	for (i = 0; i < ARRAY_SIZE(d->port_names); i++) {
+		if (!strcmp(d->port_names[i], "cpu")) {
+			d->netdev[i] = &orion_ge00.dev;
 			break;
+		}
+	}
 
-	bd = &orion_ge00_switch_board_info;
-	bd->bus_id = orion_ge00_mvmdio_bus_name;
-	bd->mdio_addr = d->sw_addr;
-	d->netdev[i] = &orion_ge00.dev;
-	strcpy(bd->modalias, "mv88e6085");
-	bd->platform_data = d;
+	orion_ge00_switch_board_info.mdio_addr = d->sw_addr;
+	orion_ge00_switch_board_info.platform_data = d;
 
 	mdiobus_register_board_info(&orion_ge00_switch_board_info, 1);
 }
