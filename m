Return-Path: <hdegoede@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519565367; cv=none;
        d=google.com; s=arc-20160816;
        b=Cb3zj91BQh5CGi6aSA76WnWdbuAM7rEuQo7ETiABMiR9JEk6coCN7ZZIaKct9gp9Wk
         XSytdPo72s8kZ+xP70V1UbVUGsNKVh7B5A1h8aas0iAxxwRudxb3/Ah/NR8+LTOQLiG2
         HRMYXZxu0d3hTQy2O1ebKJmsQhICe4jScMIe1/oi6mTFce0nwDSNWWtvNO4x/8cu4rDJ
         eYPGUQp501gnCO4paERFFxPgd/CzmPxrSfoe+sVBa3AEmkaNXpxalKl39Kkoib41qQ6t
         xuuEtHa9wAoHdGTPwwkaWO74zyspFhSrFjP4/2XukOdpPeAxmcGFYH5V8MipCkRwQsDL
         odmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=vDfhhD6YFutqHFPyjzHRJUDMfD9ztTxsjise5OAy5w0=;
        b=VH3XcAtJgV5EnnURVfiIxQhHhOwAxqfpRHYwie5+qwbBNBMzpYKXjVVKj9PGcgpher
         yiW008IeGvpYK2dNMth+iYoTySv4euUqLid0k3N/Qo0sLBfTR46l8FNpuwj4YnjOLJvw
         E1LSWFniwiB2SudPQ1y8X8ptnf1tVgqJGIakTJ1Gsks9YTXRnkE+6DB0P8UCY4XuPfAc
         D8mMUSEsFeik9u1P7byvoBJY3Edt+dclhKVEQpPK/YnLTVydEjtgTcTGsN7B0aqxERrH
         l07cqFh1JJdfeJvtUgVOXlR+EFAMdDprsHNiTkmKfkTdvtLqRvgXqtnKsBZ/s1eZ04Xd
         hkIA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AH8x226Jq0o8Y3F75436j3n41h1HW4TY6xs4e0lKE5tfU0PTsG5qPHjpdmFhgvULhDegNt7GpHumzQ==
Subject: Re: [PATCH 09/12] usb: roles: Add Intel XHCI USB role switch driver
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>,
 MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi
 <cw00.choi@samsung.com>, Mathias Nyman <mathias.nyman@intel.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Platform Driver <platform-driver-x86@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 USB <linux-usb@vger.kernel.org>
References: <20180216104751.8371-1-hdegoede@redhat.com>
 <20180216104751.8371-10-hdegoede@redhat.com>
 <CAHp75VfnqbSecz4y-ThLRPVjTe6jrBPgwEnGEuxb6AunvNDvvg@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <4e5bff81-4d54-107e-8815-b0d602d17fbb@redhat.com>
Date: Sun, 25 Feb 2018 14:29:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfnqbSecz4y-ThLRPVjTe6jrBPgwEnGEuxb6AunvNDvvg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592554254993958741?=
X-GMAIL-MSGID: =?utf-8?q?1593379775527083947?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 16-02-18 14:47, Andy Shevchenko wrote:
> On Fri, Feb 16, 2018 at 12:47 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Various Intel SoCs (Cherry Trail, Broxton and others) have an internal USB
>> role switch for swiching the OTG USB data lines between the xHCI host
>> controller and the dwc3 gadget controller.
>>
>> Note on some Cherry Trail systems there is ACPI/AML code listening to
>> edge interrupts on the id-pin (through an _AIE ACPI method) and switching
>> the role between ROLE_HOST and ROLE_NONE based on the id-pin. Note it does
>> not set the role to ROLE_DEVICE, because device-mode is usually not used
>> under Windows.
>>
>> The presence of AML code which modifies the cfg0 reg (on some systems)
>> means that we our read/write/modify of cfg0 may race with the AML code
>> doing the same to avoid this we take the global ACPI lock while doing
>> the read/write/modify.
> 
>> +/* register definition */
>> +#define DUAL_ROLE_CFG0                 0x68
>> +#define SW_VBUS_VALID                  (1 << 24)
>> +#define SW_IDPIN_EN                    (1 << 21)
>> +#define SW_IDPIN                       (1 << 20)
>> +
>> +#define DUAL_ROLE_CFG1                 0x6c
>> +#define HOST_MODE                      (1 << 29)
> 
> Does it make sense to use BIT() macro above?

Yes, fixed for v2.

> 
> 
>> +struct intel_xhci_acpi_match {
>> +       const char *hid;
>> +       int hrv;
>> +};
> 
> Consider to unify with struct acpi_ac_bl.

