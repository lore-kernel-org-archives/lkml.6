Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48yNLr8QaE3HbiiVklKR7mv0ydGtHrIaL3asp8ms9a1sqwXSecZ6r9spkUfb8wcsgU6inPo
ARC-Seal: i=1; a=rsa-sha256; t=1523021457; cv=none;
        d=google.com; s=arc-20160816;
        b=NkOkxbbU98eouNeA22qxdnCGUDps+W9dkHpHcBpzmzgG9htZokLVbdUgpw7cUGwzga
         +7EhRRnBJedpLq50PiwgVqeSOb/wYnA4uF5OmrqB+R921xCxksK3YGibdU3V+LA1qYD3
         4KVX0ZguIRQ2fLx7serh/fUT7pRPgLhZVn5QQ7FWIN3ECrvZNAo5vnqZi5+dCjeC+Nm2
         6wSMEvFQAjT3SDSQISLOCXtoN+XzgHslXbyFnWOx2St+6Wu6zdlJX9ZRN1tu/OTJblZb
         wBUclQ/CQgG3URPZ8UH+JkeUZqqkXHp9Ifd+PcatkGmv7Gf7SRtKBmnnJunkoem/XYsL
         PgaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UI/x/QzAeeKqKXXHDeBZVsfIfajThh/7QL58bMPJWH0=;
        b=c1qgTIZdtATIAZtG3Y4vJ2s6wPbwpShxyyItshFNiPkHejcdca84uCTohEJ0z6pHR7
         7ePmSdJegRqT0tVydktihtKTY5idzRaDI7oXUA6ABdfjo5WA6YMniQ5a0+Q557Q08DAl
         n5Q6JkbQJ7pXqyWO317jUEp6Ua8t8atwjGoFxXTXEiX407WbBckeqvrZMAD5E9t9XI45
         55OFZGkViVNypJgbFpySuTsS/DbT0vQIgpapxfz5m54doNwGuFz0Fz0ixl11dFsV/SaX
         9FmXBuGxQchjQ0jMMFQojBFg2e5sA+HFKIJ82rMK3dca7OFUPSM9cqvOHdQD6xN0pcD4
         GfQQ==
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
Subject: [PATCH 4.4 41/72] Bluetooth: Fix missing encryption refresh on Security Request
Date: Fri,  6 Apr 2018 15:23:42 +0200
Message-Id: <20180406084308.607718398@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003604240794198?=
X-GMAIL-MSGID: =?utf-8?q?1597003747703259506?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2251,8 +2251,14 @@ static u8 smp_cmd_security_req(struct l2
 	else
 		sec_level = authreq_to_seclevel(auth);
 
-	if (smp_sufficient_security(hcon, sec_level, SMP_USE_LTK))
+	if (smp_sufficient_security(hcon, sec_level, SMP_USE_LTK)) {
+		/* If link is already encrypted with sufficient security we
+		 * still need refresh encryption as per Core Spec 5.0 Vol 3,
+		 * Part H 2.4.6
+		 */
+		smp_ltk_encrypt(conn, hcon->sec_level);
 		return 0;
+	}
 
 	if (sec_level > hcon->pending_sec_level)
 		hcon->pending_sec_level = sec_level;
