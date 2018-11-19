Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D24FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80292145D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1mHTuXE+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80292145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbeKTEMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:12:49 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:40767 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388366AbeKTDI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:08:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=1ADKlYvoqStJ6xtgbjELNxSEP+2pBGdk3EwQEUhmNpA=;
        b=1mHTuXE+gvQxc3bvCyJ7ustNyHQV8cqH8uO/yLvQyg43xU8GwwYDNm+UL6B/ZGoTjPBxBd+tvoemh4u6TIggW6fRF+ygyaCvwxI6AsbmYBqGa/s/kRFXcdqbN/LiupU/G9friRtj5LjcHHzxrJgrOdqXpD+9Dnf0jezqLq//AuU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gOmfC-0008WJ-Ba; Mon, 19 Nov 2018 17:44:42 +0100
Date:   Mon, 19 Nov 2018 17:44:42 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Andreas Schwab <schwab@suse.de>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        davem@davemloft.net, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH net-next v3 1/6] net: phy: mscc: migrate to
 phy_select/restore_page functions
Message-ID: <20181119164442.GB31955@lunn.ch>
References: <mvm8t1pazea.fsf@suse.de>
 <20181119151057.GC26852@lunn.ch>
 <mvm4lcdaynt.fsf@suse.de>
 <20181119152830.GE26852@lunn.ch>
 <20181119154005.GA8367@piout.net>
 <mvmzhu59idl.fsf@suse.de>
 <20181119161204.GC2393@lunn.ch>
 <mvmva4t9h8x.fsf@suse.de>
 <20181119162529.GA31955@lunn.ch>
 <mvmo9al9gfl.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mvmo9al9gfl.fsf@suse.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 05:32:14PM +0100, Andreas Schwab wrote:
> On Nov 19 2018, Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > Lock debugging: prove locking correctness
> 

Lets see how much this gets messed up by email...

.config - Linux/arm 4.20.0-rc2 Kernel Configuration
 > Kernel hacking > Lock Debugging (spinlocks, mutexes, etc...) ──────
  ┌───────── Lock Debugging (spinlocks, mutexes, etc...) ──────────┐
  │  Arrow keys navigate the menu.  <Enter> selects submenus --->  │  
  │  (or empty submenus ----).  Highlighted letters are hotkeys.   │  
  │  Pressing <Y> includes, <N> excludes, <M> modularizes          │  
  │  features.  Press <Esc><Esc> to exit, <?> for Help, </> for    │  
  │ ┌────────────────────────────────────────────────────────────┐ │  
  │ │    [*] Lock debugging: prove locking correctness           │ │  
  │ │    [ ] Lock usage statistics                               │ │  
  │ │    -*- RT Mutex debugging, deadlock detection              │ │  
  │ │    -*- Spinlock and rw-lock debugging: basic checks        │ │  
  │ │    -*- Mutex debugging: basic checks                       │ │  
  │ │    -*- Wait/wound mutex debugging: Slowpath testing        │ │  
  │ │    -*- RW Semaphore debugging: basic checks                │ │  
  │ │    -*- Lock debugging: detect incorrect freeing of live loc│ │  
  │ │    [ ] Lock dependency engine debugging                    │ │  
  │ │    [*] Sleep inside atomic section checking                │ │  
  │ │    [ ] Locking API boot-time self-tests                    │ │  
  │ │    < > torture tests for locking                           │ │  
  │ │    < > Wait/wound mutex selftests                          │ │  
  │ └────────────────────────────────────────────────────────────┘ │  
  ├────────────────────────────────────────────────────────────────┤  
  │    <Select>    < Exit >    < Help >    < Save >    < Load >    │  
  └────────────────────────────────────────────────────────────────┘  
    
If you cannot see it at all, it probably means you are missing a
dependency:

  │   Depends on: DEBUG_KERNEL [=y] && \                           │  
  │ LOCK_DEBUGGING_SUPPORT [=y]                                    │  

    Andrew


