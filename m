Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227K8mqBHcd9RRMbr3ElWhKtZQaHvI9IrsQL5T0NkxSfbGTAorHpbAHSue48FKJdZdSr1OL1
ARC-Seal: i=1; a=rsa-sha256; t=1519217142; cv=none;
        d=google.com; s=arc-20160816;
        b=G2vZQykncatn1vUHOncNcGjwGR8yciD+H0smDtEvHtnFCbG4+uBqISkpYdDuWf+oT+
         xa7Onbso5yOQCgg/THndjh8JT6ip4i8UMVYfsLmYfzEun61Cn2OVESj8//wmLKd1iHwH
         A/J0Ixe7k3EYGc1MWXiFGAEpF8JZCrvBfIzHxXE6dlUwn0imEmt5GQTuLAFUa2WBwcEJ
         vSmQE46fwiNBHYoTSQNjwZs3r9hrcaWdX0aFwPnZj98wQIHD2HQJtk+zYtQddufmssRy
         Q1reENdIEob5qlXr9yG9FT1UaExMi+zOjS/jFnrDUJDHvBWbWXTj6qE2I4SSAkRU28GR
         df5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nOCv7FM9fNQdDqeELq0L1sDpTnbUIQflkRN64t8x7k4=;
        b=LsifLqHjEKjnAAjH1fxDT92hS2ET8b3bVqDbWzmpI/+1nQKrREZU89Xz0sAxmWSIV6
         wV0Qes1yQLlwK1RDTCc36XzSIbMOUtNr26upSZVRFoS53hQQiXPt5OKaGuIEq9XPSHx9
         aZN8gByi3EUhaIQMwitaqD2PTQEA16VDUEm5M/05m9Dt1W/X8coReLWodeexEUDhcebt
         0KEmCeKckuM/KMk2ZAqefdhdRyYnKHrSdxn5w0Ruuiw8RyzaHabQb18uNBQsHMKScn8f
         5vcpi7d9k51b9pL3JrkCbLLbz2n9Y6STZiCpdNM6vcT1I1jg0sU5wjZw3SCLRb38JsQA
         WmYQ==
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
Subject: [PATCH 4.4 18/33] rtlwifi: rtl8821ae: Fix connection lost problem correctly
Date: Wed, 21 Feb 2018 13:45:01 +0100
Message-Id: <20180221124410.563533089@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124409.564661689@linuxfoundation.org>
References: <20180221124409.564661689@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014634978594268?=
X-GMAIL-MSGID: =?utf-8?q?1593014634978594268?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1127,7 +1127,7 @@ static u8 _rtl8821ae_dbi_read(struct rtl
 	}
 	if (0 == tmp) {
 		read_addr = REG_DBI_RDATA + addr % 4;
-		ret = rtl_read_word(rtlpriv, read_addr);
+		ret = rtl_read_byte(rtlpriv, read_addr);
 	}
 	return ret;
 }
@@ -1169,7 +1169,8 @@ static void _rtl8821ae_enable_aspm_back_
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
 
