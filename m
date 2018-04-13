Return-Path: <SRS0=YbhT=HC=goodmis.org=rostedt@kernel.org>
X-Google-Smtp-Source: AIpwx49WBH2Ltn2ReX5K3jk/P1KEV5fFTPu55AuW8mumxWFDVOvv/Z/8lvOYGzktP70jsptqKp+d
ARC-Seal: i=1; a=rsa-sha256; t=1523641833; cv=none;
        d=google.com; s=arc-20160816;
        b=WCcXZ0bSedeKCDObw8n2CxlNbf+rfYyQ+dSzumA9Nq/KNu8lCFeNFXBQNhZtfaJ1lr
         HlKPwBDUdE43Ffrpw1OKd5tmB4lR6KPYtFBFaHZz8c3yhq5rBepoB7F/1SSOVZIAJ+Oh
         YNli6/ieC/MxZGQKucB7sddF6RehXdzJW28IG33gFeAblBEdaTadzM6v5eqQM0tdKWa6
         DDzaywhF2Fdokx/rurM+3i/yTJmV/17ZPvn7A+Hmlrb71oAaOyuwmvKxLOiKGf2KZ65V
         VorETvoL0N7ICBPQXxq6D90ubPROCFDcX32URumcc1lEf6cX3SJSh7k3iJerkGR22KG9
         K9GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=z5bTA1jyP+RxeDNqBYbblg8J8yzS9EbcalZH1QJsIWM=;
        b=flH0H1DP71Cxt/u/1d0q0PBmC8/kAAtQOXKaAiMwbgCfXTBDuyu3d2SN15XmsIcSvz
         zuSf/I82OmSpigMZdY24wLyEFkgpLhUFXKYZfNWxDthU2VJQCZ2j5Cp4JahctmHc5qZ5
         bY9yfEbHTBKQOo/hLpK6IEU6wYL5kulWhHAYGZ5x99ZCplse3Ee+4i8MjT96fmSCoYF+
         DVLYCHWgMpBxxbqR5ivEdwxVz4352RCl+VqxJfop5z3n351CFCDgjLD5q52T9jrWYdEI
         c7DXDxSJrN63MJOdgDJYyUVJUAWapSelYJWcnAyNW719lUxCS7Iq3pLxYPmantxMhxj1
         0o2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=ybht=hc=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=YbhT=HC=goodmis.org=rostedt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=ybht=hc=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=YbhT=HC=goodmis.org=rostedt@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2919A21771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 13 Apr 2018 13:50:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Steffen Maier <maier@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, Ingo Molnar
 <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>, Li Zefan
 <lizefan@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 0/2] tracing/events: block: bring more on a par with
 blktrace
Message-ID: <20180413135029.05163827@gandalf.local.home>
In-Reply-To: <20180413163623.11282-1-maier@linux.ibm.com>
References: <20180413163623.11282-1-maier@linux.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597636479596160991?=
X-GMAIL-MSGID: =?utf-8?q?1597654259578469412?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 13 Apr 2018 18:36:20 +0200
Steffen Maier <maier@linux.ibm.com> wrote:

> I had the need to understand I/O request processing in detail.
> But I also had the need to enrich block traces with other trace events
> including my own dynamic kprobe events. So I preferred block trace events
> over blktrace to get everything nicely sorted into one ftrace output.
> However, I missed device filtering for (un)plug events and also
> the difference between the two flavors of unplug.
>=20
> The first two patches bring block trace events closer to their
> counterpart in blktrace tooling.
>=20
> The last patch is just an RFC. I still kept it in this patch set because
> it is inspired by PATCH 2/2.
>=20
> Changes since v1:
> [PATCH v2 1/2]
> Use 0 and 1 instead of false and true for __print_symbolic table.
> Now "trace-cmd report" can decode it. [Steven Rostedt]
>=20
> Steffen Maier (3):
>   tracing/events: block: track and print if unplug was explicit or
>     schedule
>   tracing/events: block: dev_t via driver core for plug and unplug
>     events
>   tracing/events: block: also try to get dev_t via driver core for some
>     events
>=20
>  include/trace/events/block.h | 33 ++++++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)
>=20

=46rom just the tracing point of view:

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

as for the race conditions in the block layer, I'll let someone else
decided that.

-- Steve
