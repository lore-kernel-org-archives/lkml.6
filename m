Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDDCC28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B98D2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ps2MNiUQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B98D2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeJLH1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 03:27:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39370 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbeJLH1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 03:27:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id r9-v6so4924766pgv.6;
        Thu, 11 Oct 2018 16:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=wFerhbmL2lQShuvM3iuTsT3OZlBVk0izBsw+j10zL7s=;
        b=ps2MNiUQuQfSjU+UFpQC9pltcgupMK7JCFXoDNLltUi0mF/YMZtXlORMbG6zYSniK3
         gfP89ScBXApSUZQlcOtdHvdmNXT7+M2npY1QzPKNKx748As1uzHMPdzGKNFKBkerRieN
         G6qElVW64HGnMhDWpdPopcJtxnKtPGPa+emsxhSgQCHRFERqHMEGC0ec/m6S08udTNXm
         UjCjRGgTc9GZ1aYHCdy4oz4LxSMcGqoatrZ5+UqwGM+XywZ4Jfs9/aOa0Xl5FTP0NJi1
         5aFZyRayDMKtrbz6kgxsnctY67154LEgEXLMFrpwm7O2ncK372RWqUFMq2W3k2pJheYZ
         i+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=wFerhbmL2lQShuvM3iuTsT3OZlBVk0izBsw+j10zL7s=;
        b=am2hXnQvcEeDv2kS+IbKMYq5BOH5G51n2kjB2myNrTqPX3KCzOKXLf24UNtJk1pqW7
         At0O5RtJO39nDGeFo2vQ92HKda9g944Xekcqro7FfMREgyla0eGhdl5QkPnN11BW66ei
         PoBErZ59Mr/tAfn44MbM7R5cCn8XUbLpuGBojpUtb0UaEf4vfCHQ11eZHzStnvFKtsx2
         TNbWTyxaFxMiqcAHOvmvCa1rCwk5UMasXfHOKW5j7bjre0aopwsNcHMsJ+us0RWxpyYt
         vjj+Urv6eUlqP04s/tXxyRXMpyqFis1M4okBMNpflzqPODElXfEsRwH+Y6ufwWt+81qx
         J9hg==
X-Gm-Message-State: ABuFfogO5dpR+uN4k/IUZi18zQKjIqY0NIPJ/jG8drv9q611v7jK5hfi
        dKs5YA7q9/137yoSvst/cdw=
X-Google-Smtp-Source: ACcGV63TwdgYTbn4lzznhjV4k1wm90DMMN0BegKHfy+cLKbw19qXBkB+qa9NdUu2FwLe6mqyzIrZyg==
X-Received: by 2002:a63:e04d:: with SMTP id n13-v6mr3366419pgj.426.1539302259654;
        Thu, 11 Oct 2018 16:57:39 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id b10-v6sm40160228pfe.148.2018.10.11.16.57.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 16:57:38 -0700 (PDT)
Date:   Thu, 11 Oct 2018 16:57:36 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v4.19-rc7
Message-ID: <20181011235736.GA68543@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem:

- we added a few scheduling points into various input interfaces to
  ensure that large writes will not cause RCU stalls

- fixed configuring PS/2 keyboards as wakeup devices on newer platforms

- added a new Xbox gamepad ID.

Changelog:
---------

Daniel Drake (1):
      Input: i8042 - enable keyboard wakeups by default when s2idle is used

Dmitry Torokhov (2):
      Input: evdev - add a schedule point in evdev_write()
      Input: uinput - add a schedule point in uinput_inject_events()

Eric Dumazet (1):
      Input: mousedev - add a schedule point in mousedev_write()

Ramses Ramírez (1):
      Input: xpad - add support for Xbox1 PDP Camo series gamepad

Diffstat:
--------

 drivers/input/evdev.c         |  1 +
 drivers/input/joystick/xpad.c |  3 +++
 drivers/input/misc/uinput.c   |  1 +
 drivers/input/mousedev.c      |  1 +
 drivers/input/serio/i8042.c   | 29 ++++++++++++++++++++---------
 include/linux/suspend.h       |  2 ++
 kernel/power/suspend.c        |  6 ++++++
 7 files changed, 34 insertions(+), 9 deletions(-)

Thanks.


-- 
Dmitry
