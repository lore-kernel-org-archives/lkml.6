Return-Path: <pombredanne@nexb.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519660665; cv=none;
        d=google.com; s=arc-20160816;
        b=C7q6VrjtSuofpWPl5Pgze7qXJc2JIuO4iz6o6mQT367Z8uVyFfYXGItg+nhTjyD6n3
         rAgi9/5mEQYMNl9QyH0DJjnN0jaNhfThnZDos7jRORNTAZvT/UGjgLYO7BnxFsebBC25
         1dY+patKZrWPHIouuKeSMAjS57yQ61SLu5KzOFjy0mLL547ISs63oeji59hkrZ8KnNLZ
         PYlopYfzqbMI7l0wzSejnk6jJPCBmoc+YEzWaIP97rybYJcEtlPf6lDY4V03VAr/nA2N
         MgS5PFeVu2chl9187GUw2ReQPytoIJFU953l2eP12c5Mfy8lRWnmVGs4+FH8R2raJ6vU
         FCUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=mEbYg6pTGHVTqJk8LCAQUghaVTHAcLQ4w8/qnbVTsB4=;
        b=xzMCTB7k1DGaFGy7PWc6j0WTQYYrGB7pCFb2NMoXeB+Kmhgi+QM1Ggcv6JBt4Q3STZ
         15h2LJDEMDR0X0MItxVowfz8r5EEFrjL1wCmeh8pxGZxSMgscw9kADQeOJOqdACJxS8N
         2prdX5MqmA0FdGXHxsYwCeVjDs6/MUefuR5m7v8Sh4mmIcqvrH9YFtnjRCmJYJ7hDsod
         6r44yUviqIil98WUWif2YCRWPjHCbcNaZtufjiZcBB32D4ABfPTO22alxHxwsshxSkHv
         HE+JSE9ODYk2BodHSws0/oZ6VWBaznoPMAcRDx79NFSvr7D0wzoRVE5TSfKLiUr76NQa
         yBIA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nexb-com.20150623.gappssmtp.com header.s=20150623 header.b=wk1F2AAc;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of pombredanne@nexb.com) smtp.mailfrom=pombredanne@nexb.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nexb-com.20150623.gappssmtp.com header.s=20150623 header.b=wk1F2AAc;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of pombredanne@nexb.com) smtp.mailfrom=pombredanne@nexb.com
X-Google-Smtp-Source: AH8x227RGk9hhq6bHqUc4qHlqPe08mVgST/SAdsOIcGwL1xrxQ3OtE6fHxakSNIZIWiqGJbXLXN887DRk+4hqnObvfw=
MIME-Version: 1.0
In-Reply-To: <1519403030-21189-4-git-send-email-sudeep.holla@arm.com>
References: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com> <1519403030-21189-4-git-send-email-sudeep.holla@arm.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Mon, 26 Feb 2018 07:57:04 -0800
Message-ID: <CAOFm3uE8q63h-zk3FGnZkDqvxjJj=d0mfuUtK+nyioKosmt=dw@mail.gmail.com>
Subject: Re: [PATCH v6 03/20] firmware: arm_scmi: add basic driver
 infrastructure for SCMI
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: ALKML <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>,
	Alexey Klimov <klimov.linux@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593209576065765675?=
X-GMAIL-MSGID: =?utf-8?q?1593479701329457195?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Sudeep,

On Fri, Feb 23, 2018 at 8:23 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> The SCMI is intended to allow OSPM to manage various functions that are
> provided by the hardware platform it is running on, including power and
> performance functions. SCMI provides two levels of abstraction, protocols
> and transports. Protocols define individual groups of system control and
> management messages. A protocol specification describes the messages
> that it supports. Transports describe the method by which protocol
> messages are communicated between agents and the platform.
>
> This patch adds basic infrastructure to manage the message allocation,
> initialisation, packing/unpacking and shared memory management.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

<snip>


> --- /dev/null
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -0,0 +1,77 @@
> +/*
> + * System Control and Management Interface (SCMI) Message Protocol
> + * driver common header file containing some definitions, structures
> + * and function prototypes used in all the different SCMI protocols.
> + *
> + * Copyright (C) 2017 ARM Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program. If not, see <http://www.gnu.org/licenses/>.
> + */

Would you consider using the SPDX tags [1] instead of this legalese?
Thanks!

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst
-- 
Cordially
Philippe Ombredanne
