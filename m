Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524828972; cv=none;
        d=google.com; s=arc-20160816;
        b=NT7gISeYyJyYAN4oiPf1YI3hx/cqdFqhmuOAlJfhXFPgLAuFKySFSO1B4ik4dS9wId
         1L8sKeq/iIqCyIUOpEXtfoS7VL6ndstqnm0PKc/4Lh7kVNkXX3nNJV/GPUIctanRXTSR
         bJsYrsZxJ7RjJIoXBeL+Jwp/c94AMgclw5wRtDJChlzUOr54fCp7Nf8zU41KIq9U2vVy
         tHLv7d303GZkLU/HDwfy5j6z6SDQpnDmBNZVY/80nSy7++RKYv2g37OavnJ+zhAcT5gJ
         V0E8XfIlITifvEITJdbr6WuCDa6r4ShYXsmnwQSlGo1iJqmaZCAwIyDODpLeD9F+xJ6i
         X5bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=xnXp0AERWQQ1+lf0GKIIypejZhLi9ktx/beFRPDVjjs=;
        b=nyiQtvNVWeiPyMjxcWADtmPTl033u3dWjjNY5sfVc1qEkNnAVla0y3l2HR/2eOH7kb
         4PQoNLfFItHH3VQLfccedKtjGsnM+BCGm5nb/FAtVruRkfPigidr6eI4uu7VwksVyVEW
         VVG917XjZhTECVrGsaqtFe+dhAPqbQAJbwqXnvyVO+cMCVH/la3+7ts3U2TegnIVoAY1
         nDfpykFyoaEsS14wI8ywVaPrY4tXB0d5owgyDfbdHXCmBDFobEqBfLlb/4zSNEt2B/Aa
         2e+QLC+q8y+WR6DOAleqGi9XEhC/0EAWosc6y7ytgG1CNqkL+yU3snL/ge5nEml8i/u0
         bImw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=O5gqF7F1;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=O5gqF7F1;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AB8JxZrkbZ2mdya63OPOKvG8tJ1ryRYWbfbFJhFkJtol8EMdTVhD6b7105arKO7S/xy8IFOGTA7ceiacgyIA/0LtWy8=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <1524795811-21399-5-git-send-email-sdias@codeaurora.org>
References: <1524795811-21399-1-git-send-email-sdias@codeaurora.org> <1524795811-21399-5-git-send-email-sdias@codeaurora.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 27 Apr 2018 13:36:11 +0200
X-Google-Sender-Auth: gwYoDFpAz912qSKWM7eijoDTBXk
Message-ID: <CAK8P3a0WxbprX2kCPW=baod6vpc_dt304d7=TUcr2h266uxSfw@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] mhi_bus: dev: uci: add user space interface driver
To: Sujeev Dias <sdias@codeaurora.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
	Tony Truong <truong@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598864310335409607?=
X-GMAIL-MSGID: =?utf-8?q?1598899065167301731?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 4:23 AM, Sujeev Dias <sdias@codeaurora.org> wrote:
> This module allows user space clients to transfer data
> between external modem and host using standard file
> operations.
>
> Signed-off-by: Sujeev Dias <sdias@codeaurora.org>
> ---
>  drivers/bus/mhi/devices/Kconfig   |   9 +
>  drivers/bus/mhi/devices/Makefile  |   1 +
>  drivers/bus/mhi/devices/mhi_uci.c | 662 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 672 insertions(+)
>  create mode 100644 drivers/bus/mhi/devices/mhi_uci.c
>
> diff --git a/drivers/bus/mhi/devices/Kconfig b/drivers/bus/mhi/devices/Kconfig
> index 40f964d..83b9673 100644
> --- a/drivers/bus/mhi/devices/Kconfig
> +++ b/drivers/bus/mhi/devices/Kconfig
> @@ -7,4 +7,13 @@ config MHI_NETDEV
>           MHI based net device driver for transferring IP traffic
>           between host and modem. By enabling this driver, clients
>           can transfer data using standard network interface.
> +
> +config MHI_UCI
> +       tristate "MHI UCI"
> +       depends on MHI_BUS
> +       help
> +         MHI based uci driver is for transferring data between host and
> +         modem using standard file operations from user space. Open, read,
> +         write, ioctl, and close operations are supported by this driver.
> +

Can you expand this description both in Kconfig and the patch
changelog? It's not clear at all what this is good for and what the
actual data is that you send over it.

What tools do you use to talk to them, can you point to a source
repository here? I think that would be useful in order to decide
whether we actually need a low-level interface at all, or if it
should all be accessed using high-level interfaces like the
network driver.

       Arnd
