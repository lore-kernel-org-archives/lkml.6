Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
X-Google-Smtp-Source: AIpwx4+/G7J6l0reeCxwKJOa1+oqbTVka9N2DU4iWReCCZ0kvgEkea8WIVORhM9J4PgrIBIxEJwR
ARC-Seal: i=1; a=rsa-sha256; t=1522925210; cv=none;
        d=google.com; s=arc-20160816;
        b=ttY0gO2haecKU0UfOZ+xmOTJs0Vth7VLgyw5M52/ElKYJdPIFQyWOtgAfGdUNaEh+5
         dOUSbfdUG++RTTAiUUlB6yTQDkG7ISCozqFRRn6skctAKQCejWC75eIqf7sYcUZo5La4
         ur3K6afufR0Tl/hMCnJ0xmQJSOznAxXz7F2MC0rVhaIPaefxmNQgZlCUX2XVn1pycRw6
         Z3z5+qLXNau4d8qhfC5xAW0JzMtGoggwldfEebrB1xym+swKsonZeGvPjfqkwnoFYyNg
         UNw10SLLVCQpew8YvMS2pR2FWgw0pgU9eiBOcRDQu0D3/8lALXn/4rUziE8O7QI8DsWz
         4Sww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=BMBktSPRuyy0e34HVCjBdJ97l5vursCJT1+5PuRfp9U=;
        b=TREkSN3MbkYsRPInPsWiDCmPrGqBEwJeqKat/xKlxeck/8s/YzON42aCIdYs4+lQTH
         VSkCk3QKDKZkDVwhhmTRGdCXH7cgcUTmKOezluQ+C7ieW9R4kDJAXBd4w8ltHZG2g9ei
         6flSievhnuQteRtHgyN0IYdgfnyUATtO6UX9zMkg1jLc6RqYvF75LVBGHsgIyFBS57Z4
         N8xTCsbIDm9+wLd0TesCL5VCccnRYJKlV+CbFBfT5ThXOjUPnE8ih5/liALtS5OLb0o0
         OLadnEyhUKz6MD9aKMEWY1x0e4VHA+Crg5wmkMODbsA3lzGg3hNfGF6rOtk5CtVnKViL
         5F/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of penguin-kernel@i-love.sakura.ne.jp designates 202.181.97.72 as permitted sender) smtp.mailfrom=penguin-kernel@i-love.sakura.ne.jp
Subject: Re: WARNING in tty_set_ldisc
To: Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com
Cc: syzbot
 <bot+1a77aeddeaf63317949b59c3df98f139a1ca34f9@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Alan Cox <alan@llwyncelyn.cymru>,
        Christoph Hellwig <hch@lst.de>, Michal Hocko <mhocko@suse.com>
References: <001a1141f0c87da52c055d385a4d@google.com>
 <20171105103404.GB1487@kroah.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <2e8fd7a6-6841-d660-8e1c-17b5a07618fa@I-love.SAKURA.ne.jp>
Date: Thu, 5 Apr 2018 19:46:38 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20171105103404.GB1487@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1583215020386127700?=
X-GMAIL-MSGID: =?utf-8?q?1596902825191521537?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2017/11/05 19:34, Greg KH wrote:
> On Sun, Nov 05, 2017 at 01:45:01AM -0700, syzbot wrote:
>> Hello,
>>
>> syzkaller hit the following crash on
>> 9c323bff13f92832e03657cabdd70d731408d621
>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
>> compiler: gcc (GCC) 7.1.1 20170620
>> .config is attached
>> Raw console output is attached.
> 
> Again, what am I supposed to do with this?
> 
> thanks,
> 
> greg k-h
> 

>From 023cf07f799d0efd160ec1c1617d5b8902577765 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Thu, 5 Apr 2018 11:27:06 +0900
Subject: [PATCH] tty: Avoid possible error pointer dereference at tty_ldisc_restore().

syzbot is reporting crashes [1] triggered by memory allocation failure at
tty_ldisc_get() from tty_ldisc_restore(). While syzbot stops at WARN_ON()
due to panic_on_warn == true, panic_on_warn == false will after all trigger
an OOPS by dereferencing old->ops->num if IS_ERR(old) == true.

We can simplify tty_ldisc_restore() as three calls (old->ops->num, N_TTY,
N_NULL) to tty_ldisc_failto() in addition to avoiding possible error
pointer dereference.

If someone reports kernel panic triggered by forcing all memory allocations
for tty_ldisc_restore() to fail, we can consider adding __GFP_NOFAIL for
tty_ldisc_restore() case.

[1] https://syzkaller.appspot.com/bug?id=6ac359c61e71d22e06db7f8f88243feb11d927e7

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Alan Cox <alan@llwyncelyn.cymru>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Michal Hocko <mhocko@suse.com>
---
 drivers/tty/tty_ldisc.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 08ddb2c..de007e1 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -527,19 +527,16 @@ static int tty_ldisc_failto(struct tty_struct *tty, int ld)
 static void tty_ldisc_restore(struct tty_struct *tty, struct tty_ldisc *old)
 {
 	/* There is an outstanding reference here so this is safe */
-	old = tty_ldisc_get(tty, old->ops->num);
-	WARN_ON(IS_ERR(old));
-	tty->ldisc = old;
-	tty_set_termios_ldisc(tty, old->ops->num);
-	if (tty_ldisc_open(tty, old) < 0) {
-		tty_ldisc_put(old);
+	if (tty_ldisc_failto(tty, old->ops->num) < 0) {
+		const char *name = tty_name(tty);
+
+		pr_warn("Falling back ldisc for %s.\n", name);
 		/* The traditional behaviour is to fall back to N_TTY, we
 		   want to avoid falling back to N_NULL unless we have no
 		   choice to avoid the risk of breaking anything */
 		if (tty_ldisc_failto(tty, N_TTY) < 0 &&
 		    tty_ldisc_failto(tty, N_NULL) < 0)
-			panic("Couldn't open N_NULL ldisc for %s.",
-			      tty_name(tty));
+			panic("Couldn't open N_NULL ldisc for %s.", name);
 	}
 }
 
-- 
1.8.3.1
