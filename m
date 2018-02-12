Return-Path: <ulf.hansson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1518439253; cv=none;
        d=google.com; s=arc-20160816;
        b=fUHSh2iKzn4aSa0DKy0YzjbgcOdZcWc7gHu0EvlYsTr148VX1WBdVWzV7r45eQjdJV
         Mmbcl8HQ2w2W7qd1uMIk44RTyNUcRiwP9wd0PhINlK382mP7hJ4M5MvOuEnsZr5jys5z
         wtlqG26HbxoUU8qnYW6oUXZhoJOf8Sjaz+SA7JA14J7/KzN/Pg05qF0ftdfpA9f1ZU8F
         nak9dPkPb+7aa778S9dudY+WJ3E+n8qE7QoICoCU+81xLLj6iGbxHVvJxO5zryu/0YyM
         HIUPFYGKOMpT7NV3GySdU/sZ5oTAZijpp21bCpsQ4yRlix/rvtxbIa2ig2KTo9+PUWqo
         zB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=L9eVk3z5QizEAcSEd5vblAwHxyjDXg0Y9mgfHUR4xMo=;
        b=c7VGjeux4WZSxoaaQ4h+RdvmwdgEWPPyTPNBBQ1fR+ZC2dE5dzWELz8C2SP33p+Ydd
         FV/tEkvbgkpqOiKOVQTkQLpOIIRYbHKxNcJQvr0JmuJQumFTYkjluAZdbdEJk2Q1py6Z
         HIUqjAPC1CfdpIQO6qubfDQiRqxRizDycX44xsF90WvisNUmrI0J/MXqYTPKnxMR4Wik
         waa/SwWrrsfTsD3BQh2274Yv4Ij41nYr/blCV5vkaulOAUCqvjMtQXj9/Qr6uQLb84RP
         VzATcCrH3uTr/o7OKt4ds/DUdptAZYP7YLBsEvYKLL9l01hgr4qqJKL5xn+ZLjePTHZQ
         T+Tg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=RsU7LUV4;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=RsU7LUV4;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AH8x227vs9gUaeLH3JPZGN7bi5X1Uolgn5hVFQz9o3KM0ocRZ5U8AdFMq3AUSYDty0isqnbS81AxnDRt5F17SxWqbfI=
MIME-Version: 1.0
In-Reply-To: <1518431893.2744.1.camel@pengutronix.de>
References: <1516955899-31810-1-git-send-email-baijiaju1990@gmail.com>
 <CAPDyKFoft7aCoKtODz66AAjpDQELVhqGurFYBV6FHP9hzhy-Ug@mail.gmail.com> <1518431893.2744.1.camel@pengutronix.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 12 Feb 2018 13:40:52 +0100
Message-ID: <CAPDyKFo9sjavrNP4DbTkn4yX1WeOD_5EJJEcwFkHBt+Ag8OV-A@mail.gmail.com>
Subject: Re: [PATCH] base: power: domain: Replace mdelay with msleep
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Jia-Ju Bai <baijiaju1990@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM <linux-pm@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590643262439305991?=
X-GMAIL-MSGID: =?utf-8?q?1592198959178258299?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 12 February 2018 at 11:38, Lucas Stach <l.stach@pengutronix.de> wrote:
> Am Freitag, den 09.02.2018, 14:58 +0100 schrieb Ulf Hansson:
>> On 26 January 2018 at 09:38, Jia-Ju Bai <baijiaju1990@gmail.com>
>> wrote:
>> > After checking all possible call chains to genpd_dev_pm_detach()
>> > and
>> > genpd_dev_pm_attach() here,
>> > my tool finds that these functions are never called in atomic
>> > context,
>> > namely never in an interrupt handler or holding a spinlock.
>> > Thus mdelay can be replaced with msleep to avoid busy wait.
>> >
>> > This is found by a static analysis tool named DCNS written by
>> > myself.
>> >
>> > Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> > ---
>> >  drivers/base/power/domain.c |    4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/base/power/domain.c
>> > b/drivers/base/power/domain.c
>> > index 0c80bea..f84ac72 100644
>> > --- a/drivers/base/power/domain.c
>> > +++ b/drivers/base/power/domain.c
>> > @@ -2144,7 +2144,7 @@ static void genpd_dev_pm_detach(struct device
>> > *dev, bool power_off)
>> >                 if (ret != -EAGAIN)
>> >                         break;
>> >
>> > -               mdelay(i);
>> > +               msleep(i);
>>
>> This looks like a nice improvement, however moving to msleep() makes
>> the call to cond_resched() below a bit superfluous. Perhaps remove
>> that as well.
>
> At least for small values of i, msleep also has a high chance to
> overshoot the desired sleep by a lot. It would be better to convert
> them to usleep_range with an acceptable slack.

Ack!

[...]

Kind regards
Uffe
