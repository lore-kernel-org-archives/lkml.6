Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756486AbeEASTe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 14:19:34 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:48468 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756333AbeEASTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 14:19:32 -0400
Date: Tue, 01 May 2018 14:19:30 -0400 (EDT)
Message-Id: <20180501.141930.969764198768375676.davem@davemloft.net>
To: wang6495@umn.edu
Cc: kjlu@umn.edu, f.fainelli@gmail.com, andrew@lunn.ch,
        ecree@solarflare.com, rmk+kernel@armlinux.org.uk, alan.brady@intel.com,
        stephen@networkplumber.org, eugenia@mellanox.com, inbark@mellanox.com,
        vidya.chowdary@gmail.com, ynorov@caviumnetworks.com,
        viro@zeniv.linux.org.uk, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ethtool: fix a potential missing-check bug
From: David Miller <davem@davemloft.net>
In-Reply-To: <1525109474-5595-1-git-send-email-wang6495@umn.edu>
References: <1525109474-5595-1-git-send-email-wang6495@umn.edu>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wang6495@umn.edu>
Date: Mon, 30 Apr 2018 12:31:13 -0500

> In ethtool_get_rxnfc(), the object "info" is firstly copied from
> user-space. If the FLOW_RSS flag is set in the member field flow_type of
> "info" (and cmd is ETHTOOL_GRXFH), info needs to be copied again from
> user-space because FLOW_RSS is newer and has new definition, as mentioned
> in the comment. However, given that the user data resides in user-space, a
> malicious user can race to change the data after the first copy. By doing
> so, the user can inject inconsistent data. For example, in the second
> copy, the FLOW_RSS flag could be cleared in the field flow_type of "info".
> In the following execution, "info" will be used in the function
> ops->get_rxnfc(). Such inconsistent data can potentially lead to unexpected
> information leakage since ops->get_rxnfc() will prepare various types of
> data according to flow_type, and the prepared data will be eventually
> copied to user-space. This inconsistent data may also cause undefined
> behaviors based on how ops->get_rxnfc() is implemented.
> 
> This patch simply re-verifies the flow_type field of "info" after the
> second copy. If the value is not as expected, an error code will be
> returned.
> 
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>

Applied, thanks.
