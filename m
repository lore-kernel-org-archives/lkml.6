Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49X7heP0EF1fZM0+kDjvIiHSEzrG3zEIUuuyyhiDLMj927enWQ/fcrbTzCs0pKyGTkZ+bbU
ARC-Seal: i=1; a=rsa-sha256; t=1523021140; cv=none;
        d=google.com; s=arc-20160816;
        b=r2eZEKdAO7wiPygP4YsGbfr82VzwnZo+uEKeb12UmbV56Lpq7nqkyxxbTPUdRalAl/
         a/3iulDynqRgy7vAINSpfbwugzP14/vhQ3ate+XvSUrMFi2BJejwecDPIvFyxAH3TPzf
         I9/aZZnvnI/DH+TfMFUBAL7H+oTP9C+cQGjYHV18Ajx7ysuI58HfUjwfpGMG+AucJNjG
         OkQkO2CDFPVd2Srb7WlIt+il5geL4zHmNUXu7vRfKDWS3POly7qblJu1Np0QTdg5Q/hL
         9PfSj1MQJY2M9RBwVJSreKt4R0zvPRCMdOpUVoKgr+k3HVe9buNjHaiHqdUUvanUrG69
         7iQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=02bN5jJuyOXtuvYPkRh+iznGQnqGjMMpdJT2IBMageg=;
        b=kcV19kKuv+9K4arlaNQSP0U4b0PBktnini1nQgQcSfwraHo11DyXQYrdz129ONFc7o
         ExO+JmGcbvrvecUaW+1k7AinH2iQPaFJVTkDWaCoQmjcMWm7ZmMmW/+c27/+mwuZk7w5
         zoFigb+agWhUOTIFaH65gZxxEl+SXlPAl37AM6lgfDqRKYOMf7gbTlGf/krmVu+KCZPJ
         RGLxpmgecyS7m/U8fTGK/myM4/ELNfUaMsyXZ3JAviO+ykhN/bY2MA7OFe3PpeR9qBK2
         roVLXMNihFkizj5tgDN3MAm7SnepddLJduKgntS9JJfe1lf6PTafhRi3sPjObWGf/VOF
         xv2w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Hans de Goede <hdegoede@redhat.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 22/93] [PATCH] Revert "genirq: Use irqd_get_trigger_type to compare the trigger type for shared IRQs"
Date: Fri,  6 Apr 2018 15:22:51 +0200
Message-Id: <20180406084225.933236091@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003415122776134?=
X-GMAIL-MSGID: =?utf-8?q?1597003415122776134?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

This reverts commit 093c265afffb0a91a7611c3bb74d0883731a807b which is
commit 382bd4de61827dbaaf5fb4fb7b1f4be4a86505e7 upstream.

It causes too many problems with the stable tree, and would require too
many other things to be backported, so just revert it.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/irq/manage.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1058,10 +1058,8 @@ __setup_irq(unsigned int irq, struct irq
 		 * set the trigger type must match. Also all must
 		 * agree on ONESHOT.
 		 */
-		unsigned int oldtype = irqd_get_trigger_type(&desc->irq_data);
-
 		if (!((old->flags & new->flags) & IRQF_SHARED) ||
-		    (oldtype != (new->flags & IRQF_TRIGGER_MASK)) ||
+		    ((old->flags ^ new->flags) & IRQF_TRIGGER_MASK) ||
 		    ((old->flags ^ new->flags) & IRQF_ONESHOT))
 			goto mismatch;
 
