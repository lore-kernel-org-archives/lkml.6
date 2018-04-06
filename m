Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+Z/LXyKDdRCeE4p+uUujAZt7efudBlHSQUkWvmIGN1MFfJPg1rFYR4nKsoRaObjXV1QaNm
ARC-Seal: i=1; a=rsa-sha256; t=1523021389; cv=none;
        d=google.com; s=arc-20160816;
        b=nhBJ19D3t8FH6D5oauWIAxw54iC55vxkcRsY7LVcb2ZlHenleVs+M00WjDkLMvJajV
         4Nm5Hx/VGrTHejXz+uGW+VcvDrkOZOoHc/ZS9iYeKsHjN+CCPoNKwtxY/cUI30SgIiW8
         Whujk9KAi/vUW+zroMhzx00Sds5TgycmNK4XRsm9dhCAeczD7v2osJWw19AWdM/NVrhF
         6LCx2kssfgXPjoSp+vC4j+Vrk1TbU707yJov+/YC2F8gXIPkJSNJldPUKjo/N+hDfV1I
         c0r0ldgC7lEPFzJoeIMYZ6ZbOf8pgo3gVqTkTxzsSmvdjyqSvfCsIgoWmfCPnzmaexAb
         ADkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NlxNaYh4tDTkH47AS1F9cJSNy+fm8iZbqKSx+VQOlJc=;
        b=zWsTNfcTp7DjiyHfpw3RpwHpUeR9zQZ3xSkjvkWbp4RYM0U608A65zfQxlBY5mSIUa
         KP1LQhYhqh+u0zHhyggsuHLkElIGWLanrhH0laTb228kWa1yFA/qtsZnSzQiyD/rYiCW
         /OfwU7jamZJ3nixVgWZ+c7vP74YXaLG6zO69q83SW4X47Nh/+dVw0kJStc7YRra+BfX1
         XxNOOylPmRVRQ2NO5pSICp+udeXohX5tl1jzlOSVzpqpKPfY8qdiMKJbMhtdOQ9/ImgC
         VIU+gzyQhz/gaKXsMJLbx7NfVPjUZj+aYEybd8nqBaZRck1Gfodd3IlNULtyn71DkvhZ
         l8mg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.4 01/72] mtd: jedec_probe: Fix crash in jedec_read_mfr()
Date: Fri,  6 Apr 2018 15:23:02 +0200
Message-Id: <20180406084305.298690833@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003460655922984?=
X-GMAIL-MSGID: =?utf-8?q?1597003676812971787?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Walleij <linus.walleij@linaro.org>

commit 87a73eb5b56fd6e07c8e499fe8608ef2d8912b82 upstream.

It turns out that the loop where we read manufacturer
jedec_read_mfd() can under some circumstances get a
CFI_MFR_CONTINUATION repeatedly, making the loop go
over all banks and eventually hit the end of the
map and crash because of an access violation:

Unable to handle kernel paging request at virtual address c4980000
pgd = (ptrval)
[c4980000] *pgd=03808811, *pte=00000000, *ppte=00000000
Internal error: Oops: 7 [#1] PREEMPT ARM
CPU: 0 PID: 1 Comm: swapper Not tainted 4.16.0-rc1+ #150
Hardware name: Gemini (Device Tree)
PC is at jedec_probe_chip+0x6ec/0xcd0
LR is at 0x4
pc : [<c03a2bf4>]    lr : [<00000004>]    psr: 60000013
sp : c382dd18  ip : 0000ffff  fp : 00000000
r10: c0626388  r9 : 00020000  r8 : c0626340
r7 : 00000000  r6 : 00000001  r5 : c3a71afc  r4 : c382dd70
r3 : 00000001  r2 : c4900000  r1 : 00000002  r0 : 00080000
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 0000397f  Table: 00004000  DAC: 00000053
Process swapper (pid: 1, stack limit = 0x(ptrval))

Fix this by breaking the loop with a return 0 if
the offset exceeds the map size.

Fixes: 5c9c11e1c47c ("[MTD] [NOR] Add support for flash chips with ID in bank other than 0")
Cc: <stable@vger.kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/chips/jedec_probe.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/mtd/chips/jedec_probe.c
+++ b/drivers/mtd/chips/jedec_probe.c
@@ -1889,6 +1889,8 @@ static inline u32 jedec_read_mfr(struct
 	do {
 		uint32_t ofs = cfi_build_cmd_addr(0 + (bank << 8), map, cfi);
 		mask = (1 << (cfi->device_type * 8)) - 1;
+		if (ofs >= map->size)
+			return 0;
 		result = map_read(map, base + ofs);
 		bank++;
 	} while ((result.x[0] & mask) == CFI_MFR_CONTINUATION);
