Return-Path: <ulf.hansson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526371171; cv=none;
        d=google.com; s=arc-20160816;
        b=OFFWNP7DZa2SibvTU9adrU7OTrTk5Pn/yhKOmDJ7v2a8w3ezKJp6NS2mdRYMYZqDxx
         1pRGd3nw9r00O966LsMZuQ8o8QSPukhXH6Dq6OA6xA2UfCSZQdAXQE9Aeq4AtvWVYm/0
         B+DIELEJA604t/fo7+OD6z/h//nBDzBwXhQN6tOuy5BDEAVTNQ/PIp31hvb+4voInSQz
         14PjSHKdbBasFZCIbfL7V4soJp0G33T9YaGGworEw3wyrymLzCYAlbs7z4wKSePc0y87
         sGyOFbj+RM1owlJ4hGuiTStj8B8gJg1UFNdWVhhwTN3jioBRX8CvIjjXEqx7mZ+WhZC9
         AEpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Ijf+SXiy9RT0bblM7x5deb8q2GtX6l17ZJBy7IuRIhI=;
        b=GYwzOp6IAZmwnSCx/3/7F3MLSap/ZmdtazYTXDGh75tfuastiUwpQffy37eR+DtCxP
         mfCbYTbAdlPASsxgTLjPojzovY1jYnquZZdLSOp3lJ+O4YtA8IfDiOJvMgCg/xSEWmAf
         sobXCo6ds2w2aSkEWr7Oe9R8kKvQL0AEztgvQKND9AnwXiSGN/JCl3KkCnKYELY+22Vi
         Hxf8yE/klhMmCXbps+FpyMJ/nmr/F8u5dg0wF4VP3L/9Y7ql+WZcotO4wBO+w1P5XFHi
         /oq6uAKmw6xhDGYzzqxUsGjIih6BT89x2yS9NFcYcliZ8rdJxvlZs1sBSBcrvVlKpaJe
         HMWA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=XVOl3XQQ;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=XVOl3XQQ;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZr1Dy390C2S/MqII/+X3mfI2473LwkdvbtJWQbWPZJX5+RVv1/m9sKmfew2e43BA/f0ey6r3l08DUpb0GbK6jI=
MIME-Version: 1.0
In-Reply-To: <20180515044642.GA26133@roeck-us.net>
References: <20180515044642.GA26133@roeck-us.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 15 May 2018 09:59:30 +0200
Message-ID: <CAPDyKFp7fdpvz8vHXaSYihD4cO-iv_Yg+MSDYfykGJpuSAZGig@mail.gmail.com>
Subject: Re: [PATCH] driver core: Respect all error codes from dev_pm_domain_attach()
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598798225940952926?=
X-GMAIL-MSGID: =?utf-8?q?1600516177525684597?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 15 May 2018 at 06:46, Guenter Roeck <linux@roeck-us.net> wrote:
> On Thu, Apr 26, 2018 at 10:53:06AM +0200, Ulf Hansson wrote:
>> The limitation of being able to check only for -EPROBE_DEFER from
>> dev_pm_domain_attach() has been removed. Hence let's respect all error
>> codes and bail out accordingly.
>>
>
> AFAICS this patch causes all drivers/devices to fail instantiating
> if dev_pm_domain_set() is called in the device initialization path.
> That seems to be a systemic problem, since dev_pm_domain_set() must
> only be called for unbound devices.
>
> In practice, I see the problem when trying to boot beagle or overo
> with qemu (the Linaro version). Of course, that doesn't mean much
> because that is not real hardware. However, I am not surprised that
> all devices instantiated through, for example, omap_device_build_from_dt()
> fail to instantiate. Instrumentation confirms that dev_pm_domain_set()
> is called prior to platform_drv_probe().

Your observations are correct, my bad! Others have also reported the problems.

This should solve it:
https://patchwork.kernel.org/patch/10398597/

[...]

Kind regards
Uffe
