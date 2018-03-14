Return-Path: <opensource.ganesh@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520991213; cv=none;
        d=google.com; s=arc-20160816;
        b=MqkIBh19MM3zwVXE6+TV3f744m40oQC9H23AEahfpSHG+45fWsXffVrN/RoAxNWFO/
         JUtS6TwZmhOvspZ/mhQxpeuZMaX7o0Y+RAgsR7SFYpVp5kNa20OoysRNQGxacJgsK7pg
         yUEGnbAFDxnbX4RXC24GVUa4aP08zCYOaGb/txUil69Jn9yNx2X5opNHIMFFasvfJQ0B
         kSexfKKQeno4U2sY3n4xlZlPD0O3ddMuVIUs4N29ZwUpdmKz8GiBS7AD+ywMLKgkCdm0
         nmmspBTIkk6oD5N9yzUkqxjNTQ272vM/7R5CwKn4qY0J2d+Ii9bUGH1/WHOeX/Px4V5S
         Gigg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=B4xWAAvZ20VWKZ3ZzbmJaq8fVwnRGp4/cb/IrBH6ZKY=;
        b=VnpQ7tSYx5E1O4A02br6R5XCjmS7tcoAVJ5sQxBr2okkuud5VrPLn4/FuhnuyGnOlY
         iQMDgDl1Ky3QgHpiCkS3ggfkgpEZwDYr6h66a+TCxzOUdFbWgBsAgzMGjAcdMVGzj0EU
         mhj3nTRK9+81OM47eVldGrDinjzSEhoXTTawO01z90UnbWO42kg8gv7IaUxcMmStBZOf
         ltF11o9JaWPNhY5TlstGj/UrIzBWnYtExaQP3f61q7Su82Tmuv02lhD3aI9Ljjp7Vd6U
         HxjUdJKbJNUI6b9hLdu/qSKaMK3rZpzE6ERENl4L+l6nt+Ziia0LIt/dex1Z+gC1zF0x
         axsw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CdC68qmF;
       spf=pass (google.com: domain of opensource.ganesh@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=opensource.ganesh@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CdC68qmF;
       spf=pass (google.com: domain of opensource.ganesh@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=opensource.ganesh@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvTRdfwJX9nOZd7Qof34mkaNxavtcppTMHrO+KO8O3QoYayj7Lh7ZuBC+ZJk8txJ3dBmuizIhFh+W1f4p356sE=
MIME-Version: 1.0
In-Reply-To: <CAHp75VeNco97BovnVTcd=RH9zsK_gO=jmPALytP-sTFjK5Cq0Q@mail.gmail.com>
References: <1520239666-2964-1-git-send-email-opensource.ganesh@gmail.com> <CAHp75VeNco97BovnVTcd=RH9zsK_gO=jmPALytP-sTFjK5Cq0Q@mail.gmail.com>
From: Ganesh Mahendran <opensource.ganesh@gmail.com>
Date: Wed, 14 Mar 2018 09:33:33 +0800
Message-ID: <CADAEsF__v8b01DAC9d8B93oJk3GiqEyfieSgM6kj9CfetXMqaQ@mail.gmail.com>
Subject: Re: [PATCH v2] PM / wakeup: use seq_open() to show wakeup stats
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, "Brown, Len" <len.brown@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594086852232118519?=
X-GMAIL-MSGID: =?utf-8?q?1594874883237319587?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi, Andy

2018-03-14 0:39 GMT+08:00 Andy Shevchenko <andy.shevchenko@gmail.com>:
> On Mon, Mar 5, 2018 at 10:47 AM, Ganesh Mahendran
> <opensource.ganesh@gmail.com> wrote:
>> single_open() interface requires that the whole output must
>> fit into a single buffer. This will lead to timeout when
>> system memory is not in a good situation.
>>
>> This patch use seq_open() to show wakeup stats. This method
>> need only one page, so timeout will not be observed.
>
>> +       if (n == 0) {
>> +               seq_puts(m, "name\t\tactive_count\tevent_count\twakeup_count\t"
>> +                       "expire_count\tactive_since\ttotal_time\tmax_time\t"
>> +                       "last_change\tprevent_suspend_time\n");
>> +       }
>
> Can't you do this once at ->open() stage, for example?

We can not put this at ->open(). Because in seq_open(), the buffer is
not ready,
the seq buffer is allocated in seq_read().

Thanks.

>
>>  static int wakeup_sources_stats_open(struct inode *inode, struct file *file)
>>  {
>> -       return single_open(file, wakeup_sources_stats_show, NULL);
>> +       return seq_open_private(file, &wakeup_sources_stats_seq_ops, sizeof(int));
>>  }
>
> --
> With Best Regards,
> Andy Shevchenko
