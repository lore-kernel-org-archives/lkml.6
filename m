Return-Path: <gkohli@codeaurora.org>
X-Google-Smtp-Source: AG47ELu7so/Po8TvvvcEYUgFnyldxAeJyFo81FRPsTOei+/zVHtfq/kK1NWNKwYiQEKGFtXVYtp+
ARC-Seal: i=1; a=rsa-sha256; t=1520249803; cv=none;
        d=google.com; s=arc-20160816;
        b=ukk4QZDaqxVUDKqG3K7dZwo6FCn1cTm6zni6sY5SF1bEdsB1ynix4RmPEwe08M/Ls9
         FrshudfRqTCVdUEFhSb03OtfD1XwpUo67wPnT3Ne8oYTxM7vIuSFuqZdzCaaZgYUOXGd
         f2e7o/Ml+ZSqioAJ9rym0jOgAy6Nv+dWprB5XTM3qeB8G+AphAXNBIpImWppAIrS2Sp4
         WaUu21sDVpzjJ1gQhl1OQaMxr10z6eHu654+bFJapCmZa9TYrJ4/hsx78zs6QyPSDVV2
         tNFvQagrkuQTuAU4RP9emJtLwrzIP/VSgV4OWBqj7IIpRLSJJtScSOfI6rQWHd9zgyEp
         19VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:mime-version:user-agent
         :date:message-id:subject:from:cc:to:dmarc-filter:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=PcuEUPtaNMlzgXjidhxNnHDTAkdRRc2eRDO4FbDtw2Q=;
        b=nGo/tbk7upkGu1StMgEMb238dv6/WicJ2MzeERUsdD4rgTFNaJtxjTxPa3G1isyAQ0
         BYVhRRlsqt6wTsBy88GDR8wQK++sPlZsKEb7pMTe+3ShJ+YzAkyf6t3nlthl/DhwV1xI
         Slp4Osy5iBflt/niLlHi0U0C814iTVT7d6kaDrivuIb5PZrey/k0bfNV83wa8JcauN5/
         fvQjp7yODA1vTBRaDLSLgUqPlSqff+HlMIPuE3bsrWMRTaZUejQkqZ8xsGiznKIoiUjc
         9UrZNpy/1Dbae10UTIHyIsf6DzqPSWUIwe2lrdxjCYwJwOn1PWL2p4+WT++gIzPvxruR
         y7fw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=K+KvR7oE;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=K+KvR7oE;
       spf=pass (google.com: domain of gkohli@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=gkohli@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=K+KvR7oE;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=K+KvR7oE;
       spf=pass (google.com: domain of gkohli@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=gkohli@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 57F5D602B7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=gkohli@codeaurora.org
To: jslaby@suse.com, mikey@neuling.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
From: "Kohli, Gaurav" <gkohli@codeaurora.org>
Subject: Query Regarding init block up due to tty_wait_until_sent
Message-ID: <9863fc6d-bae1-4847-161a-40df4e914081@codeaurora.org>
Date: Mon, 5 Mar 2018 17:06:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594097458647037599?=
X-GMAIL-MSGID: =?utf-8?q?1594097458647037599?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

We have seen few instances, where init is getting blocked due to wait in below call:

-002|schedule()
-003|schedule_timeout()  -> timeout for 30 seconds
-004|tty_wait_until_sent()
-005|tty_port_close_start.part.3()
-006|tty_port_close()
-007|uart_close()
-008|tty_name(inline)
-008|tty_release()
-009|__fput()
-010|____fput()
-011|task_work_run()
-012|do_notify_resume()
-013|work_pending(asm)
  ---|end of frame

When i have checked the data structures, it seems there is pending data available in buffer, but uart_port got seems to free.

   (struct uart_state *)0xFFFFFFC3EDCE4000 = 0xFFFFFFC3EDCE4000 -> (
     port = (
       buf = (head = 0xFFFFFFC3E772BC80, work = (data = (counter = 1024), entry = (next = 0xFFFFFFC3EDCE4010, prev = 0xFFFFFFC3E
       tty = 0xFFFFFFC3E772C280,
       itty = 0xFFFFFFC3E772C280,
       ops = 0xFFFFFF89D3E7EBB0,
       lock = (rlock = (raw_lock = (owner = 3, next = 3), magic = 3735899821, owner_cpu = 4294967295, owner = 0xFFFFFFFFFFFFFFFF
       blocked_open = 0,
       count = 0,
       open_wait = (lock = (rlock = (raw_lock = (owner = 0, next = 0), magic = 3735899821, owner_cpu = 4294967295, owner = 0xFFF
       delta_msr_wait = (lock = (rlock = (raw_lock = (owner = 0, next = 0), magic = 3735899821, owner_cpu = 4294967295, owner =
       flags = 0,
       iflags = 5,
       console = 1,
       low_latency = 0,
       mutex = (count = (counter = 1), wait_lock = (rlock = (raw_lock = (owner = 4, next = 4), magic = 3735899821, owner_cpu = 4
       buf_mutex = (count = (counter = 1), wait_lock = (rlock = (raw_lock = (owner = 0, next = 0), magic = 3735899821, owner_cpu
       xmit_buf = 0x0,
       close_delay = 50,
       closing_wait = 3000,
       drain_delay = 0,
       kref = (refcount = (counter = 1))),
     pm_state = UART_PM_STATE_ON = 0x0,
     xmit = (buf = 0xFFFFFFC3E7507000, head = 1, tail = 0),
     refcount = (counter = 1),
     remove_wait = (lock = (rlock = (raw_lock = (owner = 0, next = 0), magic = 3735899821, owner_cpu = 4294967295, owner = 0xFFF
     uart_port = 0xFFFFFF89D58582A0 -> (
       lock = (rlock = (raw_lock = (owner = 604, next = 604), magic = 3735899821, owner_cpu = 4294967295, owner = 0xFFFFFFFFFFFF
       iobase = 0,
       membase = 0xFFFFFF800C7C4000,
       serial_in = 0x0,
       serial_out = 0x0,
       set_termios = 0x0,
  
So in that case write of data won't be possible, So to avoid that do we have to reduce timeout which seems high in current case.
And how can we avoid this if data is available in tty, but uart_port seems to be free.

Please let me know, In case further info is required.

Regards
Gaurav

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
