Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/D9fa450U+r982iCZmLVI8qbumxoHK0pngRTRearHMhp2Ty9SkfIl3aVaXRSccq5eDXOQL
ARC-Seal: i=1; a=rsa-sha256; t=1523021584; cv=none;
        d=google.com; s=arc-20160816;
        b=wc1ZjiJcBPCQ31bZ4UZnMH9mA1h3He5DvKqUxu0mjAaZphy3WrvOB36iz4DN4HQbVy
         Cj4lhUxA4yjsmVhowbgI5nOhRg8jiKMjG4lfx4Rdy7rF/qHaoUIhLpULou5xhSIURyMd
         Bd8dHngOouxWTxryI7gwCrnn1rmyIE/ZpvyTYXHlS4n/KPf9CaRZSNKH4qe4uqGqNsVj
         uWrkDnLSSQYaroXhtWMbXJ4oJRs1WiTIMot3ZQWy5eI4+NYTOulDZOTaRsmEHuVQTzmS
         qLdssMlaxdyFzaqRg5IM53QqJod2Oz5a43p76e19zNON21TXibIHxnalpEFyVDintsvK
         ya8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=D53GJICjBd8ypNiX4XJKrYljAWP0EmWdE2WCs8V3o2o=;
        b=mLyDUs+LdBI40pjSfDz745qdOLKMVW6nBx95mwyDHc1eNTD6yLaa7sQB5ufGFMDVft
         SUAnh2KdmYAp9FAgJuptEUfmWkpQvzhu6UJnJmLlSHjD6BVuP7Zf3Kms6XgnLu+3pdoY
         L+XlcOcWlIQqHwAvWfFYcKPtZt3QKCBh62uVXpDJeLq0EXVWOaCBG+9bROk54AjhDqSt
         gWc707N7TudNCrEpKl7kEnJgYXoac96eHPYmXp4YMyUFNzTLLticffbrnD6/ciJbSp4v
         ZTD/GvBtj1IgB8gBq4S5y1qgjQmWk7z6KvTuff9N2KYIomLQlQQeSjntK4FVUCx4zbA3
         2D+w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Matthias Kaehlcke <mka@chromium.org>,
	Grant Grundler <grundler@chromium.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Greg Hackmann <ghackmann@google.com>,
	Michael Davidson <md@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 017/102] genirq: Use cpumask_available() for check of cpumask variable
Date: Fri,  6 Apr 2018 15:22:58 +0200
Message-Id: <20180406084334.023785777@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003769148140968?=
X-GMAIL-MSGID: =?utf-8?q?1597003880603786793?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>

commit d170fe7dd992b313d4851ae5ab77ee7a51ed8c72 upstream.

This fixes the following clang warning when CONFIG_CPUMASK_OFFSTACK=n:

kernel/irq/manage.c:839:28: error: address of array
'desc->irq_common_data.affinity' will always evaluate to 'true'
[-Werror,-Wpointer-bool-conversion]

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Cc: Grant Grundler <grundler@chromium.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Greg Hackmann <ghackmann@google.com>
Cc: Michael Davidson <md@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: http://lkml.kernel.org/r/20170412182030.83657-2-mka@chromium.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/irq/manage.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -850,7 +850,7 @@ irq_thread_check_affinity(struct irq_des
 	 * This code is triggered unconditionally. Check the affinity
 	 * mask pointer. For CPU_MASK_OFFSTACK=n this is optimized out.
 	 */
-	if (desc->irq_common_data.affinity)
+	if (cpumask_available(desc->irq_common_data.affinity))
 		cpumask_copy(mask, desc->irq_common_data.affinity);
 	else
 		valid = false;
