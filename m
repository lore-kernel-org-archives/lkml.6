Return-Path: <SRS0=ubV+=ID=goodmis.org=rostedt@kernel.org>
X-Google-Smtp-Source: AB8JxZr3g/5UXkUyG3f8AV87FvATdh7Qp4g1x/R5sIqTP35IywJKecRyW7tiw2VAIK5hJoj1Keqh
ARC-Seal: i=1; a=rsa-sha256; t=1526483631; cv=none;
        d=google.com; s=arc-20160816;
        b=QFHrbz6axolOjIFRhsCknZnw6GplcUS73O2QdyblpuGbLhkh2AfwbrmuThwi85jbFm
         PcrrdXseKf4o1GSQwjjVNLVOt4FWS68TNradCvhzhqhxoAAYcCG6kU0AhEwIOG96JYVu
         sFP/hKibQ2+hRiUd4Q1Jw5H8d/pRXIu88GA0HRsbhzQc35X15ovYVLBUQqcS42JZ4AEp
         2HMpP5AMKLvptfsP8AOkR5lfmE/TA77Oj99AZ6AJzbwPsFOGJ16SSmqL4XBbMZEpSlMx
         WW4nWa1iAMnBcQgXlFkVzsnXNn0zj/ZkaFQ34HVP5RGiCq81SGwCkpAfw9ekApidAEtG
         OXMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=gvOlCEduzzo2KA5L/Qg4QZEnsHFtDqefT8vEs9JmCGY=;
        b=qPGHmXl7HFoPIDxRNP1r3RpARTRN0sht8f1oyuLBKDbGX/PPSzpALA7JEsx4k6LDr6
         kWHBwQyt1bj5yCWTPzjEot7EZmazpIurzF/fjg7ADc8XMsPt5shEBc4GHdOZAFZ4BTZI
         1M02I6HEJTpZ+ClsNc0ptcSIRnPz10ecwxFCU3gZ32CntPzjG6bC3ARbMS4c0nGuZTqz
         48oCe6V4TFil1U56WwjqzXplZgQ5Rsvs9ozIkmYoVjY2sS+fw3ED8BYUaPQ5/AThV0mx
         lErtyiSDNcDTErb45pvKXg5stp4teTawSwtoN2qrox9r3Noz5xiSTwA8tp1NVhNcRjwz
         tnKA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of srs0=ubv+=id=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ubV+=ID=goodmis.org=rostedt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of srs0=ubv+=id=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ubV+=ID=goodmis.org=rostedt@kernel.org
Date: Wed, 16 May 2018 11:13:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Linus Torvalds
 <torvalds@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Kees
 Cook <keescook@chromium.org>, Anna-Maria Gleixner
 <anna-maria@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] enable early printing of hashed pointers
Message-ID: <20180516111348.1abf69a1@gandalf.local.home>
In-Reply-To: <1526426259-23012-1-git-send-email-me@tobin.cc>
References: <1526426259-23012-1-git-send-email-me@tobin.cc>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600573966123035587?=
X-GMAIL-MSGID: =?utf-8?q?1600634100684642255?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


I think the series looks good, although if Linus takes my last patch,
it may conflict badly with the third patch. I'll have to look into that.

Anyway, Andrew, you want to take this in your tree?

-- Steve


On Wed, 16 May 2018 09:17:36 +1000
"Tobin C. Harding" <me@tobin.cc> wrote:

> Currently if an attempt is made to print a pointer before there is
> enough entropy then '(____ptrval____)' is printed.  This makes debugging
> stack traces during early boot difficult.
> 
> One partial solution to this problem is to use the hw RNG if it is
> available.
> 
> Patch 1 - Whitespace fixes.
> Patch 2 - Fix get_random_bytes_arch()
> Patch 3 - Use hw RNG for pointer hashing if available (by default).
> 
> 
> thanks,
> Tobin.
> 
> v4 -> v5
>  - Use 'upside-down-xmas-tree' style to declare local variables (Steve)
>  - Added Reviewed-by tag from Steve (patch 2 and 3).
> 
> v3 -> v4
>  - remove last patch of series (command line option patch)
> 
> v2 -> v3
>  - Add __ro_after_init (suggested by Kees).
> 
> v1 -> v2
>  - Use min_t() instead of min() (thanks checkpatch).
>  - Add __must_check to function declaration (thanks Steve).
>  - Use hw RNG by default if available (as originally suggested by Kees).
>  - Add command line option to use cryptographically insecure hashing.
>    If debug_early_boot is enabled use hash_long() instead of siphash
>    (as requested by Steve, and solves original problem for Anna-Maria).
>  - Added Acked-by tag from Ted (patch 1 and 2)
> 
> 
> 
> *** BLURB HERE ***
> 
> Tobin C. Harding (3):
>   random: Fix whitespace pre random-bytes work
>   random: Return nbytes filled from hw RNG
>   vsprintf: Use hw RNG for ptr_key
> 
>  drivers/char/random.c  | 19 ++++++++++---------
>  include/linux/random.h |  2 +-
>  lib/vsprintf.c         | 19 ++++++++++++++++---
>  3 files changed, 27 insertions(+), 13 deletions(-)
> 
