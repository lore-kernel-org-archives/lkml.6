Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C06C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351E12086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 351E12086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbeKTBhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:37:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:42730 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729554AbeKTBhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:37:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 53372B00E;
        Mon, 19 Nov 2018 15:13:11 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Quentin Schulz <quentin.schulz@bootlin.com>, davem@davemloft.net,
        f.fainelli@gmail.com, allan.nielsen@microchip.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH net-next v3 1/6] net: phy: mscc: migrate to phy_select/restore_page functions
References: <20181008100728.24959-1-quentin.schulz@bootlin.com>
        <20181008100728.24959-2-quentin.schulz@bootlin.com>
        <mvm8t1pazea.fsf@suse.de> <20181119151057.GC26852@lunn.ch>
X-Yow:  Either CONFESS now or we go to ``PEOPLE'S COURT''!!
Date:   Mon, 19 Nov 2018 16:13:10 +0100
In-Reply-To: <20181119151057.GC26852@lunn.ch> (Andrew Lunn's message of "Mon,
        19 Nov 2018 16:10:57 +0100")
Message-ID: <mvm4lcdaynt.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 19 2018, Andrew Lunn <andrew@lunn.ch> wrote:

> On Mon, Nov 19, 2018 at 03:57:17PM +0100, Andreas Schwab wrote:
>> On Okt 08 2018, Quentin Schulz <quentin.schulz@bootlin.com> wrote:
>> 
>> > The Microsemi PHYs have multiple banks of registers (called pages).
>> > Registers can only be accessed from one page, if we need a register from
>> > another page, we need to switch the page and the registers of all other
>> > pages are not accessible anymore.
>> >
>> > Basically, to read register 5 from page 0, 1, 2, etc., you do the same
>> > phy_read(phydev, 5); but you need to set the desired page beforehand.
>> >
>> > In order to guarantee that two concurrent functions do not change the
>> > page, we need to do some locking per page. This can be achieved with the
>> > use of phy_select_page and phy_restore_page functions but phy_write/read
>> > calls in-between those two functions shall be replaced by their
>> > lock-free alternative __phy_write/read.
>> >
>> > Let's migrate this driver to those functions.
>> 
>> This has some serious locking problem.
>
> Hi Andreas
>
> Could you be more specific. Are you getting a deadlock? A WARN_ON?

See the stack trace.  That's where it hangs.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
