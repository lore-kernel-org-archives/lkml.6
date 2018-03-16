Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvjiMndfAYymvJ9uAfV6CADYi8cDU4EaITWPuMUbB1/CoUTzdgiNSiP1LLkxjUR4aTVndE3
ARC-Seal: i=1; a=rsa-sha256; t=1521214797; cv=none;
        d=google.com; s=arc-20160816;
        b=CmJtuR2CngEi7rQmjnNZQldcZPt4vNI0psHhvLbrUzlmcrZE7b0VVe8CsY/WVFrYrr
         Ti1WGIlfx3zV5vaKZE8J0Llu+c9sN6uwa873y+GRo7eYlRWrg4ETCkKmfJGgHNUzwQTU
         a7VibO25svtnsLpjfvCw6KHh0oqiwVZzwNs/qUm/sIAqpLF9W6J78ttoP36Z+ozW7kv0
         EbSMAYj/ib17uk+uBG36OPXH0AMLNIiw3XEAKKRsl6tvBZ9A2iTHJogC4PAAfnnJZ/UR
         3G6XHA1TgV6atieMQpHOrACRmwuPtPwFeGoiqUGCxgRwYcYJhJF1zYgRFTwvAEtts/Md
         apYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aUpYOKc6Gf7Vf0oKbIX/2vleg5rC2JWK6UMcopnwZGA=;
        b=yium1C+ETP/W7QiDxOkmdo041EMwvbpaGoqf9MufpNxMkUPOugwUDv/Kv+dzxBgIXr
         qE0ndqEXcv/4tPsaI5gBjkC+dO2ciMDJsYe4SQVQ3YMugEPiHjO8bioB1L31A93rrfj0
         UFsSX4ZMPVaB7D7N5QknXNSz6gdn/pH1g/WpwaRrJ8K7f4u+ioCJ6rCSJTfqDB4ZZIBI
         NePLdH0+maNgI43C25ZaJyTc9ipbNNcV+OSuUoZpfBUfIxO81TJE3Ow8zkls7SpptObi
         Jp8OTYfU6QzayDh/QTCtH0ZMz01MJhDy2F6COvULmtN5pYiTSpTrptDG2sqAkhOMDA6Y
         Ch4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nikola Ciprich <nikola.ciprich@linuxbox.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.15 022/128] serial: core: mark port as initialized in autoconfig
Date: Fri, 16 Mar 2018 16:22:43 +0100
Message-Id: <20180316152337.591610913@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108943923921835?=
X-GMAIL-MSGID: =?utf-8?q?1595109327842295218?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

commit 714569064adee3c114a2a6490735b94abe269068 upstream.

This is a followup on 44117a1d1732 ("serial: core: mark port as
initialized after successful IRQ change").
Nikola has been using autoconfig via setserial and reported a crash
similar to what I fixed in the earlier mentioned commit. Here I do the
same fixup for the autoconfig. I wasn't sure that this is the right
approach. Nikola confirmed that it fixes his crash.

Fixes: b3b576461864 ("tty: serial_core: convert uart_open to use tty_port_open")
Link: http://lkml.kernel.org/r/20180131072000.GD1853@localhost.localdomain
Reported-by: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Tested-by: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-by: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Acked-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/serial_core.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1144,6 +1144,8 @@ static int uart_do_autoconfig(struct tty
 		uport->ops->config_port(uport, flags);
 
 		ret = uart_startup(tty, state, 1);
+		if (ret == 0)
+			tty_port_set_initialized(port, true);
 		if (ret > 0)
 			ret = 0;
 	}
