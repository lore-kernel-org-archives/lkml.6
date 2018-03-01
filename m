Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AG47ELuHXBj+vkQttRI0cR1C85Qqj/Xr9rXnxnelXH2nXSPP7SsMmtjjJmW8j7a85TFVkwZiIlc9
ARC-Seal: i=1; a=rsa-sha256; t=1519929055; cv=none;
        d=google.com; s=arc-20160816;
        b=UMQFoXCI3Zc2FvjGQNxk8sn3XmmgKBewAhxUwfx5wvNojzcyrY0z6Os0ycrresNQpq
         3NeZgEtJKlP+f7HbCG/Uw1IuxcXUikPK/1PM1dPsoX3xoNyZFPRfPJzu8jkzXytdBvBs
         CY4QmD205mvJ8DVT8oKgjpiTMwK9z5yPRmx7IQd4CqvACdWo/six1WvwrGN+s9aJihIm
         PjAvJ2Iq99aOWf93tBlL69pbkBCL9kJL4SFi6tiYVd6xSBPoEY8karOfp0GR5ECqds0k
         Aw4HyWjsd0Ev77la+pYEPprDv4kJyOLplvYbkMIGdVcZvTQTHBobpXZ+fHgrnm0BSu4t
         DWeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=NR9gDPOfXKT+pmV67HiPLMSn44hx8CAhX/NS3cDLSk0=;
        b=nCNSvWzu0BLvpqpQR18x5cC0ihALHywFnQDpA8lGtQHbYI9OnxG7+88XJZSi18Nk7K
         xWACsZBSCYdvKoSXhzNpNBWm60EE4WJaiOfw00zCEPidqDjuJnUm9fkgKvXYaDWXI8e2
         gjjvUupFMhc5pOaHvvTvfOW1h38jTdsKWXpbdDUG4yXricOrRvdGDyb2e99ldjqtmEQl
         XXa2yKqGXEnfE+N9jkCQbJ+44AfSBLGjUMWefNQnlXw+3V8UeO+kT5tprRrkprHL8NeF
         QoraWuRoJgnyZjbYYbX8xLb01bNcTQnw7veXSLI1vV5pa2yDoyRVIlRqJVkzHTzEJAV1
         EKpQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=Ipa/bDD7;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=Ipa/bDD7;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH] earlycon: Allow specifying a uartclk in options
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: adurbin@chromium.org, briannorris@chromium.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jslaby@suse.com>, "open list:SERIAL DRIVERS"
 <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20180301182028.237856-1-djkurtz@chromium.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <57fb4f35-fd75-b2cc-75f7-8157ab1081d5@infradead.org>
Date: Thu, 1 Mar 2018 10:30:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180301182028.237856-1-djkurtz@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593760477138517104?=
X-GMAIL-MSGID: =?utf-8?q?1593761127100155975?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/01/2018 10:20 AM, Daniel Kurtz wrote:
> Currently when an earlycon is registered, the uartclk is assumed to be
> BASE_BAUD * 16 = 1843200.  If a baud rate is specified in the earlycon
> options, then 8250_early's init_port will program the UART clock divider
> registers based on this assumed uartclk.
> 
> However, not all uarts have a UART clock of 1843200.  For example, the
> 8250_dw uart in AMD's CZ/ST uses a fixed 48 MHz clock (as specified in
> cz_uart_desc in acpi_apd.c).  Thus, specifying a baud when using earlycon
> on such a device will result in incorrect divider values and a wrong UART
> clock.
> 
> Fix this by extending the earlycon options parameter to allow specification
> of a uartclk, like so:
> 
>  earlycon=uart,mmio32,0xfedc6000,115200,48000000
> 
> If none is specified, fall-back to prior behavior - 1843200.
> 
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>

Hi,

Hopefully there will also be an update to one of
Documentation/admin-guide/kernel-parameters.txt or
Documentation/admin-guide/serial-console.rst.

Thanks.

> ---
>  drivers/tty/serial/earlycon.c | 8 ++++++--
>  include/linux/serial_core.h   | 2 +-
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> index 870e84fb6e39..c9b38f520057 100644
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -115,12 +115,17 @@ static int __init parse_options(struct earlycon_device *device, char *options)
>  	}
>  
>  	if (options) {
> -		device->baud = simple_strtoul(options, NULL, 0);
> +		char *uartclk;
> +		device->baud = simple_strtoul(options, &uartclk, 0);
> +		if (*uartclk++ == ',')
> +			port->uartclk = simple_strtoul(uartclk, NULL, 0);
>  		length = min(strcspn(options, " ") + 1,
>  			     (size_t)(sizeof(device->options)));
>  		strlcpy(device->options, options, length);
>  	}
>  
> +	port->uartclk = (port->uartclk) ?: BASE_BAUD * 16;
> +
>  	return 0;
>  }
>  
> @@ -134,7 +139,6 @@ static int __init register_earlycon(char *buf, const struct earlycon_id *match)
>  		buf = NULL;
>  
>  	spin_lock_init(&port->lock);
> -	port->uartclk = BASE_BAUD * 16;
>  	if (port->mapbase)
>  		port->membase = earlycon_map(port->mapbase, 64);
>  
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index b32df49a3bd5..b772f0d20b18 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -343,7 +343,7 @@ static inline int uart_poll_timeout(struct uart_port *port)
>  struct earlycon_device {
>  	struct console *con;
>  	struct uart_port port;
> -	char options[16];		/* e.g., 115200n8 */
> +	char options[32];		/* e.g., 115200n8,48000000 */
>  	unsigned int baud;
>  };
>  
> 


-- 
~Randy
