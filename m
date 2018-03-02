Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934257AbeCBXIx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 18:08:53 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35289 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932885AbeCBXIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 18:08:51 -0500
X-Google-Smtp-Source: AG47ELs8O/gFPlBGKMuMMiSpB/PrZ765eapIZ4yNfBcB7FIOIGkpzjnIgSl5EzXkHr7YLC60pBKMAg==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: david.laight@aculab.com, Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        linux-kernel@vger.kernel.org (open list), opendmb@gmail.com,
        davem@davemloft.net
Subject: [PATCH v2 0/4] net: Use strlcpy() for ethtool::get_strings
Date: Fri,  2 Mar 2018 15:08:35 -0800
Message-Id: <20180302230839.31468-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After turning on KASAN on one of my systems, I started getting lots of out of
bounds errors while fetching a given port's statistics, and indeed using
memcpy() is unsafe for copying strings which have not been declared as an array
of ETH_GSTRING_LEN bytes, so let's use strlcpy() instead. This allows the best
of both worlds: we still keep the efficient memory usage of variably sized
strings, but we don't copy more than we need to.

Changes in v2:
- dropped the 3 other patches that were not necessary
- use strlcpy() instead of strncpy()

Florian Fainelli (4):
  net: dsa: b53: Use strlcpy() for ethtool::get_strings
  net: phy: marvell: Use strlcpy() for ethtool::get_strings
  net: phy: micrel: Use strlcpy() for ethtool::get_strings
  net: phy: broadcom: Use strlcpy() for ethtool::get_strings

 drivers/net/dsa/b53/b53_common.c | 4 ++--
 drivers/net/phy/bcm-phy-lib.c    | 4 ++--
 drivers/net/phy/marvell.c        | 4 ++--
 drivers/net/phy/micrel.c         | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.14.1
