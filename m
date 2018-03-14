Return-Path: <grygorii.strashko@ti.com>
X-Google-Smtp-Source: AG47ELuiieQkSNP74JjwFTQ0A40hC+PI1bntgsHG3sMKwCK0UsSHThJyI2Cpa4abwt6ceRgkKEOG
ARC-Seal: i=1; a=rsa-sha256; t=1521066391; cv=none;
        d=google.com; s=arc-20160816;
        b=gLWmGVRq4FKKMLaStSXKz7lq5EixoeoYs4WsHeu9yJhPNWfCrs8F9U+Ha/2c8h9wXo
         BJrE5zD7EDpXw1/SRct1Uf9pMgEqpp/X3i0nr2qbVPHXSEWF4qWcwgN7KPx/jOuvbVIT
         NMdgY1YkmQIHQ/0mScPlFy5VR0Ij9g6ZR4/pthgysAsoWGrOvWeBGggx/WGu6xgtxOJf
         Q2b2X+ho5XrTLL+qxAZsnc+cdjF9uMJGXh3lhkdPpf2Tl6IdFNlsXjXUh3FJ//TpVhCt
         8XPKbxcAjvedF7HbXZsyYe04kACp419FAkRc0velGEFKw/Cv8e7uTerFvP58JxTO08Uc
         YfkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=7oNW9kNFuam641UKnT2jTtQEh39hl/Uy7TphNVMWSAc=;
        b=yDC9o5tZgZdgadu2V7rDYUx0JncuSgLtfU7sCtgEMZrqBWp8w4Q5sDbcgyV1S+guCf
         kUGgT8bnLNnSAyEUPRNEb6ALeP+jOeMv8K/zLvL01NQkr9MRzF/W0otU9eBR4wBohN0j
         s0nEI8RtlYO0oPVKqpqFTVVOW2h9ACrSg2umN5z932LZgsyghgix5blJhDkwWStOMr12
         2ub4vsFwQTQMaOnkoxod3In4QtAtGspjsDgGRkZdZrP5fs717ktv1fh5NF1jnrcWaGR6
         wGbxM+MhFdeG+xYAHx1Kbk27wO1ulFeR0eVBD+IDB8JjcKpVa6WAYwnG2Qbwl9QS3J8D
         xNIg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=KQyZF/oT;
       spf=pass (google.com: domain of grygorii.strashko@ti.com designates 198.47.19.17 as permitted sender) smtp.mailfrom=grygorii.strashko@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=KQyZF/oT;
       spf=pass (google.com: domain of grygorii.strashko@ti.com designates 198.47.19.17 as permitted sender) smtp.mailfrom=grygorii.strashko@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
From: Grygorii Strashko <grygorii.strashko@ti.com>
To: "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        Andrew
 Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 0/2] net: phy: relax error checking when creating sysfs link netdev->phydev
Date: Wed, 14 Mar 2018 17:26:22 -0500
Message-ID: <20180314222624.12744-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.10.5
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594953711945737346?=
X-GMAIL-MSGID: =?utf-8?q?1594953712544582579?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Some ethernet drivers (like TI CPSW) may connect and manage >1 Net PHYs per
one netdevice, as result such drivers will produce warning during system
boot and fail to connect second phy to netdevice when PHYLIB framework
will try to create sysfs link netdev->phydev for second PHY
in phy_attach_direct(), because sysfs link with the same name has been
created already for the first PHY.
As result, second CPSW external port will became unusable.
This issue was introduced by commits:
5568363f0cb3 ("net: phy: Create sysfs reciprocal links for attached_dev/phydev"
a3995460491d ("net: phy: Relax error checking on sysfs_create_link()"

Patch 1: exports sysfs_create_link_nowarn() function as preparation for Patch 2.
Patch 2: relaxes error checking when PHYLIB framework is creating sysfs
link netdev->phydev in phy_attach_direct(), suppress warning by using
sysfs_create_link_nowarn() and adds debug message instead.

This is stable material 4.13+.

Cc: Florian Fainelli <f.fainelli@gmail.com>
Grygorii Strashko (2):
  sysfs: symlink: export sysfs_create_link_nowarn()
  net: phy: relax error checking when creating sysfs link netdev->phydev

 drivers/net/phy/phy_device.c | 15 +++++++++++----
 fs/sysfs/symlink.c           |  1 +
 2 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.10.5
