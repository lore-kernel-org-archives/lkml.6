Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519414714-2-10991120816937436134
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519414714; b=YSTEFGU3HT5VviB8w/pz+3/foJ2ddXVw1jJJ7IlOJ09RHHQ
    kxk+7d7SmGF1uU/TFAQsym/gudYSBUy149GmhTclFoRIamqgdcfPd1ystYnLQe3J
    OaVcS7lAfJOmyeA5DGFuUpFaFzsr8aN+o36GVyaj4gHRfkV8uPffrVbsHm6pSb9x
    ZR8vYTDAlZt/HRdlPrzySQdBvlaEIATDI2RYqQsUt30vWEs+kXZzRk+bZqVBmpWi
    nQY4VaLGyjIVjd2M4duqJBESLR3wT1gU5P+616Sf0bSPjPez9NP5UT8tFcGQ+/Wb
    7a0lp7djhLRZapl7vwreaogef8v1UK2umGY9LXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414714; bh=2MAtqfklvjbghIMgLzFkMCdI6m
    0UF92EQ7c6BOjHbO4=; b=D24PSfs5OAuR/iO2Ur+xzScBypl7ohb4Og6kcmP84F
    yDG9XAv2Bcjt1XOm3VzLiKEjpkAlshVPr39XYGt+jfUFWFJ9OV7692BQcEVC3sbC
    rGrzK2dM95D5BxYhiDjuP2VNQxETAjRBZfZtYPFf6dGPVXfSqlKr+Vnq71NNTsoM
    b0Txw6p6ExNyB4QkpQa4ZU4AAljm3WEZRJjHgPe6b2tWx4FkPHz4Ie1CccJBS18W
    pibCmiYSuC5K0OCT49uvra8fchVbys8VJ92kGAdpX4aq2Gz90j9hqspS9tKX2ZPq
    W9p3H8jNUFmlErobianP4zM6zwizXNmSf1zDFJleSRCA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934602AbeBWSuG (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:50:06 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45508 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934413AbeBWSuF (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:50:05 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 023/159] ALSA: bcd2000: Add a sanity check for invalid EPs
Date: Fri, 23 Feb 2018 19:25:31 +0100
Message-Id: <20180223170745.997497718@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 6815a0b444572527256f0d0efd8efe3ddede6018 upstream.

As syzkaller spotted, currently bcd2000 driver submits a URB with the
fixed EP without checking whether it's actually available, which may
result in a kernel warning like:
  usb 1-1: BOGUS urb xfer, pipe 1 != type 3
  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 1846 at drivers/usb/core/urb.c:449
  usb_submit_urb+0xf8a/0x11d0
  Modules linked in:
  CPU: 0 PID: 1846 Comm: kworker/0:2 Not tainted
  4.14.0-rc2-42613-g1488251d1a98 #238
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
  Workqueue: usb_hub_wq hub_event
  Call Trace:
   bcd2000_init_device sound/usb/bcd2000/bcd2000.c:289
   bcd2000_init_midi sound/usb/bcd2000/bcd2000.c:345
   bcd2000_probe+0xe64/0x19e0 sound/usb/bcd2000/bcd2000.c:406
   usb_probe_interface+0x35d/0x8e0 drivers/usb/core/driver.c:361
   ....

This patch adds a sanity check of validity of EPs at the device
initialization phase for avoiding the call with an invalid EP.

Reported-by: Andrey Konovalov <andreyknvl@google.com>
Tested-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/bcd2000/bcd2000.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/sound/usb/bcd2000/bcd2000.c
+++ b/sound/usb/bcd2000/bcd2000.c
@@ -342,6 +342,13 @@ static int bcd2000_init_midi(struct bcd2
 				bcd2k->midi_out_buf, BUFSIZE,
 				bcd2000_output_complete, bcd2k, 1);
 
+	/* sanity checks of EPs before actually submitting */
+	if (usb_urb_ep_type_check(bcd2k->midi_in_urb) ||
+	    usb_urb_ep_type_check(bcd2k->midi_out_urb)) {
+		dev_err(&bcd2k->dev->dev, "invalid MIDI EP\n");
+		return -EINVAL;
+	}
+
 	bcd2000_init_device(bcd2k);
 
 	return 0;
