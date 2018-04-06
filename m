Return-Path: <aspriel@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523043335; cv=none;
        d=google.com; s=arc-20160816;
        b=qXlRwHIrdDvIlANxXdxtpBrXRx0qxoH7LyRtdlzpb62JV+EkIv7YBbqPZF3eyk0Ha2
         S8c0pns+W2/WKzDjIWFb7KJblbAgiNQ+pUMcbMm+0KqGFaNk1jFa5NtG5MlCEd7yZalD
         l2Mv5TeMgvPc66rPlxqP0YxtrEDvGq2bu4DhfsMSFekqH+k8lCK1CDyZKL7hqVXA950C
         D9PmojEB1jOboQA09DsqNkH9WGRZ21OOtOIMNhoLgMiz9RDFYzGMO0QW+SbUGRBXHh9D
         r3SWcem7SL7IauPsjCvKcxUfvG05kUvUmku+LPTPOdatdowLBfApA2cWLUiQqSEtfs+y
         B39g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=yJf2rd7q7h17RaozJewqS2I07rwQg7XEfBhCSo0BIM8=;
        b=fcbrTiDH+KwJ9D8mX/GjkoY63xoj7RfN6AVWKEUKl6SvbKW47/+N3p+90HQWC3vJoK
         vgG1K+qEkSq9w85lLDAnjcM8nUQAtdzLW6BEIgElEjU3KBc4m4ywypRSLYYBQq+jW7w8
         6P6ggBJfIaEfKyyeGWWOCE5lid7ovBxLmGPNzUq6BTtTsTXkYLXZovDxi+cE67q5PvAz
         OcsCqnqewpSKYqpg+JbI20d1YN3/QFblaxbWPoY1uMN3Ie4vly+h4VOKDjq01KpD2qIJ
         YqjbxWnKeFrFI4KHbBeRmudJYVTP8XOA2p8UJPC0xVJC5SBwxktdCySkTGaZxJyCdTlQ
         HoKQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=vA2Vj6HP;
       spf=pass (google.com: domain of aspriel@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aspriel@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=vA2Vj6HP;
       spf=pass (google.com: domain of aspriel@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aspriel@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx487OcrPIB2d1PHo15w+6iCIV0CkOgSiJ6S8rtUhBWFw9yke3kot6CL3UXPMCUCKziLlsUl/YxP6A/9EdRgE2P8=
MIME-Version: 1.0
In-Reply-To: <20180406144601.GA25567@kroah.com>
References: <1521107725-25027-1-git-send-email-aspriel@gmail.com>
 <1521107725-25027-3-git-send-email-aspriel@gmail.com> <20180323165543.GA21833@kroah.com>
 <CAJ65rDy1UjJ7tEu4f3m8BwnA1qai1iRU3yWfU4qvEE9uLrr5pg@mail.gmail.com>
 <20180324090446.GA863@kroah.com> <CAJ65rDw-gQKdsokwoC7+NskzTpLq=RLVbLQMh7CDisNFY3o8Uw@mail.gmail.com>
 <20180406144601.GA25567@kroah.com>
From: Arend van Spriel <aspriel@gmail.com>
Date: Fri, 6 Apr 2018 21:35:35 +0200
Message-ID: <CAJ65rDxQpe4J2qawRdXDz9nmp9FdPo0KoDHT4Tm4maZ034Np7g@mail.gmail.com>
Subject: Re: [PATCH for-4.16 2/3] drivers: change struct device_driver::coredump()
 return type to void
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594997067781625897?=
X-GMAIL-MSGID: =?utf-8?q?1597026689273151543?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Op vr 6 apr. 2018 4:46 PM schreef Greg Kroah-Hartman
<gregkh@linuxfoundation.org>:
>
> On Fri, Apr 06, 2018 at 12:13:38PM +0200, Arend van Spriel wrote:
> > On Sat, Mar 24, 2018 at 10:04 AM, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > On Sat, Mar 24, 2018 at 09:50:05AM +0100, Arend van Spriel wrote:
> > >> On Fri, Mar 23, 2018 at 5:55 PM, Greg Kroah-Hartman
> > >> <gregkh@linuxfoundation.org> wrote:
> > >> > On Thu, Mar 15, 2018 at 10:55:24AM +0100, Arend van Spriel wrote:
> > >> >> Upon submitting a patch for mwifiex [1] it was discussed whether this
> > >> >> callback function could fail. To keep things simple there is no need
> > >> >> for the error code so the driver can do the task synchronous or not
> > >> >> without worries. Currently the device driver core already ignores the
> > >> >> return value so changing it to void.
> > >> >>
> > >> >> [1] https://patchwork.kernel.org/patch/10231933/
> > >> >>
> > >> >> Signed-off-by: Arend van Spriel <aspriel@gmail.com>
> > >> >> ---
> > >> >>  include/linux/device.h | 5 ++++-
> > >> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> > >> >>
> > >> >> diff --git a/include/linux/device.h b/include/linux/device.h
> > >> >> index b093405..f08c25b 100644
> > >> >> --- a/include/linux/device.h
> > >> >> +++ b/include/linux/device.h
> > >> >> @@ -256,6 +256,9 @@ enum probe_type {
> > >> >>   *           automatically.
> > >> >>   * @pm:              Power management operations of the device which matched
> > >> >>   *           this driver.
> > >> >> + * @coredump:        Called when sysfs entry is written to. The device driver
> > >> >> + *           is expected to call the dev_coredump API resulting in a
> > >> >> + *           uevent.
> > >> >>   * @p:               Driver core's private data, no one other than the driver
> > >> >>   *           core can touch this.
> > >> >>   *
> > >> >> @@ -287,7 +290,7 @@ struct device_driver {
> > >> >>       const struct attribute_group **groups;
> > >> >>
> > >> >>       const struct dev_pm_ops *pm;
> > >> >> -     int (*coredump) (struct device *dev);
> > >> >> +     void (*coredump) (struct device *dev);
> > >> >
> > >> > Isn't this going to cause build warnings now?  Are there no users of
> > >> > this callback function yet?
> > >>
> > >> Hi Greg,
> > >>
> > >> I submitted driver patches for the 4.17 kernel and from that
> > >> discussion we concluded it would be good to change to void return
> > >> type. So those driver patches were dropped. The caller of the callback
> > >> in drivers/base/dd.c does not use the return value so from that side
> > >> there is no issue. So my motivation for asking to consider this for
> > >> 4.16 is so I can resubmit the driver patches for 4.17 if there is
> > >> still time before the merge window.
> > >
> > > It's too late for 4.16 for this, and I would queue it up in my tree now
> > > but I don't want to cause any build warnings in linux-next from it.  So
> > > how about I submit something like this right after 4.17-rc1 is out,
> > > where the function signature is changed _and_ all definitions of that
> > > function are changed at the same time to keep everything sane at once?
> > >
> > > Can you send me such a patch right before -rc1 is out base on Linus's
> > > tree?  That should give everyone enough time to get the things merged,
> > > right?
> > >
> > > Or is there no in-flight patches to use this yet, and I can queue it up
> > > now for -rc1 as no build warnings will happen?
> >
> > Hi Greg,
> >
> > Are we good regarding this patch. I have assured there are not
> > in-flight patches.
>
> All of my stuff is now in Linus's tree, so check there :)

Hi Greg,

That should have been obvious to me with merge window. Anyway, I
checked and it seems this particular patch got lost somehow. The other
two patches in the series are in Linus's tree. There was only one
in-flight patch in bt-next and had it removed with you on Cc:.
Probably got lost in your daily email storm :-p

Regards,
Arend
