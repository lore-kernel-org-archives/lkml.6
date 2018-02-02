Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2943005-1517591119-2-11833794949281866659
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
    t=1517591118; b=wp23SWcaGoQ+kwo1Y3rAlKUcyFRivUm9fMhFAQahKazRvCV
    KBpGXDkx4eGTYbCW+E9ArmdPz53uK9eJ03IHXfWXcDQzsaJRKy+gEDBAH+3ssgtX
    YYc7QmvJZJa4glNYU/nsITLvP75CHb4pgawj56CgKBetb9FNCKchPmnTR0hJXGFX
    In1aMBn92YVZSEZyXqt52JbmUcgGk5X0ip6MdrFBWhEkZKDTBEHTB23OEdAbZUb3
    5Qg/l2/VeeKFc1sfRrKZ/6IBJgjbQPIU/k8Hn+FfQE4b33t2cEWlTR2BdLHPA7iu
    4v5ZWqcoJ3cGwuCL70sNOkAoUuLPhxe5lgK41EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591118; bh=yAjtyL89mOQF6iJV0KSWNhMiKS
    ZcmX6WXZJNLc3umDY=; b=eURXmxJMdp4ASLQVo/Rn1oHCDcqzt3qjriGNi59huG
    FtCD96WHTPtSuMYi2pDYcRHec8o4N5quTwMB/zcTIKPmNz9DQQ3lt1Z8vnXt6nTx
    lqqrIYNPJNybAMAuvSFbULxxfwXUWyWWwlrIOqV+7Zc9jcYP3bv/ouCK2J2Nr4aU
    YVGMeLglhUeuMMEIBtYSOyWss8wO/6c7qaalNpn7UxNw6iFN7bEDQYzeRAES86cr
    OxZhdEkCLTiAhUQMpnla44th8dBPWeRKT2moPv5SkWRq7PECbl56cTlvnaV/MfeF
    dEpK3JJteV6lWs8h8isnJsR27YY4f4KMjfWOWMp9dBBw==
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
        id S1752768AbeBBRFP (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:05:15 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36384 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752773AbeBBRFH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:05:07 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Aaron Armstrong Skomra <aaron.skomra@wacom.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.9 11/86] HID: wacom: EKR: ensure devres groups at higher indexes are released
Date: Fri,  2 Feb 2018 17:57:31 +0100
Message-Id: <20180202140823.877348441@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aaron Armstrong Skomra <skomra@gmail.com>

commit 791ae273731fa85d3332e45064dab177ae663e80 upstream.

Background: ExpressKey Remotes communicate their events via usb dongle.
Each dongle can hold up to 5 pairings at one time and one EKR (identified
by its serial number) can unfortunately be paired with its dongle
more than once. The pairing takes place in a round-robin fashion.

Input devices are only created once per EKR, when a new serial number
is seen in the list of pairings. However, if a device is created for
a "higher" paring index and subsequently a second pairing occurs at a
lower pairing index, unpairing the remote with that serial number from
any pairing index will currently cause a driver crash. This occurs
infrequently, as two remotes are necessary to trigger this bug and most
users have only one remote.

As an illustration, to trigger the bug you need to have two remotes,
and pair them in this order:

1. slot 0 -> remote 1 (input device created for remote 1)
2. slot 1 -> remote 1 (duplicate pairing - no device created)
3. slot 2 -> remote 1 (duplicate pairing - no device created)
4. slot 3 -> remote 1 (duplicate pairing - no device created)
5. slot 4 -> remote 2 (input device created for remote 2)

6. slot 0 -> remote 2 (1 destroyed and recreated at slot 1)
7. slot 1 -> remote 2 (1 destroyed and recreated at slot 2)
8. slot 2 -> remote 2 (1 destroyed and recreated at slot 3)
9. slot 3 -> remote 2 (1 destroyed and not recreated)
10. slot 4 -> remote 2 (2 was already in this slot so no changes)

11. slot 0 -> remote 1 (The current code sees remote 2 was paired over in
                        one of the dongle slots it occupied and attempts
                        to remove all information about remote 2 [1]. It
                        calls wacom_remote_destroy_one for remote 2, but
                        the destroy function assumes the lowest index is
                        where the remote's input device was created. The
                        code "cleans up" the other remote 2 pairings
                        including the one which the input device was based
                        on, assuming they were were just duplicate
                        pairings. However, the cleanup doesn't call the
                        devres release function for the input device that
                        was created in slot 4).

This issue is fixed by this commit.

[1] Remote 2 should subsequently be re-created on the next packet from the
EKR at the lowest numbered slot that it occupies (here slot 1).

Fixes: f9036bd43602 ("HID: wacom: EKR: use devres groups to manage resources")
Signed-off-by: Aaron Armstrong Skomra <aaron.skomra@wacom.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/wacom_sys.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2192,23 +2192,23 @@ static void wacom_remote_destroy_one(str
 	int i;
 	unsigned long flags;
 
-	spin_lock_irqsave(&remote->remote_lock, flags);
-	remote->remotes[index].registered = false;
-	spin_unlock_irqrestore(&remote->remote_lock, flags);
+	for (i = 0; i < WACOM_MAX_REMOTES; i++) {
+		if (remote->remotes[i].serial == serial) {
 
-	if (remote->remotes[index].battery.battery)
-		devres_release_group(&wacom->hdev->dev,
-				     &remote->remotes[index].battery.bat_desc);
+			spin_lock_irqsave(&remote->remote_lock, flags);
+			remote->remotes[i].registered = false;
+			spin_unlock_irqrestore(&remote->remote_lock, flags);
 
-	if (remote->remotes[index].group.name)
-		devres_release_group(&wacom->hdev->dev,
-				     &remote->remotes[index]);
+			if (remote->remotes[i].battery.battery)
+				devres_release_group(&wacom->hdev->dev,
+						     &remote->remotes[i].battery.bat_desc);
+
+			if (remote->remotes[i].group.name)
+				devres_release_group(&wacom->hdev->dev,
+						     &remote->remotes[i]);
 
-	for (i = 0; i < WACOM_MAX_REMOTES; i++) {
-		if (remote->remotes[i].serial == serial) {
 			remote->remotes[i].serial = 0;
 			remote->remotes[i].group.name = NULL;
-			remote->remotes[i].registered = false;
 			remote->remotes[i].battery.battery = NULL;
 			wacom->led.groups[i].select = WACOM_STATUS_UNKNOWN;
 		}
