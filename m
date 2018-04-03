Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbeDCQXh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 12:23:37 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59190 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751376AbeDCQXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 12:23:36 -0400
Date: Tue, 3 Apr 2018 17:23:34 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 2/2] net: systemport: Fix sparse warnings in
 bcm_sysport_insert_tsb()
Message-ID: <20180403162334.GI30522@ZenIV.linux.org.uk>
References: <20180402225856.4351-1-f.fainelli@gmail.com>
 <20180402225856.4351-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180402225856.4351-3-f.fainelli@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 03:58:56PM -0700, Florian Fainelli wrote:
> skb->protocol is a __be16 which we would be calling htons() against,
> while this is not wrong per-se as it correctly results in swapping the
> value on LE hosts, this still upsets sparse. Adopt a similar pattern to
> what other drivers do and just assign ip_ver to skb->protocol, and then
> use htons() against the different constants such that the compiler can
> resolve the values at build time.

This is completely bogus.  What sparse is complaining about is htons used
to convert from big-endian to host-endian.  Which is what ntohs is for.
IOW, instead of all that crap just

-		ip_ver = htons(skb->protocol);
+		ip_ver = ntohs(skb->protocol);

and be done with that.  Same in other drivers with the same problem.
