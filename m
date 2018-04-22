Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48gIKRP41GrdxwMrTPYeGSinseuQWeQUvi9MtRz4Zfd3FMgtJIsHM8NWe8/ft0wm/YnHqu/
ARC-Seal: i=1; a=rsa-sha256; t=1524406675; cv=none;
        d=google.com; s=arc-20160816;
        b=p2hGhKmhl0lfxgWz1paT0OgB0z1ZZfJnBvQH8a9oJkcOqzqQaBXm1oKcei58VyKvWZ
         f8Y+vQHPxNAoXNhz03NDkxSgeggCp4V+bzbzuUXyjfJDfditppSqomQ1iLWO3vGFEbH7
         hw/nYc0/3/gZxuZzwV/ti2PkAtH8ikO32BgNHthMvWuaWKoOxLNkItz/aRskwYkvCuzz
         J5+tsGFPRMpWrxWDXV2JYMG8Ecmox2jlsV3sCa07JvVfbAVx87qqRVeR2NnGe+L404dU
         4ENFcGUuxh4M1LPs71v6TOYJL+SWJC0LmwyjmoSNKn286kGKmEjBMrC7ivyjjfjL8Km3
         IEIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CnDRyFR/UP8nW4SqEKUP/aSuTBFMfkdzLLKKgxAjJBw=;
        b=e83D3Y02qRi/IJaOt+/FyYJs4ohKqWLS4Gsjp40Lz0Wzg0R9JVGEkFk/cDOx1MMs5t
         nyQaa/vxbRo+Yvgjzmhvc++DnSPF0FT56Jm8HUFYXyjPLjsBp5ihkoMvT9CkdNIT3rzX
         R7xhKgUKcuMWO9qvliH1dyYDJXcTmbmOvGnIbO/oeltoKdUQej3D43dBs76W7vT4Wbn7
         L2vsfcuqs6I06VWhu/qwzpz3MIjtoHdQ6sZJLxm9o9i3gHYVThg4couBt2zDxgeMqdqb
         RArPZw/EqF28G6qhce3kGl10m/hpzwruzjWZQFrAQQxE+4lQy6LloEtXSUttk5uIMDGn
         sE9w==
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
Subject: [PATCH 4.4 35/97] ACPI / video: Add quirk to force acpi-video backlight on Samsung 670Z5E
Date: Sun, 22 Apr 2018 15:53:13 +0200
Message-Id: <20180422135307.306311447@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454876969505713?=
X-GMAIL-MSGID: =?utf-8?q?1598456254477636667?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -206,6 +206,15 @@ static const struct dmi_system_id video_
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
