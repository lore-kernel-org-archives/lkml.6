Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528B2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F0920657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391115AbfAPO7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:59:10 -0500
Received: from muru.com ([72.249.23.125]:33832 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728675AbfAPO7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 09:59:09 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9938C8030;
        Wed, 16 Jan 2019 14:59:14 +0000 (UTC)
Date:   Wed, 16 Jan 2019 06:59:04 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Johan Hovold <johan@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marcel Partap <mpartap@gmx.net>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Michael Scott <hashcode0f@gmail.com>,
        NeKit <nekit1000@gmail.com>, omerlle@gmail.com,
        Sebastian Reichel <sre@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Message-ID: <20190116145904.GM5544@atomide.com>
References: <20181217004450.GW6707@atomide.com>
 <20181227101647.GA32260@amd>
 <20181228193105.GW6707@atomide.com>
 <20190116135829.GA10426@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116135829.GA10426@amd>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [190116 13:58]:
> Hi!
> 
> > * Pavel Machek <pavel@ucw.cz> [181227 10:17]:
> > > Ok, I really need SMS messages, too.
> > > 
> > > Fortunately, they are on /dev/motmdm9, in PDU format. Quite
> > > logical. And you probably need to acknowledge them, using PDU,
> > > too... (because otherwise you'll just get the same SMS over and over
> > > and over). Which is also logical, but hard to do from shell/python.
> > 
> > Yeah so I found that Ruby pdu_tools module allows decoding PDUs
> > properly while I did not have much luck with other tools.
> > 
> > So I wrote a hasty script to read SMS, copy it to a Maildir and
> > then ack it:
> > 
> > https://github.com/tmlind/droid4-sms-tools
> 
> I could not get that one to work.
> 
> /var/lib/gems/2.3.0/gems/phone-1.2.3/lib/support.rb:47:in
> `class_eval': /var/lib/gems/2.3.0/gems/phone-1.2.3/lib/support.rb:47:
> `@@{' is not allowed as a class variable name (SyntaxError)
> /var/lib/gems/2.3.0/gems/phone-1.2.3/lib/support.rb:47: syntax error,
> unexpected end-of-input
>           unless defined? @@{:default=>true}
> 	                              ^
> from /var/lib/gems/2.3.0/gems/phone-1.2.3/lib/support.rb:47:in `block in cattr_accessor'

Hmm yeah looking at my notes I also had some issues and did something like
this to install git version of phone gem:

$ git clone git://github.com/carr/phone
$ cd phone
$ sed -i 's/beta//' lib/phone/version.rb
$ cd phone
$ sed -i 's/1.3.0.beta1/1.2.9/' lib/phone/version.rb
$ gem build phone.gemspec
$ sudo gem uninstall phone
$ sudo gem uninstall bigdecimal -v 1.4.2        # 1.3.4 works
$ sudo gem install phone-1.2.9.gem

> And I wanted to ask -- did you figure out how to acknowledge the
> SMSs? +CGNNA does not seem to do the job:
> 
> 07912470338016...
> AT+CGNMA=1
> +CGNMA:ERROR=9

Yeah the scripts in droid4-sms-tools git repo work for me for sending
and receiving. They do not work with cdma currently as the format is
different.

Maybe you've managed to change the mode of the modem to queue the
messages with the at commands to the usb port?

You are reading and writing to /dev/motmdm9 for incoming sms right?

> > My logs show that Android uses two different commands for ack.
> > Either AT+GCNMA=1 or AT+CNMA=0,0 gets used depending on something
> > that I have no idea of.. Maybe the network connected?

I think AT+GCNMA=1 works 3g and AT+CNMA=0,0 with cdma. Or it could be
that one of them is just a delayed ack, I don't know.

Regards,

Tony
