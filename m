Return-Path: <akpm@linux-foundation.org>
X-Google-Smtp-Source: AIpwx4+M+TCT0WmNqEo2wP5uF5Dnd7835nYCtKYgYu8rKt2eIvElPmMm5ogXCTIkkraWOttIh2Kd
ARC-Seal: i=1; a=rsa-sha256; t=1524167000; cv=none;
        d=google.com; s=arc-20160816;
        b=IKAUT/vWzeQAo9EFJ5/gow2Qt7w8XVikAs4dPPx0pdqscfqD9+tl903znWFlnKzXG1
         xyRSH74HC4XWv7ZvyuComdO3WTsSbBbOr/AFiLZGrYn6GBuaCaRibs1+4835HSZ0wA47
         9LItH8K8z3tC9aPCddHT5i7tMYOhFZVBzsqadGnarQIKMZChHdPAwk7xf6sVgqirqNTc
         RbrRt+DhYlOFulEUx3D50tWFMnBC3s36KQRsBKgtrH4LOhx1DhJR1ObaD6086p7uBZG6
         b71bJipPhBPIDoOmQ0gINVzyEwUbBXitT1bLM9V2S+pVE80DAfRkHmC/3HsUkhfG6o8d
         XnVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=34b9dmm9XWetYnpFDTFYmW85l6PRdv+m6RSyFD10fFA=;
        b=MRsfrVBzu5qSXyF7v4uB0Fq1AU2TIodS7LNMZQl2jrVWL8zO0dLsP7NIW4wNLkIadV
         ip3y5PiXPHiWZzToFGosBaSdjgIgNchvJsZxBFBfFUSJhtTgDbuljF/s4Trpb1pSlARQ
         uyhY9wGUSgTIbRE9IntSB3CFqG0oQxTEVF0p+9gPYS75vYTytEew4icMyTziMQk2BFx3
         szKceNNqpuT2p+g12aZoArvBqnbztTt4Zlscd6RCvs1KuTSE7SOfSvff/Yy0UPq1iCUm
         f1S8Dsu/8e8jNMhtGbdLLOGHJBx6cyYivguixxsJ6X7YBx+fpkCvC92VGBqBhsX0ei3K
         DIug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.71 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.71 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Date: Thu, 19 Apr 2018 12:43:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Waiman Long <longman@redhat.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Thomas Gleixner
 <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] proc/stat: Separate out individual irq counts into
 /proc/stat_irqs
Message-Id: <20180419124319.8e329eb25234c045bf161cd5@linux-foundation.org>
In-Reply-To: <1524157769-30775-1-git-send-email-longman@redhat.com>
References: <1524157769-30775-1-git-send-email-longman@redhat.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598195278130024579?=
X-GMAIL-MSGID: =?utf-8?q?1598204937014853902?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 19 Apr 2018 13:09:29 -0400 Waiman Long <longman@redhat.com> wrote:

> It was found that reading /proc/stat could be time consuming on
> systems with a lot of irqs. For example, reading /proc/stat in a
> certain 2-socket Skylake server took about 4.6ms because it had over
> 5k irqs. In that particular case, the majority of the CPU cycles for
> reading /proc/stat was spent in the kstat_irqs() function.  Therefore,
> application performance can be impacted if the application reads
> /proc/stat rather frequently.
> 
> The "intr" line within /proc/stat contains a sum total of all the irqs
> that have happened followed by a list of irq counts for each individual
> irq number. In many cases, the first number is good enough. The
> individual irq counts may not provide that much more information.
> 
> In order to avoid this kind of performance issue, all these individual
> irq counts are now separated into a new /proc/stat_irqs file. The
> sum total irq count will stay in /proc/stat and be duplicated in
> /proc/stat_irqs. Applications that need to look up individual irq counts
> will now have to look into /proc/stat_irqs instead of /proc/stat.
> 

(cc /proc maintainer)

It's a non-backward-compatible change.  For something which has
existing for so long, it would be a mighty task to demonstrate that no
existing userspace will be disrupted by this change.

So we need to think again.  A new interface which omits the per-IRQ
stats might be acceptable.

Or, conceivably, a new /proc knob which disables the per-IRQ stats in
/proc/stat.  That would allow operators to opt in to this disabling and
would avoid the need to alter
whatever-application-it-is-that-is-having-trouble.  This seems a bit ugly
though.

Also, the changelog is rather vague.  "application performance can be
impacted".  Well, *are* applications impacted?  What is the real-world
performance gain which this change provides, in a real-world workload?
