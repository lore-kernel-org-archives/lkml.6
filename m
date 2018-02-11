Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x224PkcjvpzWfXpRgFEPyPoiJSi3faPfHT3GQ3Y5mc7fTn3tzy6XP5fHSmCIfWcebSu6xnniF
ARC-Seal: i=1; a=rsa-sha256; t=1518323636; cv=none;
        d=google.com; s=arc-20160816;
        b=edDuWogJH1muxGA/ZioPqImS5k52pWecrVn3RFwrO49YLeEeILcQ0aLfc8A5/7jSGg
         uRpQfo6wACoFe5NsPyHBS0v219irLMDbM9AgCuB5XY1MKthf1weDpMeKSw69aFVMDz7R
         BjYrv2H1bHblc297f3778Xh8LqYi1jpDgEBmgWgXiSS21S9XtvNCkyLQg+hF/njRHdF4
         RsfosLhgcfUxTloareE09xCRnQ4q0cyC27WrvVzZXvgrEvZU4VuggG+DZ5zTNFriUjgx
         /RMUeUWqEuX60Jgj7tjNymcF8SwLG70KKU+Ix22vT6ey8I+Zg/cxBJdq6Zu89LelQYXY
         mEQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=zG3Awq0mjrxHUPxLBvyU3Wcsy2xrlQnoqDV+MT0u8a8=;
        b=K0is9pWnL6+YuqGfbpBQltIVYUwSbGg5+TLsjEkFjTlFizKD/yFaXozb53fc7p25JN
         0ULvEtbQeGSmS4Z0wpAxDHz93KWgkT8fz8X0+PrbTMbcIMoj+N+wnjPS9oMrDAPmqBBx
         2pJUo+NpqBkaFEzS9dK20E9/UDRjHIXXURT8fu2d3/+4t8S5RqMB5TuW9Y4+h4jm0rPQ
         5Fsv4/jiAu/FWJuYVoeCrdfsxfrGs1yBZKk64xGJm4lA+wlcRXbHNEVqHPlQF4QTqL/k
         AtP7ufMsZOlPsJqRNb+Wbvyseh/od0wq/DzZcYpRCGreo8pFZapQRaqo7yYsCUHAF7e7
         iveA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Guenter Roeck" <groeck@chromium.org>,
 "Lepton Wu" <ytht.net@gmail.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Juerg Haefliger" <juerg.haefliger@canonical.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.926595971@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 136/136] kaiser: Set _PAGE_NX only if supported
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592077709129408782?=
X-GMAIL-MSGID: =?utf-8?q?1592077725302700782?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Lepton Wu <ytht.net@gmail.com>

This finally resolve crash if loaded under qemu + haxm. Haitao Shan pointed
out that the reason of that crash is that NX bit get set for page tables.
It seems we missed checking if _PAGE_NX is supported in kaiser_add_user_map

Link: https://www.spinics.net/lists/kernel/msg2689835.html

Reviewed-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Lepton Wu <ytht.net@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(backported from Greg K-H's 4.4 stable-queue)
Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/mm/kaiser.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/mm/kaiser.c b/arch/x86/mm/kaiser.c
index 2d5ac54dbcee..7cb57d14ddc0 100644
--- a/arch/x86/mm/kaiser.c
+++ b/arch/x86/mm/kaiser.c
@@ -195,6 +195,8 @@ static int kaiser_add_user_map(const void *__start_addr, unsigned long size,
 	 * requires that not to be #defined to 0): so mask it off here.
 	 */
 	flags &= ~_PAGE_GLOBAL;
+	if (!(__supported_pte_mask & _PAGE_NX))
+		flags &= ~_PAGE_NX;
 
 	for (; address < end_addr; address += PAGE_SIZE) {
 		target_address = get_pa_from_mapping(address);
