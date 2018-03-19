Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvFvgEwMQX1nbaiT8hmS7eKWDrbZNE5YD6kT2iafAPFfT/KlWTvYf/xkwwVtWbcz5wyk93+
ARC-Seal: i=1; a=rsa-sha256; t=1521483185; cv=none;
        d=google.com; s=arc-20160816;
        b=gfjA4jeHNYVDcHuyfXrhyzS8AgLQTSiD43H9gnBJG4oivdt0qBvrd8OBRXjzooKDfA
         7c1k0qma2BGXaySnOhxPx6Y9v2z+HiBDarJ3+O3ylhxO1SAfnocKfbrexdORd2gVQ27k
         gmxRqhz0hDAFGeadcTzQrR+yvUQFbFEkwxZdQYpPL9y6fIk22rrF6ZZJvSnwuo1YKrD6
         t//1ln5T4w9+7ToZcFm+fIuWJ9Vabg4GsDSu6NOPViJaEugnoWb1ftXO40ZSI8Jy8PrP
         RbF2s9MiRRb/3EAYh0tHIjoxaNs6/TT/5cS5Tma61XsiuBFPgo1VIMGhGT0uFotApNUZ
         ERmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=v8NdPbMtbpd+FeyoSzH7cMlz4JT90kEZ0nvutMD3vSU=;
        b=uieSjs4wyfqwxqebco8tidIOoI+HWpUAixbvTUJXvn2VPwyJEoEB8KpD07V6SSLeJV
         kdvbSEiD2dewiB3MbpEL3EOpIkiUx5AsIAd1p1YB7NNwVHP3hXrlP1bBQv8fJVx0pmOe
         p9mWnKpPInuCwstO38IDYcz1jDymKijMYJM5D7jLlSmKt4OKujv0dchg/apVfkk+WjS4
         YRycIk9ekF5EJkzBwjb/rLcedZAfUlUCrhm8CS373MxrasTHsDIfVCBc9rjh2ZjD7rdv
         5CUJLVx9sZUPPaCBm+v70xnmNm3gtg/hjF8XRyNKZhxEJDLh07qZ/HPu1XNViAhQtZub
         bCTg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Varsha Rao <rvarsha016@gmail.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 003/134] staging: speakup: Replace BUG_ON() with WARN_ON().
Date: Mon, 19 Mar 2018 19:04:46 +0100
Message-Id: <20180319171849.537393187@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390752859933338?=
X-GMAIL-MSGID: =?utf-8?q?1595390752859933338?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Varsha Rao <rvarsha016@gmail.com>


[ Upstream commit d351c2db5420bb17dcd2d9aac7ddb5f64c6d04b3 ]

BUG_ON() is replaced with WARN_ON() and EINVAL is returned, when
WARN_ON() is true. This fixes the following checkpatch issue:

Avoid crashing the kernel - try using WARN_ON & recovery code rather
than BUG() or BUG_ON().

Signed-off-by: Varsha Rao <rvarsha016@gmail.com>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/speakup/kobjects.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/staging/speakup/kobjects.c
+++ b/drivers/staging/speakup/kobjects.c
@@ -831,7 +831,9 @@ static ssize_t message_show(struct kobje
 	struct msg_group_t *group = spk_find_msg_group(attr->attr.name);
 	unsigned long flags;
 
-	BUG_ON(!group);
+	if (WARN_ON(!group))
+		return -EINVAL;
+
 	spin_lock_irqsave(&speakup_info.spinlock, flags);
 	retval = message_show_helper(buf, group->start, group->end);
 	spin_unlock_irqrestore(&speakup_info.spinlock, flags);
@@ -843,7 +845,9 @@ static ssize_t message_store(struct kobj
 {
 	struct msg_group_t *group = spk_find_msg_group(attr->attr.name);
 
-	BUG_ON(!group);
+	if (WARN_ON(!group))
+		return -EINVAL;
+
 	return message_store_helper(buf, count, group);
 }
 
