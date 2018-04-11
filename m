Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48lWa7HlA1ZD5yBRuRiLjP/KTXQ7bmITVALhpTlMZEEHO/318uhKvyyZtHxEN2NBd743miW
ARC-Seal: i=1; a=rsa-sha256; t=1523472601; cv=none;
        d=google.com; s=arc-20160816;
        b=pLF3csw/L6o2YKb12uvdgscp16lYEjJmBBBRPywS3VKC9LmxWWot4xkMPYigO2Y+bu
         VFZdfhDFCuc1P8blj/NHyC/TkXE91LE0BGPOB7RI4ROgqzvqBsPDGQ27GhWiF4BWvLRV
         02WvyHV3lXikO5BU7yIwzPkJePIJhxe64i3M77F8AJ4ifXhZNoau0H11NkMuVkoDjn0A
         hjtNwWV0sibRViie0U71RS50pccAeLWPK7/cCjOegASFwafsrF5l6eOkMljGWS6q5VD0
         t7jrfacRZVQ6BSGWHXvYi28CN5GT2TC704VoXmV2kHu2mntKFTYiTs8ptLZJtDhqooH1
         acIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Pc40WPiql77bDR06QaH8pfVYosrdsSLvYK7AmizN3gk=;
        b=jz6hSZX46orMrNsqSsokLRQoaXfDvWpUCpRTopuhCqKrS3OctZk1RzL6fTDC+QLF6m
         /wWK1cGhxQDRLhwR+RWV3IPs44NrJjL5y4lEmP/Rz6ArZAFh7VBQAH4nzZDeS7kgmkvl
         5lxxRu0rbkEczqpDIRXdecrg77ka6MyyNgpBse6nB4b2uqP97GAfNxaDdbinO2/rpIkk
         dIp+Rdxokl7CAgO9SkcE/iTBiJujJIe253mzcgGoF4qjBZ3oMo98keYlpFHcOS1y0JDQ
         GriKu2N80gd+fM/p/3FkIGnwyMasxx4UCO3/YAGVqBE8RhdBBJ6xuE6vMe2SQ2FqGhdq
         6OEw==
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
Subject: [PATCH 4.4 145/190] ACPICA: Events: Add runtime stub support for event APIs
Date: Wed, 11 Apr 2018 20:36:31 +0200
Message-Id: <20180411183601.113500771@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476360075015907?=
X-GMAIL-MSGID: =?utf-8?q?1597476806698047883?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
