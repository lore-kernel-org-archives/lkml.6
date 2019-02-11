Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9427C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EBE520700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbfBKOYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:24:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:57540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728097AbfBKOYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:24:20 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4737120844;
        Mon, 11 Feb 2019 14:24:19 +0000 (UTC)
Date:   Mon, 11 Feb 2019 09:24:17 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     John Sperbeck <jsperbeck@google.com>
Cc:     wsa@the-dreams.de, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH v2] i2c: core-smbus: don't trace smbus_reply data on
 errors
Message-ID: <20190211092417.7f211ee0@gandalf.local.home>
In-Reply-To: <20190211034021.242932-1-jsperbeck@google.com>
References: <20190205190849.GA2686@kunai>
        <20190211034021.242932-1-jsperbeck@google.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Feb 2019 19:40:21 -0800
John Sperbeck <jsperbeck@google.com> wrote:

> If an smbus transfer fails, there's no guarantee that the output
> buffer was written.  So, avoid trying to show the output buffer when
> tracing after an error.  This was 'mostly harmless', but would trip
> up kasan checking if left-over cruft in byte 0 is a large length,
> causing us to read from unwritten memory.

This looks fine to me, but I'm not sure how the i2c maintainers feel,
but I always require that a new patch version starts a new thread, and
not be part of a older thread release (causes these patches to be
hidden from those that read patches in threading mode).

-- Steve

> 
> Signed-off-by: John Sperbeck <jsperbeck@google.com>
> ---
>  drivers/i2c/i2c-core-smbus.c | 2 +-
>  include/trace/events/smbus.h | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
> index 9cd66cabb84f..132119112596 100644
> --- a/drivers/i2c/i2c-core-smbus.c
> +++ b/drivers/i2c/i2c-core-smbus.c
> @@ -585,7 +585,7 @@ s32 __i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
>  trace:
>  	/* If enabled, the reply tracepoint is conditional on read_write. */
>  	trace_smbus_reply(adapter, addr, flags, read_write,
> -			  command, protocol, data);
> +			  command, protocol, data, res);
>  	trace_smbus_result(adapter, addr, flags, read_write,
>  			   command, protocol, res);
>  
> diff --git a/include/trace/events/smbus.h b/include/trace/events/smbus.h
> index d2fb6e1d3e10..a4892a187842 100644
> --- a/include/trace/events/smbus.h
> +++ b/include/trace/events/smbus.h
> @@ -138,9 +138,9 @@ TRACE_EVENT_CONDITION(smbus_reply,
>  	TP_PROTO(const struct i2c_adapter *adap,
>  		 u16 addr, unsigned short flags,
>  		 char read_write, u8 command, int protocol,
> -		 const union i2c_smbus_data *data),
> -	TP_ARGS(adap, addr, flags, read_write, command, protocol, data),
> -	TP_CONDITION(read_write == I2C_SMBUS_READ),
> +		 const union i2c_smbus_data *data, int res),
> +	TP_ARGS(adap, addr, flags, read_write, command, protocol, data, res),
> +	TP_CONDITION(res >= 0 && read_write == I2C_SMBUS_READ),
>  	TP_STRUCT__entry(
>  		__field(int,	adapter_nr		)
>  		__field(__u16,	addr			)

