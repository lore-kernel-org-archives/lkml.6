Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AIpwx48PS6gyooQPB2ut4QDYhwqgsU5o8ia5vue4DODpHywKTaOPGQXJhXMxadH7QnQ40lfdd00u
ARC-Seal: i=1; a=rsa-sha256; t=1523852269; cv=none;
        d=google.com; s=arc-20160816;
        b=eEn3oRT8fHV9qiACToXAmtGvg/ALu7yIXrX0TjkcFGGGU1Cm5vdC6wf6o+UZ/m8h9C
         6ev4VIDrUkg6j//kIiBRwgUVqMqtsShfGdkozdRLvf9RjKpmtKNnkYJsrv+rYHceW3rB
         LBxtBmfu/QS4Qlk1UF0gIljUVxKNDDiNcxdVF2TnKHhqhuTgXO2CMZbVOIMq6+KPrbuC
         maH7HVUNjdngLWGh841itm11aUhYITnER8Q+whl0udRn5KCcqVEh8PUli5/wBfcVIIt0
         p31HwjmVIF/C20u2uDcRYor3OyJv0/fKZK81Cd9ObaZwnqvmRVLpmNkyiBe7nMNJrDTL
         ZPNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=jo8VJhrtR+c2hbdQO2kBCCm984CJpEygtIVC9PLfpPk=;
        b=hVnKvDWiOX07jDJrwobiBZg47r+rlZOAaZ2uQSTGioTYyt4/hmUMXAcFaMOGxVbOi1
         OmbKQ8yoygVYxPMPBC6z3MOTjNyyCdCUXurl2+xIDHCDlbj485S7KXamDQR9aTnsE1gD
         hWZApJ9p0xonng7mrWOwnVPLPCEKDKF+RiIfgXiynF4sagJlUE4VEznOSm0XpPI18quQ
         85d2HJ5L8Lk/ldlkNogGNG9pNQSmVMhYHgkxnmpZPOF2TiaFrzP0yF9HuqjEd393iHVS
         jf6+Pr6Vi1vaoaBShXl7wJ+Q2Io6uzE0hHNqD5b9LLrpE6Qc0lwDkdrLZAqkqysJe2Tf
         7TPA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=nFZswkAu;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=nFZswkAu;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH v4 4/4] zram: introduce zram memory tracking
To: Minchan Kim <minchan@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20180416033110.32361-1-minchan@kernel.org>
 <20180416033110.32361-5-minchan@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <496fe3d5-3306-1aa0-51b7-c61380dc2797@infradead.org>
Date: Sun, 15 Apr 2018 21:17:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180416033110.32361-5-minchan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597872002743020578?=
X-GMAIL-MSGID: =?utf-8?q?1597874917471723433?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/15/2018 08:31 PM, Minchan Kim wrote:
> zRam as swap is useful for small memory device. However, swap means
> those pages on zram are mostly cold pages due to VM's LRU algorithm.
> Especially, once init data for application are touched for launching,
> they tend to be not accessed any more and finally swapped out.
> zRAM can store such cold pages as compressed form but it's pointless
> to keep in memory. Better idea is app developers free them directly
> rather than remaining them on heap.
> 
> This patch tell us last access time of each block of zram via
> "cat /sys/kernel/debug/zram/zram0/block_state".
> 
> The output is as follows,
>       300    75.033841 .wh
>       301    63.806904 s..
>       302    63.806919 ..h
> 
> First column is zram's block index and 3rh one represents symbol
> (s: same page w: written page to backing store h: huge page) of the
> block state. Second column represents usec time unit of the block
> was last accessed. So above example means the 300th block is accessed
> at 75.033851 second and it was huge so it was written to the backing
> store.
> 
> Admin can leverage this information to catch cold|incompressible pages
> of process with *pagemap* once part of heaps are swapped out.
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  Documentation/blockdev/zram.txt |  24 ++++++
>  drivers/block/zram/Kconfig      |  10 +++
>  drivers/block/zram/zram_drv.c   | 140 +++++++++++++++++++++++++++++---
>  drivers/block/zram/zram_drv.h   |   5 ++
>  4 files changed, 168 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/blockdev/zram.txt b/Documentation/blockdev/zram.txt
> index 78db38d02bc9..45509c7d5716 100644
> --- a/Documentation/blockdev/zram.txt
> +++ b/Documentation/blockdev/zram.txt
> @@ -243,5 +243,29 @@ to backing storage rather than keeping it in memory.
>  User should set up backing device via /sys/block/zramX/backing_dev
>  before disksize setting.
>  
> += memory tracking
> +
> +With CONFIG_ZRAM_MEMORY_TRACKING, user can know information of the
> +zram block. It could be useful to catch cold or incompressible
> +pages of the proess with*pagemap.

?               process

> +If you enable the feature, you could see block state via
> +/sys/kernel/debug/zram/zram0/block_state". The output is as follows,
> +
> +	  300    75.033841 .wh
> +	  301    63.806904 s..
> +	  302    63.806919 ..h
> +
> +First column is zram's block index.
> +Second column is access time.
> +Third column is state of the block.
> +(s: same page
> +w: written page to backing store
> +h: huge page)
> +
> +First line of above example says 300th block is accessed at 75.033841sec
> +and the block's state is huge so it is written back to the backing
> +storage. It's a debugging feature so anyone shouldn't rely on it to work
> +properly.
> +
>  Nitin Gupta
>  ngupta@vflare.org
> diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
> index ac3a31d433b2..01090338fb47 100644
> --- a/drivers/block/zram/Kconfig
> +++ b/drivers/block/zram/Kconfig
> @@ -26,3 +26,13 @@ config ZRAM_WRITEBACK
>  	 /sys/block/zramX/backing_dev.
>  
>  	 See zram.txt for more infomration.
> +
> +config ZRAM_MEMORY_TRACKING
> +	bool "Tracking zram block status"

	bool "Track zram block status"

although sometimes it is zRam or zRAM.


> +	depends on ZRAM && DEBUG_FS
> +	help
> +	  With this feature, admin can track the state of allocated block

	                                                            blocks

> +	  of zRAM. Admin could see the information via
> +	  /sys/kernel/debug/zram/zramX/block_state.
> +
> +	  See zram.txt for more information.

	  See Documentation/blockdev/zram.txt for more information.


-- 
~Randy
