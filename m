Return-Path: <robh+dt@kernel.org>
X-Google-Smtp-Source: AG47ELsXA3cfiL2YzxH5GAdXRmgejoWxLgFB8NdHB9ldYYZELyZAGIIl7M1kaFtnk5lS5QSG7GN+
ARC-Seal: i=1; a=rsa-sha256; t=1520342976; cv=none;
        d=google.com; s=arc-20160816;
        b=eCrgd6SoeyUlOlZcWZNfF/lqcrxZ7s/eDsQb5H5U9LJNwi9PsuzHNvZXqlL33pEt2l
         Wd70JxB3ZQvByA0GNkUwwO91wjH/wSej2v2GKWi0bFK/klnaG0CnS7k0Ixnxms0ZpnHm
         Ni6DILMGiJQRb/aoKIc/M9+F8EsKIisLLVE7tUqwlUfEob3fEFLIGGcZTJfhtduAu339
         8PkYCE5f+Zl0piowxLXe84OS66G5JXh5vzEzV308WI5Oi7srNYcHLe3CaqC4kwcYVhaf
         37G9LQZs4zlqxKYnsRWD88ejLmeoHYOaMGfW/X6DjIgrJuXuL8roDfsEDqJGZUB3bqgY
         srmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=0siqNWPnJjlA4zrfs/WAw/yT/IQQY6myWviTo6JlC8g=;
        b=o/x1lIjmjllCweFka5i2PPerA+PqXoWocRXzVRU47DAGVfA7fJP9LFr4cz748Qfnsq
         2URDqX/gyfYwNFXOgcZi/vmTbgOcUWuqF0aD3zAF6MLjah5dAeK8C94eVaQrm0x0RpCH
         hwgzKLcCXSiJIV/pO+8kE6MqafPsPvub7APO9FSJkpo8TnX5DutcGE3MQWMLTbwdK/A4
         J1c6ZYpenKglAXdfHBQswWxIFRKZtMQDhy6mn7mQfQYhw8vp+BCYHNLKfUCj/iYzNQMD
         Q3tNfAr/H3O50t1pnjC8VuOOhaLch7RiRpY+yuTXv/xqmUtpTfhHcrnXkwFmdEDYcCWd
         UiHw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of robh+dt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh+dt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of robh+dt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh+dt@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B36E2179F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
MIME-Version: 1.0
In-Reply-To: <1520323650-11030-4-git-send-email-patrice.chotard@st.com>
References: <1520323650-11030-1-git-send-email-patrice.chotard@st.com> <1520323650-11030-4-git-send-email-patrice.chotard@st.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 6 Mar 2018 07:29:15 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJv-FV4T8=+py2EEr4kipnQikJPhDKkDdvkAab2QTgBzg@mail.gmail.com>
Message-ID: <CAL_JsqJv-FV4T8=+py2EEr4kipnQikJPhDKkDdvkAab2QTgBzg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] tty: st-asc: Update tty alias
To: Patrice Chotard <patrice.chotard@st.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594174915502764084?=
X-GMAIL-MSGID: =?utf-8?q?1594195157414432203?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 6, 2018 at 2:07 AM,  <patrice.chotard@st.com> wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
>
> Since dtc v1.4.6-9-gaadd0b65c987, aliases property name
> must include only lowercase and '-'.
>
> After having updated all STi boards serial aliases from "ttyASN"
> to "serialN", st-asc driver need to be updated accordingly as tty
> aliases id is retrieved using of_alias_get_id(np, ASC_SERIAL_NAME);

Again, changing the tty name breaks userspace. You can't do that.

You need to do something like this:

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index c763253514e9..5f9f01fac6dd 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -782,7 +782,9 @@ static struct asc_port *asc_of_get_asc_port(struct
platform_device *pdev)
        if (!np)
                return NULL;

-       id = of_alias_get_id(np, ASC_SERIAL_NAME);
+       id = of_alias_get_id(np, "serial");
+       if (id < 0)
+               id = of_alias_get_id(np, ASC_SERIAL_NAME);

        if (id < 0)
                id = 0;
