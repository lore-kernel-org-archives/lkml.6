Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+TrxiduAts8qUJbBbxcjuCRcJAxfbPlas5H7xJIwW7jwfp4XrV7BD4p6uMDsT7FxaPmjtZ
ARC-Seal: i=1; a=rsa-sha256; t=1523473456; cv=none;
        d=google.com; s=arc-20160816;
        b=oSkGI3Q2pAxBvnZKIl/ncbtHjSjMv6K/1AM9L1KhnIwrXnY8/3JCNIxLlKfv9qX5dH
         OcxBzJiyF/nSYVSFyzii2QqsfdhwJKKgU8eXw6Jyl0RYkqCHdbuyi35UH/NalyBIuM3F
         yUYffUQxHhNQqnHGoNcbp6H8V62JAlqqAmDnJ24aW+u+U5P3sTw6/KFl9tHDfgVXhuUg
         zKR0kJSHCt+7cYQaTJshAyE9sXf1ovCS5K8vTa6u3P4v1HbrzZ8r5wkEd+pjusnD1z1T
         c64QMjaE+CS2k2bZorIfE75FeDc9yoj5hdQGqc7upxDvmFkBK8gy78VXYDJ4ERF9b3jj
         1Wnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=APJeqxx1IoAwqlACIkYdLqQOQ7fJeHQkuNzGq37uMmk=;
        b=j47TpkPfBDspLCQXvIVJltOMhboXcjNgL/rD8HyHSLJV1584CMjl6TcAvLCcbjoM2/
         jxii5Y9L69ytz7Zn71jm3H/XbBeg8iSAsR9BlTeEZekrQBwcLB+/kTZGPKJ97rPiHo1x
         6sBc0msFnTRi2Yk12/5UXF0dFWWv+GfbIBdl6saOyjsmJV4+U8rnZbAZxoNZrmLWfdOF
         WoZPyQupgK/zcPo/P8ZmcKmjOBbFmS53vwOOjwddUZn27BMNXteIGUVVPxpXPub/W+wK
         GQ8eMJKx/pC/8L2pb0CEZvyvENFk8VLj4QaHJffAuxt4OvKn/SLF873oZjyeDYO8Kjmh
         yp4A==
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
Subject: [PATCH 4.9 210/310] net: phy: avoid genphy_aneg_done() for PHYs without clause 22 support
Date: Wed, 11 Apr 2018 20:35:49 +0200
Message-Id: <20180411183631.598025958@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476246644672781?=
X-GMAIL-MSGID: =?utf-8?q?1597477703201562942?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 
