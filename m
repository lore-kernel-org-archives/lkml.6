Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+BgSvHfGC7Feh/2A3peUNifkqPL+xBvWPI+3OCrimRWMcnjTmY7rbNEhmM8oJ3mWwIlZ2n
ARC-Seal: i=1; a=rsa-sha256; t=1524405982; cv=none;
        d=google.com; s=arc-20160816;
        b=C/pU/xM7GPamFrPTkqcjgIv7jyiNMZUOfXecuhY+7Z23LrZSeWMd2iROhbMCLWq1XO
         t2aM6iJ/eLGGsFsI2jGC5wlNXQO2ZNRbV0guPQY1riVtSN7PCcmY63t+XR5t3779VXcV
         BMDx2McoGyZNO55eMkpmUBlNC8Qu6YDM3HZmVaN+hSXjGAWqkLDo2ZRdJc6sCordTsMB
         Kcy3iBT42y6PY4rXwKRp1kju29Xpll1bt/BjkAdkI+HhmOTMwCHJjQTWy5O3Aw41ykBE
         Y3sriox9pel8+ylJRe8GUZlOMv2oHRjmjuONOV4PNJ9ZGNxA4bCpOsF1zxgdfsIPba4W
         1ItQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZKUv3TaJFDrX9EXH1x0H/rEgVHeYtRvkZ4v7opm1wAI=;
        b=G9JZ2vGO4W6BQngm44zyoR3vrhiy/mv9qiEcDMuKCk7oRbf7ZN93GQKEwUzYwQSwqg
         ouaTMEKTITg64qMUy3d2WauulBDGnAL6AZtsluz3BiYV7MsBzDn2Zy67Kq+MSkazhi8B
         lRVb+BKqi8/Hkbybe3bUtcWttlY4UhA1zjh1wOvNNb2IIFD9veXwwrrWlt5ebvbpejwc
         humgDcjQq53CrOD8SPHu1LjK6ocs37ONmfMD+LMtceyoku75jfZLz39n83ul3tiHmg//
         kNEe67I5TNbutDJ+iIIcYb1QkRYvpUtwOuIymwf6XO0PPVAfg2d/mb//UNJ4+KwNQ0A9
         Thxg==
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
Subject: [PATCH 4.14 035/164] ACPI / video: Add quirk to force acpi-video backlight on Samsung 670Z5E
Date: Sun, 22 Apr 2018 15:51:42 +0200
Message-Id: <20180422135136.847798019@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454876969505713?=
X-GMAIL-MSGID: =?utf-8?q?1598455527961356702?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -220,6 +220,15 @@ static const struct dmi_system_id video_
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
