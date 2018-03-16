Return-Path: <grygorii.strashko@ti.com>
X-Google-Smtp-Source: AG47ELvdLnwWpOBPBbP0STcnX59PFE8B4nJWTE6BseLarTQJY/HkV8GEiQoUEciuk61AvCrIS5C3
ARC-Seal: i=1; a=rsa-sha256; t=1521238119; cv=none;
        d=google.com; s=arc-20160816;
        b=lZn3uB6rPPLIc3fzaeOqIF66N9nArJI+B5g70aao1ZQUxt8grO76wxyG8wK7SFHja/
         0/y86X0twU/2DUntYQoF/O7ZipKivgVG8HFbs/zqX6vWXgBBGttJEwlxhNcj5/e0Pvly
         DmUD0r45pTsx8SpQma/jUbx2R1KJ+yj4ESfF2DTpnhMiCphG9y63pWC/3UU/YtwiLQFy
         xC+yiWHZ/3asHxA2Sti2NT/bm8Ih3+2voGg7Cov2aD5GCwM77XLlg4k/jovBx2a/H5wW
         eN/yWTNYE2JlqYFcWeartamoMmoLT6vBXHubEuv7jwkGxXm2wD/DKtfGwWKwRtDLjSrd
         x9CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=5Bp0YIlhaMxIC0CTFAY43mKdEKWYhPOl2XxTyQVIfOo=;
        b=NNqsKxpnbtCTi3Zy8lzXS+/PmMaNfa7pnDfIrrUOPF1fHMB4Mel9mFTNoTE5MB/DJA
         oRa0JJmjZXOLLdquf1KB2uo23uG2+GAKifmu2l1C/iXpLj+8lKN6VaLI4ZA5lJdg9JqB
         md0d7X4aof+SQJy2WgSkYiWgkC7mlp1J+rnxEofyUWZQUuJOi14X1Wqt6OL5VKnMefuR
         vSAwqLt6zugOSke8PA61EiCIe/31km+SiKy40ps83dvvKluMy9yjbD8nJDuk27vl3i6F
         /eJWzU2c4GDs8wwHvUXEnZqjPURTlIho5nKeOmRzSXO0ChHKb7rl+3+OXTPXgqPCQaN9
         aC6A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=bUda7GHK;
       spf=pass (google.com: domain of grygorii.strashko@ti.com designates 198.47.27.80 as permitted sender) smtp.mailfrom=grygorii.strashko@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=bUda7GHK;
       spf=pass (google.com: domain of grygorii.strashko@ti.com designates 198.47.27.80 as permitted sender) smtp.mailfrom=grygorii.strashko@ti.com;
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
Subject: [PATCH v2 0/2] net: phy: relax error checking when creating sysfs link netdev->phydev
Date: Fri, 16 Mar 2018 17:08:33 -0500
Message-ID: <20180316220835.30006-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.10.5
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595133782136044428?=
X-GMAIL-MSGID: =?utf-8?q?1595133782136044428?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Some ethernet drivers (like TI CPSW) may connect and manage >1 Net PHYs per
one netdevice, as result such drivers will produce warning during system
boot and fail to connect second phy to netdevice when PHYLIB framework
will try to create sysfs link netdev->phydev for second PHY
in phy_attach_direct(), because sysfs link with the same name has been
created already for the first PHY.
As result, second CPSW external port will became unusable.
This regression was introduced by commits:
5568363f0cb3 ("net: phy: Create sysfs reciprocal links for attached_dev/phydev"
a3995460491d ("net: phy: Relax error checking on sysfs_create_link()"

Patch 1: exports sysfs_create_link_nowarn() function as preparation for Patch 2.
Patch 2: relaxes error checking when PHYLIB framework is creating sysfs
link netdev->phydev in phy_attach_direct(), suppresses warning by using
sysfs_create_link_nowarn() and adds error message instead, so links creation
failure is not fatal any more and system can continue working,
which fixes TI CPSW issue and makes boot logs accessible
in case of NFS boot, for example.

This can be stable material 4.13+.

Changes in v2:
- commit messages updated.

v1: 
 https://patchwork.ozlabs.org/cover/886058/

Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Grygorii Strashko (2):
  sysfs: symlink: export sysfs_create_link_nowarn()
  net: phy: relax error checking when creating sysfs link netdev->phydev

 drivers/net/phy/phy_device.c | 15 +++++++++++----
 fs/sysfs/symlink.c           |  1 +
 2 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.10.5
