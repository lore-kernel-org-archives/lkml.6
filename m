Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521877892; cv=none;
        d=google.com; s=arc-20160816;
        b=gCW/zl0mwbQGCnRHpiug+U+i8EPMbRbNK1pjvvJiLqOPEEF/MtB1EOeCp71LuSlE8x
         YDeJzgi1QoGkf7W9WdpAHMy+9e1mAxIUgdWa++cAbRlm41NDztdClUKN60JUWGj8DBOR
         2LnXbYrJIq+v7VlOh0GvumV8RJYKWwlMfjR7AOVNp484BuUTF0wURm4LFsAIvDZRxubo
         r+ZQXZ19sAG76IcaSb3+ULqTEFZoAxruDeOG8/BA8PJXTJJf1U6FzqiuVg9JWcx3bpjR
         sw6mXRFIpGqY4pRjYIZ+Tgj+qvA7B0R+ftU7ZxZZ4LSV/Co9o5Cv3nyWIMLh27MaScRQ
         yzEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=eVP+v7GCryVm6E5SK1VcxqZyGv1dQ+viY+IjTwlC01s=;
        b=mPc6WGgmqVEw+mYK9+rMUjpW+ZubKiAVuw2T5mo+G3fks2SPfeIflL2EO9fOnJusgT
         S4DU42g6H90EbjuoI6r4JxjLgy2b962CBIh8oTm+qn/muwrt1OQxu2y/5N04aBcYTEZn
         0hEDckf11wNaMGjPKlb81SnpEKZdevONzcjzRdEUfpgfHVHvUXX571SETsOm4f/zvwUS
         MXwM3Pi0pOOEM3Hr6nUBgHnujZ5OKYP39/U93+ecZiaIkGxND0plhVAppJQU3JuFPLI4
         7Rz9L06hEm3oPJ5ofOXjx6z0XbgNJLAmS/T3S7o6BJL4/Wr0YmgFt2pN/2mSiLYZLyfs
         eWUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fn6ee0Wj;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fn6ee0Wj;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AG47ELuglFaVreM5mXj5X6hDunKgIPylYZ+YIydjkBOLKqQRKbOAnVngy4NiiGf0YnDFXlogyZCoJodtTWaihXI2dXU=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <d8c243a9ead2fe1375dee242aec26d1276129409.1521818402.git.ioana.ciornei@nxp.com>
References: <cover.1521818402.git.ioana.ciornei@nxp.com> <d8c243a9ead2fe1375dee242aec26d1276129409.1521818402.git.ioana.ciornei@nxp.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 24 Mar 2018 15:51:30 +0800
X-Google-Sender-Auth: oKO0m3q6fHa9XK_cdo606aao3jI
Message-ID: <CAK8P3a089ZiPdp1CcVct8Kac+ejkNP8TrVpWYSr_nMGo4goO1Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: gregkh <gregkh@linuxfoundation.org>, Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stuart Yoder <stuyoder@gmail.com>,
	Ruxandra Ioana Radulescu <ruxandra.radulescu@nxp.com>, razvan.stefanescu@nxp.com,
	Roy Pledge <Roy.Pledge@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595743497041548891?=
X-GMAIL-MSGID: =?utf-8?q?1595804632778076316?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 23, 2018 at 11:38 PM, Ioana Ciornei <ioana.ciornei@nxp.com> wrote:
> Adding kernel support for restool, a userspace tool for resource
> management, means exporting an ioctl capable device file representing
> the root resource container.
> This new functionality in the fsl-mc bus driver intends to provide
> restool an interface to interact with the MC firmware.
> Commands that are composed in userspace are sent to the MC firmware
> through the RESTOOL_SEND_MC_COMMAND ioctl.
> By default the implicit MC I/O portal is used for this operation,
> but if the implicit one is busy, a dynamic portal is allocated and then
> freed upon execution.

Hi Ioana,

So this driver is a direct passthrough to your hardware for passing
fixed-length command/response pairs. Have you considered using
a higher-level interface instead?

Can you list some of the commands that are passed here as
clarification, and explain what the tradeoffs are that have led
to adopting a low-level interface instead of a high-level interface?

The main downside of the direct passthrough obviously is that you
tie your user space to a particular hardware implementation, while
a high-level abstraction could in principle work across a wider range
of hardware revisions or even across multiple vendors implementing
the same concept by different means.

> +static long fsl_mc_restool_dev_ioctl(struct file *file,
> +                                    unsigned int cmd,
> +                                    unsigned long arg)
> +{
> +       int error;
> +
> +       switch (cmd) {
> +       case RESTOOL_SEND_MC_COMMAND:
> +               error = fsl_mc_restool_send_command(arg, file->private_data);
> +               break;

> @@ -14,10 +14,18 @@
>   * struct fsl_mc_command - Management Complex (MC) command structure
>   * @header: MC command header
>   * @params: MC command parameters
> + *
> + * Used by RESTOOL_SEND_MC_COMMAND
>   */
>  struct fsl_mc_command {
>         __u64 header;
>         __u64 params[MC_CMD_NUM_OF_PARAMS];
>  };
>
> +#define RESTOOL_IOCTL_TYPE     'R'
> +#define RESTOOL_IOCTL_SEQ      0xE0

I tried to follow the code path into the hardware and am a bit confused
about the semantics of the 'header' field and the data. Both are
accessed passed to the hardware using

       writeq(le64_to_cpu(cmd->header))

which would indicate a fixed byte layout on the user structure and that
it should really be a '__le64' instead of '__u64', or possibly should be
represented as '__u8 header[8]' to clarify that the byte ordering is
supposed to match the order of the byte addresses of the register.

However, the in-kernel usage of that field suggests that we treat it
as a 64-bit cpu-endian number, for which the hardware needs to know
the endianess of the currently running kernel and user space.

Can you have a look at where the mistake is and what the byteorder
for the fsl_mc_command structure is supposed to be? Obviously,
this is one thing that would be simplified by using a high-level
interface, but it's possible to do it like this as long as it's completely
clear how the structure layout is meant to be used in the uapi header.

        Arnd
