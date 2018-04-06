Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48mmQQfbhMA3wPBWqL/iV9Aj7KPyQlgVuTCsblOw5C/VtwFSKkrJRPSq1wHR1Z+HDSTjjV1
ARC-Seal: i=1; a=rsa-sha256; t=1523021320; cv=none;
        d=google.com; s=arc-20160816;
        b=i0BOQdB9argQUiYv/SDlC0sKH08ZcDgfiihwdebFgk+T1TV7S/00F4m/PeRSU6OKPo
         k85OEX4VEf4Hrm6KhRCVlruhuSMbzoEsy1NaFgCqpCQJwlIykKPXF0S2tZ+esWg9o+/7
         Npp/OmG0r4JuOybPmvZ1SC4cauK1b1Lxejw4T52eTn4rXhtxcr10WOjYMBVuRI6ni+ho
         SZG3xLcyag2dExEh26ZYIw6GXTmGPgoJi9p+o2d5tMi6dNUnwIZgMKLOOASgdu75ms2n
         4z56D6l0M4QXWNu+mB7gmakkDpIZToT/uVchHWbPUrGms+oXXbK7wn3BTWMKTju4vnHj
         XeKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ftOp224C/EFcUi/cNoHoqxwiSwqSmi6LE/eTn4QnWoY=;
        b=R13GwKO/S3OxdrssoxPRCDj654Azgzws2zdYhZREEc+IGoAUVqyzXIdDUAPAoP5JDF
         wxmGAZ6vwNxVxjlOeVK0zIXCpyiwTlVyowPtEXFpy1E+bWm57B/lZfMDFKQhMhPGNxeq
         DOVVs2aef9qIiR4kTDN9Kxu1T1+n7UbOkexlLqDdgp1UyI9xpLiyCfCDQUvtvScpVT5K
         pf4zfg2n7kW80wWDPhokwVJ2/nVbZv2m+TXNlxQ/Qbp/yv/qrArZbi56XwuTPepydJGz
         BXtg1RoSIvk6N8/mlaFZA/gCoNW6Jpb2qvotlBRWo+qh9chzPED+0DvBP83PMNSKif+6
         HIwA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Szymon Janc <szymon.janc@codecoup.pl>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 3.18 55/93] Bluetooth: Fix missing encryption refresh on Security Request
Date: Fri,  6 Apr 2018 15:23:24 +0200
Message-Id: <20180406084227.307581569@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003604240794198?=
X-GMAIL-MSGID: =?utf-8?q?1597003604240794198?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Szymon Janc <szymon.janc@codecoup.pl>

commit 64e759f58f128730b97a3c3a26d283c075ad7c86 upstream.

If Security Request is received on connection that is already encrypted
with sufficient security master should perform encryption key refresh
procedure instead of just ignoring Slave Security Request
(Core Spec 5.0 Vol 3 Part H 2.4.6).

> ACL Data RX: Handle 3585 flags 0x02 dlen 6
      SMP: Security Request (0x0b) len 1
        Authentication requirement: Bonding, No MITM, SC, No Keypresses (0x09)
< HCI Command: LE Start Encryption (0x08|0x0019) plen 28
        Handle: 3585
        Random number: 0x0000000000000000
        Encrypted diversifier: 0x0000
        Long term key: 44264272a5c426a9e868f034cf0e69f3
> HCI Event: Command Status (0x0f) plen 4
      LE Start Encryption (0x08|0x0019) ncmd 1
        Status: Success (0x00)
> HCI Event: Encryption Key Refresh Complete (0x30) plen 3
        Status: Success (0x00)
        Handle: 3585

Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bluetooth/smp.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1178,8 +1178,14 @@ static u8 smp_cmd_security_req(struct l2
 	else
 		sec_level = authreq_to_seclevel(auth);
 
-	if (smp_sufficient_security(hcon, sec_level))
+	if (smp_sufficient_security(hcon, sec_level)) {
+		/* If link is already encrypted with sufficient security we
+		 * still need refresh encryption as per Core Spec 5.0 Vol 3,
+		 * Part H 2.4.6
+		 */
+		smp_ltk_encrypt(conn, hcon->sec_level);
 		return 0;
+	}
 
 	if (sec_level > hcon->pending_sec_level)
 		hcon->pending_sec_level = sec_level;
