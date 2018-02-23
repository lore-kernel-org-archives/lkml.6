Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519414723-2-14704559449224144170
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
    t=1519414723; b=brhcZGbGSe/CnC1yOaYPsSWL4u3uGNGGB/qsriwMh+20Yic
    xqvMcGoMbhsFsaRr/VGLr98fFydQ2h+rQzVkIgBiJTz13vrkwG30kyIDmde4KsJz
    HTWLaCKniBXtyaGqNxATNTv8ueOWgToC3BuYC3yYMOs2DDBSDjOK7dCGM82KI4PW
    LXkKbJxI1RA7Mq6ze8V54lOp7faStiro5Cf1w06H97s6aTHpLqLln+5xLPSV5jie
    00rQZkU/ZWEgOKkLFS90uDz2TU0pL/eoRWvCLYSXl1//aci8HW7RQgA+LuC1cw2f
    LdCK/vLCch/yNA1JIHhsjjRXhsvvfXgevyEvzKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414723; bh=Z50b7ryVLe51Efola3Q6/DREUR
    67iyJQ94a1j8f4HFs=; b=A23tKb+kCDy1VCDPgXHbHSE63ixVvy+a1Lyw/rQOKd
    H1MtaPRs6z4pmXvlR7qZJ6GU7gNxhvs9Gq4WORAvQOStu7vz5PdrBC8BbXVocVuv
    0atcMg9ITvmZwQ4ERvXqRbfZ+geIiFU2zlKgxpN4s4Ly7yHWu+qEJPYVABkZO9fE
    Xq1d35ZmLkAsRqSFk6rHS+iPTXKBYGc2pJKScR46dMdp5v64vf3bV7PtKtqbMnL8
    upxs/koxVTXpmTF3s27UTbxldp6P0jN6CxlmMrnezzcU33R2kNZ/fXUbLKaF+dIs
    h58Ys1NjoMLOXSMFR8qFlGrYvUiwtCocaV+wp8AnyhVw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934355AbeBWSuB (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:50:01 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45480 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934602AbeBWSuA (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:50:00 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 022/159] ALSA: caiaq: Add a sanity check for invalid EPs
Date: Fri, 23 Feb 2018 19:25:30 +0100
Message-Id: <20180223170745.876499330@linuxfoundation.org>
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

commit 58fc7f73a85d45a47057dad2af53502fdf6cf778 upstream.

As syzkaller spotted, currently caiaq driver submits a URB with the
fixed EP without checking whether it's actually available, which may
result in a kernel warning like:
  usb 1-1: BOGUS urb xfer, pipe 3 != type 1
  ------------[ cut here ]------------
  WARNING: CPU: 1 PID: 1150 at drivers/usb/core/urb.c:449
  usb_submit_urb+0xf8a/0x11d0
  Modules linked in:
  CPU: 1 PID: 1150 Comm: kworker/1:1 Not tainted
  4.14.0-rc2-42660-g24b7bd59eec0 #277
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
  Workqueue: usb_hub_wq hub_event
  Call Trace:
   init_card sound/usb/caiaq/device.c:467
   snd_probe+0x81c/0x1150 sound/usb/caiaq/device.c:525
   usb_probe_interface+0x35d/0x8e0 drivers/usb/core/driver.c:361
   ....

This patch adds a sanity check of validity of EPs at the device
initialization phase for avoiding the call with an invalid EP.

Reported-by: Andrey Konovalov <andreyknvl@google.com>
Tested-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/caiaq/device.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -461,6 +461,13 @@ static int init_card(struct snd_usb_caia
 			  cdev->midi_out_buf, EP1_BUFSIZE,
 			  snd_usb_caiaq_midi_output_done, cdev);
 
+	/* sanity checks of EPs before actually submitting */
+	if (usb_urb_ep_type_check(&cdev->ep1_in_urb) ||
+	    usb_urb_ep_type_check(&cdev->midi_out_urb)) {
+		dev_err(dev, "invalid EPs\n");
+		return -EINVAL;
+	}
+
 	init_waitqueue_head(&cdev->ep1_wait_queue);
 	init_waitqueue_head(&cdev->prepare_wait_queue);
 
