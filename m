Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeCZNen (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 09:34:43 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44049 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751692AbeCZNem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 09:34:42 -0400
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net-next 0/2] net: mvpp2: Remove unnecessary dynamic allocs
Date: Mon, 26 Mar 2018 15:34:21 +0200
Message-Id: <20180326133423.14779-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some utility functions in mvpp2 make use of dynamic alloc to exchange temporary
objects representing Parser Entries (which are generic filtering entries in the
PPv2 controller).

These objects are small (44 bytes each), we can use the stack to exchange them.

Some previous discussion on this topic showed that the mvpp2_prs_hw_read, which
initializes a struct mvpp2_prs_entry based on one of its fields, can easily lead
to erroneous code if we don't zero-out the struct beforehand :

https://lkml.org/lkml/2018/3/21/739

To fix this, I propose to rename mvpp2_prs_hw_read into mvpp2_prs_init_from_hw,
make it zero-out the struct and take the index as a parameter. That's what's
done in the first patch of the series.

The second patch is the V3 of
("net: mvpp2: Don't use dynamic allocs for local variables"), making use of
mvpp2_prs_init_from_hw and taking previous comments into account.

Maxime Chevallier (2):
  net: mvpp2: Make mvpp2_prs_hw_read a parser entry init function
  net: mvpp2: Don't use dynamic allocs for local variables

 drivers/net/ethernet/marvell/mvpp2.c | 320 +++++++++++++++--------------------
 1 file changed, 137 insertions(+), 183 deletions(-)

-- 
2.11.0
