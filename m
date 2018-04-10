Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/o+bxKjE1aXBQucx5TwxdVzNsoWG/XDwiANM8QdvjtPS4nFB2TnxjZPHRvcPE/sGWBxmKL
ARC-Seal: i=1; a=rsa-sha256; t=1523399654; cv=none;
        d=google.com; s=arc-20160816;
        b=fUz1eenCnGii7l9IXhdfJjpgCDrpUHyRgFx+E4Vo/rJ3vGMraR/cHsh7mu2zVUfsBs
         bksCIWAMcp8IoDKyRfcvS9vajH4cREYymuwTek14TPXVcsbPBu1y/XWRKmPpnSDRxqSX
         bj5e06TCg6iBJ8FtbUd4mvKmigNsjm/pyGjqiGyuTRE3+tYZdaH0VEaaskc5AGRM4Om9
         s+8KonsTEgr4eup+rTN6eUYheUDnREVZqWYeP9fYgTEf/r1471FozeOk52W5dYJp+HEK
         fr1VO7YaiNNtZL2cxQj7Rutg03oCCL7tPpbexVvVa9IRWqTj9aCpWodqNLCGig/OXT4z
         CAXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GJ99xkCiVUovRk/R3xg1qAgd4XqUrTSx2lSyArz3Zls=;
        b=rscawQhpxflmoYE4Nk4EGrkErK0Yn/DA1NTiP1E40ypo+8Aqx03SBZqs1blBcpqb/c
         B+7qUdmg8rNY3XFot4ZgKN4umxs4d813t6HD/2gwj2MlbpoYirC/FnESp5TDukHhS5tB
         rk3H86Fvbo0+/4fcxx8BCTC7nr1tVOk92D5wJjPW+A35DPP9HbxjcGUqy+hglz6MYjXh
         IrWT19oFEd0D1GO8svifg3rt7MpWkOls/m0gRu5cVI9SpbkvbUXjKwDLGoCFhJI+/sWm
         J7ozZCouo3Eucdj9bWMwPRu6Fw9vhMc3GVr2dOmrnSRJcDINlvh7g3pHLIGDsZUgMw8w
         q9iQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 016/138] ACPI / video: Default lcd_only to true on Win8-ready and newer machines
Date: Wed, 11 Apr 2018 00:23:26 +0200
Message-Id: <20180410212904.000064796@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399882007140427?=
X-GMAIL-MSGID: =?utf-8?q?1597400316455224232?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>


[ Upstream commit 5928c281524fe451114e04f1dfa11246a37e859f ]

We're seeing a lot of bogus backlight interfaces on newer machines without
a LCD such as desktops, servers and HDMI sticks. This causes userspace to
show a non-functional brightness slider in e.g. the GNOME3 system menu,
which is undesirable. And, in general, we should simply just not register
a non functional backlight interface.

Checking the LCD flag causes the bogus acpi_video backlight interfaces to
go away (on the machines this was tested on).

This change sets the lcd_only option by default on any machines which
are Win8-ready, to fix this.

This is not entirely without a risk of regressions, but video_detect.c
already prefers native-backlight interfaces over the acpi_video one
on Win8-ready machines, calling acpi_video_unregister_backlight() as soon
as a native interface shows up. This is done because the ACPI backlight
interface often is broken on Win8-ready machines, because win8 does not
seem to actually use it.

So in practice we already end up not registering the ACPI backlight
interface on (most) Win8-ready machines with a LCD panel, thus this
change does not change anything for (most) machines with a LCD panel
and on machines without a LCD panel we actually don't want to register
any backlight interfaces.

This has been tested on the following machines and fixes a bogus backlight
interface showing up there:
 - Desktop with an Asrock B150M Pro4S/D3 m.b. using i5-6500 builtin gfx
 - Intel Compute Stick STK1AW32SC
 - Meegopad T08 HDMI stick

Bogus backlight interfaces have also been reported on:
 - Desktop with Asus H87I-Plus m.b.
 - Desktop with ASRock B75M-ITX m.b.
 - Desktop with Gigabyte Z87-D3HP m.b.
 - Dell PowerEdge T20 desktop

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1097436
Link: https://bugzilla.redhat.com/show_bug.cgi?id=1133327
Link: https://bugzilla.redhat.com/show_bug.cgi?id=1133329
Link: https://bugzilla.redhat.com/show_bug.cgi?id=1133646
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/acpi_video.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -80,8 +80,8 @@ MODULE_PARM_DESC(report_key_events,
 static bool device_id_scheme = false;
 module_param(device_id_scheme, bool, 0444);
 
-static bool only_lcd = false;
-module_param(only_lcd, bool, 0444);
+static int only_lcd = -1;
+module_param(only_lcd, int, 0444);
 
 static int register_count;
 static DEFINE_MUTEX(register_count_mutex);
@@ -2136,6 +2136,16 @@ int acpi_video_register(void)
 		goto leave;
 	}
 
+	/*
+	 * We're seeing a lot of bogus backlight interfaces on newer machines
+	 * without a LCD such as desktops, servers and HDMI sticks. Checking
+	 * the lcd flag fixes this, so enable this on any machines which are
+	 * win8 ready (where we also prefer the native backlight driver, so
+	 * normally the acpi_video code should not register there anyways).
+	 */
+	if (only_lcd == -1)
+		only_lcd = acpi_osi_is_win8();
+
 	dmi_check_system(video_dmi_table);
 
 	ret = acpi_bus_register_driver(&acpi_video_bus);
