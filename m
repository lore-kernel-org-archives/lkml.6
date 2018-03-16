Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvc8c8gIOuoa4eyvgDaj1nbM3c1KE7PFIciJw55bgltglJWHEubHwcNj+TPtxUc2RuSTacg
ARC-Seal: i=1; a=rsa-sha256; t=1521214383; cv=none;
        d=google.com; s=arc-20160816;
        b=T9v0RaJLRLsK1VY1SYxpXjTe6er/bOErWXCtpvokuFaOKlfYrIxnT6PM3t56J7YXdC
         ExNPmY9pZVBZgsSLZIeuX3oPX3iKSR5yxQtngMCyOpZue8vUFJBymYVhbr30Ezk1AOS1
         UIYm0T/K22hayO6u4J9x0JYXHAYkhn0RL1MXrosLtjyf1vx5NL81SqBK9fx2v7gDeCdy
         KOXn8wBQTizBntdC3iGW1iWsdgOGVFD9icZP4bq7ZP9TwpoSmDXDofDFtGRJT4VXTDhP
         2QAeL0VOXebNclCwpgAZCS9/uR+B+SwwjT4KnT022rSHIqyW/l7hETjDbGKQEB80Nl01
         z7jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IdknCDyjaxyuI+3FILbqewgVq/Jfbh27rKj9ZEifkwA=;
        b=EU+YOnhaUVaGAWafVZEJQnuqSGtp0U9dFfP0rIDrfCil16tKnFht2i8wi+byLBeB8f
         TZAs4oX5G0aJmvAOuEzIGpwdZAffv/utstGYxomPhOPdEbl+miLNQ6nLKPyHSutQCSRB
         0qsb2EFt6/fcRHtEIV/h+mfgCnyRB/Y/r4yImlfS6ZSzKG5NSvYIrE3h9ORibptjxsO2
         DVrDZCRRdcWgsAyqrPuRSEUy2/0dgZEh2LBvV1eJt+pXrmEbBWOYCHa0yzKzPFh2cPg+
         NXd65eYkZNt2/RPfUpbDLjxLucKS7vEG3Cl+a/3ffyLkYqblku7jITBsUYXBR4FuSVm8
         yBwA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Ulrich Hecht <ulrich.hecht+renesas@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Nguyen Viet Dung <dung.nguyen.aj@renesas.com>
Subject: [PATCH 4.9 73/86] serial: sh-sci: prevent lockup on full TTY buffers
Date: Fri, 16 Mar 2018 16:23:36 +0100
Message-Id: <20180316152322.278253230@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108493927910261?=
X-GMAIL-MSGID: =?utf-8?q?1595108893258272321?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

commit 7842055bfce4bf0170d0f61df8b2add8399697be upstream.

When the TTY buffers fill up to the configured maximum, a system lockup
occurs:

[  598.820128] INFO: rcu_preempt detected stalls on CPUs/tasks:
[  598.825796]  0-...!: (1 GPs behind) idle=5a6/2/0 softirq=1974/1974 fqs=1
[  598.832577]  (detected by 3, t=62517 jiffies, g=296, c=295, q=126)
[  598.838755] Task dump for CPU 0:
[  598.841977] swapper/0       R  running task        0     0      0 0x00000022
[  598.849023] Call trace:
[  598.851476]  __switch_to+0x98/0xb0
[  598.854870]            (null)

This can be prevented by doing a dummy read of the RX data register.

This issue affects both HSCIF and SCIF ports. Reported for R-Car H3 ES2.0;
reproduced and fixed on H3 ES1.1. Probably affects other R-Car platforms
as well.

Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: stable <stable@vger.kernel.org>
Tested-by: Nguyen Viet Dung <dung.nguyen.aj@renesas.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/sh-sci.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -935,6 +935,8 @@ static void sci_receive_chars(struct uar
 		/* Tell the rest of the system the news. New characters! */
 		tty_flip_buffer_push(tport);
 	} else {
+		/* TTY buffers full; read from RX reg to prevent lockup */
+		serial_port_in(port, SCxRDR);
 		serial_port_in(port, SCxSR); /* dummy read */
 		sci_clear_SCxSR(port, SCxSR_RDxF_CLEAR(port));
 	}
