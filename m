Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520959188; cv=none;
        d=google.com; s=arc-20160816;
        b=ltQ/UAm5LzKvmT2yNLd+lwJ+npX5h+/DpN96XQiZE5INM9gFwBShtNRUfZ4vAL4Lz8
         krWykT+nJMACNfmbiVVGpsJQdLYXLYR3adp7PA1W5fmWBg8RYcoe3j/AvFNSVBC0eLKt
         yJ6o9TRI0HZMtm7AFZUEMm7CXtHCUf/wXe8SEDZYtbwfayBhBkEK55Oqbxhk1kHGiNYI
         xPOqjmyce53UC+E8F/3a028Mb5VGGuw56cIzIpoE2kk9riKiZYIc2gMVEGHAiiZkgBTS
         Tpzm2X1EEx2nZzKz9YxvHwgycQlFGfHTExmpD/uKauGlPg4GTIdQZC2j928iKnuLLRDf
         DCng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=achoZEZ1KvVp+nKjWNHUrfgF8IHVoA1V+jQch3tOHE0=;
        b=fskK8ogwEa6WX6lswa7gqs8SQcWOw+8L3x1+S7nulY6HWDBkM9fjs2L3pRBSJnUI1N
         3rqbifnDZM/rX7HumG/1T6K7m5x+OADriBPXDtguHDJkEZ3h2kSrs4IrXex2STaXBLmB
         sJDgndSV78kehJy1oGEoJnU4ZprJdMHah/FQIG6Px0hF5H+TPs53W37lYiOfiApXqcc5
         WlsqUFLdyvMAYFxddjxaqbZTED1SfEnDl+esH5ihXq3RkIdHza/ztkzLnkvoK0mHlm2D
         ut9AvpfotWvTthww5qdr89EqHClK/uB/ncV+InyXVrAJoGVzWRfk3I7fSRdEmRVianCC
         lyxQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TKSOSOAX;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TKSOSOAX;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELupGHOvWU35i81rrsIbAZbe9ugR8kx0o34VwQ/KR7xhF2Oyx5JTyiYeWyXjcEWTefXManYagLiVyz7qgVMXXtA=
MIME-Version: 1.0
In-Reply-To: <1520239666-2964-1-git-send-email-opensource.ganesh@gmail.com>
References: <1520239666-2964-1-git-send-email-opensource.ganesh@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Mar 2018 18:39:47 +0200
Message-ID: <CAHp75VeNco97BovnVTcd=RH9zsK_gO=jmPALytP-sTFjK5Cq0Q@mail.gmail.com>
Subject: Re: [PATCH v2] PM / wakeup: use seq_open() to show wakeup stats
To: Ganesh Mahendran <opensource.ganesh@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, "Brown, Len" <len.brown@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594086852232118519?=
X-GMAIL-MSGID: =?utf-8?q?1594841302149972083?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 5, 2018 at 10:47 AM, Ganesh Mahendran
<opensource.ganesh@gmail.com> wrote:
> single_open() interface requires that the whole output must
> fit into a single buffer. This will lead to timeout when
> system memory is not in a good situation.
>
> This patch use seq_open() to show wakeup stats. This method
> need only one page, so timeout will not be observed.

> +       if (n == 0) {
> +               seq_puts(m, "name\t\tactive_count\tevent_count\twakeup_count\t"
> +                       "expire_count\tactive_since\ttotal_time\tmax_time\t"
> +                       "last_change\tprevent_suspend_time\n");
> +       }

Can't you do this once at ->open() stage, for example?

>  static int wakeup_sources_stats_open(struct inode *inode, struct file *file)
>  {
> -       return single_open(file, wakeup_sources_stats_show, NULL);
> +       return seq_open_private(file, &wakeup_sources_stats_seq_ops, sizeof(int));
>  }

-- 
With Best Regards,
Andy Shevchenko
