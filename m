Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753807AbeDEUem (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 16:34:42 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:45083 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753773AbeDEUej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 16:34:39 -0400
X-Google-Smtp-Source: AIpwx4/7kb7ZZJRVorDkdgWtew/tDfrERtEi9m/Fl0WH8wFp/b/BTsw4SlqrRnwduN8XBLoBtdispQ==
From: Esben Haabendal <esben.haabendal@gmail.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "open list\:PTP HARDWARE CLOCK SUPPORT" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH 2/2] net: phy: dp83640: Read strapped configuration settings
In-Reply-To: <95678797-bd17-ba3f-8a70-a00b4792a258@gmail.com> (Florian
        Fainelli's message of "Thu, 5 Apr 2018 09:02:38 -0700")
References: <20180405114424.8519-1-esben.haabendal@gmail.com>
        <20180405114424.8519-2-esben.haabendal@gmail.com>
        <95678797-bd17-ba3f-8a70-a00b4792a258@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
Date: Thu, 05 Apr 2018 22:34:35 +0200
Message-ID: <878ta1jstg.fsf@haabendal.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Fainelli <f.fainelli@gmail.com> writes:

> On 04/05/2018 04:44 AM, esben.haabendal@gmail.com wrote:
>> From: Esben Haabendal <eha@deif.com>
>> 
>> Read configration settings, to allow automatic forced speed/duplex setup
>> by hardware strapping.
>
> OK but why? What problem is this solving for you?

It is ensuring that the PHY is configured according to the HW design.
If the HW design has set the strap configuration to fx. fixed 100 Mbit
full-duplex, this avoids Linux configuring it for auto-negotiation.

> In general, we do not really want to preserve too much of what the PHY
> has been previously configured with,

Even when this "previous" configuration is the configuration selected by
the board configuration?

> provided that the PHY driver can re-instate these configuration
> values.

This is sort of what I try to do here.  The PHY driver needs to check
the BMCR register to figure out what the strapped configuration was.
Without that, it is necessary for software configuration to duplicate
the exact same configuration as is encoded in the strap configuration in
order for the PHY to be configured as it is supposed to.

> I just wonder how this can be robust when you connect this PHY with
> auto-negotiation disabled to a peer that expects a set of link
> parameters not covered by the default advertisement values?

I assume it will fail just as it will if you use ethtool to configure
the PHY wrongly.

> This really looks like a recipe for disaster when you could just
> disable auto-negotiation with ethtool.

The current PHY driver approach to always default to enable
auto-negotation, and then allow user-space to configure it differently
with ethtool.

With this patch, the default configuration is chosen based on the strap
configuration, but user-space can still change the configuration with
ethtool if needed / desired.

I don't think it is such a big change.

Bringing up the PHY with a default configuration according to HW
strapping instead of an in-kernel SW hard-coded value sounds like a good
idea to me.

/Esben
