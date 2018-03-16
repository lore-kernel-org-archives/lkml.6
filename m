Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsOWBI4Y73aP/QJC6YjjafNRaZzZiqG72hj+5wrjbVaC5d7fcz3+794WJRrD704ii79yALw
ARC-Seal: i=1; a=rsa-sha256; t=1521214859; cv=none;
        d=google.com; s=arc-20160816;
        b=UqhfD8lYuW3d5AV9GqBy38LI/T32RRvTErQF5IefsYdsVTSl38ZTG8QkpxqI+qiKO7
         9OD3XkX+17gKhrId7PxnkVKfrWMGb99wHjWI/Sr7vvetATMC3vqw1yWkBRp6ViTcAdlH
         GqSidMH23YI5v/D6rdf9ZFl1bwIwhsOhnQu3aqoQ8ZiHSCyIsSUZczf0SizKJRXeTj4e
         1XuBaNp7lqE5AQuPwGZ2iw0xO+lgxawEiokRyFt4GfK1fVXZYp1e2GocZNWpQMq/Iybd
         2SBDEVznztgr7WVWKDJCEx5Xv8NHJHfWMlkOakXCVKIWihz3j+RRAYs5GGHK2+hzpAll
         ehuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Yr7k/eOEJOv0/8NwK2sHLymB27YcjSlIXekZvtEumnM=;
        b=egiDr9dB+wVgLZAF59SmNY2LYE8wNJyciCXKyFvj1UR+BWeG+vjjKqYurE+IULXjPB
         ib9mXtt5wxwOxMnW5cFoOvV+72Jnu04fAPsfkT+cjqmuqq+1MYYeBexz/CFn8FAuVqqs
         /oQUaCjPi0vEFgmU6eefmjpWRLn+BLWUyo0f88YqNK94LV1gMsNhNxNg1yFR0NW3ON5Z
         bLHrwXe22tEJSYD9Iv8LnnHsZPQta5YK3DRzuig+L/G8v0nlqZZkMn5P4bLKphMj3wK/
         LyO9uno8GLdbFMa5YtzPiWQNayg8lqjTpihN+BZbeos6r7Q6h3oyQFqrzAghCcTr7CyJ
         itCA==
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
Subject: [PATCH 4.15 009/128] serial: sh-sci: prevent lockup on full TTY buffers
Date: Fri, 16 Mar 2018 16:22:30 +0100
Message-Id: <20180316152336.670371434@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108493927910261?=
X-GMAIL-MSGID: =?utf-8?q?1595109392350436061?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -885,6 +885,8 @@ static void sci_receive_chars(struct uar
 		/* Tell the rest of the system the news. New characters! */
 		tty_flip_buffer_push(tport);
 	} else {
+		/* TTY buffers full; read from RX reg to prevent lockup */
+		serial_port_in(port, SCxRDR);
 		serial_port_in(port, SCxSR); /* dummy read */
 		sci_clear_SCxSR(port, SCxSR_RDxF_CLEAR(port));
 	}
