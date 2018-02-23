Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225uho/49gZf+Vy2n3YlUUDxtSy+dyLyIUx13xDWCs75ah1Ayr1w49Ri+VwolZFC1b26d/Rg
ARC-Seal: i=1; a=rsa-sha256; t=1519412098; cv=none;
        d=google.com; s=arc-20160816;
        b=H77A0kRzp8LEUoxGRbORJHK3gIjLzYYblou6JEtdhKCS4qsSOpuUjEl21ELuP5Uxpk
         9LQYr/GXbCE56Uc52u5QvRRCRiCqDY7+6ue/wpphbWKdHm15unCwh7oU/DEpm66LT89A
         q2kNH67H9DfOU/qbPFGV4CfWH7e0N0tZQPnkvaCQuBf5iRN5YxMImyRK0v9Wufy48vAB
         slEIyvnQwhmlZ1ktAVofGpsw9gHFquR3tsBIoAxEcWYWNkMAPx22O/VfxvJsic2v92jU
         x/UfC90p7ew/GgMyVK4Lg2lA6QyCpNMf1xSUpZ8e3cS8BC91NhWEcDer62EtJPJY57Hs
         DWTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=baXbnTUOXF+T2hVpJG1atca3fnNHt5qe26MdZ7hFgqE=;
        b=J8diPd5hzu2FqF/boBHLQ9KIQNNJdawdD31LNyy6CPj/VidjqXZiDzo51Jrwph6csp
         hkctfQJrIaHX3qhOP1ONpBxudXkyvWk7tsPeXnIpVELlDbG744wil+Dcl40JPwiafbko
         tabreOiyc88VJIcX4KrPn2DAq0JHoeCxL2A2brc3ky9TfKdhkEPIUL4C8xTjQFYpfnHK
         Qn7KPGghI367ruVzVFvZegDzNl1tar7pkaOE+pZRE196zOkW48OfCvrmNabJHvMOUuX9
         FjFEcyrj/Ch43GVYx4wKK+M+KqU5VqMZKgwdlVZA9l38CJno3O7h2izBoTom2yjUS4RX
         xdJw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 125/159] net: dsa: mv88e6xxx: Unregister MDIO bus on error path
Date: Fri, 23 Feb 2018 19:27:13 +0100
Message-Id: <20180223170758.323061227@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593219060197259693?=
X-GMAIL-MSGID: =?utf-8?q?1593219060197259693?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Lunn <andrew@lunn.ch>


[ Upstream commit 3126aeec5313565bfa19e2dd8fd7e3c3390514cb ]

The MDIO busses need to be unregistered before they are freed,
otherwise BUG() is called. Add a call to the unregister code if the
registration fails, since we can have multiple busses, of which some
may correctly register before one fails. This requires moving the code
around a little.

Fixes: a3c53be55c95 ("net: dsa: mv88e6xxx: Support multiple MDIO busses")
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c |   30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -2153,6 +2153,19 @@ static const struct of_device_id mv88e6x
 	{ },
 };
 
+static void mv88e6xxx_mdios_unregister(struct mv88e6xxx_chip *chip)
+
+{
+	struct mv88e6xxx_mdio_bus *mdio_bus;
+	struct mii_bus *bus;
+
+	list_for_each_entry(mdio_bus, &chip->mdios, list) {
+		bus = mdio_bus->bus;
+
+		mdiobus_unregister(bus);
+	}
+}
+
 static int mv88e6xxx_mdios_register(struct mv88e6xxx_chip *chip,
 				    struct device_node *np)
 {
@@ -2177,27 +2190,16 @@ static int mv88e6xxx_mdios_register(stru
 		match = of_match_node(mv88e6xxx_mdio_external_match, child);
 		if (match) {
 			err = mv88e6xxx_mdio_register(chip, child, true);
-			if (err)
+			if (err) {
+				mv88e6xxx_mdios_unregister(chip);
 				return err;
+			}
 		}
 	}
 
 	return 0;
 }
 
-static void mv88e6xxx_mdios_unregister(struct mv88e6xxx_chip *chip)
-
-{
-	struct mv88e6xxx_mdio_bus *mdio_bus;
-	struct mii_bus *bus;
-
-	list_for_each_entry(mdio_bus, &chip->mdios, list) {
-		bus = mdio_bus->bus;
-
-		mdiobus_unregister(bus);
-	}
-}
-
 static int mv88e6xxx_get_eeprom_len(struct dsa_switch *ds)
 {
 	struct mv88e6xxx_chip *chip = ds->priv;
