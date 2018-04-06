Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+Qx01VctWl03VOiofsg/wA2KM0+HcBS+ET76TG6VoQ9FJEVhGsdr7TtrDkUOJyCUa1tloX
ARC-Seal: i=1; a=rsa-sha256; t=1523021183; cv=none;
        d=google.com; s=arc-20160816;
        b=jXT6sEeDXqEvt17TfyDhJk7s5OuQKM78tlS9tEWTABAr7meHjkEVG5gAPS8qMOivga
         sE0FabdRfgWtb47qdLmuphASpJsD5jaCpGptai9oU2eH9bNte/Q23Yp+BJ9wtayQB4YJ
         c5hnEWncXazk5Puzt7v1x5HKuLlvqPow0uTkFc75zl1vnUNhH0BbrvseHEaMmmmyCat/
         WXxFSXIKt3CvnEVovhr/chF4kSPofaQ6Oxm+4iB/bKRw/pHpQNTLF0SjUVolR71XQv4Z
         3VcwMxSLsEPnTQ7fkWqZ8QSMspcJUs9g3Sk0YvkAM287UK2UslcVdwioPog2cR5aRMN2
         BRLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=k+ykTYCrmsoMyyDl6Yk8Rn++YmGzSnKDqL5hggMHvCo=;
        b=WCDJIciuv2qBaIIOg/RiRzytKRXAdUzQGEV7emz2LLG00XKaq00JID+NKkEcSm2s6P
         XiYKeFlH47Sskoj5olHFP9s+MwfV8ghpnQEY85kiNBoU+igiirQD3oBkfebKJcQVv0Om
         xT3AIQz7thHuhxQJTLVZE4yH5lCuyKi/oW6GXVd3OcN2AwnTmXe6Slrb/8oi4zL7Lq5E
         YwT4l9a9WUtWFSa8JuzS78tWq2EKwtJiFizhbkMAVVXqvdUQjVCufSJ+9OAkYCFeXZ/B
         iT3e5lfO7jUlrWFkD7ZYkZz3/uk9TxxGJjA1i+RTW4F4Kwe7nWAHCYxl2+Z1ivEq/p5f
         9PcA==
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
Subject: [PATCH 3.18 37/93] mtd: jedec_probe: Fix crash in jedec_read_mfr()
Date: Fri,  6 Apr 2018 15:23:06 +0200
Message-Id: <20180406084226.574797724@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003460655922984?=
X-GMAIL-MSGID: =?utf-8?q?1597003460655922984?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
