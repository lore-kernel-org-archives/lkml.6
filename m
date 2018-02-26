Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELubSOjXGhNOveqZZxiNTr3jKNQT3iEJe29zTlgdYJH119b576ep4zrXZveYv2zFXOKJhfVg
ARC-Seal: i=1; a=rsa-sha256; t=1519676654; cv=none;
        d=google.com; s=arc-20160816;
        b=VVF9WCmrf27uA4aXohR8i/tfccELCgE4WFSx86hfEVnElwKDs8izRpLXs8sSLA1iPK
         DFvxjHK5y+2IcseQNrKjUEa12+bFu2fOwZnoEkpeoUUhJDuts/IHPZLlJieMO6YF4gP9
         ppV7BqBGraFCUFaP1ALLRPM09EPdIYHxWaQ6QB1iNkZCCqG94EWRrIqEwsSYh4Hyn7Pb
         jwmijhvTMDFpG887Llca2xnAUOYbXWD/Mc3l5E5P07DjTXBiHmdgBx1AAj0oRF3l6WeB
         FgxVgT0RoojjN+RGpNAjuNO7Bk79UcusRMiioaLQBBVaCoPQr548Zr/cd/1jYKVnl7G8
         THGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=K1heWTc9S9PD8H7g2P2lJUzPS5DLgYeJb2nwGqcpUVQ=;
        b=Xm9gx52aQWe2HPrio9g2U6nj7hjgCBed74jM3p9oeepcH7sy5daRR86GQ8aBN5/rAS
         1ZSilwQvzcJIQQoG3a5+oCva9QrFSA1eG/CBTVn1c69wX0gsJeG/pRF0AVU5JDSj276C
         Lllw2M0Ev43xYc1zJsMeOV9zJZOEyPoJCOToBAyCBQ7Z84IFb3NvjsR6Fh59ovhdajIt
         li3vzwjovSGgIAK4kW02mL2GI5zLilJILbc0QiRCvAawMPJxrCSJMvKH6Rz0wCWmahbZ
         vmipAGY0TSLgF0F/SoSxisbKQ9ibZmJpfkzObrSkJawjql25JllkD1VPgh01tiDRlt4+
         pcvg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Huang, Ying" <ying.huang@intel.com>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Dan Streetman <ddstreet@ieee.org>,
	Seth Jennings <sjenning@redhat.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Shaohua Li <shli@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Mel Gorman <mgorman@techsingularity.net>,
	Shakeel Butt <shakeelb@google.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Juergen Gross <jgross@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 27/54] mm, swap, frontswap: fix THP swap if frontswap enabled
Date: Mon, 26 Feb 2018 21:22:04 +0100
Message-Id: <20180226202145.746789198@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496467326007853?=
X-GMAIL-MSGID: =?utf-8?q?1593496467326007853?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huang Ying <huang.ying.caritas@gmail.com>

commit 7ba716698cc53f8d5367766c93c538c7da6c68ce upstream.

It was reported by Sergey Senozhatsky that if THP (Transparent Huge
Page) and frontswap (via zswap) are both enabled, when memory goes low
so that swap is triggered, segfault and memory corruption will occur in
random user space applications as follow,

kernel: urxvt[338]: segfault at 20 ip 00007fc08889ae0d sp 00007ffc73a7fc40 error 6 in libc-2.26.so[7fc08881a000+1ae000]
 #0  0x00007fc08889ae0d _int_malloc (libc.so.6)
 #1  0x00007fc08889c2f3 malloc (libc.so.6)
 #2  0x0000560e6004bff7 _Z14rxvt_wcstoutf8PKwi (urxvt)
 #3  0x0000560e6005e75c n/a (urxvt)
 #4  0x0000560e6007d9f1 _ZN16rxvt_perl_interp6invokeEP9rxvt_term9hook_typez (urxvt)
 #5  0x0000560e6003d988 _ZN9rxvt_term9cmd_parseEv (urxvt)
 #6  0x0000560e60042804 _ZN9rxvt_term6pty_cbERN2ev2ioEi (urxvt)
 #7  0x0000560e6005c10f _Z17ev_invoke_pendingv (urxvt)
 #8  0x0000560e6005cb55 ev_run (urxvt)
 #9  0x0000560e6003b9b9 main (urxvt)
 #10 0x00007fc08883af4a __libc_start_main (libc.so.6)
 #11 0x0000560e6003f9da _start (urxvt)

After bisection, it was found the first bad commit is bd4c82c22c36 ("mm,
THP, swap: delay splitting THP after swapped out").

The root cause is as follows:

When the pages are written to swap device during swapping out in
swap_writepage(), zswap (fontswap) is tried to compress the pages to
improve performance.  But zswap (frontswap) will treat THP as a normal
page, so only the head page is saved.  After swapping in, tail pages
will not be restored to their original contents, causing memory
corruption in the applications.

This is fixed by refusing to save page in the frontswap store functions
if the page is a THP.  So that the THP will be swapped out to swap
device.

Another choice is to split THP if frontswap is enabled.  But it is found
that the frontswap enabling isn't flexible.  For example, if
CONFIG_ZSWAP=y (cannot be module), frontswap will be enabled even if
zswap itself isn't enabled.

Frontswap has multiple backends, to make it easy for one backend to
enable THP support, the THP checking is put in backend frontswap store
functions instead of the general interfaces.

Link: http://lkml.kernel.org/r/20180209084947.22749-1-ying.huang@intel.com
Fixes: bd4c82c22c367e068 ("mm, THP, swap: delay splitting THP after swapped out")
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reported-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Tested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Suggested-by: Minchan Kim <minchan@kernel.org>	[put THP checking in backend]
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Dan Streetman <ddstreet@ieee.org>
Cc: Seth Jennings <sjenning@redhat.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Shaohua Li <shli@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: <stable@vger.kernel.org>	[4.14]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/xen/tmem.c |    4 ++++
 mm/zswap.c         |    6 ++++++
 2 files changed, 10 insertions(+)

--- a/drivers/xen/tmem.c
+++ b/drivers/xen/tmem.c
@@ -284,6 +284,10 @@ static int tmem_frontswap_store(unsigned
 	int pool = tmem_frontswap_poolid;
 	int ret;
 
+	/* THP isn't supported */
+	if (PageTransHuge(page))
+		return -1;
+
 	if (pool < 0)
 		return -1;
 	if (ind64 != ind)
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -970,6 +970,12 @@ static int zswap_frontswap_store(unsigne
 	u8 *src, *dst;
 	struct zswap_header *zhdr;
 
+	/* THP isn't supported */
+	if (PageTransHuge(page)) {
+		ret = -EINVAL;
+		goto reject;
+	}
+
 	if (!zswap_enabled || !tree) {
 		ret = -ENODEV;
 		goto reject;
