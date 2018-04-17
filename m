Return-Path: <akpm@linux-foundation.org>
X-Google-Smtp-Source: AIpwx4//Q3om0rSWPlUeJwJcujICKHsVzhRrqDM6BLrKBtyp5KKFDFf2vLEnBX2F0LNdLPU9BZkH
ARC-Seal: i=1; a=rsa-sha256; t=1524002362; cv=none;
        d=google.com; s=arc-20160816;
        b=vywvLSfMgJS1CVPp9JWhHaN7ECBE12DQHjUJuW/+MxTu4zeomQYlQ/wjzghdKaR4SF
         4Ix4Eq5TXWpBG2fKfMvE4muqZ2T/zezOwoTPOEmUWeN3NpJ/jh/dtfpukOtfZIVOM8hR
         OUOwlhoH8UEU3JMa2+2tqTZTfGEOjlMsnY0Q49aRF+t58N8wTbndG6JiubNGrkUXlAD6
         gQn2SVGVtTBjC5jhT+HEOroyTGKwOIhAUXhzBeUnOc5p7gmlhjGX1ms/2NUwRu2A8+aU
         UTxDE/hPNXCcyDCcz99Z7uFw3dyWlWFAe1gqOoECBU7l39CZhivxrlxro+QwD0AhuhOt
         QSnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=ucZIOVyNrYuv9KA3wFRgymN/8+phPss53kQDhVU3jtA=;
        b=yPbS4NhZ8q/fwci7l/bb5+nmf56a+KKd/LGFAQHgwUJamBp1oU1LtUMejCuMRMpcHe
         GMDx+62vC8jjqidFTaKUYyKlSobYHtZhK906E1faB5uIESVy+QbJ7e9hGPdYUAI2CEtH
         ou+L8f70Ool+vNUs/jCWnylHVbGwtkNdfwebhbs29dwGN8NMH4WzfugJktLPuR0aMMA3
         iKA683n+YO9aTzh/asX6QmfBgNSrHziTcdPcOlZUnc340nYEO4brNjKL+/d/Pu/orHqJ
         gomM5HJmLO4oW8f2fsVK3sosWdtzudxaYsdoECGhkwgYjVQEqHXn6hprctE99ECuUs80
         eVhw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.71 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.71 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Date: Tue, 17 Apr 2018 14:59:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Minchan Kim <minchan@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Sergey Senozhatsky
 <sergey.senozhatsky.work@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sergey Senozhatsky
 <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH v5 4/4] zram: introduce zram memory tracking
Message-Id: <20180417145921.eac3d6379b5bade6c4f1a091@linux-foundation.org>
In-Reply-To: <20180416090946.63057-5-minchan@kernel.org>
References: <20180416090946.63057-1-minchan@kernel.org>
	<20180416090946.63057-5-minchan@kernel.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597872002743020578?=
X-GMAIL-MSGID: =?utf-8?q?1598032301595387608?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 16 Apr 2018 18:09:46 +0900 Minchan Kim <minchan@kernel.org> wrote:

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

A few things..

- Terms like "Admin can" and "Admin could" are worrisome.  How do we
  know that admins *will* use this?  How do we know that we aren't
  adding a bunch of stuff which nobody will find to be (sufficiently)
  useful?  For example, is there some userspace tool to which you are
  contributing which will be updated to use this feature?

- block_state's second column is in microseconds since some
  undocumented time.  But how is userspace to know how much time has
  elapsed since the access?  ie, "current time".

- Is the sched_clock() return value suitable for exporting to
  userspace?  Is it monotonic?  Is it consistent across CPUs, across
  CPU hotadd/remove, across suspend/resume, etc?  Does it run all the
  way up to 2^64 on all CPU types, or will some processors wrap it at
  (say) 32 bits?  etcetera.  Documentation/timers/timekeeping.txt
  points out that suspend/resume can mess it up and that the counter
  can drift between cpus.
