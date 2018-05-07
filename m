Return-Path: <minchan.kim@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525702245; cv=none;
        d=google.com; s=arc-20160816;
        b=b0NqXZdAw7ZifLIEQ4pkvgapE3acldRNDxt+pLDGj1ifWL0F6Ix8sD6f3D/D0aR9in
         oqbB04b+f4BQGw7CLjvu6OLc+FXJUs2W85zG4DlKYMsgPHaelE9VjA9Io0Ki9S1WGbTo
         h55gwAIYA3VQtFHxswEtwE8MjVsyFyjh/XMuIIGEbbtxnMgLGc+PpFtm+P5rdtqZ02FD
         4aqm/4VwFhI4nAAIomfnO+UxdTcSRAFqLZi9n8p8YxvbAtd1IYBt74R+KbNmYKUQIwdO
         jmY3tlpqn3iy2QJJUR3Ihd8N7XeUg77n/Z5heUHuoqKAQPqAThZwpNDMORCr45yYaW2c
         Y2/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=mp6aRJVwdz/B7Iawa+LBnflGIO9m4yzeeIZgdTkH7vM=;
        b=CO6AKSBMDNSUesIChvuF6krMF4ttdkxHhANyG+tEcCvGqJKIGZxK2XXIDnRw1G1HVt
         FOOlCm2AcgIh7Vf3ilt8nnxyPkV/A5MYuLg1Zh4YnGXqijpYuusZOxIYpCdvlswSA2Jd
         +14S0YbhwFMcOlwhXYVwCBxYQECW42TJPjL3F7HL8/cUIGY+W1gqB2m+O3tigFcykC25
         7GFLVCHohS/UNgNcYCpSpDvcOEh2/ciZNJi+bTi1kYXRGqC8D9LQb6zEJWJ3oIjqEOUv
         EKxPWlCRf5NY+CfNQBAdx1p1GVl0lzDVXZ0iJcadHaGAJIv2tnh5hnif5rTE3iQhS1fu
         AEGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZAZGvlRi;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZAZGvlRi;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
X-Google-Smtp-Source: AB8JxZoFEKaLED2hafbZTEEJ33PUqr3nrVi06NISAPcR3YUVnuYfBjyx4u2HMD/TXxxQPHg1QDUA2w==
Sender: Minchan Kim <minchan.kim@gmail.com>
Date: Mon, 7 May 2018 23:10:39 +0900
From: Minchan Kim <minchan@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux-Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: linux-next: build warning after merge of the akpm-current tree
Message-ID: <20180507141039.GA1934@rodete-desktop-imager.corp.google.com>
References: <20180504141756.670dc3f3@canb.auug.org.au>
 <4fb39549-8902-950d-3076-82a11b1c5102@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fb39549-8902-950d-3076-82a11b1c5102@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599505695773381278?=
X-GMAIL-MSGID: =?utf-8?q?1599814757690562454?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 04, 2018 at 08:39:43AM -0700, Randy Dunlap wrote:
> On 05/03/2018 09:17 PM, Stephen Rothwell wrote:
> > Hi Andrew,
> > 
> > After merging the akpm-current tree, today's linux-next build
> > (x86_64_allmodconfig) produced this warning:
> > 
> > drivers/block/zram/zram_drv.c: In function 'read_block_state':
> > drivers/block/zram/zram_drv.c:674:16: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 5 has type '__kernel_time_t {aka long int}' [-Wformat=]
> >     "%12lu %12llu.%06lu %c%c%c\n",
> >            ~~~~~^
> >            %12lu
> >     (unsigned long)index, ts.tv_sec,
> >                           ~~~~~~~~~
> > 
> > Introduced by commit
> > 
> >   827c7dbda8eb ("zram-introduce-zram-memory-tracking-update-fix-fix")
> > 
> 
> typedef __s64 time64_t;
> 
> struct timespec64 {
> 	time64_t	tv_sec;			/* seconds */
> 	long		tv_nsec;		/* nanoseconds */
> };
> 
> time64_t is signed. Also, %lu on i386 et al is for 32-bit longs.
> I guess that "we" will need to cast ts.tv_sec to (s64) and use %lld to print it
> in order to satisfy other $arch.
> 
> Andrew, want to add a fix-fix-fix patch?

Thanks for the fix during I am absent, Andrew and Randy.
Here goes fix.
Andrew please fold this patchset.

>From 16569c7abb641930b4e4ec66b4dc2005e6c87be8 Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Mon, 7 May 2018 23:00:16 +0900
Subject: [PATCH] zram-introduce-zram-memory-tracking-update-fix-fix-fix

fix compile warning

drivers/block/zram/zram_drv.c: In function 'read_block_state':
drivers/block/zram/zram_drv.c:674:16: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 5 has type '__kernel_time_t {aka long int}' [-Wformat=]
    "%12lu %12llu.%06lu %c%c%c\n",
           ~~~~~^
           %12lu
    (unsigned long)index, ts.tv_sec,
                          ~~~~~~~~~
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/zram_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index f2f3104b2b48..635307e3238b 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -671,8 +671,8 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 
 		ts = ktime_to_timespec64(zram->table[index].ac_time);
 		copied = snprintf(kbuf + written, count,
-			"%12lu %12llu.%06lu %c%c%c\n",
-			(unsigned long)index, ts.tv_sec,
+			"%12lu %12lld.%06ld %c%c%c\n",
+			(unsigned long)index, (s64)ts.tv_sec,
 			ts.tv_nsec / NSEC_PER_USEC,
 			zram_test_flag(zram, index, ZRAM_SAME) ? 's' : '.',
 			zram_test_flag(zram, index, ZRAM_WB) ? 'w' : '.',
-- 
2.17.0.441.gb46fe60e1d-goog
