Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225fN9/CslvqeWrZYZ8f1fZDcydTgbBM8EY2gIcH0EFQeo+hhMt7sEHRoWQAAUrCletI5GQx
ARC-Seal: i=1; a=rsa-sha256; t=1519218688; cv=none;
        d=google.com; s=arc-20160816;
        b=Ttw6cE1mbjvQnQ42D63/Zr5yGGOGgSnA0rJAyzf/6FzZyhAWEoX+8M4i0+X7Kqh2I5
         3L5yqXFhZYXmUAmZ/U0KGpiVvfGTVo3cDhQyw4Vqt1CVYOY5I7548qm74zYlUD7M3Ero
         wNzkl5WZBrvsuvyeAN9RN0Xp1jFVj/EMT3RH4hh83gfj8q9HHrky5U7Ffsmlj+WjgEu9
         yqswoxHzf+MSEjadwuVcMeXhh6k9Mv5X2wgsZALI4nszHhwK652L2jtlzFufD+xleqPJ
         7XH0P4AolsgowlJwVNdo5ILMUglWSXgJvgdpb0NJR2DhPTJBldeEU6FhY6w01jiXQKER
         wzig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NdzJwEZq5tbb2GGhsLJLdk7tBNMa8z0lmtzIKTUeE6Y=;
        b=A5TrYcx8w0Iiawf7XCfKKS+BTp+dlAwjHIZ2zqOITbvStAefT4M7wyMoSLu61hRRaA
         Ml0x38ZniJxVAx2Q0Vbj/3hQkEjAlvWUkXNPEBTaHqWClovvhrQ9KWoq7uYISQJI7IOy
         f2qKBgJeH1M2YbRz6H04y4q8YIAR7mXjnllhr8fDG55SF27tH5/9BCLv04ZLJ6+PB4ph
         HpbWP3I/mBBLIdswj/6Kx2yqzD2ou6+V5ilRIN2JwYFfDZSNCOOIiJn/ehRQWwtALMef
         DVpb3VOCZpiyDDCV8Ae0/+d7EepXIdvdHuH4cVQzemDeoOi7+/fNAowFJHWVrMZkMt/k
         0hgA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.15 127/163] rtlwifi: rtl8821ae: Fix connection lost problem correctly
Date: Wed, 21 Feb 2018 13:49:16 +0100
Message-Id: <20180221124537.155053230@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014634978594268?=
X-GMAIL-MSGID: =?utf-8?q?1593016255206586890?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Larry Finger <Larry.Finger@lwfinger.net>

commit c713fb071edc0efc01a955f65a006b0e1795d2eb upstream.

There has been a coding error in rtl8821ae since it was first introduced,
namely that an 8-bit register was read using a 16-bit read in
_rtl8821ae_dbi_read(). This error was fixed with commit 40b368af4b75
("rtlwifi: Fix alignment issues"); however, this change led to
instability in the connection. To restore stability, this change
was reverted in commit b8b8b16352cd ("rtlwifi: rtl8821ae: Fix connection
lost problem").

Unfortunately, the unaligned access causes machine checks in ARM
architecture, and we were finally forced to find the actual cause of the
problem on x86 platforms. Following a suggestion from Pkshih
<pkshih@realtek.com>, it was found that increasing the ASPM L1
latency from 0 to 7 fixed the instability. This parameter was varied to
see if a smaller value would work; however, it appears that 7 is the
safest value. A new symbol is defined for this quantity, thus it can be
easily changed if necessary.

Fixes: b8b8b16352cd ("rtlwifi: rtl8821ae: Fix connection lost problem")
Cc: Stable <stable@vger.kernel.org> # 4.14+
Fix-suggested-by: Pkshih <pkshih@realtek.com>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Tested-by: James Cameron <quozl@laptop.org>  # x86_64 OLPC NL3
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c |    5 +++--
 drivers/net/wireless/realtek/rtlwifi/wifi.h         |    1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
@@ -1123,7 +1123,7 @@ static u8 _rtl8821ae_dbi_read(struct rtl
 	}
 	if (0 == tmp) {
 		read_addr = REG_DBI_RDATA + addr % 4;
-		ret = rtl_read_word(rtlpriv, read_addr);
+		ret = rtl_read_byte(rtlpriv, read_addr);
 	}
 	return ret;
 }
@@ -1165,7 +1165,8 @@ static void _rtl8821ae_enable_aspm_back_
 	}
 
 	tmp = _rtl8821ae_dbi_read(rtlpriv, 0x70f);
-	_rtl8821ae_dbi_write(rtlpriv, 0x70f, tmp | BIT(7));
+	_rtl8821ae_dbi_write(rtlpriv, 0x70f, tmp | BIT(7) |
+			     ASPM_L1_LATENCY << 3);
 
 	tmp = _rtl8821ae_dbi_read(rtlpriv, 0x719);
 	_rtl8821ae_dbi_write(rtlpriv, 0x719, tmp | BIT(3) | BIT(4));
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -99,6 +99,7 @@
 #define RTL_USB_MAX_RX_COUNT			100
 #define QBSS_LOAD_SIZE				5
 #define MAX_WMMELE_LENGTH			64
+#define ASPM_L1_LATENCY				7
 
 #define TOTAL_CAM_ENTRY				32
 
