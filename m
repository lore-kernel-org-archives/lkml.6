Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AIpwx49IHqitOXJjyaASQW2IUmsHTpBlvMrW1+XDNT0G3OAqL7e8DOK0rPmO0w8QaAZgfNX/lcO2
ARC-Seal: i=1; a=rsa-sha256; t=1524159527; cv=none;
        d=google.com; s=arc-20160816;
        b=vn4EVgxAnuACQRjy6EXLu0jMO4CLINBW3fMSzGYwLAJL7wRKYmoiF6VtTjSdCIN8/G
         EOic5UXWF7hnhn+5FZDDz08aLfihnhh+3gkYd69fRl+aNQIBeLKyLRar1W6c2LqxZ0Eb
         lnYBExpUYM4GycX/bjLeo+Fc+AokwD6/OY5TUvVaxTTHaCoOBZOjtI1XTunYgY/P1dtw
         tKBZyqbx0qWnjOUqidM/pbz1+mS1zEN0pKKxfw0dlGjmJTiMeYrsauAjJz8BDM/TAGoe
         SYCQi+cyHtNVgAg162ec/pyUuLUkEKFXD/gr9iKcv45Sbh2kqpUJwH/G9SNhJBh6MnE/
         NvzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=Dk6462GzuCFEhnRswTQtZ5oijRV9dSfP8TrI6aPTKrQ=;
        b=sCraRFT6XFbPW2btxj5Pya2iiF0a16IrfdqZuV/1hf6ZZEqdEuJkpILZ0Ufzb6Fq5t
         ITPBFH4xppX8VcmMXv6P8FoRXy5Oc8AclragUZMlYizqO3bMx1QGx/ZrWChBHlg7memY
         RiOGGL8CRyEiTBT7Xs1GgQvoYaXaz4SRopcVjt0bxKLJDcV/Sf/ia0kqdF9Ma2ALYNbQ
         ghVFHBQAcf6YBOsVuya+UqoHz1nOb5SJh3pxO5Wp2KMcyMbydFPYGXD4kybz2Bt5A7vY
         6fNCq2asm1L9mszKPT+ALXs2cLoyWB2+yTCk2J3COxaw9AqgC2f1zZR9qGob0TiudTdz
         hYYg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=e9PajVC+;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=e9PajVC+;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH] proc/stat: Separate out individual irq counts into
 /proc/stat_irqs
To: Waiman Long <longman@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
References: <1524157769-30775-1-git-send-email-longman@redhat.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3b8d1463-a671-add0-9b92-51e7518f1c07@infradead.org>
Date: Thu, 19 Apr 2018 10:38:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524157769-30775-1-git-send-email-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598195278130024579?=
X-GMAIL-MSGID: =?utf-8?q?1598197101109344286?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/19/18 10:09, Waiman Long wrote:
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
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  fs/proc/stat.c | 48 +++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 41 insertions(+), 7 deletions(-)

Also please update Documentation/filesystems/proc.txt.

thanks,
-- 
~Randy
