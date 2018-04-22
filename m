Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49Q7BmdPjfwpCWdapI89nqwWH0A3tbtIWhI0mpVvoYgYXuqr+7OWP5zSBq3fG31GqzxVsDb
ARC-Seal: i=1; a=rsa-sha256; t=1524405361; cv=none;
        d=google.com; s=arc-20160816;
        b=qTyLwYX5zP3H1YgJ/TCn6q8xmHPrYETb5GCNNkGaPbm3M03jjh8j/XKVWyJwWcGjxI
         OnqqL/h6n4IhaUK/bBGzQOnD7STHd8rMM/Dlh1XuPG4fMwLXd0lvo0BGbMW+a/Kqz78W
         UNmvayR4SAcu+4Nnj1tVpWwGM65dE6xOjipygivOE259ElH2CcHRUcHlfpvANxDUDahY
         t5UtN2cYOvkf95qp+PdOcx516Yh6qoD54DDytOSfAJ9DUMJnBbAT0NZIHURFVRt02eVa
         RncJQrWNvOoRuuRneHS839MrmFP6+LBsmVJJ+6YBuSWSsbC/Xtnmq+gDK+3OYmbuNnLE
         D77w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6mRQAkJI18Tinu9l9OqYS+qEskjm6UkDUzT446kL/yk=;
        b=U0QTXo32a3klBDvJDTCsWcvA2Qj//fHurZ4bIvFnBbDTKsqZ0bDPQZvTfiE2SD1izp
         Sezvqf6b8gNdn2col/AmPzH/ryXCqaRjSc/qbq9LikhBu24JSmFLX3kWpd5tvEtZ6VNl
         qBqKFAw6ubwEM6/gSgoTw6q/TiTL8SyvITAazuh1O51vLzxXiE5D1TBcFxcTd8jG2Mgf
         6HSh9clbxVblZnVNZsH1X+24JukRwwPkgnUqKSl3u6GxvKhRNTAhuP89KMvxkfrn794D
         t6BUJdl6YP5aHxXj/7Tijz+I9vNnHgqBD0IWDduJkwzv72yxIyTsBjXCzyRiUtqzaDrg
         2Ncg==
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
Subject: [PATCH 4.16 037/196] ACPI / video: Add quirk to force acpi-video backlight on Samsung 670Z5E
Date: Sun, 22 Apr 2018 15:50:57 +0200
Message-Id: <20180422135106.009413867@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454876969505713?=
X-GMAIL-MSGID: =?utf-8?q?1598454876969505713?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
