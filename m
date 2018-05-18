Return-Path: <axboe@kernel.dk>
ARC-Seal: i=1; a=rsa-sha256; t=1526611296; cv=none;
        d=google.com; s=arc-20160816;
        b=skR333erknI13zDPjS0EyECuy8lm5W3dHLKQY6Te9iUjxCniLx1k/v8YkyH5gSYNqh
         iJp8hP5IaVqTKesDvTUXQ/ov4SONhk5Ps2HR6T0bcEf3ooUtonBSUEqozIK1BnL5hrqz
         +ALICTrOgH/xVW3xQGc7RnD//zxGOEXBGh6En2+JcT7SZXeOCYRHqfmDmyjtFoJr3WpR
         KGmQRnlW6DW4DR0v24b9lxy4V18zPu7cZOrGIkZ0ONAXXSTNFAkstH7iubfonxnRVCMJ
         zz5dFW9iHfYmM7yFC8AiJQDSkplb2g9IKYbqQtHgNhDMVDnVdLZmq5AW10ZnPtA6q/fN
         kMjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=6h9/Yw7N+RL+YtirrgRjfua4uTb0EXSXDQG7XxCQS20=;
        b=jDsjGD1h0Ynf/MFJaV78XMAppvPQYaNxSDgoRzi9NDkGNwgDhvSkabfGV/GGQCaCQY
         ytGOCSS/uyka5g2mq8WClcbyyT8WLhbtJWbkeUHP8NgBgqT3Gt5XDWGzBoh4LWlArulr
         4y9S86VUletw/tMQvdwerG7oDgje/l7uBY5IjmKZ29xi/TADu6c4dth8TTesffCakuQ7
         dvqMph5+P53FXHVw2axIEfqvud5WaEssvPK7KmIWUSKVkEkdY3qIux+GIdThKD9cZpHF
         XhtjfYUg2ttMWiF+1HCkAVz8WkXaxbzuEu1A18K94F0RVbRu4+D+mXnqXWA9j28gvGAp
         AA+A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel-dk.20150623.gappssmtp.com header.s=20150623 header.b=ORSsL13I;
       spf=pass (google.com: domain of axboe@kernel.dk designates 209.85.220.65 as permitted sender) smtp.mailfrom=axboe@kernel.dk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel-dk.20150623.gappssmtp.com header.s=20150623 header.b=ORSsL13I;
       spf=pass (google.com: domain of axboe@kernel.dk designates 209.85.220.65 as permitted sender) smtp.mailfrom=axboe@kernel.dk
X-Google-Smtp-Source: AB8JxZohF3CJVZgLTLt834phSJmIGvd6gYMHVv4rex672d+As021YMQ0ntQv1WMtxgwha9S6I6feeQ==
Subject: Re: [PATCH v4 0/3] AIO add per-command iopriority
To: adam.manzanares@wdc.com, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, bcrl@kvack.org
Cc: mingo@kernel.org, peterz@infradead.org, pombredanne@nexb.com,
 gregkh@linuxfoundation.org, bigeasy@linutronix.de, rgoldwyn@suse.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-aio@kvack.org, linux-api@vger.kernel.org
References: <20180517203803.2664-1-adam.manzanares@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3ec960cf-e14c-6ff6-3356-186136f43df7@kernel.dk>
Date: Thu, 17 May 2018 20:41:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180517203803.2664-1-adam.manzanares@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600745117774475570?=
X-GMAIL-MSGID: =?utf-8?q?1600767967556615585?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 5/17/18 2:38 PM, adam.manzanares@wdc.com wrote:
> From: Adam Manzanares <adam.manzanares@wdc.com>
> 
> This is the per-I/O equivalent of the ioprio_set system call.
> See the following link for performance implications on a SATA HDD:
> https://lkml.org/lkml/2016/12/6/495
> 
> First patch factors ioprio_check_cap function out of ioprio_set system call to
> also be used by the aio ioprio interface.
> 
> Second patch converts kiocb ki_hint field to a u16 to avoid kiocb bloat.
> 
> Third patch passes ioprio hint from aio iocb to kiocb and enables block_dev
> usage of the per I/O ioprio feature.
> 
> v2: merge patches
>     use IOCB_FLAG_IOPRIO
>     validate intended use with IOCB_IOPRIO
>     add linux-api and linux-block to cc
> 
> v3: add ioprio_check_cap function
>     convert kiocb ki_hint to u16
>     use ioprio_check_cap when adding ioprio to kiocb in aio.c
> 
> v4: handle IOCB_IOPRIO in aio_prep_rw
>     note patch 3 depends on patch 1 in commit msg
> 
> Adam Manzanares (3):
>   block: add ioprio_check_cap function
>   fs: Convert kiocb rw_hint from enum to u16
>   fs: Add aio iopriority support for block_dev
> 
>  block/ioprio.c               | 22 ++++++++++++++++------
>  fs/aio.c                     | 16 ++++++++++++++++
>  fs/block_dev.c               |  2 ++
>  include/linux/fs.h           | 17 +++++++++++++++--
>  include/linux/ioprio.h       |  2 ++
>  include/uapi/linux/aio_abi.h |  1 +
>  6 files changed, 52 insertions(+), 8 deletions(-)

This looks fine to me now. I can pick up #1 for 4.18 - and 2+3 as well,
unless someone else wants to take them.

-- 
Jens Axboe
