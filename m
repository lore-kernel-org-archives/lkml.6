Return-Path: <l.stach@pengutronix.de>
X-Google-Smtp-Source: AH8x2243NymiAH+LRNL0gbaj+cSxB5TjPXj/sMIXaQUHI/veaxe/tP+C8DuNg9K17nqrmvEcU7AD
ARC-Seal: i=1; a=rsa-sha256; t=1518431904; cv=none;
        d=google.com; s=arc-20160816;
        b=HKOATw5/rA14uG3blez+d6C8IkcO7mBOKYEt+5XES2IwMUlPLG26RQ0Xlro9b7CUUZ
         IKAOqaqm/Nj11+AGcWIJ/pPgi2u4M/Lx1OjZrExfPfipQ720/RcMIaw0qF1On953ntXl
         1YgsSkF4AvyD4h2eNG4KQiHTPnLbw4e+27qQPxHB1mT9Fwol9mRJtEMZotzPpCYia6nR
         tJSwgk2tO0QWc65thEvElpgYcYtIqbdB3uaTv/oZ4sleQa8AXdHG+TwOXGBcIjgPCNm7
         esxA4H32fxZ5BVZ0R29JHiIcf2LAlYm9c4tbhtQLSaH0Fh8cH9w/3Pj1Y9tKJesOmRus
         MaVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=90JOzHh9LTnC2Zov/ZadPtGXAS2HAoNaX3wMq3ISpLk=;
        b=lWzj/jSkZz9b3B/LH0NOzDKtUZ+z/Yo73Pf3U2PnqqlkPkWzYL+Q2VDwMGkZr6B6z3
         vscFgtdGIIJk5E0dYMSMWj2ZbiwX5a+fG3CtkjgbdOgbjDN6a3MdHhd5zGen7lQ45iCw
         LbUPvJ/IAoZOXBq3+QFu8+y/Q1x7TGqvaf5PeP4Lstcz82NwJ/WNtwqPOHpG5R1H2mhK
         AJfmECIZ/Or5ww815dO0tuSI+KF7mJdOgEBcgusIebmu+hGfhA1AGH+FDfis0MxWf/Vn
         Mbob3PC6yryqJuwJ+kjTRyrDpuLqp4YPphvUtBmyCMYVIcT+Uc/QmAVsr63Cj/YHEjy1
         TGWA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of l.stach@pengutronix.de designates 2001:67c:670:201:290:27ff:fe1d:cc33 as permitted sender) smtp.mailfrom=l.stach@pengutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of l.stach@pengutronix.de designates 2001:67c:670:201:290:27ff:fe1d:cc33 as permitted sender) smtp.mailfrom=l.stach@pengutronix.de
Message-ID: <1518431893.2744.1.camel@pengutronix.de>
Subject: Re: [PATCH] base: power: domain: Replace mdelay with msleep
From: Lucas Stach <l.stach@pengutronix.de>
To: Ulf Hansson <ulf.hansson@linaro.org>, Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman
 <khilman@kernel.org>,  Len Brown <len.brown@intel.com>, Pavel Machek
 <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM
 <linux-pm@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Date: Mon, 12 Feb 2018 11:38:13 +0100
In-Reply-To: <CAPDyKFoft7aCoKtODz66AAjpDQELVhqGurFYBV6FHP9hzhy-Ug@mail.gmail.com>
References: <1516955899-31810-1-git-send-email-baijiaju1990@gmail.com>
	 <CAPDyKFoft7aCoKtODz66AAjpDQELVhqGurFYBV6FHP9hzhy-Ug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:fa0f:41ff:fe58:4010
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: gregkh@linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590643262439305991?=
X-GMAIL-MSGID: =?utf-8?q?1592191252904483155?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am Freitag, den 09.02.2018, 14:58 +0100 schrieb Ulf Hansson:
> On 26 January 2018 at 09:38, Jia-Ju Bai <baijiaju1990@gmail.com>
> wrote:
> > After checking all possible call chains to genpd_dev_pm_detach()
> > and
> > genpd_dev_pm_attach() here,
> > my tool finds that these functions are never called in atomic
> > context,
> > namely never in an interrupt handler or holding a spinlock.
> > Thus mdelay can be replaced with msleep to avoid busy wait.
> > 
> > This is found by a static analysis tool named DCNS written by
> > myself.
> > 
> > Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> > ---
> >  drivers/base/power/domain.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/base/power/domain.c
> > b/drivers/base/power/domain.c
> > index 0c80bea..f84ac72 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -2144,7 +2144,7 @@ static void genpd_dev_pm_detach(struct device
> > *dev, bool power_off)
> >                 if (ret != -EAGAIN)
> >                         break;
> > 
> > -               mdelay(i);
> > +               msleep(i);
> 
> This looks like a nice improvement, however moving to msleep() makes
> the call to cond_resched() below a bit superfluous. Perhaps remove
> that as well.

At least for small values of i, msleep also has a high chance to
overshoot the desired sleep by a lot. It would be better to convert
them to usleep_range with an acceptable slack.

Regards,
Lucas

> >                 cond_resched();
> >         }
> > 
> > @@ -2231,7 +2231,7 @@ int genpd_dev_pm_attach(struct device *dev)
> >                 if (ret != -EAGAIN)
> >                         break;
> > 
> > -               mdelay(i);
> > +               msleep(i);
> 
> Ditto.
> 
> >                 cond_resched();
> >         }
> >         mutex_unlock(&gpd_list_lock);
> > --
> > 1.7.9.5
> > 
> 
> Kind regards
> Uffe
