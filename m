Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033675AbeBOUiK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 15:38:10 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44648 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033595AbeBOUiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 15:38:07 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2ADAE604BE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Thu, 15 Feb 2018 20:38:05 +0000
From: Lina Iyer <ilina@codeaurora.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] drivers: qcom: rpmh-rsc: log RPMH requests in
 FTRACE
Message-ID: <20180215203805.GE23714@codeaurora.org>
References: <20180215173507.10989-1-ilina@codeaurora.org>
 <20180215173507.10989-4-ilina@codeaurora.org>
 <20180215145755.31346aff@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180215145755.31346aff@gandalf.local.home>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15 2018 at 19:57 +0000, Steven Rostedt wrote:
>On Thu, 15 Feb 2018 10:35:00 -0700
>Lina Iyer <ilina@codeaurora.org> wrote:
>
>> @@ -298,6 +303,7 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int m, int n,
>>  		write_tcs_reg(drv, RSC_DRV_CMD_MSGID, m, n + i, msgid);
>>  		write_tcs_reg(drv, RSC_DRV_CMD_ADDR, m, n + i, cmd->addr);
>>  		write_tcs_reg(drv, RSC_DRV_CMD_DATA, m, n + i, cmd->data);
>> +		trace_rpmh_send_msg(drv, m, n + i, msgid, cmd);
>
>No biggy, but I'm curious to why you didn't do something this:
>
>+static void __tcs_buffer_write(struct rsc_drv *drv, int m, int n,
>+                             struct tcs_request *msg)
>+{
>+       u32 msgid, cmd_msgid = 0;
>+       u32 cmd_enable = 0;
>+       u32 cmd_complete;
>+       struct tcs_cmd *cmd;
>+       int i;
>+
>+       cmd_msgid = CMD_MSGID_LEN;
>+       cmd_msgid |= (msg->is_complete) ? CMD_MSGID_RESP_REQ : 0;
>+       cmd_msgid |= CMD_MSGID_WRITE;
>+
>+       cmd_complete = read_tcs_reg(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, m, 0);
>+
>+       for (i = 0; i < msg->num_payload; i++) {
>
>		int bit = n + i;
>
>+               cmd = &msg->payload[i];
>+               cmd_enable |= BIT(bit);
>+               cmd_complete |= cmd->complete << (n + i);
>+               msgid = cmd_msgid;
>+               msgid |= (cmd->complete) ? CMD_MSGID_RESP_REQ : 0;
>+               write_tcs_reg(drv, RSC_DRV_CMD_MSGID, m, bit, msgid);
>+               write_tcs_reg(drv, RSC_DRV_CMD_ADDR, m, bit, cmd->addr);
>+               write_tcs_reg(drv, RSC_DRV_CMD_DATA, m, bit, cmd->data);
>
>		trace_rpmh_send_msg(drv, m, bit, msgid, cmd);
>
>The compiler should optimize that, so this isn't really a big deal, but
>I was just curious.
>
>
No particular reason. Think I just went with the logic at that time and
didn't look back deeply again on the code to tidy it up. Thanks for the
suggestion.

>+       }
>+
>+       write_tcs_reg(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, m, 0, cmd_complete);
>+       cmd_enable |= read_tcs_reg(drv, RSC_DRV_CMD_ENABLE, m, 0);
>+       write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, m, 0, cmd_enable);
>+}
>
>>  	}
>>
>>  	write_tcs_reg(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, m, 0, cmd_complete);
>
>[..]
>
>> +TRACE_EVENT(rpmh_send_msg,
>> +
>> +	TP_PROTO(struct rsc_drv *d, int m, int n, u32 h, struct tcs_cmd *c),
>> +
>> +	TP_ARGS(d, m, n, h, c),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(const char*, d->name)
>> +		__field(int, m)
>> +		__field(int, n)
>> +		__field(u32, hdr)
>> +		__field(u32, addr)
>> +		__field(u32, data)
>> +		__field(bool, complete)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->name = s;
>> +		__entry->m = m;
>> +		__entry->n = n;
>> +		__entry->hdr = h;
>> +		__entry->addr = c->addr;
>> +		__entry->data = c->data;
>> +		__entry->complete = c->complete;
>> +	),
>> +
>> +	TP_printk("%s: send-msg: tcs(m): %d cmd(n): %d msgid: 0x%08x addr: 0x%08x data: 0x%08x complete: %d",
>> +			__entry->name, __entry->m, __entry->n, __entry->hdr,
>
>I'm sorry I didn't catch this in my other reviews, but please don't use
>direct strings in TP_printk(). In trace-cmd and perf, it has no access
>to that information when reading this trace event. Not to mention, if
>drv is freed between the time it is recorded, and the time it is read
>in the trace buffer, you are now referencing random memory.
>
>The way to do this in a trace event is to use the string functionality:
>
>	TP_STRUCT__entry(
>		__string(name, d->name)
>		[..]
>	TP_fast_assign(
>		__assign_string(name, d->name)
>		[..]
>	TP_printk("%s: ...",
>		__get_str(name), ...
>
>Then the name is recorded in the ring buffer at the time of execution
>of the trace event, and trace-cmd and perf can read it, and there's no
>worries about it being freed between recording and reading the tracing
>buffer.
>
The drv would not be freed. But that said, I will use this in my
patches.

Thanks Steve.

-- Lina
