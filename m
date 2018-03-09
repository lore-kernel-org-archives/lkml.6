Return-Path: <jonathanh@nvidia.com>
X-Google-Smtp-Source: AG47ELtiMtJNoH9+t/ZzByQjHo7NbE+fsj09+wy7zhnKkbhnFu66K/Ji0qCyonmVT033Jz1IngzM
ARC-Seal: i=1; a=rsa-sha256; t=1520594357; cv=none;
        d=google.com; s=arc-20160816;
        b=PsOcqNlULhddJMxplczKbXVpuNu1A0ZcWWIKuswKp9p4WlXfQlLFT2+OmyPinWGDeu
         p7ScNB60qxFEIFsZhB9Lx24T209Z8+Uk0juKvBVVJatXrzHheZ0M6J5oi0UKFmcuO9Ti
         EJroENZRI/Hcgge3X7xPVd5ZvEaqa1SF0dPZlVntUiWWrr1ztFv3gOhYLKrLNZYBjdR0
         UvTfRw/AIUj1lQTJgV4gNOSLf3k40HD4ayNBM08NO9pZhGhrTAOKVrYfR72duL3ikoyX
         vINaUZIS1pCUefd1/JBmVk4RhcIpAxQcNmx5uySTqpGHR9jl9XFHopT0tP9Xjn+43HIs
         TsBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=QJ5bXM8yTgvWc/EOq7HD76RSgUytivcUK4YdQUzTWos=;
        b=nUgpZIVg1RZtj97DAD3V/uNB4Zyj+pUkLJn0cte7GjFKlsLZIPsGDQiCu9LKF+M6TH
         k6wjVjhSU9gHdQhaPGbLnQcVwBN63BLF10Vwt+9qDmnbcEz5xUgA2mvLLs/kibglqsJ/
         /ainiFwaeTUpqq7N/WcUUKSmM/zHnRQ7Yv9hkUsD5bR0hdnEWzbJ2ZKS29BssosxOU5v
         soeCsEqNFg+hPgBFwdhaKZTJ0JjygR5l3BIkaiGLPxsuUa5JhQ+EenFri7B/Or7cvAVe
         V2aiziouD/5/24cqDWEwZlE0kQEjkEa81v4qURiK+GJTs7GjvtWx1ONCQ3vN01CT3N32
         r8kA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jonathanh@nvidia.com designates 216.228.121.65 as permitted sender) smtp.mailfrom=jonathanh@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jonathanh@nvidia.com designates 216.228.121.65 as permitted sender) smtp.mailfrom=jonathanh@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hqpgpgate102.nvidia.com on Fri, 09 Mar 2018 03:19:15 -0800
Subject: Re: [PATCH 2/3] usb: xhci: tegra: Add runtime PM support
To: Mathias Nyman <mathias.nyman@intel.com>, Thierry Reding
	<thierry.reding@gmail.com>
CC: Mathias Nyman <mathias.nyman@linux.intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1518626085-29102-1-git-send-email-jonathanh@nvidia.com>
 <1518626085-29102-2-git-send-email-jonathanh@nvidia.com>
 <54bd00b7-2835-a253-0399-370e8c8203b8@linux.intel.com>
 <f1a1c300-a558-f31a-bcfa-c3eda697b0fd@nvidia.com>
 <20180309083629.GA13877@ulmo>
 <1fff9fc1-2ad2-dba1-cb1d-d531254984ce@intel.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <81534ac4-c446-62da-2656-e4d5d0fd1da2@nvidia.com>
