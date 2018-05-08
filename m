Return-Path: <npiggin@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525750825; cv=none;
        d=google.com; s=arc-20160816;
        b=kbqCSSVYcNOERhhDnyQVFdlB28jgG6NYfKQDjcaV5KDUJA3U+MltP8GM6Cqu/S0qx9
         b8pwU2m7Ev2A4sKZESgflqbvmmqLd9Hz6ch/QduCU3yz600dgkvW6dwMdlDC1oHOnccf
         A3G3BKaPVwA58GaT2YGf4LkPD/tYlVv2pvLLNghS0ML7Z4uTGWTGlNJR6I23KUSSsftn
         BL9jr4MdClyvwvmkTRQtoPoVNQnlGxNdYQ9cSM3Y0KLCRNPrOywpPhCMEUlYuqYWPDvD
         GT1c/ugJss5JSXmQ/SFpOpScX2lfK5mMQtsH08YqQVmp8AQLhz73QzRWMVLmVDPXNu1y
         LN3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=KiYQ+0FS11nO4Ta97MyUarAhmBEE+lBl/jqHhFtTlK0=;
        b=kfU2tXzCRpqF3uKF+WGG2UUnCanW+mRHuBC1m2QhfyvifHgElcGIZL8tPtFTRlxX46
         kTwD+iJ/8A+lT7vi972JZ/jbE9YtlYppNNzP9uqByQuQtlK/LmpArn1VZAhMUXdZw5ko
         7OOi/W8tbEk/RsbQIjrw0JS6h5HvwtS9pOVX/F7B1jv8sgL2J90PKvvZKnRbxMbIJdsM
         xXKTkAtnF5AoDXlZ4lnP/OiJiARmznBb+xOvvZIzwiu6E1HFAHrjzTN26dgOh3l2q1vV
         nXp0l/3Uxe8nh8wHWjSPx5nPPQM9fRpLIhN886mVtep0dmfFSOqw7fv3mjDJqtyJIK6M
         LvPw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=uhuHPezA;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=uhuHPezA;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZqgfa4SP+HtjGQlxMj3ULM0pPUnrnG6Boz+pcL31jlmWHN8MmFvcsBlc03k98JdMPmCITP3Ug==
Date: Tue, 8 May 2018 13:40:13 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Jiri Slaby <jslaby@suse.com>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 04/15] powerpc/powernv: opal-kmsg use flush fallback
 from console code
Message-ID: <20180508134013.472b7981@roar.ozlabs.ibm.com>
In-Reply-To: <87wowfbvm0.fsf@concordia.ellerman.id.au>
References: <20180430145558.4308-1-npiggin@gmail.com>
	<20180430145558.4308-5-npiggin@gmail.com>
	<87muxg80ga.fsf@concordia.ellerman.id.au>
	<20180504153717.4806d9c4@roar.ozlabs.ibm.com>
	<87wowfbvm0.fsf@concordia.ellerman.id.au>
Organization: IBM
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599183451122520462?=
X-GMAIL-MSGID: =?utf-8?q?1599865698048194506?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 07 May 2018 20:36:39 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> > On Fri, 04 May 2018 15:16:37 +1000
> > Michael Ellerman <mpe@ellerman.id.au> wrote:  
> >> Nicholas Piggin <npiggin@gmail.com> writes:  
> >> > Use the more refined and tested event polling loop from opal_put_chars
> >> > as the fallback console flush in the opal-kmsg path. This loop is used
> >> > by the console driver today, whereas the opal-kmsg fallback is not
> >> > likely to have been used for years.
> >> >
> >> > Use WARN_ONCE rather than a printk when the fallback is invoked to
> >> > prepare for moving the console flush into a common function.    
> >> 
> >> Do we want to add a WARN in that path? If we're panicking things might
> >> get worse if we WARN (which takes a trap).  
> >
> > True, probably a good idea not to... oh there's a printk_once so
> > that'll work nicely.  
> 
> Cool.
> 
> I have this series in a tree so you can send me an incremental diff if
> it's reasonably small.

It's a one liner (also moved location of message back to where it was
originally).

The next patch will clash because it moves this over into opal.c, so
you'd have to fix that by hand.

Thanks,
Nick

---
 arch/powerpc/platforms/powernv/opal-kmsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal-kmsg.c b/arch/powerpc/platforms/powernv/opal-kmsg.c
index fd2bbf4fd6dc..c610ef3541aa 100644
--- a/arch/powerpc/platforms/powernv/opal-kmsg.c
+++ b/arch/powerpc/platforms/powernv/opal-kmsg.c
@@ -53,12 +53,12 @@ static void force_opal_console_flush(struct kmsg_dumper *dumper,
 	} else {
 		__be64 evt;
 
-		WARN_ONCE(1, "opal: OPAL_CONSOLE_FLUSH missing.\n");
 		/*
 		 * If OPAL_CONSOLE_FLUSH is not implemented in the firmware,
 		 * the console can still be flushed by calling the polling
 		 * function while it has OPAL_EVENT_CONSOLE_OUTPUT events.
 		 */
+		printk_once(KERN_NOTICE "opal: OPAL_CONSOLE_FLUSH missing.\n");
 		do {
 			opal_poll_events(&evt);
 		} while (be64_to_cpu(evt) & OPAL_EVENT_CONSOLE_OUTPUT);
-- 
2.17.0
