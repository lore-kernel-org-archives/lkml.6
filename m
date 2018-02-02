Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2879036-1517590966-2-3913344609994614160
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517590966; b=hjWEc1N2D555C3K1TKVSWAF/i9fD6a3kuDNuEHxSMRWhhwQ
    iLGGC4OKm+FtkqQVgK3KwVGK25fzC9gMAur6OmSv+SyBX4tP2oHC4T/Q/9PFK3gL
    epkT5ylBXOKq15QjaNMIhivisZMc2rG0aPuRB6PzYGmxzw2O24r5CNCUFtjSYMZC
    KCScvvgUyAL2bCc7NRCxzlJdYDf2a4Sx9FMcc5EWqxmrRFK+CtDmauC84BRIXWxY
    45d9Rl79/o/Jt9h3FJL4BGn+oT2qqUtJ+nXTgtMGdLssgfY/PL0OtUVOr21UWbW1
    QHPyHc61Wj+ca8YNP9VI9gNSasXu+nkRKIU4SGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517590966; bh=Te7qtmHhImi2V88Ur4wUA6Eh9/
    Ha3LL+a804U5rIxEU=; b=PTtDWG7PzaqlxuKAJuy64MLKlapa5bz5gv0DvZNf6u
    pa+FzTh4uH1SOshclUN9Nfr5IN3fyMB3+QXpnlbzYrturi4J5fwWqmeeoHyOZiAa
    43F0bqMCSCZddgcIppCrCT51v5dCz8DUpLxmvdbEhm2n8N+fsWVRkr5PE35nC0Rg
    CqoKjSveEItJX01C80XP8LS6m5E4ajDRwlxdW1UrWwsUbpCw0qAPtGjxcqAG5k4x
    IdKJulwzMy29dougal3CiS7S8Yrm8X/2DLBNnPwwyzonOW0W0VodR58bN49jwvyG
    LLyUZI9p/3os9RyJxSEq/hN52URyc/dfQiOGld0FE/xQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752568AbeBBRCl (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:02:41 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35464 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752768AbeBBRCf (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:02:35 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4.4 64/67] usb: uas: unconditionally bring back host after reset
Date: Fri,  2 Feb 2018 17:58:33 +0100
Message-Id: <20180202140822.268335379@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

commit cbeef22fd611c4f47c494b821b2b105b8af970bb upstream.

Quoting Hans:

If we return 1 from our post_reset handler, then our disconnect handler
will be called immediately afterwards. Since pre_reset blocks all scsi
requests our disconnect handler will then hang in the scsi_remove_host
call.

This is esp. bad because our disconnect handler hanging for ever also
stops the USB subsys from enumerating any new USB devices, causes commands
like lsusb to hang, etc.

In practice this happens when unplugging some uas devices because the hub
code may see the device as needing a warm-reset and calls usb_reset_device
before seeing the disconnect. In this case uas_configure_endpoints fails
with -ENODEV. We do not want to print an error for this, so this commit
also silences the shost_printk for -ENODEV.

ENDQUOTE

However, if we do that we better drop any unconditional execution
and report to the SCSI subsystem that we have undergone a reset
but we are not operational now.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Reported-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/storage/uas.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -1052,20 +1052,19 @@ static int uas_post_reset(struct usb_int
 		return 0;
 
 	err = uas_configure_endpoints(devinfo);
-	if (err) {
+	if (err && err != ENODEV)
 		shost_printk(KERN_ERR, shost,
 			     "%s: alloc streams error %d after reset",
 			     __func__, err);
-		return 1;
-	}
 
+	/* we must unblock the host in every case lest we deadlock */
 	spin_lock_irqsave(shost->host_lock, flags);
 	scsi_report_bus_reset(shost, 0);
 	spin_unlock_irqrestore(shost->host_lock, flags);
 
 	scsi_unblock_requests(shost);
 
-	return 0;
+	return err ? 1 : 0;
 }
 
 static int uas_suspend(struct usb_interface *intf, pm_message_t message)
