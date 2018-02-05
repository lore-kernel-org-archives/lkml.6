Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224RIy2SuH2RpXqI/aJBGqyav980p412LsBRH3Et04Iy14DsEdL5LY7YJ15UtdSqw1JS4Baj
ARC-Seal: i=1; a=rsa-sha256; t=1517855169; cv=none;
        d=google.com; s=arc-20160816;
        b=NXOTXh06gydXpF3fdRJHbKTl7exneBmSUWIR8aDYoCy5cRHTW0nCUsCTxKv7acgPYV
         lEs4oHawIy/ryaifaBDZQwKgkYVbZWf+KT2fwP3pNOAJ5XTfRb4YsOclYDDZ2fALhI2y
         jk+g0HQCNkTAV17h3YDEWcQ4VCgQamDpiY5eJ/Vgpd/SrlT9A7F7VP2v6+w0XYvs5hX6
         e3WolcbOIaL1PQgeH51IQ2sCIZwKvAISGjBJB6bpXWYG6Zl4L2JkT4H/E4R8nqOHH6ij
         8Ly+qvKtNr9ZEYg7yJJZ9gp6lC/9DUV5Lvno8u9ljFEDf/+togmufCd1vy4eAMoPUv5n
         LIIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JoIHCS4/6vhqLWeGLpObunBp7nQPO5oAzkZD2tqXdGI=;
        b=Jf+fAzOehsgZRcggNfREnZNEt1yn1hS/TYBh9WBJW1Ps9OqzYaiV0OODvmU7ToCRuh
         xcVdep7qzuYvk5PDyKTL13s4VU9WCMazD+voEPGpX/wx7a4iyPWmiATHYY21J7dO/B3E
         vyogzAKfyrfSWJUtE/LYQ88PGjxgonurr+dvDbGdEUrFangq8tpqPxOBFUefDSYt3ppn
         l+N8hodnd7n833BD2D2ipEvqL1EerZ/0OICF/4tNVD0VdmwpEBH5UeQOA/HQf2KsXb+/
         rWvVvAkg17NV1r0gUoYO/V58Hf/nzo8fyu1mYb9iXQeWqQKlu/VVdQaUTokdB00agHKi
         8Wbg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4.15 59/60] serial: core: mark port as initialized after successful IRQ change
Date: Mon,  5 Feb 2018 10:23:32 -0800
Message-Id: <20180205182217.167848860@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586407815437780?=
X-GMAIL-MSGID: =?utf-8?q?1591586502487310743?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

commit 44117a1d1732c513875d5a163f10d9adbe866c08 upstream.

setserial changes the IRQ via uart_set_info(). It invokes
uart_shutdown() which free the current used IRQ and clear
TTY_PORT_INITIALIZED. It will then update the IRQ number and invoke
uart_startup() before returning to the caller leaving
TTY_PORT_INITIALIZED cleared.

The next open will crash with
|  list_add double add: new=ffffffff839fcc98, prev=ffffffff839fcc98, next=ffffffff839fcc98.
since the close from the IOCTL won't free the IRQ (and clean the list)
due to the TTY_PORT_INITIALIZED check in uart_shutdown().

There is same pattern in uart_do_autoconfig() and I *think* it also
needs to set TTY_PORT_INITIALIZED there.
Is there a reason why uart_startup() does not set the flag by itself
after the IRQ has been acquired (since it is cleared in uart_shutdown)?

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/serial_core.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -974,6 +974,8 @@ static int uart_set_info(struct tty_stru
 		}
 	} else {
 		retval = uart_startup(tty, state, 1);
+		if (retval == 0)
+			tty_port_set_initialized(port, true);
 		if (retval > 0)
 			retval = 0;
 	}
