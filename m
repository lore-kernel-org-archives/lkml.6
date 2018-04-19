Return-Path: <adobriyan@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524168140; cv=none;
        d=google.com; s=arc-20160816;
        b=LM4m0KxCHmMvNJpcMUgHUqA1EqU42vo/zvzmMoYWvQ8DKh7ZAaw7uG7zKpdfkhcAal
         SD6OjBaUeOkk8aJUibF1bb1Z7dPyYfJQO6pbfU195k5yXkHaH0E9Q4B6qbghUgQb5+Mo
         fzOkQS3K5baXDc4krIdlKBvz9Ovm2Ls92AGidsffYMiO6yxyRJxhhcHk0UpXn6UtPUfp
         PZdcUO6TrqrSKvIM2Lu/Iuy9OS7Jal70rYrHLS33s+0X67wGPp2YkQH55XgZxTPjIeTL
         rGRgJb4ol0tyHpi2Ebs3/DgJltsNLnjt7oae1XWkDlaV4IbGsAFGfW7Xk+FbOdgDGgfP
         NbmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=diReYfGUUrH+aPyxMzyyQ5YbtdpXeuqKOJxG8fcykR0=;
        b=DZtOqWNSTCoEdLu8tVtszAuuIm2d2MksDRuU1NfenTVnWvvdUMIcQ28d04k5xXnuDa
         6hRWoakJJIq9+u48jqP+zIFxbTw6Tpc9jEGUuUF1W7DHdUZ1OPFztv8dEwC7nqSAHPiD
         USZJ8KQbhR4+F8IASccUZbMaEqXTAWYutfRIJKrY/W5lgD9JKlimakm6R+gLfDqWDzpC
         QKXCBmVMDLtPodgA8wMm1K+nVYqTgrZkv8dIbrbTARnkl363wsC+zW1vL/lnBnW6ED6N
         UfHHyypZju2eCLxomYownZJpYxV+39I2PNCBMeo5xuwJjmQ7y+pnCP4PMLtNLO3mvHph
         X/Qg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=vcidmzfy;
       spf=pass (google.com: domain of adobriyan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=adobriyan@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=vcidmzfy;
       spf=pass (google.com: domain of adobriyan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=adobriyan@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48ZDud5pcrUZZhVH6cFGfH7DzKWmJaPrQ1AtHWFDUjynJoupbQJJNJcO+OPNxKfIObx6gswgQ==
Date: Thu, 19 Apr 2018 23:02:17 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Waiman Long <longman@redhat.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc/stat: Separate out individual irq counts into
 /proc/stat_irqs
Message-ID: <20180419200217.GA4467@avx2>
References: <1524157769-30775-1-git-send-email-longman@redhat.com>
 <20180419124319.8e329eb25234c045bf161cd5@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180419124319.8e329eb25234c045bf161cd5@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598195278130024579?=
X-GMAIL-MSGID: =?utf-8?q?1598206132026944588?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 12:43:19PM -0700, Andrew Morton wrote:
> On Thu, 19 Apr 2018 13:09:29 -0400 Waiman Long <longman@redhat.com> wrote:
> 
> > It was found that reading /proc/stat could be time consuming on
> > systems with a lot of irqs. For example, reading /proc/stat in a
> > certain 2-socket Skylake server took about 4.6ms because it had over
> > 5k irqs. In that particular case, the majority of the CPU cycles for
> > reading /proc/stat was spent in the kstat_irqs() function.  Therefore,
> > application performance can be impacted if the application reads
> > /proc/stat rather frequently.
> > 
> > The "intr" line within /proc/stat contains a sum total of all the irqs
> > that have happened followed by a list of irq counts for each individual
> > irq number. In many cases, the first number is good enough. The
> > individual irq counts may not provide that much more information.
> > 
> > In order to avoid this kind of performance issue, all these individual
> > irq counts are now separated into a new /proc/stat_irqs file. The
> > sum total irq count will stay in /proc/stat and be duplicated in
> > /proc/stat_irqs. Applications that need to look up individual irq counts
> > will now have to look into /proc/stat_irqs instead of /proc/stat.
> > 
> 
> (cc /proc maintainer)
> 
> It's a non-backward-compatible change.  For something which has
> existing for so long, it would be a mighty task to demonstrate that no
> existing userspace will be disrupted by this change.
> 
> So we need to think again.  A new interface which omits the per-IRQ
> stats might be acceptable.

Here is profile of open+read+close /proc/stat

30% is taking mutex only to print "0".

+   98.80%     0.04%  a.out    [kernel.vmlinux]  [k] entry_SYSCALL_64                                                                            ▒
+   98.75%     0.10%  a.out    [kernel.vmlinux]  [k] do_syscall_64                                                                               ▒
+   95.56%     0.04%  a.out    libc-2.25.so      [.] __GI___libc_read                                                                            ◆
+   95.09%     0.01%  a.out    [kernel.vmlinux]  [k] sys_read                                                                                    ▒
+   95.04%     0.03%  a.out    [kernel.vmlinux]  [k] vfs_read                                                                                    ▒
+   94.98%     0.05%  a.out    [kernel.vmlinux]  [k] proc_reg_read                                                                               ▒
+   94.98%     0.00%  a.out    [kernel.vmlinux]  [k] __vfs_read                                                                                  ▒
+   94.92%     0.06%  a.out    [kernel.vmlinux]  [k] seq_read                                                                                    ▒
+   94.52%     3.65%  a.out    [kernel.vmlinux]  [k] show_stat                                                                                   ▒
+   48.62%     2.59%  a.out    [kernel.vmlinux]  [k] kstat_irqs_usr                                                                              ▒
+   33.52%     9.55%  a.out    [kernel.vmlinux]  [k] seq_put_decimal_ull                                                                         ▒
+   19.63%    19.59%  a.out    [kernel.vmlinux]  [k] memcpy_erms                                                                                 ▒
+   17.34%     9.53%  a.out    [kernel.vmlinux]  [k] kstat_irqs                                                                                  ▒
-   15.45%    15.43%  a.out    [kernel.vmlinux]  [k] mutex_lock                                                                                  ▒
     15.43% __GI___libc_read                                                                                                                     ▒
        entry_SYSCALL_64                                                                                                                         ▒
        do_syscall_64                                                                                                                            ▒
        sys_read                                                                                                                                 ▒
        vfs_read                                                                                                                                 ▒
        __vfs_read                                                                                                                               ▒
        proc_reg_read                                                                                                                            ▒
      - seq_read                                                                                                                                 ▒
         - 15.41% show_stat                                                                                                                      ▒
              kstat_irqs_usr                                                                                                                     ▒
              mutex_lock                                                                                                                         ▒
+   13.32%    13.27%  a.out    [kernel.vmlinux]  [k] mutex_unlock                                                                                ▒
+    4.60%     1.35%  a.out    [kernel.vmlinux]  [k] cpumask_next                                                                                ▒
+    3.03%     3.03%  a.out    [kernel.vmlinux]  [k] __radix_tree_lookup                                                                         ▒
+    2.96%     0.08%  a.out    [kernel.vmlinux]  [k] seq_printf                                                                                  ▒
+    2.92%     0.02%  a.out    libc-2.25.so      [.] __GI___libc_open                                                                            ▒
+    2.89%     0.07%  a.out    [kernel.vmlinux]  [k] seq_vprintf                                                                                 ▒
+    2.81%     0.70%  a.out    [kernel.vmlinux]  [k] vsnprintf                                                                                   ▒
+    2.66%     2.66%  a.out    [kernel.vmlinux]  [k] _find_next_bit                                                                              ▒
+    2.42%     1.36%  a.out    [kernel.vmlinux]  [k] num_to_str                                                                                  ▒
+    2.41%     0.19%  a.out    [kernel.vmlinux]  [k] get_idle_time                                                                               ▒
+    2.39%     0.02%  a.out    [kernel.vmlinux]  [k] do_sys_open
