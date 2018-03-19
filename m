Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuYMhMR1NuaMcjvp+EhBZaYBJC7Nh8R+FVj68jM92Q3p5X+fYYLmvYUsOLysV2CTjCY2pFp
ARC-Seal: i=1; a=rsa-sha256; t=1521483562; cv=none;
        d=google.com; s=arc-20160816;
        b=TWPOFXApNK70pUE6Jk4rSO10PUGAe0xCm8FVeCLRM1ZnbGAB80khKFzNE6l5brNhHx
         luYRQuT5UGJtKxhLfuQ5yZXrVIK/P2qpI/aaLLxj7jSvSrbNg0u66kn4io9xhOLZ8IWq
         tNL44Uf+1dDbgyCP6Un6dPCxDg9EQVYLmTAPToPlvrnFSKLQaZ9Iltkz/oRIjkjPtPm4
         PVbLLrSZsLIienTh+mh4/Q4Kj/d33HqHdhVWOchANimL7p7mc4AxvI2dHrMeiYv9FbnH
         Wg/niwBIXfLMKpdyf5KgKZ9j8Vkg1nr0be6UX5HIHo1XH721pYwnrBg/MMQs5rGwILMK
         OfrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bVYeul09x2/KTk9nBRa6BhjUwVQgthjmgDPHM5zubAk=;
        b=cJsGRbtFnqKYO7Hc6jaHXS5jgB23eBGfd1EXUIdqn6OFCAWoZjK5wyHi6QWsAm4/AK
         8ldxf5Ck8Hkg9KUwf5a15Z6DO085A8Uk2gOo4cUtAaOC21Wr0LEMaBRwsbTrNxS5Te4F
         VSAT7E7nx0v5aN8tOMbMHTXG4xi27coM5FgnkTuaHJonYSq3c6iwq3avBlGO6DT+8cbI
         coDMGCS38h5yTsAn6TfOdn6XERdsZrSAK6isP7O61vJGzAe+h3TLYOxuATbZTdoMf1br
         fZbGrdRqssQWhYA6eNQ5EeNe5rNh21FAGJ/0D4lnwzyaFL61o/mnRaJ6N//3md/gpOAi
         uh1A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Oliver Neukum <oneukum@suse.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 035/241] usb: misc: lvs: fix race condition in disconnect handling
Date: Mon, 19 Mar 2018 19:05:00 +0100
Message-Id: <20180319180752.635543182@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391148154086523?=
X-GMAIL-MSGID: =?utf-8?q?1595391148154086523?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>


[ Upstream commit c4ba329cabca7c839ab48fb58b5bcc2582951a48 ]

There is a small window during which the an URB may
remain active after disconnect has returned. If in that case
already freed memory may be accessed and executed.

The fix is to poison the URB befotre the work is flushed.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/misc/lvstest.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/misc/lvstest.c
+++ b/drivers/usb/misc/lvstest.c
@@ -433,6 +433,7 @@ static void lvs_rh_disconnect(struct usb
 	struct lvs_rh *lvs = usb_get_intfdata(intf);
 
 	sysfs_remove_group(&intf->dev.kobj, &lvs_attr_group);
+	usb_poison_urb(lvs->urb); /* used in scheduled work */
 	flush_work(&lvs->rh_work);
 	usb_free_urb(lvs->urb);
 }
