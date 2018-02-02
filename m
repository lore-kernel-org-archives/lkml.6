Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226vifsMCXXxNCDRGFeytGg6jlYTXRiWcIq466ycx6f0BrkldGosZ2jdliENRyv+FbIc+/D+
ARC-Seal: i=1; a=rsa-sha256; t=1517590919; cv=none;
        d=google.com; s=arc-20160816;
        b=SrFdGqHyuBpSq9rKId++GyG0ew6LkmAZJGWx1BesEdqj5G63MSUXvz/eHNXs3m7IK+
         ikF0v4NcfG/BKqiCP3zt0452oom7H56BNxUDxRvsMmtdPayogNHoB1tF22PJRAMOkcGH
         WV2XZB4BRA5axkuNrYHdIkKKTfwMOWxTN/3JYmZscoYHj7s2KL3krJ51NA0CldzaCmb4
         qPzjT8V6KxJmVpudoG6wEwDe+wVxzohZGqItoQfofARwiSt0nFC8RpHd0p2xsq6lJG+j
         Aw6h3Ay71gZax+0W1zAV5Jh+UdZp9yhMmbWc2RwQHqNWTHs5zjjR4PGA1mt2gpowSgND
         rAHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cm3t7wtCMBpCPDkR8GsfcMo8pu10Q4wo+tUKkicZFrw=;
        b=vPeTZxWVv+FOh462elRG2XS+xV9VsCuZ3aYCe9g+wdA/oNykwihdDtmxLyMJg5KYr6
         MOrnb8X9rNV36QVwl73dBqTHovmBdbwIHh5UMbv2G3NMOk90DywW1XWN5z/lPidwQtdW
         JiDiGLObsEWbKMwJHhFYvKTAVe35XoA0V+i5axV4hYEnn6jDBwb7nyfjnjrYCunDoRzK
         OtyUIDOynk6J9SLMCXEHVJoriO/6o8Om4W3VVgO4fFzXnMPJfU8Sx1FXLVqzg3m/YgVR
         PG/LKOXR/SNWpyl0KWps50vFEBx7PNPItqZidJqgz5DkAB6LdM5tb2W9G4Yn7Er59Nby
         Z3Ww==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 4.4 57/67] USB: cdc-acm: Do not log urb submission errors on disconnect
Date: Fri,  2 Feb 2018 17:58:26 +0100
Message-Id: <20180202140821.585669569@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309416129281728?=
X-GMAIL-MSGID: =?utf-8?q?1591309416129281728?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit f0386c083c2ce85284dc0b419d7b89c8e567c09f upstream.

When disconnected sometimes the cdc-acm driver logs errors like these:

[20278.039417] cdc_acm 2-2:2.1: urb 9 failed submission with -19
[20278.042924] cdc_acm 2-2:2.1: urb 10 failed submission with -19
[20278.046449] cdc_acm 2-2:2.1: urb 11 failed submission with -19
[20278.049920] cdc_acm 2-2:2.1: urb 12 failed submission with -19
[20278.053442] cdc_acm 2-2:2.1: urb 13 failed submission with -19
[20278.056915] cdc_acm 2-2:2.1: urb 14 failed submission with -19
[20278.060418] cdc_acm 2-2:2.1: urb 15 failed submission with -19

Silence these by not logging errors when the result is -ENODEV.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/class/cdc-acm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -377,7 +377,7 @@ static int acm_submit_read_urb(struct ac
 
 	res = usb_submit_urb(acm->read_urbs[index], mem_flags);
 	if (res) {
-		if (res != -EPERM) {
+		if (res != -EPERM && res != -ENODEV) {
 			dev_err(&acm->data->dev,
 					"%s - usb_submit_urb failed: %d\n",
 					__func__, res);
