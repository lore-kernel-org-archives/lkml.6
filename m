Return-Path: <ulf.hansson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526301048; cv=none;
        d=google.com; s=arc-20160816;
        b=Sm+CVlvUbcslbKOT0gT+GZf7W/9ee3Ul7QioPG0I6c8GOJgdBJCIlyR3b3fXC0gcLt
         +qRsFOk/FmUwNGch19CX5vEgWkkSBWK6OvFi/jpJTG2M1EiEH8Edo5j2aLw2rNZTWd1A
         VtIuHZ1p5ymcV5nzJFIgiXHzmKiCwcKS8GLveF21LNOvCDzPSGMU0XsPmpvEW9RNOjoa
         branOjrBbU3QTX4FWt8a4t+sGifhTnNdCgADnDCcTgEWnLjSDhqyHlWiMoy/vpGRQym9
         0GpK2ITF4CHxZIBKbh5UMXKyulLnGWlI3EDjaxss+4HjTCQLsTPMHqEGvk6n0DeWBGFA
         2YiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=ljjtGxm3SZB+MyVVe1cT4zpB7JPhG9uBVO4b9BjWEN0=;
        b=PCroFcSYT2ot6yCS6CNmKuI4SxhQJALVhd9ShCZLR0n4FRJ42ws+5csvr4UQDlB1l2
         HKOH/jlHxlWEZLVtMl6ociEvbP2LVvLM81f4dNOLfYzGHGeD3i/omCQCy9ge9Fm/k2no
         3xsK+OrkiVojhaJ+eyve/ToSWckjWSVXMI5o8yeb6d5uu1hMbp7kHjG0OHqboYeslJyF
         L7jm93YGExNqY63Jsz5TQWe3ER996sdfIzkSZqk/dAma6vBBp/e5qMOHBWVyQth83W0a
         A3JIdLm9dRWadcBxvz0lae+QA+7jyaES4E1Zz0rjn96kR+5u0950AAtjErRW9t2TmB4l
         Uq+A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=KinmAk8T;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=KinmAk8T;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZpCBSBkWMNML83tWjE858vBu4lJq+A6xyGCdv9m6DbvxdE/sW5P7zeuKm7CHtENRHQxXNcVIZxnGS8nsU2Q2+g=
MIME-Version: 1.0
In-Reply-To: <b193b8a0-ad25-1895-8f8d-ffab97261dc1@samsung.com>
References: <CGME20180514101728epcas4p3108760546a415b36252df93dfe38e0fb@epcas4p3.samsung.com>
 <CAJKOXPfD8gZR8nZkmAr=Ldt3xESuFocQLnMtrDsNZu=ba55jcw@mail.gmail.com> <b193b8a0-ad25-1895-8f8d-ffab97261dc1@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 14 May 2018 14:30:47 +0200
Message-ID: <CAPDyKFoQFxHqupyqH3JsriUDdJHpUDecD37OqOSKn-sT26gEiA@mail.gmail.com>
Subject: Re: [FAIL bisect] Sound card probe error
To: Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
	Mark Brown <broonie@kernel.org>, Inki Dae <inki.dae@samsung.com>,
	"linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>, Andrzej Hajda <a.hajda@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600434255100788752?=
X-GMAIL-MSGID: =?utf-8?q?1600442648614822649?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 14 May 2018 at 14:22, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
> Hi,
>
> On 05/14/2018 12:17 PM, Krzysztof Kozlowski wrote:
>
>> Bisected to:
>> 8c123c14bbba4add148536b6d47a9226deda2f7a is the first bad commit
>> commit 8c123c14bbba4add148536b6d47a9226deda2f7a
>> Author: Ulf Hansson <ulf.hansson@linaro.org>
>> Date:   Thu Apr 26 10:53:06 2018 +0200
>>
>>     driver core: Respect all error codes from dev_pm_domain_attach()
>>
>>     The limitation of being able to check only for -EPROBE_DEFER from
>>     dev_pm_domain_attach() has been removed. Hence let's respect all error
>>     codes and bail out accordingly.
>>
>>     Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>     Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The DRM driver creates the HDMI codec but its registration fails, due
> to some missing clocks. The clock are missing because the exynos5-subcmu
> driver probing fails.
>
> [    0.678578] exynos5-subcmu: probe of GSC failed with error -17
> [    0.679250] exynos5-subcmu: probe of MFC failed with error -17
> [    0.679992] exynos5-subcmu: probe of DISP failed with error -17
>
> The exynos5-subcmu driver before registering platform device makes
> of_genpd_add_device() call, so in platform_drv_probe() dev_pm_domain_attach()
> call will fail, as dev->pm_domain is already set. Previously the error
> was masked by code removed in the above commit and platform_drv_probe()
> was could complete successfully.

Thanks for providing this information!

I was about to tell that I overlooked the fact that there is more than
one way to assign PM domain pointers to devices. To fix the problem,
dev_pm_domain_attach() should return 0, not -EEXIST when it finds and
existing PM domain pointer.

Does the below patch fix the problem?

From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 14 May 2018 14:26:16 +0200
Subject: [PATCH] PM / Domains: Don't return -EEXIST at attach when PM domain
 exists

As dev_pm_domain_attach() isn't the only way to assign PM domain pointers
to devices, clearly we must allow a device to have the pointer already
being assigned. For this reason, return 0 instead of -EEXIST.

Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index 5e4b481..390868c 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -106,7 +106,7 @@ int dev_pm_domain_attach(struct device *dev, bool power_on)
        int ret;

        if (dev->pm_domain)
-               return -EEXIST;
+               return 0;

        ret = acpi_dev_pm_attach(dev, power_on);
        if (!ret)
-- 
2.7.4
