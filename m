Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt1EUJAj56tNxGdtQqevobTDW27EYWpdKq3U0kqrPb6cr/DaGLMcLKlQ0Ze4pWymWp70A41
ARC-Seal: i=1; a=rsa-sha256; t=1521214406; cv=none;
        d=google.com; s=arc-20160816;
        b=PkZ1zwISumHwtCt6cTm4QFYfsnonAOGzmjdZJOpfENd5uzkJY/eJf+CPfQQ+wVKSK6
         YgRDlCyxewrNrZpeEZNl9Pn2xj7O2IVuKAjJQOzLxwkAzxPBGcVhIHYtw5oSpu0bhW3t
         8Bcu4FoK5cJTRdHxCai+VuDa+ymuK35VSoZb0ywf6qzGynM06TnOIaxj1StsACpyVB31
         gTTG1+g5KNv4ZXllKhL6LJUDiqGVm4Y7qZNlROmWDW0Ujuokc74atwnU6QlwsNU1SSC6
         2pQabHXxk3MhOf1aGLugYaaFJRQjd2TB9Flxz1L1kpYlndA9Lm18sAO355p6rafjkL1S
         Loaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Lu4lkNX4ZRR11eq0XkBpQrjZiBOJGF86qJ/iyRVGX00=;
        b=nzQeLZTeFb+jZ+TWk9mU8TSoVjtBPx7onvwm7VoaTxHN9MAcpodSvdfEZM7HcT9DHO
         suBl+kmWpVAPInUtxQgYd0xyP+NgZHBfil2xklNRxp0Q0FsLpl7BPJFk3YyqhSLOxerX
         Re6v3Mzems8IbWevdOIeBJr8Nlzko+uL+HFGFrKOCaDuXLu5zrIsmG5yvDZdxSmEFkkU
         POuQiFL8oP6+PNUrYlsmhSGO1UnaeR+wsVbXKe12/mzj0HEnoDMHR0EznNuTdRdTj1Y2
         GXXDzDgXZkslZFveCcFTVicg/vJGaEB1Wj18xvs28mCwxEwKp6kH3Py8T+j2gEFMKfgb
         uN/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jerry Hoemann <jerry.hoemann@hpe.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 4.9 47/86] watchdog: hpwdt: SMBIOS check
Date: Fri, 16 Mar 2018 16:23:10 +0100
Message-Id: <20180316152320.603556028@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108554885329127?=
X-GMAIL-MSGID: =?utf-8?q?1595108917562153855?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
