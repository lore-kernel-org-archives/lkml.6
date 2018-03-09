Return-Path: <kernel-hardening-return-12291-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvSlWyKqHYyOuVNs5cz7VdhU0VQz0n+S0dbWWLIxT9WKVpr5OQ56apbhqtBK3A0RPCepUcR
ARC-Seal: i=1; a=rsa-sha256; t=1520571372; cv=none;
        d=google.com; s=arc-20160816;
        b=irZXON2VOiAgMvGrOfLEuxbqZTpxLWnTu84SYkT2hZkiWzm5sfW0Hc4BNFgSWZCDcn
         PmjF3sTrObW3876ahBzwWJSpKFC5ktCB5Q9tguMuBVMEe+/Lv3tPlEofJc89RC4yHw7W
         fkHu7mVQpy+RgqR34yrZxuCGPJyL0M7UgrYNZn6vtFMUFFfX/gE3cPeYqbVCU1ZBbrOH
         xLU8MSrQ6QqKyszEu2xHESbxTZ05FPH3BSZrztPHs/VOCtuvMw5WvnajcvIXc0xpeVuh
         yGVb9kTcQva3eBGl697MaactGGDgIBfjwNv1g+u1IW6FLphJoszWxJ/h2lICGvNT87Ly
         S+Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=30LVqgEMRJ1gVsvTFvLcUAx0zclJSro+0b8enUwt9sk=;
        b=WL74AsnsASo8JLIwuz909sTLaXIC5H6Y9zObzxUcXzT8PLEvrF4vQB/2oJXSnL5Na3
         vy0dHQzKWC597LTsRxGD5RIRnK4wyaC4ENwkSJ+GoUP1QLCbHWcqhZlGzkFzfXxsDtel
         WsO2Mdd+gf/x20q9pDh9y88BtKMxZE9JmWbrPyH94mqq7RkWmzjZqGBcho19Q+05OPAB
         Japni/olkO4gXQNy1FDdUhZuSH8xtfiol89jFGTzBXFYQc3nO6Dp8GYx9LihaU454QRf
         QMxcSz/K6QhqQjOyDYKVU1ehqHqytvK9OIDhuQYwViu85AmE+oqqiZ11V1rwY1Ncz12M
         F7Vw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=E3P0VBTU;
       dkim=pass header.i=@chromium.org header.s=google header.b=oOcu7fWc;
       spf=pass (google.com: domain of kernel-hardening-return-12291-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12291-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=E3P0VBTU;
       dkim=pass header.i=@chromium.org header.s=google header.b=oOcu7fWc;
       spf=pass (google.com: domain of kernel-hardening-return-12291-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12291-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180309033544.22509-1-tycho@tycho.ws>
References: <20180309033544.22509-1-tycho@tycho.ws>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 8 Mar 2018 20:55:50 -0800
X-Google-Sender-Auth: mfPnPpHr8rasg4F45jbBCWKFpzo
Message-ID: <CAGXu5j+XKejfPhUcEjCeqrveaq-knTEeTiWxh5VM8wX5iQmu+A@mail.gmail.com>
Subject: Re: [PATCH] md: get rid of a VLA
To: Tycho Andersen <tycho@tycho.ws>
Cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>, dm-devel@redhat.com,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	"Tobin C . Harding" <tobin@apporbit.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594429624503738722?=
X-GMAIL-MSGID: =?utf-8?q?1594434647503239966?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 8, 2018 at 7:35 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> Ideally, we'd like to get rid of all VLAs in the kernel and add -Wvla to
> the build args: https://lkml.org/lkml/2018/3/7/621
>
> This one is a simple case, since we don't actually need the VLA at all: we
> can just iterate over the stripes twice, once to emit their names, and the
> second time to emit status (i.e. trade memory for time). Since the number
> of stripes is probably low, this is hopefully not that expensive.
>
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> CC: Alasdair Kergon <agk@redhat.com>
> CC: Mike Snitzer <snitzer@redhat.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/md/dm-stripe.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
> index b5e892149c54..cd209e8902a6 100644
> --- a/drivers/md/dm-stripe.c
> +++ b/drivers/md/dm-stripe.c
> @@ -368,7 +368,6 @@ static void stripe_status(struct dm_target *ti, status_type_t type,
>                           unsigned status_flags, char *result, unsigned maxlen)
>  {
>         struct stripe_c *sc = (struct stripe_c *) ti->private;
> -       char buffer[sc->stripes + 1];
>         unsigned int sz = 0;
>         unsigned int i;
>
> @@ -377,11 +376,12 @@ static void stripe_status(struct dm_target *ti, status_type_t type,
>                 DMEMIT("%d ", sc->stripes);
>                 for (i = 0; i < sc->stripes; i++)  {
>                         DMEMIT("%s ", sc->stripe[i].dev->name);
> -                       buffer[i] = atomic_read(&(sc->stripe[i].error_count)) ?
> -                               'D' : 'A';
>                 }
> -               buffer[i] = '\0';
> -               DMEMIT("1 %s", buffer);
> +               DMEMIT("1 ");
> +               for (i = 0; i < sc->stripes; i++) {
> +                       DMEMIT("%c", atomic_read(&(sc->stripe[i].error_count)) ?
> +                              'D' : 'A');
> +               }
>                 break;
>
>         case STATUSTYPE_TABLE:
> --
> 2.14.1
>



-- 
Kees Cook
Pixel Security
