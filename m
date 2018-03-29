Return-Path: <atull@kernel.org>
X-Google-Smtp-Source: AIpwx48kFCP2H3CsS8d6/UxNGo/uhLs51iDRcsxnAwTowf7yFXq4h0vR/XOUtkDIqlRmMzlSzdHE
ARC-Seal: i=1; a=rsa-sha256; t=1522348040; cv=none;
        d=google.com; s=arc-20160816;
        b=vGr9OlybmDal/bl68zAzfjhr/3MibaWIbD3yMcIGndOjqBRVlGkSVFlRIzPwh0omh3
         9ZrGmPQsGw+3Ccw6drpyP/cCAZoLPtsHZqlGw0fkWETw5+HtNCTURBFis6N8ij6PDg9j
         PDsN7dxrRDe/0nIihlLGpIVduCuS5IISU29YCS6IXe6/2H0OIvk54x9ds0PJrGDRUtVr
         ZVD4/S/jjFpJs4NLzG+txE2qX6pLuVK0A0ZkEXQ0Hdthz/ZjDXNb7LXzX/nQRmOFuZM6
         qzH3pKig6j9VR/GX2cn7O03LKrhmvy9XEEiPOkTAnGSFLC4PAYDT9sJ91FJZ5iLgT8T3
         JoYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=Kcn+MmJ7lSU2a+VTwFofyrTlEzZFdEIq48i5IsdQzLs=;
        b=xab92/RXmAfHUPl+XTZ4eAZBGM+oaPV3xwGjlFh4X0h9bgsFGv+QWuoB/eeeW0f4l+
         CHAghX4EfkxEGA1Vr5ZGXG41KThSHiVUx+SbGthGbiRtdN68INzAa0OXXTZs3YR2eoOB
         ZHgNHzd1qij3dQ1U7ChTxc1h/mxyoGcHDrKUMjtCkySNYYbIoyLH1z7IYRe6Cp4+1pdy
         dcmiwADYo4FiI3sCk+zBySt5gDdpziszAQkd1xb6R+6/ZwypVqWEAiPd6OmlpIErUAqQ
         PSx0AtsTyRZ+1JEBKCpuodYoh1pMAI7ts7nku+oW1N8TL0rbDuX92RcHVZ5KtWrRZYUu
         ETxA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of atull@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=atull@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of atull@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=atull@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E63B217D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
MIME-Version: 1.0
In-Reply-To: <20180329170356.GC8501@kroah.com>
References: <20180329153658.11614-1-mdf@kernel.org> <20180329153658.11614-3-mdf@kernel.org>
 <20180329170356.GC8501@kroah.com>
From: Alan Tull <atull@kernel.org>
Date: Thu, 29 Mar 2018 13:26:39 -0500
X-Gmail-Original-Message-ID: <CANk1AXQ3BLfcCvfVrM_Rp1y_abq2QWve_+8sDWRr3HEBQZVx1Q@mail.gmail.com>
Message-ID: <CANk1AXQ3BLfcCvfVrM_Rp1y_abq2QWve_+8sDWRr3HEBQZVx1Q@mail.gmail.com>
Subject: Re: [PATCH 2/6] fpga: manager: don't use drvdata in common fpga code
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596287278751372804?=
X-GMAIL-MSGID: =?utf-8?q?1596297619173092900?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 12:03 PM, Greg KH <gregkh@linuxfoundation.org> wrote:

Hi Greg,

