Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/twEGwgWK48TAAzAgDYW0im6aJJi/nZ4PjWnJfGQns79zwd2AvMn7ASXHH8QzaJdk3M97L
ARC-Seal: i=1; a=rsa-sha256; t=1524406292; cv=none;
        d=google.com; s=arc-20160816;
        b=lmBwvvXF+rx4zJOhVxhKJDTXTDidgkxeRMEJGxBDfEWf5MjLWojVfS2TAoa8EKsn7j
         mAhq3zUM83M2cjcrOX7P5/HekqiB3n/4916dJjndGIU/bs864d6Xxx38mdZ8t6RUHMjC
         GFOf8dbCd4LDBwGQLW3Fa9omuc91tB7ilrtcYCzeSp4WUZyPdSly+MmW9RvHmkeMKedV
         rNamtLQkkE/8ZFzTbmk1/ZXlLw0Lz0kR/Bdl7ab7ZHXddL5JQZaB1kOv58aKeGykECXx
         nhL41wDjD1KPdninUdju5gzBZ9oZ9BBdkb2lfJoIeJhTENkL/q6qDliMBIf86MNWaK3P
         fBbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=S0g/MyTKaDSmjU4Hbe4o+vv4xwAvxmZLg127AVfWkLk=;
        b=OeChp5THQGlL8Xnx7HQrOANzA9u1cHuLnqKczRk1AoV0pEGhySJZLZxRe9ZjBJVGqZ
         SEu0DmC0ZLW3lr9bNY/SyFY0ZZ/JwJnA3eWG+Mzd3yYD9mut/eRNDh/kSD3YHiRUwusl
         lC/09dfadmqM+5dyEBhE6+ELsDOmUvWMC0izi+b0KJThANfIhJ4UcsymvwUTMkWNwIkv
         Xcy5Me4RvXtOwfDL1iZsMSS9mvSFtoB3v+vitsZozVKtxcwR7g4TSGocnqKNaSl9Hy5S
         bEGFhhs+efknlctz0ruyl3hwuPIPlUlIK9wVrt7Z81l2iCJlhQkqeuJeUbvMCJSz/d3v
         OQ5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.9 18/95] ACPI / video: Add quirk to force acpi-video backlight on Samsung 670Z5E
Date: Sun, 22 Apr 2018 15:52:47 +0200
Message-Id: <20180422135211.186445612@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454876969505713?=
X-GMAIL-MSGID: =?utf-8?q?1598455852147090592?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit bbf038618a24d72e2efc19146ef421bb1e1eda1a upstream.

Just like many other Samsung models, the 670Z5E needs to use the acpi-video
backlight interface rather then the native one for backlight control to
work, add a quirk for this.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1557060
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/video_detect.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -214,6 +214,15 @@ static const struct dmi_system_id video_
 		},
 	},
 	{
+	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1557060 */
+	 .callback = video_detect_force_video,
+	 .ident = "SAMSUNG 670Z5E",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "670Z5E"),
+		},
+	},
+	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1094948 */
 	 .callback = video_detect_force_video,
 	 .ident = "SAMSUNG 730U3E/740U3E",
