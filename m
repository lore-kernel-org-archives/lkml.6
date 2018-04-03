Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752650AbeDCQ3f (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 12:29:35 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59310 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751779AbeDCQ3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 12:29:34 -0400
Date: Tue, 3 Apr 2018 17:29:33 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 1/2] net: bcmgenet: Fix sparse warnings in
 bcmgenet_put_tx_csum()
Message-ID: <20180403162933.GJ30522@ZenIV.linux.org.uk>
References: <20180402225856.4351-1-f.fainelli@gmail.com>
 <20180402225856.4351-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180402225856.4351-2-f.fainelli@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 03:58:55PM -0700, Florian Fainelli wrote:
> skb->protocol is a __be16 which we would be calling htons() against,
> while this is not wrong per-se as it correctly results in swapping the
> value on LE hosts, this still upsets sparse. Adopt a similar pattern to
> what other drivers do and just assign ip_ver to skb->protocol, and then
> use htons() against the different constants such that the compiler can
> resolve the values at build time.

Fuck that and fuck other drivers sharing that "pattern".  It's not hard
to remember:
	host-endian to net-endian short is htons
	host-endian to net-endian long is htonl
	net-endian to host-endian short is ntohs
	net-endian to host-endian long is ntohl

That's *it*.  No convoluted changes needed, just use the right primitive.
You are turning trivial one-liners ("conversions between host- and net-endian
are the same in both directions, so the current code works even though we
are using the wrong primitive, confusing the readers.  Use the right one")
which are absolutely self-contained and safe into much more massive changes
that are harder to follow and which are *not* self-contained at all.

Don't do it.
