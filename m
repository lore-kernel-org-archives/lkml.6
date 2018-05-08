Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoPaOOgyb8FIeqg/32foVShzQSg/xDNuU3oZj7/MsM4g+kdtdxidlAZqBm2OBPEY9tzuXit
ARC-Seal: i=1; a=rsa-sha256; t=1525767202; cv=none;
        d=google.com; s=arc-20160816;
        b=fM38ZK9tPSKiof50ilMQ0oX2CkiKW8WTWQ75k9C6XkCKkX082j0Zd57mXQGJYqpEja
         c/XHli4AbBZESjIdAqTe2E7eo8kCsSnUxqaySZndh5Vf4NCLxBOfSUu3Tpu9NC3tDx+F
         W+e0hcgOFLjCc4PuHM2rL52FSW09IJ9rMNNsdKiJYdB/tyy5yWfLakco/v8bXbcC5g9K
         3LAZZZYSIQzmvTHKhWls4JcOOYXRryZHlvr5XSv2d5G2eN6gXzdIkQg/vslknsMOUbQ/
         8IdrrE5mcW94guoG6QcJuEfIpdnq8QhQVgKRektw9jSNJsZq03IQ0AkmSpX2naAiiR3t
         yU7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=IE/LeA+OqzGPROPH7XPPXLs6CtLgUSNa+MSg6TgHUnk=;
        b=GFDiVk/yYjzvRVj2sZnckhW61rTp+V9SSIb1G77TYykPXMndcGD2pq6fhvDzSF9Wr9
         YWX2A5u4HpBmXJZXxttSe9J+9hywNg8BS1T9AlFPEJTseY0/HTE+G13oJIfmMeXdOIvk
         PAB3Ps6GAzXq8OvadAD8nUk+WBGsS0VIyKw22ME2L7Zpk4M3V4TAa0cLWx3O1Psr8N8d
         f+J4LhxhKBLvQjRNsXKhBtp+9krOwY8ko43jrCCw1ZS8OdCdT36ZgAYTiHmcrTpkuRS3
         GFUygGt19Q8bua9/nGxY/G+JZM26Rp4WA/VA1TIkvwXlfGpf6h5bP2Kg8Z8jUm2QOH+f
         B5Fw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=JVXHmU3w;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=JVXHmU3w;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Mario Limonciello <mario.limonciello@dell.com>,
	"Darren Hart (VMware)" <dvhart@infradead.org>
Subject: [PATCH 4.16 44/52] platform/x86: Kconfig: Fix dell-laptop dependency chain.
Date: Tue,  8 May 2018 10:10:42 +0200
Message-Id: <20180508073934.347293397@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882869901119872?=
X-GMAIL-MSGID: =?utf-8?q?1599882869901119872?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@dell.com>

commit 7fe3fa3b5ec8e75389cce4bf5d052a52e6198d59 upstream.

As reported by Randy Dunlap:
>> WARNING: unmet direct dependencies detected for DELL_SMBIOS
>>   Depends on [m]: X86 [=y] && X86_PLATFORM_DEVICES [=y]
>>	&& (DCDBAS [=m] ||
>> DCDBAS [=m]=n) && (ACPI_WMI [=n] || ACPI_WMI [=n]=n)
>>   Selected by [y]:
>>   - DELL_LAPTOP [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y]
>> && DMI [=y]
>> && BACKLIGHT_CLASS_DEVICE [=y] && (ACPI_VIDEO [=n] ||
>>	ACPI_VIDEO [=n]=n)
>> && (RFKILL [=n] || RFKILL [=n]=n) && SERIO_I8042 [=y]
>>

Right now it's possible to set dell laptop to compile in but this
causes dell-smbios to compile in which breaks if dcdbas is a module.

Dell laptop shouldn't select dell-smbios anymore, but depend on it.

Fixes: 32d7b19bad96 (platform/x86: dell-smbios: Resolve dependency error on DCDBAS)
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
Cc: stable@vger.kernel.org
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/platform/x86/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -154,7 +154,7 @@ config DELL_LAPTOP
 	depends on ACPI_VIDEO || ACPI_VIDEO = n
 	depends on RFKILL || RFKILL = n
 	depends on SERIO_I8042
-	select DELL_SMBIOS
+	depends on DELL_SMBIOS
 	select POWER_SUPPLY
 	select LEDS_CLASS
 	select NEW_LEDS
