Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9F5C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 00:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8575C2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 00:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731232AbeLQAo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 19:44:56 -0500
Received: from muru.com ([72.249.23.125]:58482 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731112AbeLQAo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 19:44:56 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id BD1B980E7;
        Mon, 17 Dec 2018 00:44:57 +0000 (UTC)
Date:   Sun, 16 Dec 2018 16:44:50 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org
Cc:     Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Johan Hovold <johan@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marcel Partap <mpartap@gmx.net>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Michael Scott <hashcode0f@gmail.com>,
        NeKit <nekit1000@gmail.com>, omerlle@gmail.com,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh@kernel.org>
Subject: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Message-ID: <20181217004450.GW6707@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

So the little elves have been slowly working to get voice calls
working on droid 4 with the mainline kernel. And just in time for the
upcoming holidays, it might be possible to call friends and relatives.

I've pushed out an experimental branch containing serdev ts 27.010
UART multiplexing support. That contains a serdev core driver for the
mdm6600 modem (that also now idles the modem for PM), support for Alsa
ASoC voice codec and mixer, and a GNSS driver for the GPS.

Where it does not make sense to do a kernel serdev driver, I've
exposed the rest of the available 27.010 channels as ten /dev/motmdm*
character devices. There's /dev/motmdm1 for AT commands to dial voice
calls, /dev/motmdm3 for SMS eventually, and I think there's also a SIM
card reader at /dev/motmdm10. Then /dev/motmdm7 seems to be just an
echo channel. The other channels are still a bit of a mystery.

I'll be cleaning up these patches and submitting them for review
when ready. If anybody feels like helping, I've added some REVISIT
comments to the patches. The patches are in a git branch at [0][1]
below based on a few Alsa ASoC patches for v4.21 from Linux next.

Thanks everybody for helping with comments and code to get the
various pieces working, below are some brief instructions too :)

Cheers,

Tony

[0] https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/log/?h=droid4-pending-mdm-v4.20
[1] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap droid4-pending-mdm-v4.20


8< ----------------------
Serdev voice call and GNSS instructions for droid 4

1. Configure alsamixer

Speaker Right -> Voice
Call Noise Cancellation -> Unmute
Call Output -> Handset
Call -> 100
Mic2 -> 40
Left -> Mic 2
Voice -> 55

Voice call should get automatically enabled for the duration of
voice calls

2. Test a voice call

$ minicom -D /dev/motmdm1	# Then Ctrl-a-e to enable local echo
AT				# Case sensitive AT commands..
:OK				# Response uses : as separator..
AT+CFUN=1			# Enable radio
+CFUN:OK
~+RSSI=1,9,108,99,0,0,0
...
ATD1234567890			# Dial some phone number
D:OK
...
ATH				# Hang up
H:OK

3. Test GNSS

$ cat /dev/gnss0
$GPGSV,3,1,11,03,,,,05,14,313,,07,66,322,,08,32,106,*43
...

4. Known pending issues

There's an issue with gpsd not parsing $GNGNS packets, see
https://lists.gnu.org/archive/html/gpsd-dev/2016-05/msg00298.html

Sending SMS should be doable by writing to /dev/motmdm3 but I have
not quite figured out the message format

I have not tested with built-in modules.. There may be some
deferred probe issues remaining.
