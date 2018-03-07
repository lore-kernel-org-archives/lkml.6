Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv+8M+wsKMAIZ3qBwPs2as05cspUy9/ph42Q60ApqdLh03limIQuuQ9ADETpNxcRWmwUW/v
ARC-Seal: i=1; a=rsa-sha256; t=1520452101; cv=none;
        d=google.com; s=arc-20160816;
        b=c5Kbu0lvJ7BBmK2fsQFT5lww/+81oEtEn/B1c+WgCNcTpCQbcNyg7Qv+FXIpxwe/CD
         4/JjhCplspsZkbusFrI4DQ8dNb9cTI0o8Sn1x69reeTC0038ikEq7g71lBHIEGUT5Eiv
         eSgB/WqviFsQuJTubTpdFYWhp8SjtaiC3GLaV/YSkrRH8Tp/LOmv0qr5EutSghsFa53Z
         a4VAwguvzFdhTJbuXt2c2Gs3lvar9prXU8V+ogYI1EhDCF5Dp5R/fAD6iBNGR8EIMpmB
         ZwO5LhqZBBTLc2iI98jsyujt12GksHhxDt612vsII/Jr24tOmF/h5BXUw23VrO0/y+jI
         txCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=N0cwCstZ1sFb0FXynx+f83TVHlS9KM98WN+gFA/N1l8=;
        b=Th72J7+3JhioiSxD96KpA3bIEjQC/qIRcIokbzLji2I22ubbVc0f40ejdKhgSaIn2F
         WetQgLsLxYGuzyaO4Tt3JEUMeyf0SQtTr74/4P8qUKlLVQDC0gmkzf+G+EQAw/kvzC8s
         0r9GMotWU5G/nNw+ivymeNg1VzXWeAPKamZ+kfzu8sDqsCSgojKPk2ibxeArHCvQXPfz
         5/IWJJEE8fcEPtHYK0Qp6tuzo3yplrIJV+jdpAkBUKXMCpRbcfU4CkY/FJKb43yrAWg6
         cA6R7ROkKoenPAc66pfYKirMoSM4PD9bflJQshRGKsevZO/W6RYu1wprtvoZUrGNPBoc
         U4Ag==
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
Subject: [PATCH 4.14 092/110] ARM: orion: fix orion_ge00_switch_board_info initialization
Date: Wed,  7 Mar 2018 11:39:15 -0800
Message-Id: <20180307191051.632195007@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309287292591217?=
X-GMAIL-MSGID: =?utf-8?q?1594309583080755951?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
