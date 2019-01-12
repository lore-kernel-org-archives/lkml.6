Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256DDC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 15:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A712084C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 15:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbfALPdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 10:33:54 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:33892 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfALPdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 10:33:54 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id BA8038034E;
        Sat, 12 Jan 2019 16:33:49 +0100 (CET)
Date:   Sat, 12 Jan 2019 16:33:48 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH V7 2/2] drm/panel: Add Sitronix ST7701 panel driver
Message-ID: <20190112153348.GA12461@ravnborg.org>
References: <20190111124714.19566-1-jagan@amarulasolutions.com>
 <20190111124714.19566-2-jagan@amarulasolutions.com>
 <20190111211931.GA29735@ravnborg.org>
 <CAMty3ZArGPf8+M5GVhkzoMDhtYwT3aUS9bNbKt8=gqeb6-b82Q@mail.gmail.com>
 <20190112101409.GA14273@ravnborg.org>
 <CAMty3ZBUNeFvsHDRmBFUoZG=J+EfQuKtJDOhaezcfEOykhpOeQ@mail.gmail.com>
 <20190112120056.GA7374@ravnborg.org>
 <CAMty3ZAvEzatWMPbtPKUhVRMSzC9icarsxK7KfXAp+gvCR74Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMty3ZAvEzatWMPbtPKUhVRMSzC9icarsxK7KfXAp+gvCR74Lw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=IkcTkHD0fZMA:10 a=_LFP0PS5GB3_aTSERa0A:9 a=QEXdDO2ut3YA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan.

> > But as we just assert reset (set it to 0), this timing constraint can be ignored.
> 
> But we unaware of reset pulse duration right? it's the hardware that
> bring the reset assert if we set the line 0. am I correct or do we
> need to explicitly wait 10us after reset initiated?
> there is family of chip Sitronix st7789v which don't taking care of
> this sequence (I don't know why?) in
> drivers/gpu/drm/panel/panel-sitronix-st7789v.c with Page 48 of
> datasheet[2]


The prepare sequence used is:
1) reset
   20 ms
2) regulator enable
   20 ms
3) unassert reset
   20 ms
4) assert reset
   30 ms
4) unassert reset
   150 ms
5) SOFT RESET
   5 ms
6) Exit SLEEP mode
   sleep_delay (120 ms)
7) COMMANDS

The enable sequence is
1) Display ON
2) backlight enable


The disable sequence is
1) backlight disable
2) Display OFF

The unprepare sequence is
1) Exit SLEEP mode  <= this should be Enter SLEEP mode (covered by previous mail)
   sleep_delay (120 ms)
2) assert reset
3) unassert reset
4) assert reset
5) regulator disable


The implementation in simple-panel supports a long list of panels so we
can assume this is a good reference implementation.
Unless your combo of st7701 + panel has special requirements.

Prepare sequence:
-----------------
- Just set reset to 1 - no need to trigger an edge.
  But if you somehow think the edge is required keep the current code
  but drop the delays that are not required.
  We can assume power is OK when it is enabled, no extra waiting required.
- No reason to unassert and then assert and then unassert reset.

In other words:
- Delay between 1 and 2 can be dropped.
- step 3 and step 4 can be dropped

Unprepare sequence:
-------------------
Enter SLEEP mode may take 120 ms so delay between 1) and 2) is OK.
No reason to do the reset dance, drop 2) and 3)
Make sure reset is completed, so wait before leaving the function.
See note 3. on page 54 in datasheet:

	"During the Resetting period, the display will be blanked
	 (The display is entering blanking sequence, which maximum
	 time is 120 ms, when Reset Starts in Sleep Out –mode.
	 The display remains the blank state in Sleep In –mode.) and
	  then return to Default condition for Hardware Reset."

We have already sent an Enter SLEEP command but we have no timing constrains
when panel is in SLEEP mode, So stick to the 120 ms.
Just use sleep_delay.

Thats my best understanding, your reading of the datasheet or your testing
may prove different.

	Sam
