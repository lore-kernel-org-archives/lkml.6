Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225J3hqvI9FDX5IoK2dVdXhadaU0iJdw6Er6Vnw6am+3vlnIjmuxXfUu3kE4hDUZpkHIA1Yc
ARC-Seal: i=1; a=rsa-sha256; t=1517855079; cv=none;
        d=google.com; s=arc-20160816;
        b=yg20blLzM16MxV89dioJHLYfeNhliUQ20KicFBC9injNnK5mqUma9udYrZFd9N2/Pg
         99lhrZQRzghXrs6gXtyd4Is+t4ToLm1R2h5QU+ueslqLc9msVP7ZuR5K5D4jIKvJlrLG
         D/ZRMzVmQdFI555E/fbVQgPxCZ40b0ZZbepRPnImV/u4hVm5ZvdthABR/Mt3byJEHvT7
         R0xJHsnZ2FJKe8MGcPqJhV5FFHc6GHGNQaOem9SFcbZHJ75lnSgjnzXV2PMFRpHGqQmL
         vY1asBR06s7YPWQd6w0CUprmmhVPYzWfk0REjqlA2rwsmsRAM3neBRIgeW8oAzYgmOf6
         hlVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WNWwtFJC1x5+d5+TyjJ3Jlkz3z2moJC/i0HlZaBfJok=;
        b=AABWwJIpiVNUNv7DDTOzgLDvBmiM8H+HDRfgz08nV/boubV+rSdJ2yqEq3EssstCaE
         0mxfWG0VTwnyYhw0GXW9+jmwm1ZJZNC7f3UOmstT2iDIFhc/Y9Gm9LNCn9fJDAoFI9cU
         Dow7o+utpi8R2eL3C6J/dFjEFg6+liga4tLY3vGw7+EXdoy1vE1VtT8WkQLmdbO0p2xq
         L1raGTw8812profSyLvYXEKdnxdpMfu6i3XLK4K3wAQjR/yh9HJmnRiVNBezwkIJ7AvV
         jv9lzX2hOi4JvMyHJaLo6ZEtcC/wgNElt0UgUOii34GBYML0TFvhdLM4fmgSGBe7cAhV
         tM2g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4.14 63/64] serial: core: mark port as initialized after successful IRQ change
Date: Mon,  5 Feb 2018 10:23:22 -0800
Message-Id: <20180205182141.172399066@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586407815437780?=
X-GMAIL-MSGID: =?utf-8?q?1591586407815437780?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -987,6 +987,8 @@ static int uart_set_info(struct tty_stru
 		}
 	} else {
 		retval = uart_startup(tty, state, 1);
+		if (retval == 0)
+			tty_port_set_initialized(port, true);
 		if (retval > 0)
 			retval = 0;
 	}
