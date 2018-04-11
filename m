Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48VEnEIFX2vJoNs9INQZ4xuvTnepBDTYvULyG+HtEOfFINMq1Odkkn3sR+IsJPlS2nvdQ5e
ARC-Seal: i=1; a=rsa-sha256; t=1523473510; cv=none;
        d=google.com; s=arc-20160816;
        b=OVXJeAfDmSfVTcqGdovdmHtwC/Zb2DuDln6crL0DxuYN9aiDPXtnVTXGJzdws1U418
         MtBSCyTF/h+NKOH7boc5VqukQO1EnOHsm8mx/w6CknX9hJBRoKtMoze7MLjKDQns61jt
         cziKU0dWqeahWmTybI5CEHs5UvixwfgRqO+2it60zkeJu1qAlvqoSpzWX9ZGVJlSExW4
         Qqj8wtjlYAOTWSMzrlkY8cs1shstiTU45vS2H3GFbmIUAAiyldICoPVX7u+WljlIzw3Z
         jT5au3Ttjaq8TF5qXmUZbr/g5944ytZwcUv/YdpBx8anivyrRIZBrXHl4Elh0DuoXfm3
         Tk9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LDJzTjoiMJbVR56ZWPwGskNP7RpBTBrBPcAh9kSM7i8=;
        b=sOhoxTD+mMU/6Bp2uds4lMeBS6mF90nTRJcehCrxmzDC9kHtvqzmuTMCpE8krZt53f
         DdzY0XC2lDZo7m0lfC0UvRBfGgxV1PYdzBEFJThbM5/EEzbJnt/KOdodaeaSuJ4wbb2q
         V1mkAWVds3RJ0LDzViT5mmqcJMHIcirwuvXAxC6xvtR4OLrMnSzqEhUJi+jmPxvbhnf5
         C1oKE57VsdM3hwPZCsW/TTy0uX/VryY7/BNBmYnlgCLznmNlx+3KnDOXQIlcgifi/L8g
         vx5EvBd4lbKw1aXSXXRFIZfWp4lkf5GkWfFSo+pCLmTj2H8PBnBvmpTg6NCHlU/BFeY8
         IHDA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>,
	Michael Schmitz <schmitzmic@gmail.com>
Subject: [PATCH 4.9 274/310] random: use lockless method of accessing and updating f->reg_idx
Date: Wed, 11 Apr 2018 20:36:53 +0200
Message-Id: <20180411183634.411401502@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476320315000318?=
X-GMAIL-MSGID: =?utf-8?q?1597477759922247699?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 92e75428ffc90e2a0321062379f883f3671cfebe upstream.

Linus pointed out that there is a much more efficient way of avoiding
the problem that we were trying to address in commit 9dfa7bba35ac0:
"fix race in drivers/char/random.c:get_reg()".

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/random.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1115,15 +1115,15 @@ static void add_interrupt_bench(cycles_t
 static __u32 get_reg(struct fast_pool *f, struct pt_regs *regs)
 {
 	__u32 *ptr = (__u32 *) regs;
-	unsigned long flags;
+	unsigned int idx;
 
 	if (regs == NULL)
 		return 0;
-	local_irq_save(flags);
-	if (f->reg_idx >= sizeof(struct pt_regs) / sizeof(__u32))
-		f->reg_idx = 0;
-	ptr += f->reg_idx++;
-	local_irq_restore(flags);
+	idx = READ_ONCE(f->reg_idx);
+	if (idx >= sizeof(struct pt_regs) / sizeof(__u32))
+		idx = 0;
+	ptr += idx++;
+	WRITE_ONCE(f->reg_idx, idx);
 	return *ptr;
 }
 
