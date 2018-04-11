Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/fQ+BiI/LBDEZMqt53yyoRMaEfL1II0qZ28FgOAryulsl1OaNr2Fm0Qzv9cQQ4LfOOS+Qm
ARC-Seal: i=1; a=rsa-sha256; t=1523472555; cv=none;
        d=google.com; s=arc-20160816;
        b=S4skMghi3YdKYRBhcPGuGWIT5IErwKf4Dsy8aOmFwGmzj0xzboonrem/fkXtnHXID7
         IPpbhpur4ZH7SdAxB7Ep/VjiXxE7sOOX51n4n0JEIP1A9MuhBnanggzCg4wWn6GsFFhz
         EY+hoBDZcQIxSqb+KVxeFmlEOpWbme4Mrts2yVUgRkJNPJ1RnnzfqT9ycAFVtm4nLKVh
         fECNmUHk7cYhtOBzYeWFWZDLXMPaj30hiOvLESrHb0jfd5nPSR/JraBSkWQqgFLBUYVS
         M+BnOjH6RSaXkngO4eEnDPgNk/3hIL8mXFuRc0geeWDxy2JSYntiZZq1K4m3u7/03xpb
         swSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4bYGoiAkzCsWmqQLivG6Lw+wyqMwAeMtRUxEglQ9Rhs=;
        b=Mx6j+q46IQX1PuKfAWsPq6H4r9/WjKebDLqmIeKOx349QTxub0J3mCD+NXwwdcbOJc
         8QEFkyh47AoTf2CIWl47mHGNb23zgcqyYvTpVMGdejBXrngXABY4Ut9HtAmrWWDMfhYu
         oZ7XcnuGq8OAw9FuCZuXq6dTDW1k89GGsC9DraJMOFe7TlYD5IkZiAtq++ahin5SVbVQ
         HdYnYEpoZ+XmuPbxJQ0nSJKHDXmXITkd0xqEtmKbbcYsHVyGkRK2zqq8VoY7fOf1fNHT
         229T857jTVWU58rZpcu25mNho3BQiYiylji7SiVZZb5WIORI5hxaz0Bh0nuv+3AzHlT3
         RXxg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 127/190] net: phy: avoid genphy_aneg_done() for PHYs without clause 22 support
Date: Wed, 11 Apr 2018 20:36:13 +0200
Message-Id: <20180411183559.610516099@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476246644672781?=
X-GMAIL-MSGID: =?utf-8?q?1597476758416127356?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Russell King <rmk+kernel@armlinux.org.uk>


[ Upstream commit 41408ad519f7a2a1c5229e61f2a97f4df1b61adc ]

Avoid calling genphy_aneg_done() for PHYs that do not implement the
Clause 22 register set.

Clause 45 PHYs may implement the Clause 22 register set along with the
Clause 22 extension MMD.  Hence, we can't simply block access to the
Clause 22 functions based on the PHY being a Clause 45 PHY.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/phy.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -148,6 +148,12 @@ static inline int phy_aneg_done(struct p
 	if (phydev->drv->aneg_done)
 		return phydev->drv->aneg_done(phydev);
 
+	/* Avoid genphy_aneg_done() if the Clause 45 PHY does not
+	 * implement Clause 22 registers
+	 */
+	if (phydev->is_c45 && !(phydev->c45_ids.devices_in_package & BIT(0)))
+		return -EINVAL;
+
 	return genphy_aneg_done(phydev);
 }
 
