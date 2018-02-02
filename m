Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227avv6EkBlQNVLikW6PCfFU4qApXTuU1Wom4Tk4j4ytkWo1oSoAcn8brbvwMgFIsZk4Gr8M
ARC-Seal: i=1; a=rsa-sha256; t=1517591704; cv=none;
        d=google.com; s=arc-20160816;
        b=N9+PCMpr25Z70pQgahRl+tZXGtdpsmgnkh3qbcfLOqOAClCPgTfa3xENrOCskAGX4i
         mw2JW8+RfPJKRyPDBMGk0hl1QHtk/r3ds666vathaSX7t3cnQZT1a2qELMFefIHdpxkQ
         9RB8us8uuXvHpp4tFLxWJZJ1IKgjMc35mElvyd0l6Y0UsIQf1oWMdrsWA9InNkj/1qiq
         bNkWUfqhF2NPQ/RyLFEG1bGQdEsjyoraLOkkqWW4o4fjAJgLPFsaUFyPSXiBnT/ZBJW/
         rrsN2uixwAfUZKuZPvr3V3DgqSGTFM9SgAtVaX/9DKIBQNW+tZ41ceCzVM3VfzUE/BEN
         bRKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ApKFnqhklY3IT22WgBSTCS5r7sUzVq4EkzHU0QWgpi8=;
        b=pIHK27IoyVy9qPpnpW9eplQJtpwlaLrj+Vi7QuTn14OIyHtNLNb6c6FhrFBML1j6DZ
         k5qUwdstAOZhDy+wogVumvFGrE27yJN908gA8/QVtRDnl9e7sfjZeuG9FS1M4j1TW7vD
         pQZFNhjIZ2A3d9iUcvZqJopZwe42oenmqxFqePYJvHfsEsza84pqIwVz/nu4y2IYR+bH
         1P0zQiF7dK4KQVlnQlqlX3U1MGvxtOJxrV1ekbqD3f+XlO56enfQgW5yufjvEIgZpeL6
         ifOhksnmfhHIOrKxIzeoc2G9sTPzt6pkSQHCVHEkhyM1gkn4VwY1eFn2/92qIwDQa+fF
         vhRA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Aaron Armstrong Skomra <aaron.skomra@wacom.com>,
	Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.15 16/55] HID: wacom: EKR: ensure devres groups at higher indexes are released
Date: Fri,  2 Feb 2018 17:58:34 +0100
Message-Id: <20180202140827.785498296@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309613344059565?=
X-GMAIL-MSGID: =?utf-8?q?1591310239371823253?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2347,23 +2347,23 @@ static void wacom_remote_destroy_one(str
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
