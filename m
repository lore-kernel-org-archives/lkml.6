Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvplUKMNYp+n3nhH7PhxIHVJ91CSSq7WARvvclElWJelAtrEky91/aUArPoPbf/D616jgXW
ARC-Seal: i=1; a=rsa-sha256; t=1521214131; cv=none;
        d=google.com; s=arc-20160816;
        b=0v5Yatn85G/nNCjf7bXwSFdzb/ffQ0x1EZBwPyMwEst3rHVxDrh7PPLq1ZdBRNBeGv
         9J3vGNjyv2akzX0IVago1aPGx6mNnXSAFxnZnCBgg8AnZC5eSJZDbINU+TNShdewiy7z
         QOPAqstQfFTJvUq0ImUpsXtRu1myi/4C17YB+8d42Jj5PWjFLwKqp38QyM4+XrxRSmbS
         jEBMHTztdfI6T+V0FhNW7rPOzn1+vi/MFVI4/Jz3YOkH8k2fwMCRq8CZhgYcL6GMeFA1
         kPPcUCSNuQodGEaHrhRc8tSVKiC9cF+NpJkdQ1VUvrzUDsxM2cIUDeQdwX8g8YfcGGLl
         btHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LPNFr0fDLjPXQ2iWig8SEQ6rGDqqkIqbmmnZpNggcug=;
        b=bXTYaQcEIgbl5AU1C7kf5KI0SA8lCmOsgmV/F01jViN0kUJZIST1+nSJTiM4CWdLZ+
         jRFQVlbCgI+zFIwdXPBuKWlROh8Jf6AamKQyldYo1lxstgs5Ha3iShm/v1yQsikVH+Xd
         02kLqQs4W9vKc/QG69Ff8RF3Cvqj+jZI7fFBeuoWBoU3AK9h9FkFjFwhkDgffV0/WUt9
         hEmwRAKObhqC1L5pJ1VgDD6p/anDVPZPYSfykEZDLsp/hksbjqRRDWLCza4/U7qn5BKM
         Paj6FHV+XLmyZJ0fCXvbmFocLw7ETX4LeraqbesQ4skaj5sbKsaPxCfqx/4XWGW55A7s
         nKxw==
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
Subject: [PATCH 4.4 52/63] serial: sh-sci: prevent lockup on full TTY buffers
Date: Fri, 16 Mar 2018 16:23:24 +0100
Message-Id: <20180316152305.709565664@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108493927910261?=
X-GMAIL-MSGID: =?utf-8?q?1595108629488307137?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -847,6 +847,8 @@ static void sci_receive_chars(struct uar
 		/* Tell the rest of the system the news. New characters! */
 		tty_flip_buffer_push(tport);
 	} else {
+		/* TTY buffers full; read from RX reg to prevent lockup */
+		serial_port_in(port, SCxRDR);
 		serial_port_in(port, SCxSR); /* dummy read */
 		sci_clear_SCxSR(port, SCxSR_RDxF_CLEAR(port));
 	}
