Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519414746-2-12217629666890461522
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
    t=1519414745; b=BIE8RdsAkLIGlZYFmY9/FaEdkvArQNSxoFeitMsaXcE50Rx
    WAdhbIhJPk22cJtJbwLS1LEd4FAOR4TvyZRVTXEYZCUh+TdH391LFwAlhyYYJ+RH
    HXlUQGr9T0R+RBcaiEvvjzV2865h/MPSHtcxffaUJZ/RFomhHpeBpRf9767u+3rT
    pVrL/rTlGpiIePyqmg8TYCZkMYRecKAUOJ48dlHTJIKKvvaoD0ft7IG/ImRwm7h5
    jlijUSs/fqPScgXu9Cv4KExb2jRzeIuK1sVgZsS3DO4xAssM52sFnL6sCmeMj8WV
    muxRiGvrtHYlfBYYmXRFmlpBAsoGgt7w+2Hb/lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414745; bh=/Gw3Y4LVZxB3WvNbw3IxiMdzt7
    hh1qBZFFcI0FLxoX0=; b=BZheWFyrzxfbC47Gi8FZMrkeOC5mPXpM0p30QIOCc6
    sJQ8eb1Iqciua/d4j4tlrEyB8qKdn9wYqvM3p0xfOl3mLzX0tEhZciOifU+H4DcG
    rE5gLAVmc2tXj1E34PTda1sqdtKf0GG+V0w6j5uWY6FBf+/0YN+sPOFPj5nmOsSQ
    3hB7toeRP4deXcOyncPITWhpy552eijlD+ZB3QdLqQPTmXzudXl0titW0EdApQS2
    t9cwzjBFiWWFGD6KzAwDNFEqmG8mwCM8XGJx8zZhC6ETrn7Xibt+3t0aA+p7lr5G
    eymzBj1UMVP2iZ6+1bpYT04l+PN42yGHJleT1xjkJ/Dg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754555AbeBWTit (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:38:49 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45470 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934323AbeBWSt5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:49:57 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 021/159] ALSA: line6: Add a sanity check for invalid EPs
Date: Fri, 23 Feb 2018 19:25:29 +0100
Message-Id: <20180223170745.762995404@linuxfoundation.org>
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

commit 2a4340c57717162c6bf07a0860d05711d4de994b upstream.

As syzkaller spotted, currently line6 drivers submit a URB with the
fixed EP without checking whether it's actually available, which may
result in a kernel warning like:
  usb 1-1: BOGUS urb xfer, pipe 3 != type 1
  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 24 at drivers/usb/core/urb.c:449
  usb_submit_urb+0xf8a/0x11d0
  Modules linked in:
  CPU: 0 PID: 24 Comm: kworker/0:1 Not tainted 4.14.0-rc2-42613-g1488251d1a98 #238
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
  Workqueue: usb_hub_wq hub_event
  Call Trace:
   line6_start_listen+0x55f/0x9e0 sound/usb/line6/driver.c:82
   line6_init_cap_control sound/usb/line6/driver.c:690
   line6_probe+0x7c9/0x1310 sound/usb/line6/driver.c:764
   podhd_probe+0x64/0x70 sound/usb/line6/podhd.c:474
   usb_probe_interface+0x35d/0x8e0 drivers/usb/core/driver.c:361
   ....

This patch adds a sanity check of validity of EPs at the device
initialization phase for avoiding the call with an invalid EP.

Reported-by: Andrey Konovalov <andreyknvl@google.com>
Tested-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/line6/driver.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -78,6 +78,13 @@ static int line6_start_listen(struct usb
 			line6->buffer_listen, LINE6_BUFSIZE_LISTEN,
 			line6_data_received, line6);
 	}
+
+	/* sanity checks of EP before actually submitting */
+	if (usb_urb_ep_type_check(line6->urb_listen)) {
+		dev_err(line6->ifcdev, "invalid control EP\n");
+		return -EINVAL;
+	}
+
 	line6->urb_listen->actual_length = 0;
 	err = usb_submit_urb(line6->urb_listen, GFP_ATOMIC);
 	return err;