Date: Fri, 9 Mar 2018 11:19:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1fff9fc1-2ad2-dba1-cb1d-d531254984ce@intel.com>
X-Originating-IP: [10.21.132.129]
X-ClientProxiedBy: UKMAIL101.nvidia.com (10.26.138.13) To UKMAIL101.nvidia.com
 (10.26.138.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592394886362728213?=
X-GMAIL-MSGID: =?utf-8?q?1594458749006074778?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On 09/03/18 09:13, Mathias Nyman wrote:
> On 09.03.2018 10:36, Thierry Reding wrote:
>> On Thu, Mar 08, 2018 at 09:31:07PM +0000, Jon Hunter wrote:
>>>
>>> On 01/03/18 14:18, Mathias Nyman wrote:
>>>> On 14.02.2018 18:34, Jon Hunter wrote:
>>>>> Add runtime PM support to the Tegra XHCI driver and move the function
>>>>> calls to enable/disable the clocks, regulators and PHY into the
>>>>> runtime
>>>>> PM callbacks.
>>>>>
>>>>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>>>>> ---
>>>>> =C2=A0=C2=A0 drivers/usb/host/xhci-tegra.c | 80
>>>>> ++++++++++++++++++++++++++++++-------------
>>>>> =C2=A0=C2=A0 1 file changed, 56 insertions(+), 24 deletions(-)
>>>>>
>>>>> diff --git a/drivers/usb/host/xhci-tegra.c
>>>>> b/drivers/usb/host/xhci-tegra.c
>>>>> index 02b0b24faa58..42aa67858b53 100644
>>>>> --- a/drivers/usb/host/xhci-tegra.c
>>>>> +++ b/drivers/usb/host/xhci-tegra.c
>>>>> @@ -18,6 +18,7 @@
>>>>> =C2=A0=C2=A0 #include <linux/phy/tegra/xusb.h>
>>>>> =C2=A0=C2=A0 #include <linux/platform_device.h>
>>>>> =C2=A0=C2=A0 #include <linux/pm.h>
>>>>> +#include <linux/pm_runtime.h>
>>>>> =C2=A0=C2=A0 #include <linux/regulator/consumer.h>
>>>>> =C2=A0=C2=A0 #include <linux/reset.h>
>>>>> =C2=A0=C2=A0 #include <linux/slab.h>
>>>>> @@ -1067,22 +1068,12 @@ static int tegra_xusb_probe(struct
>>>>> platform_device *pdev)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 platform_set_drvdata(pdev, tegra=
);
>>>>> =C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0 err =3D tegra_xusb_clk_enable(tegra)=
;
>>>>> -=C2=A0=C2=A0=C2=A0 if (err) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(&pdev->dev, "fail=
ed to enable clocks: %d\n", err);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto put_usb2;
>>>>> -=C2=A0=C2=A0=C2=A0 }
>>>>> -
>>>>> -=C2=A0=C2=A0=C2=A0 err =3D regulator_bulk_enable(tegra->soc->num_sup=
plies,
>>>>> tegra->supplies);
>>>>> -=C2=A0=C2=A0=C2=A0 if (err) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(&pdev->dev, "fail=
ed to enable regulators: %d\n",
>>>>> err);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto disable_clk;
>>>>> -=C2=A0=C2=A0=C2=A0 }
>>>>> +=C2=A0=C2=A0=C2=A0 pm_runtime_enable(&pdev->dev);
>>>>> =C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0 err =3D tegra_xusb_phy_enable(tegra)=
;
>>>>> +=C2=A0=C2=A0=C2=A0 err =3D pm_runtime_get_sync(&pdev->dev);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err < 0) {
>>>>
>>>> Does this mean that if runtime PM is disabled then clocks and regulato=
r
>>>> will never be enabled
>>>> for Tegra xhci?
>>>>
>>>> How about keeping the clock and regualtor enabling in probe, and
>>>> instead
>>>> add something like:
>>>>
>>>> pm_runtime_set_active(&pdev->dev);
>>>> pm_runtime_enable(&pdev->dev);
>>>> pm_runtime_get_noresume(&pdev->dev);
>>>
>>> For 64-bit Tegra there is a dependency on CONFIG_PM, but for 32-bit
>>> AFAIK there is not and so yes we should handle the case when PM_RUNTIME
>>> is disabled.
>>>
>>> Typically we do something like ...
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_enable(&pdev->dev);
>>> =C2=A0=C2=A0=C2=A0=C2=A0 if (!pm_runtime_enabled(&pdev->dev))
>>> =C2=A0=C2=A0=C2=A0=C2=A0ret =3D tegra_xusb_runtime_resume(&pdev->dev);
>>> =C2=A0=C2=A0=C2=A0=C2=A0 else
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D pm_runtime_get=
_sync(&pdev->dev);
>>>
>>> That way we can keep the regulator and clock stuff in the handler. I
>>> will update this series.
>>
>> Is there any good reason why we don't depend on PM for 32-bit as well?
>> I'm not aware of any differences in drivers that are 32-bit specific for
>> Tegra, and I'm not even sure the !PM case gets any testing at all. And
>> even if, do we really still want to support that?
>>
>> I don't see any advantage these days for having it disabled.
>=20
> I don't know much about Tegra, but I'd still like to turn this question
> around:
>=20
> Is there any reason why clks and regulators can't initially be turned on
> in probe,
> and then let runtime PM handle them later if PM is supported?

I personally prefer having the regulator, clock, etc handling for
enabling and disabling for a device in their own handler. Duplicating
the calls to the regulator and clock frameworks in probe and the rpm
handlers seems more prone to mistakes. Hence, that's why I would prefer
the option I suggested above, which IMO is the best of both worlds.

> Shouldn't this work in all cases, and it avoids creating new dependencies=
?

Yes but when you want to use frameworks such as genpd it becomes more
complex to support !PM and that is why for 64-bit Tegra we have a
dependency today.

Cheers
Jon

--=20
nvpublic
