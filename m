Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49H8Lm0RhHdB2sfK/fSJEansNEo9lhRyUSrPi2NjSDV1ypkfDQo5IXdkKK/ojH8WvwNhDMn
ARC-Seal: i=1; a=rsa-sha256; t=1523473518; cv=none;
        d=google.com; s=arc-20160816;
        b=N+QbJmcf/tQDFrAoUsk2aXNCaCyk/q6xHlCYT8in/g+A3pUSNLX4t2TiKgKQgeqnqP
         Bz9VuSBXhRAVH7g30JMejY/bA2Ymzwwxiu1Epqhtebw8CHWdxqfKMb6QIOU2aqX5V09/
         ZxGzLyFm5qekDdOhKpHwMjt1X2cFQ/es4F3GULUhCnpQafBg9UKC2cmHXH1e1xNovOHy
         RbkSbF+Qm0iRxbmfMA9zZVWZVkv+Gv39WJ6LDrLjbvWZyT4cp21uiHFfmO604w8osjG9
         5mCDbnZvL2k2OxHl8XTpvD347gNHNBxXjWnyniEp0KWxOJ2kwa/Cyyu/YR1ZDXs4PvjY
         308w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=odGAykZQLbgw4x/vNVsVvQe8BtcssWqeQwn9BrCxXhs=;
        b=u9qQNK+TPptEizbRuf1/9rNs29Bpzk1W4X5tTMFXGzsD5iRdiZzVo1lXclEuo24Ghw
         EIt99B2mT6j52X4h9ykEE2bLVpkkvrAQqIuIbPHta6BAMbdoLbFvLeTfUnTNWs+h7/g4
         AJi4UOZG8ObojoD6y3LM+/unPdi03+BqNm6cdnKJxuVc+8/BXeU+96qcb8/PfCcERmZM
         vIU89vpeivu/1ZTB/az+TQbbWIi74aykts1Tp/EZw0e56nQcCkfayFiGCL5KKsMOK63F
         F7VaW+Sfi3ZH44HUMqWpVfw/Q5PLvzKE8oa7/Z9nnVYxHk61ygu5vxrHiRuKrg48Eiq8
         zKQg==
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
Subject: [PATCH 4.9 250/310] ACPICA: Events: Add runtime stub support for event APIs
Date: Wed, 11 Apr 2018 20:36:29 +0200
Message-Id: <20180411183633.202723115@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476360075015907?=
X-GMAIL-MSGID: =?utf-8?q?1597477768712823113?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
