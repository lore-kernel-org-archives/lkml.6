Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA42C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29538207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732852AbfBMNu5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:50:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:32782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727894AbfBMNu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:50:57 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4B8A2075D;
        Wed, 13 Feb 2019 13:50:55 +0000 (UTC)
Date:   Wed, 13 Feb 2019 08:50:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     John Sperbeck <jsperbeck@google.com>
Cc:     wsa@the-dreams.de, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH v3] i2c: core-smbus: don't trace smbus_reply data on
 errors
Message-ID: <20190213085054.1a63c95a@gandalf.local.home>
In-Reply-To: <20190213034057.244716-1-jsperbeck@google.com>
References: <20190213034057.244716-1-jsperbeck@google.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019 19:40:57 -0800
John Sperbeck <jsperbeck@google.com> wrote:

> If an smbus transfer fails, there's no guarantee that the output
> buffer was written.  So, avoid trying to show the output buffer when
> tracing after an error.  This was 'mostly harmless', but would trip
> up kasan checking if left-over cruft in byte 0 is a large length,
> causing us to read from unwritten memory.

From a tracing viewpoint:

 Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

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

