Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtULqiUg9BgJIuJRp/edSQe9G5jN2Bi1eDnkFBLbviBEdNbvyH4wd7RuRga6SB6pjZ6ScIU
ARC-Seal: i=1; a=rsa-sha256; t=1521483153; cv=none;
        d=google.com; s=arc-20160816;
        b=LCtL+IEhcEri68+/DekbXY8I460z6qdfVk6xHSj/QHk5YZDlwpTdNEGmysFs0ibWRE
         CjCUG11qg2AP/53beG2/0QlDVbx6ybRJV9Al26a1niRMh5FC/m0/SODf1xOcGmGDTrv1
         hx4PpAVSmpAYBx1IGeiScAbqjy85ozdJVDI+jnOXapSwK1Df7igsVsKpSoRSLQ324dko
         Al980IM4GLJn6Cf2b+9XqxH+dPOKi7+EdWU/EQPYHu382HuqlSjayA/PuYxczv8nNF40
         O3QD+uw64arI/Eriz+gA/GzzuM6Q8z/qMiT2W4PY7jXCTZ1Ulenmtm309Yvv4mKmF6Fb
         4vHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Vp8Gu3v66TdxOCO5FpJJSmKBsqZknWq5fVF+iclyOag=;
        b=xiDk2Mq5nouUY5oxqGd3YKtuLe8/RDap0rUVuy+F3EnyPg5l8HQKhzSoBuYFSAyyuh
         mYChCbLcp3s1eEI3rsZBckIr7LvpdDyIKL0H5Jro9adSZ7f0QSZFouOrGOnBq8hqKffd
         wYfBXhcXATvCe/TIKz+utPZ1n+IdZlkSjO76NQ73q9oHEcHOA4MZ/1ryHhWkOuJ1PgeR
         W07WCtPCxs1EPocbZ77DqNXcs47+Abqks+Nt1+e7sU3qBGOGmqejxc2i/8UaGKUoTybz
         yBGEf2bDmRGRKv0s7fvfdnoySi65O2WQ36YsGen1bP3zIkICwsMVMo/I2PnGiYBzJMRW
         RNqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tomasz Kramkowski <tk@the-tk.com>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Jiri Kosina <jkosina@suse.cz>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 019/134] HID: clamp input to logical range if no null state
Date: Mon, 19 Mar 2018 19:05:02 +0100
Message-Id: <20180319171851.917430533@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390498609156118?=
X-GMAIL-MSGID: =?utf-8?q?1595390718962107862?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomasz Kramkowski <tk@the-tk.com>


[ Upstream commit c3883fe06488a483658ba5d849b70e49bee15e7c ]

This patch fixes an issue in drivers/hid/hid-input.c where values
outside of the logical range are not clamped when "null state" bit of
the input control is not set.

This was discussed on the lists [1] and this change stems from the fact
due to the ambiguity of the HID specification it might be appropriate to
follow Microsoft's own interpretation of the specification. As noted in
Microsoft's documentation [2] in the section titled "Required HID usages
for digitizers" it is noted that values reported outside the logical
range "will be considered as invalid data and the value will be changed
to the nearest boundary value (logical min/max)."

This patch fixes an issue where the (1292:4745) Innomedia INNEX
GENESIS/ATARI reports out of range values for its X and Y axis of the
DPad which, due to the null state bit being unset, are forwarded to
userspace as is. Now these values will get clamped to the logical range
before being forwarded to userspace. This device was also used to test
this patch.

This patch expands on commit 3f3752705dbd ("HID: reject input outside
logical range only if null state is set").

[1]: http://lkml.kernel.org/r/20170307131036.GA853@gaia.local
[2]: https://msdn.microsoft.com/en-us/library/windows/hardware/dn672278(v=vs.85).asp

Signed-off-by: Tomasz Kramkowski <tk@the-tk.com>
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-input.c |   21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1128,19 +1128,26 @@ void hidinput_hid_event(struct hid_devic
 
 	/*
 	 * Ignore out-of-range values as per HID specification,
-	 * section 5.10 and 6.2.25.
+	 * section 5.10 and 6.2.25, when NULL state bit is present.
+	 * When it's not, clamp the value to match Microsoft's input
+	 * driver as mentioned in "Required HID usages for digitizers":
+	 * https://msdn.microsoft.com/en-us/library/windows/hardware/dn672278(v=vs.85).asp
 	 *
 	 * The logical_minimum < logical_maximum check is done so that we
 	 * don't unintentionally discard values sent by devices which
 	 * don't specify logical min and max.
 	 */
 	if ((field->flags & HID_MAIN_ITEM_VARIABLE) &&
-	    (field->flags & HID_MAIN_ITEM_NULL_STATE) &&
-	    (field->logical_minimum < field->logical_maximum) &&
-	    (value < field->logical_minimum ||
-	     value > field->logical_maximum)) {
-		dbg_hid("Ignoring out-of-range value %x\n", value);
-		return;
+	    (field->logical_minimum < field->logical_maximum)) {
+		if (field->flags & HID_MAIN_ITEM_NULL_STATE &&
+		    (value < field->logical_minimum ||
+		     value > field->logical_maximum)) {
+			dbg_hid("Ignoring out-of-range value %x\n", value);
+			return;
+		}
+		value = clamp(value,
+			      field->logical_minimum,
+			      field->logical_maximum);
 	}
 
 	/*
