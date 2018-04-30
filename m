Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754654AbeD3Sir (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 14:38:47 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:42424 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754104AbeD3Sip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 14:38:45 -0400
X-Google-Smtp-Source: AB8JxZruoi6vZYy/NhAWA2AqWHEHGEDYRXv+M/mxsHCZ2o0vUMJXqZCM8IfyJ3odhkcQEjjYRHnATjcNl1Bq01YFbas=
MIME-Version: 1.0
In-Reply-To: <CA+55aFyNqnrM=_5pMgEeL20jVKN7MgWKG52pbaR0FayO=5VuXw@mail.gmail.com>
References: <alpine.DEB.2.20.1804301741570.3243@hypnos.tec.linutronix.de>
 <CAGXu5jL1W=AC023asgeMRUXAnhU2vd-RJRqGtOOetQ=aXwDcFQ@mail.gmail.com>
 <CA+55aFwieC1-nAs+NFq9RTwaR8ef9hWa4MjNBWL41F-8wM49eA@mail.gmail.com>
 <20180430124135.0cce92e3@gandalf.local.home> <CA+55aFzpJC4+tuSopeze72D2sv1urGdap8+Bj2Y9hEYitAkE4Q@mail.gmail.com>
 <CA+55aFyNqnrM=_5pMgEeL20jVKN7MgWKG52pbaR0FayO=5VuXw@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 30 Apr 2018 11:38:42 -0700
X-Google-Sender-Auth: 9s89w1C9chvQ-nItNmKQE7VeG_Q
Message-ID: <CAGXu5jLVJxDJcbhrQU5-wduaP+OvePXP8VvCFMrJ47pYD-zaXg@mail.gmail.com>
Subject: Re: Hashed pointer issues
To: Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C. Harding" <me@tobin.cc>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 10:01 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Apr 30, 2018 at 9:57 AM Linus Torvalds <
> torvalds@linux-foundation.org> wrote:
>
>> Although in *practice* we'd have tons of entropy on any modern development
>> CPU too, since any new hardware will have the hardware random number
>> generation. Some overly cautious person might not trust it, of course.
>
> In fact, maybe that's the right policy. Avoid a boot-time parameter by just
> saying
>
>   "if you have hardware random number generation, we can fill entropy
> immediately"

Something like this? (Untested.)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 30c0cb8cc9bc..2d8615f14dc9 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1672,9 +1672,8 @@ char *pointer_string(char *buf, char *end, const
void *ptr,
 static bool have_filled_random_ptr_key __read_mostly;
 static siphash_key_t ptr_key __read_mostly;

-static void fill_random_ptr_key(struct random_ready_callback *unused)
+static void ptr_key_ready(void)
 {
-       get_random_bytes(&ptr_key, sizeof(ptr_key));
        /*
         * have_filled_random_ptr_key==true is dependent on get_random_bytes().
         * ptr_to_id() needs to see have_filled_random_ptr_key==true
@@ -1684,14 +1683,28 @@ static void fill_random_ptr_key(struct
random_ready_callback *unused)
        WRITE_ONCE(have_filled_random_ptr_key, true);
 }

+static void fill_random_ptr_key(struct random_ready_callback *unused)
+{
+       get_random_bytes(&ptr_key, sizeof(ptr_key));
+       ptr_key_ready();
+}
+
 static struct random_ready_callback random_ready = {
        .func = fill_random_ptr_key
 };

 static int __init initialize_ptr_random(void)
 {
-       int ret = add_random_ready_callback(&random_ready);
+       int ret;
+
+       /* If we have hw RNG, start hashing immediately. */
+       if (arch_has_random()) {
+               get_random_bytes_arch(&ptr_key, sizeof(ptr_key));
+               ptr_key_ready();
+               return 0;
+       }

+       ret = add_random_ready_callback(&random_ready);
        if (!ret) {
                return 0;
        } else if (ret == -EALREADY) {


>
> No kernel command line needed in practice any more. That's assuming any
> kernel developer will have an IvyBridge or newer.
>
> The "I don't trust my hardware" people can still disable that with
> "nordrand".
>
> Hmm?
>
>                     Linus



-- 
Kees Cook
Pixel Security