That is not a bad idea, but probably best done as a follow-up commit,
since this patch-set already touches enough subsystems as is.

I just added this to my TODO:
  -Add acpi_find_dev_present() helprt which takes an array of and returns a
   pointer to (or NULL):
   struct acpi_dev_present_match {
         const char *hid;
         const char *uid;
         int hrv;
   };
   And use this in drivers/acpi/ac.c drivers/acpi/battery.c,
   drivers/usb/roles/intel-xhci-usb-role-switch.c, ...

>> +static const struct intel_xhci_acpi_match allow_userspace_ctrl_ids[] = {
>> +       { "INT33F4",  3 }, /* X-Powers AXP288 PMIC */
>> +};
>> +
>> +static int intel_xhci_usb_set_role(struct device *dev, enum usb_role role)
>> +{
>> +       struct intel_xhci_usb_data *data = dev_get_drvdata(dev);
>> +       unsigned long timeout;
>> +       acpi_status status;
> 
>> +       u32 glk = -1U;
> 
> I prefer to see consistency and moreover less confusing set, like
> 
> ~0U

Looks like a chose a bad example as user of the
acpi_acquire_global_lock() function, others don't init this at all
because it is not necessary.

> 
>> +       u32 val;
>> +
>> +       /*
>> +        * On many CHT devices ACPI event (_AEI) handlers read / modify /
>> +        * write the cfg0 register, just like we do. Take the ACPI lock
>> +        * to avoid us racing with the AML code.
>> +        */
>> +       status = acpi_acquire_global_lock(ACPI_WAIT_FOREVER, &glk);
> 
> FOREVER?!
> Wouldn't be slightly long under certain circumstances?

The mode-switch itself may take up-to 600ms, so I don't think any
delays caused by this will be a problem. This is just some weird
ACPI-subsys-ism where instead of just having a mutex and using
mutex_trylock() where necessary, the ACPICA code has its own
private timeout handling. I'm sure if I were to just do a mutex_lock()
here nobody would fall over that. The FOREVER just makes this look
scarier then it really is, in theory any mutex_lock() call can wait
forever.

>> +       if (ACPI_FAILURE(status) && status != AE_NOT_CONFIGURED) {
>> +               dev_err(dev, "Error could not acquire lock\n");
>> +               return -EIO;
>> +       }
> 
>> +       acpi_release_global_lock(glk);
> 
>> +       /* Polling on CFG1 register to confirm mode switch.*/
>> +       do {
>> +               val = readl(data->base + DUAL_ROLE_CFG1);
> 
>> +               if (!!(val & HOST_MODE) == (role == USB_ROLE_HOST))
> 
> I would prefer ^ instead of first ==, but it's up to you.
> 
>> +                       return 0;
>> +
>> +               /* Interval for polling is set to about 5 - 10 ms */
>> +               usleep_range(5000, 10000);
>> +       } while (time_before(jiffies, timeout));
>> +
>> +       dev_warn(dev, "Timeout waiting for role-switch\n");
>> +       return -ETIMEDOUT;
>> +}
> 
>> +static int intel_xhci_usb_probe(struct platform_device *pdev)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       struct intel_xhci_usb_data *data;
>> +       struct resource *res;
>> +       resource_size_t size;
>> +       int i, ret;
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> 
>> +       size = (res->end + 1) - res->start;
> 
> resource_size()

Fixed for v2.

>> +       data->base = devm_ioremap_nocache(dev, res->start, size);
> 
> So, what's wrong with devm_ioremap_resource() ?
> ...which also prints an error message.

Nothing, I inherited this from the Android X86 patches this is
based on, fixed for v2.

> 
>> +       if (IS_ERR(data->base)) {
>> +               ret = PTR_ERR(data->base);
> 
>> +               dev_err(dev, "Error iomaping registers: %d\n", ret);
> 
> At least printing return code is useless. Driver core does this.
> 
>> +               return ret;
>> +       }
>> +
> 
>> +       data->role_sw = usb_role_switch_register(dev, &sw_desc);
>> +       if (IS_ERR(data->role_sw)) {
>> +               ret = PTR_ERR(data->role_sw);
> 
>> +               dev_err(dev, "Error registering role-switch: %d\n", ret);
> 
> Ditto.

Ok, both dropped.

> 
>> +               return ret;
>> +       }
>> +
>> +       return 0;
>> +}
> 
>> +static const struct platform_device_id intel_xhci_usb_table[] = {
>> +       { .name = DRV_NAME },
> 
>> +       {},
> 
> No comma, please.

Fixed for v2.

Regards,

Hans
