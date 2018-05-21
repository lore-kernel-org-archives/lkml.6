Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrpLgy/H7oHGWyM6t/Kypi9cPcDyvPn+/THwLIwEnaXPoeWqDjTgwudaOuxlCapbe09Y7mt
ARC-Seal: i=1; a=rsa-sha256; t=1526937651; cv=none;
        d=google.com; s=arc-20160816;
        b=ZJHlLnX+VhbuqFulwQ2T+L4GyFEpvAN+uwGWasRG5KQhj4Lsay4yU+B76hL8lpw7Mq
         MJ1l6T44EkMLOWd80iL6MSkDqLs3TiQmQArQGtLtIxN1JiUTaK8rja3fp4Xs7wMKozsN
         AKp99KFiqZEuK6ar9CYA+YXwpOpVApSVF/uYSP1h3sQgpIHkMoRLvWpwFVNdBMOWHP7K
         7WB75p4U3PKBGOnItA5NMHg2IvpdVA0oEtnF7IsQ3rKx/kl+7dByn+pI+SLIArdy/45M
         uDusrGsqFithabDyqQ02yDK8nuxdcivmh7RFPXFU7QGhCanbDZMWaONaVp04gXBjD4Ji
         fwgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=bwVJimv/n4KZALNrp7YexZp95/8OgQEkNS0V5Y5ac+8=;
        b=K+gBEq/OeLONB8LodLRUTKqrA6xL0YIKIGh9dMbvOoanvbi1huiC/pYyknupwdOgVz
         WWqzIX8BCS7VMPkEetFdWPjFGuLPrW1SfxxS5LlD7hNDiSFY0G/PMFMCxblNz0xWB72e
         cM76yw1jBNBgIIV+hEBfUFPiSPEIAyu5nAjRozDas54gqYxe8aCVZtfc4UeiFKkHYHPm
         Iu6O82Gl6BqAF/8FU3upehvThFskuFBNVlqKUQUtsM7L9eZxEDMTt/GiplHn1AZVtVp1
         gaFnNM0/kFAoQ3hZXwczZrZDcpMdnDXqQg5UuW7DmpJ2ZAwinm2JamtA8zbj/hW07BR8
         MU4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=OLBD3l5Q;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=OLBD3l5Q;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 4.14 39/95] ARM: 8770/1: kprobes: Prohibit probing on optimized_callback
Date: Mon, 21 May 2018 23:11:29 +0200
Message-Id: <20180521210455.995294715@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109801592715270?=
X-GMAIL-MSGID: =?utf-8?q?1601110175196831082?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

commit 70948c05fdde0aac32f9667856a88725c192fa40 upstream.

Prohibit probing on optimized_callback() because
it is called from kprobes itself. If we put a kprobes
on it, that will cause a recursive call loop.
Mark it NOKPROBE_SYMBOL.

Fixes: 0dc016dbd820 ("ARM: kprobes: enable OPTPROBES for ARM 32")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/probes/kprobes/opt-arm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/probes/kprobes/opt-arm.c
+++ b/arch/arm/probes/kprobes/opt-arm.c
@@ -192,6 +192,7 @@ optimized_callback(struct optimized_kpro
 
 	local_irq_restore(flags);
 }
+NOKPROBE_SYMBOL(optimized_callback)
 
 int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *orig)
 {
