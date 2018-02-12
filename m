Return-Path: <pombredanne@nexb.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518433174; cv=none;
        d=google.com; s=arc-20160816;
        b=OfZRxTC9SYBoCEBsUaUuaR1EB8yiVzxP8Mp12XY7Z/eayFjjAjqZZAfqKFM5iqJ24q
         ojskEf3MU8hDq3UWx8R1wy7TKH+/GMf1eZAIqHD6jYgKhhV4KVcqYJp8QbF7NXFeWCRQ
         VPFVzB1eOLtQdXUu42CvSHmJU1NwOr8jjTk9Ls0bVy4wyDbbQk3hjrTDpZ/5vcpGJblb
         QBBZLW65pKyEUXSInHjv6C9JgeAx0HSfIOIvv+hCKnEYcKe5L4FMd7tgzTT6KHd/1q+i
         NgniqGaDZlyfCkfVNLjsY40YMmHmtywTJdn6mJqlTjaYo5Bdx5r/KuVycE33OiDytvuB
         5ODA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=zlslSp7Ivx4CwTveqoDQcjKyhkzEFTdWTAcD2VJE4mQ=;
        b=nUp8fDHF+zIiSPJOuu0z1c02/ZZkH08dp809ljXvXEVpZOrQQk8lA4awn1+0stuYlw
         fkHtsEAbIunMknMG9krpfXQC/1gQkyR94eWlZeAOipYXLXH9LDadahHaNsTiI2prFiG2
         OtwO1wd7KWc6Ye7Sup4EafO2Z3VNnNOz/pozRhK2Yagkf6vMr0NpqWNougJPbewNfMnj
         b8Oxam/M4aeDivKJ4uGQHtpjCz7tio2BybNT3k+EfG0MoOg7Vh2j6HQ2bVVzhZHeeyqU
         gjBjGuRRWPArpbdWK0xrj1E1f9U/kOzIII6qzMDwc1e9p/7Wk++XIHcf93oUkAQQeLWU
         cjgg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nexb-com.20150623.gappssmtp.com header.s=20150623 header.b=0zqdImnO;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of pombredanne@nexb.com) smtp.mailfrom=pombredanne@nexb.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nexb-com.20150623.gappssmtp.com header.s=20150623 header.b=0zqdImnO;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of pombredanne@nexb.com) smtp.mailfrom=pombredanne@nexb.com
X-Google-Smtp-Source: AH8x226E3kTawLBmr5zEpv3dKzK7qex/XTRrmHMv3q3x4QTEPCDnBmspz/Ksdwc+9k5JoihA3XjIhdeaePpt0qqfBcI=
MIME-Version: 1.0
In-Reply-To: <1518431703-32649-1-git-send-email-mnarani@xilinx.com>
References: <1518431703-32649-1-git-send-email-mnarani@xilinx.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Mon, 12 Feb 2018 11:58:53 +0100
Message-ID: <CAOFm3uEj2jEu=BW_sbtPx5izP1aeXzyV0j7eBanLyMkdeRQ9Dw@mail.gmail.com>
Subject: Re: [RFC PATCH] soc: zynqmp: Add support for tap delay settings
To: Manish Narani <manish.narani@xilinx.com>
Cc: Michal Simek <michal.simek@xilinx.com>, Dhaval Shah <dhaval.shah@xilinx.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, mnarani@xilinx.com,
	Kate Stewart <kstewart@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, anirudh@xilinx.com, sgoud@xilinx.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592191062183184575?=
X-GMAIL-MSGID: =?utf-8?q?1592192584080881756?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 11:35 AM, Manish Narani
<manish.narani@xilinx.com> wrote:
> This patch add support for tep delays programming for zynqmp platform.
> This also adds dll reset support.
>
> Signed-off-by: Manish Narani <mnarani@xilinx.com>

<snip>

> --- /dev/null
> +++ b/drivers/soc/xilinx/zynqmp/tap_delays.c
> @@ -0,0 +1,270 @@
> +/*
> + * Xilinx Zynq MPSoC Tap Delay Programming
> + *
> + *  Copyright (C) 2016 Xilinx, Inc.
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */

Dear Manish,
Why not using the SPDX ids there too and elsewhere? You are using them
alright in many other places in this patch. See
Documentation/process/license-rules.rst for details
-- 
Cordially
Philippe Ombredanne
