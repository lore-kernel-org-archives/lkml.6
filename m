Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49CfTSu+RXpsl5nJ9SEuV3imzSXjTCe5Pe7qIQsCHYS8P8nTDwaP6DNmo3RyBXmmBuLAuTj
ARC-Seal: i=1; a=rsa-sha256; t=1523472175; cv=none;
        d=google.com; s=arc-20160816;
        b=LZGoLFQYWaJ1ARRunBHGNho3Ay6F4+18OESncYFXRLE61mP7rHjq2/56x9zUhdnIyX
         tLI/gKLQXwB5faAJ8eoabgKfRpeoJgCDOXKRUo1Lb3XhUaZfsFjWGC22UWg4qPy1TmJW
         oT5k7LqS5bft7bQ1c6T1KZzB+dNjvLUDheMMMF2nIvkimx/9/38Z+BW5yMuAyrjolBXR
         pZBTqmFwEv9zihMDcbxRu4EZZA9MGUmo2T0N6vy8wVZgXrN5E+0kiZxaAM1AshyyF6Pp
         ejL+dKil+DKLzhi9EVh1NHH8YjpiIbCckv2Y0XXPfCyYSbbQFuNRayBNxOyKDrvchJ9D
         c2mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2AQlGEBfPsq/xQEk2VObtEBhHVyRIGEuPLxRXKkhMr8=;
        b=llB86Cp2OvMuli0b2ORD0pL0/4JGAb0MBvOjnROhgFp5/rSudQqOKlsXBlbCm8ZL6E
         zB3nO4AiqibPsDlugPn4g1bxJMGJ/Nqidjp/+YuSkkbCADQ80mPXke7vFQgIDYXAPOBK
         tp9r+O8zEBcnL3Ec6ETDayp2vLQ72qcnkbi7fXBXCWzBcWJFK3BqOHy7gNOMGTojCdZk
         QzGYFwyfp1j5k65xLKo9Xm2DIDo6aLc4u2FaOf4HZIOn27/vIJHUSOl2JT1Gfkjo6XU1
         am1lik2dNAnuwfYwWlz7QWs2FkXkBXwtQ40/Gvzc7gQLW/ZP/0WDHj1exQHVCpqcjPHK
         ijNA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chandan Tagore <tagore.chandan@gmail.com>,
	Lv Zheng <lv.zheng@intel.com>,
	Bob Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 087/121] ACPICA: Events: Add runtime stub support for event APIs
Date: Wed, 11 Apr 2018 20:36:30 +0200
Message-Id: <20180411183501.682927667@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476360075015907?=
X-GMAIL-MSGID: =?utf-8?q?1597476360075015907?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lv Zheng <lv.zheng@intel.com>


[ Upstream commit 861ba6351c520328e94a78c923b415faa9116287 ]

ACPICA commit 99bc3beca92c6574ea1d69de42e54f872e6373ce

It is reported that on Linux, RTC driver complains wrong errors on
hardware reduced platform:
  [    4.085420] ACPI Warning: Could not enable fixed event - real_time_clock (4) (20160422/evxface-654)

This patch fixes this by correctly adding runtime reduced hardware check.
Reported by Chandan Tagore, fixed by Lv Zheng.

Link: https://github.com/acpica/acpica/commit/99bc3bec
Tested-by: Chandan Tagore <tagore.chandan@gmail.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/acpica/evxfevnt.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- a/drivers/acpi/acpica/evxfevnt.c
+++ b/drivers/acpi/acpica/evxfevnt.c
@@ -180,6 +180,12 @@ acpi_status acpi_enable_event(u32 event,
 
 	ACPI_FUNCTION_TRACE(acpi_enable_event);
 
+	/* If Hardware Reduced flag is set, there are no fixed events */
+
+	if (acpi_gbl_reduced_hardware) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
 	/* Decode the Fixed Event */
 
 	if (event > ACPI_EVENT_MAX) {
@@ -237,6 +243,12 @@ acpi_status acpi_disable_event(u32 event
 
 	ACPI_FUNCTION_TRACE(acpi_disable_event);
 
+	/* If Hardware Reduced flag is set, there are no fixed events */
+
+	if (acpi_gbl_reduced_hardware) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
 	/* Decode the Fixed Event */
 
 	if (event > ACPI_EVENT_MAX) {
@@ -290,6 +302,12 @@ acpi_status acpi_clear_event(u32 event)
 
 	ACPI_FUNCTION_TRACE(acpi_clear_event);
 
+	/* If Hardware Reduced flag is set, there are no fixed events */
+
+	if (acpi_gbl_reduced_hardware) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
 	/* Decode the Fixed Event */
 
 	if (event > ACPI_EVENT_MAX) {
