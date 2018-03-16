Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsqpPvqmEzkmEwGBMSDKcDkzhXVbcklNkaYymJt+AASRFFr0nnz++6ODUQeUakSqE4knxve
ARC-Seal: i=1; a=rsa-sha256; t=1521214800; cv=none;
        d=google.com; s=arc-20160816;
        b=oBvqvMkNWcJdxyl3SyGUtYe6i8HzJrE8vnzobMpBTJYYznks/2H/TmqLr3RZpXjh6r
         3BngZZG6c7eLUCpfKvG3Y7yUw6nhv/PINeufZS53m8V1lfSB1jAsPj4AeWmtsnyq7l3T
         8WkIekJvxC3xJkwbQOwKYOFR9x6/brfZR7WtZiSkNXT411GEwzegaUlJzqvVPYzgUc++
         97JH1oZFlOY8udIFk+fFtADSWfgRyWqprsFAYb30LRc7smymVRrZ7KmnhLqyongsxuMb
         /rrICenYQCEizas5+COQo50FFH3aekfsB9EJeHBPS09ilai23S3Dmag1pOFh9VMmVewC
         aNmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ev+0e7O6FFJs8jiKT02pGYFWV7+wkDBsLEJJBgiKwI0=;
        b=ookp6G8vQiQzMEB9YhQLr5ed9YtQNwzAQnBGu9LNONOfjVpHzI1tM3clMI3B1nSG5o
         uoF/wVT3bDp7pdU5lAuxzjGST1CPS6r0m8msZfK6Pim7GXKpMuxUJHsyLn0OmUSs/9ru
         b0iGudbmY/sA120g+6Ra5PqWdCDKUMmdDH/YyP9F1JoOYerBZZWon0+3Z5RIn+uDdtbi
         pmPWVEvWQVu3Pud1G4mGjzP8GWk2E48eCIy2syuoAdAyWlNBZOPmHZG4EWsS/LvM32wo
         gDN4QlNzf6BccTHqQATXm6OJjZMXLn+cpCR8DCJbhdAbhKa9dDZFG2Tm9QZGBrIWzDZ1
         wSvw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Greentime Hu <greentime@andestech.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Peter Hurley <peter@hurleysoftware.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH 4.15 023/128] earlycon: add reg-offset to physical address before mapping
Date: Fri, 16 Mar 2018 16:22:44 +0100
Message-Id: <20180316152337.642785148@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108946951536205?=
X-GMAIL-MSGID: =?utf-8?q?1595109330010326882?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greentime Hu <green.hu@gmail.com>

commit 1f66dd36bb18437397ea0d7882c52f7e3c476e15 upstream.

It will get the wrong virtual address because port->mapbase is not added
the correct reg-offset yet. We have to update it before earlycon_map()
is called

Signed-off-by: Greentime Hu <greentime@andestech.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: stable@vger.kernel.org
Fixes: 088da2a17619 ("of: earlycon: Initialize port fields from DT properties")
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/earlycon.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -250,11 +250,12 @@ int __init of_setup_earlycon(const struc
 	}
 	port->mapbase = addr;
 	port->uartclk = BASE_BAUD * 16;
-	port->membase = earlycon_map(port->mapbase, SZ_4K);
 
 	val = of_get_flat_dt_prop(node, "reg-offset", NULL);
 	if (val)
 		port->mapbase += be32_to_cpu(*val);
+	port->membase = earlycon_map(port->mapbase, SZ_4K);
+
 	val = of_get_flat_dt_prop(node, "reg-shift", NULL);
 	if (val)
 		port->regshift = be32_to_cpu(*val);