> On Thu, Mar 29, 2018 at 08:36:54AM -0700, Moritz Fischer wrote:
>> From: Alan Tull <atull@kernel.org>
>>
>> Change fpga_mgr_register to not set or use drvdata.
>>
>> Change the register/unregister function parameters to take the mgr
>> struct:
>> * int fpga_mgr_register(struct fpga_manager *mgr);
>> * void fpga_mgr_unregister(struct fpga_manager *mgr);
>>
>> Change the drivers that call fpga_mgr_register to alloc the struct
>> fpga_manager (using devm_kzalloc) and partly fill it, adding name,
>> ops, parent device, and priv.
>>
>> The rationale is that setting drvdata is fine for DT based devices
>> that will have one manager, bridge, or region per platform device.
>> However PCIe based devices may have multiple FPGA mgr/bridge/regions
>> under one PCIe device.  Without these changes, the PCIe solution has
>> to create an extra device for each child mgr/bridge/region to hold
>> drvdata.
>>
>> Signed-off-by: Alan Tull <atull@kernel.org>
>> Reported-by: Jiuyue Ma <majiuyue@huawei.com>
>> Signed-off-by: Moritz Fischer <mdf@kernel.org>
>> ---
>>  Documentation/fpga/fpga-mgr.txt  | 24 +++++++++++++++++-------
>>  drivers/fpga/altera-cvp.c        | 18 ++++++++++++++----
>>  drivers/fpga/altera-pr-ip-core.c | 17 +++++++++++++++--
>>  drivers/fpga/altera-ps-spi.c     | 18 +++++++++++++++---
>>  drivers/fpga/fpga-mgr.c          | 39 ++++++++++++++-------------------------
>>  drivers/fpga/ice40-spi.c         | 20 ++++++++++++++++----
>>  drivers/fpga/socfpga-a10.c       | 16 +++++++++++++---
>>  drivers/fpga/socfpga.c           | 18 +++++++++++++++---
>>  drivers/fpga/ts73xx-fpga.c       | 18 +++++++++++++++---
>>  drivers/fpga/xilinx-spi.c        | 18 +++++++++++++++---
>>  drivers/fpga/zynq-fpga.c         | 16 +++++++++++++---
>>  include/linux/fpga/fpga-mgr.h    |  8 ++++----
>>  12 files changed, 166 insertions(+), 64 deletions(-)
>>
>> diff --git a/Documentation/fpga/fpga-mgr.txt b/Documentation/fpga/fpga-mgr.txt
>> index cc6413ed6fc9..3cea6b57c156 100644
>> --- a/Documentation/fpga/fpga-mgr.txt
>> +++ b/Documentation/fpga/fpga-mgr.txt
>> @@ -67,11 +67,9 @@ fpga_mgr_unlock when done programming the FPGA.
>>  To register or unregister the low level FPGA-specific driver:
>>  -------------------------------------------------------------
>>
>> -     int fpga_mgr_register(struct device *dev, const char *name,
>> -                           const struct fpga_manager_ops *mops,
>> -                           void *priv);
>> +     int fpga_mgr_register(struct fpga_manager *mgr);
>>
>> -     void fpga_mgr_unregister(struct device *dev);
>> +     void fpga_mgr_unregister(struct fpga_manager *mgr);
>>
>>  Use of these two functions is described below in "How To Support a new FPGA
>>  device."
>> @@ -148,8 +146,13 @@ static int socfpga_fpga_probe(struct platform_device *pdev)
>>  {
>>       struct device *dev = &pdev->dev;
>>       struct socfpga_fpga_priv *priv;
>> +     struct fpga_manager *mgr;
>>       int ret;
>>
>> +     mgr = devm_kzalloc(dev, sizeof(*mgr), GFP_KERNEL);
>> +     if (!mgr)
>> +             return -ENOMEM;
>
> This feels odd to have to do for every driver.  Why can't the fpga core
> handle this all for you?
>
>
>> +
>>       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>       if (!priv)
>>               return -ENOMEM;
>> @@ -157,13 +160,20 @@ static int socfpga_fpga_probe(struct platform_device *pdev)
>>       /* ... do ioremaps, get interrupts, etc. and save
>>          them in priv... */
>>
>> -     return fpga_mgr_register(dev, "Altera SOCFPGA FPGA Manager",
>> -                              &socfpga_fpga_ops, priv);
>
> Why can't this be:
>         fpga_mgr_create(...)
> that returns the correct structure?  That way each driver always gets
> the proper things set (you don't have to remember and audit each driver
> to ensure they do it all correctly), and all is good?
>
> That should make this a lot simpler to use, and change.

Are you suggesting something like this?

-       return fpga_mgr_register(dev, "Altera SOCFPGA FPGA Manager",
-                                &socfpga_fpga_ops, priv);
+       mgr = fpga_mgr_create(dev, "Altera SOCFPGA FPGA Manager",
+                               &socfpga_fpga_ops, priv);
+
+       platform_set_drvdata(pdev, mgr);
+
+       return fpga_mgr_register(mgr);

That would be straightforward and if there are more fields to fill in
in the future, we can still do that before calling fpga_mgr_register.

Alan

>
> thanks,
>
> greg k-h
