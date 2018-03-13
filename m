Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvSHmJ6RhOI6s+FZAC2/O89ZKlbFga/pU7R7/T3oq8Q1fmSLQUIgEIVTYmx0p7Tlgksld+F
ARC-Seal: i=1; a=rsa-sha256; t=1520955312; cv=none;
        d=google.com; s=arc-20160816;
        b=M/4kPqiR5LXcLsqBXwIAgpvlvYLllwaWEFAfV/fDxMxibX0DXzkG6or36jZ4M7gSHV
         6Xt5E3GkgzoKR062nH6aLwnU03QJXDU6OlfbPKelJvuWFTzOrPJ2Jk5fxXe7vI7/3ATl
         7rNDEtgu2oTW8l/rRjHO80dj4xsYrKvodqoXT4H6LU00Owlzqhi0JQS6KK1KGPzITz/0
         tbZkjX4VkQVF+HmLuRctQATxQre9SUf5tq/Qv2em/QXrXj6WtR9qYfyq95WLbR9joYFT
         E39Ib7OhiK89jxIqvRxxl1CHAZS642wYXzbNhIKbzFNOSPz34L4RgoclBaMHlz7souJf
         2FKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gIVJsblirOuGSy5nj/ehveKZjH3jreUBeO42p4dUaCE=;
        b=AJ8kxgIlximbCQT48YCezrDF1+xUa0YMStImB7Gld0shdyzkBFnFQBwb6Rpv77YGQp
         DRUkNzy8LHkGOpTAGmEuxBFEzf6R7BZ8EPYIQrexCGXLiElQ+5ZrVC9nmP8vIQoxGpBu
         dbBpNxutx02je2cevw+sKlGt+IFfGgWJPqTskpFXZKT47BCChf4OeCRjprmpUmNmwWSK
         mLRWe35ZjHwG2dx9fRPZn98Uzn6ybU4U2zUwtnDkwCICRTmPhc4BYXOPJ4yOicgI+Hc7
         yR7ehQobCf6RXGMx/053n4qk6TPNpy6Jsr7G0KXuR0KIbl6rrlQCdo/G8l4rZUAEjNhI
         KMcQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jerry Hoemann <jerry.hoemann@hpe.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 4.14 002/140] watchdog: hpwdt: SMBIOS check
Date: Tue, 13 Mar 2018 16:23:25 +0100
Message-Id: <20180313152458.356548266@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837141192924323?=
X-GMAIL-MSGID: =?utf-8?q?1594837238411650170?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jerry Hoemann <jerry.hoemann@hpe.com>

commit c42cbe41727a138905a28f8e0b00c147be77ee93 upstream.

This corrects:
commit cce78da76601 ("watchdog: hpwdt: Add check for UEFI bits")

The test on HPE SMBIOS extension type 219 record "Misc Features"
bits for UEFI support is incorrect.  The definition of the Misc Features
bits in the HPE SMBIOS OEM Extensions specification (and related
firmware) was changed to use a different pair of bits to
represent UEFI supported.  Howerver, a corresponding change
to Linux was missed.

Current code/platform work because the iCRU test is working.
But purpose of cce78da766 is to ensure correct functionality
on future systems where iCRU isn't supported.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/watchdog/hpwdt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -700,7 +700,7 @@ static void dmi_find_icru(const struct d
 		smbios_proliant_ptr = (struct smbios_proliant_info *) dm;
 		if (smbios_proliant_ptr->misc_features & 0x01)
 			is_icru = 1;
-		if (smbios_proliant_ptr->misc_features & 0x408)
+		if (smbios_proliant_ptr->misc_features & 0x1400)
 			is_uefi = 1;
 	}
 }
