Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933339AbeEIBDf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 21:03:35 -0400
Received: from muru.com ([72.249.23.125]:41302 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932988AbeEIBDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 21:03:34 -0400
Date: Tue, 8 May 2018 18:03:24 -0700
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: ofono@ofono.org, kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: Incoming sms problem on Motorola Droid 4
Message-ID: <20180509010324.GA98604@atomide.com>
References: <20180508215102.GA5253@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508215102.GA5253@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180508 21:53]:
> Hi!
> 
> I have problems with incoming SMS. ofono tries to use +CNMI=1,2,2,1,0
> 
> > AT+CNMI=?
> < +CNMI: (0,1,2),(0,1,2,3),(0,2),(0,1,2),(0,1)
> < OK
> ofonod[3070]: drivers/atmodem/sms.c:build_cnmi_string()
> ofonod[3070]: drivers/atmodem/sms.c:construct_ack_pdu()
> > AT+CNMI=1,2,2,1,0
> < OK
> ofonod[3070]: src/network.c:__ofono_netreg_add_status_watch() 0x5bbbf0
> 
> ... unfortunately, with that configuration no messages are comming to
> ofono and the other phone sees them as "delievery failed".
> 
> I had some luck with unicsy_demo using AT+CNMI=1,2 with text mode (not
> PDU) messages. That works well enough for me.
> 
> Unfortunately, if I force ofono to pass "AT+CNMI=1,2", it does not
> work well, either.
> 
> Any ideas how to debug this / what to try?

Well you can try to see what Android is doing for SMS with:

# echo 0x7fffffff > /sys/module/ts27010mux/parameters/debug_level
# dmesg | grep ts27010 | grep AT

To send SMS, looks like Android RIL first does:

2 AT+CMGS=327 where 327 seems to be the size of the whatever
encoded message. Then the next packet to dlci 2 contains the
encoded message that is of size 327.

When receiving, mdm6600 sends these on dlci 1:
~+WAKEUP
~+WAKEUP
~+WAKEUP

Then mdm6600 sends this on dlci 9:
~+CMT=372

And that's probably the incoming SMS size. But I don't see
anything for what actually reads the incoming SMS.

Regards,

Tony
