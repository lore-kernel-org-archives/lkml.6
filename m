Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1521561-1519217687-2-16171987608356712181
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, URIBL_BLACK 1.7,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519217686; b=FUpEb4Sb8+M7k35olOd6eHwmlnw6CYJ5jSa/7hyt5IgeEiC
    xh158hZXQlLN7gTGUdwSfhfLVF9VkSZdUU1KkhlxY2W3Mefbsg/mRcOIk/UueAdb
    4MKSDFFdXJLe6b6AdlPf/l2rqd5zYla2eddILYngnyCo8QuwZfL1DXK2M1JutbOn
    Zdb7HJ/H+LxoApfpuPulGRywwJVk9zoA64Mnze8UGVLwB0I20DFZRjztLZMKaZry
    UqCRcK1V5W280a/AnS7weGxWdY7LQG0ONyBQPyfaLsQ7qgxyl1LB595GveY+Jrnf
    7OMzDBoYLdZrhURzYYfo5rPt8oxbqFS2xlBbcaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519217686; bh=MtiZxpLZQQt6+hCoQSG42T+zp2
    4/GKcKqzcQ8R4RmYY=; b=vL644QCkOrctviSMvyN7dwUf+1XkFTTGXxc7tLF4ul
    3IXAJ1b+Go6YM6BtbOuMUyJVaIcPkjOQtQ0vMDqLsDoHBrjXt70ysOOgHf54CmT2
    A0ApdbZYIfJ7L2wziHa7rT8fm38S4uasQB4kZWohBsKekejZtjjzzyreHb0rC8TC
    DL47ZbYNC5h7Z8fPIU39mnUXmNNDX860RudAT72QgK6oQjYMNsOWuzSa2CJhyXQi
    yUrB2V3bko0QQivHEF7GfFwxT0xXS1f7TgVS8UV72mgu69QvGhD5I+bjehoDNDzI
    C9vGXE3ZsIWj88NNVqKli0+2Gki8ItyBI6F5QaHBbqbA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934093AbeBUMyn (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 07:54:43 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34144 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932466AbeBUMyh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 07:54:37 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.9 16/77] rtlwifi: rtl8821ae: Fix connection lost problem correctly
Date: Wed, 21 Feb 2018 13:48:25 +0100
Message-Id: <20180221124432.867563876@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1128,7 +1128,7 @@ static u8 _rtl8821ae_dbi_read(struct rtl
 	}
 	if (0 == tmp) {
 		read_addr = REG_DBI_RDATA + addr % 4;
-		ret = rtl_read_word(rtlpriv, read_addr);
+		ret = rtl_read_byte(rtlpriv, read_addr);
 	}
 	return ret;
 }
@@ -1170,7 +1170,8 @@ static void _rtl8821ae_enable_aspm_back_
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
 
