Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753196AbeAaLnw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 06:43:52 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38978 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751690AbeAaLnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 06:43:49 -0500
X-Google-Smtp-Source: AH8x224hdkHUcYdcN3bmGTBI5Hrk4Z/AqMbn+FsSLXKqny3+2IeDOhwhNTp542q4HleiTiShHpK+7w==
Subject: Re: [PATCH v2] iio: accel: bmc150: Check for a second ACPI device for
 BOSC0200
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Steve Presser <steve@pressers.name>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Jeremy Cline <jeremy@jcline.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        Lars Kellogg-Stedman <lars@oddbit.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org
References: <010001602cf53153-39ad69f1-1b39-4e6d-a748-9455a16c2fbd-000000@email.amazonses.com>
 <20171210182152.70ad8fbf@archlinux>
 <01000160dccefcb4-25edfd89-56f3-486f-88a4-cb8c07253974-000000@email.amazonses.com>
 <20180114104330.2aa7c1fd@archlinux> <20180128094021.572ab366@archlinux>
 <CAHp75VenBEYSZ9okZfGZUmBX+ikL236a9_qjtn-DJtSihw5X+g@mail.gmail.com>
 <20180130160107.000006df@huawei.com>
 <CAHp75VchRJzp1CM33q18e9x8Uq7bNrPZykz-GdpRgB3=y2C+KQ@mail.gmail.com>
 <CAHp75Vf==OQ=Cx4Nzrd+vAOJshT-oL6L8Y54aWt0cGyJJuacjg@mail.gmail.com>
 <CADXBfmvKF_doLv0Vg0TY4cH_rDBEP5NvJ4jHJf85iuOjJB6TzA@mail.gmail.com>
 <CAHp75VdsDAbgJ1XmhaxA5C8FTcYX7tBa4x_Y4ZYk6Sub510nqw@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <9171d401-32de-b334-40da-5e80a00e24d9@redhat.com>
Date: Wed, 31 Jan 2018 12:43:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAHp75VdsDAbgJ1XmhaxA5C8FTcYX7tBa4x_Y4ZYk6Sub510nqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H5,

On 01/30/2018 06:38 PM, Andy Shevchenko wrote:
> On Tue, Jan 30, 2018 at 7:25 PM, Steve Presser <steve@pressers.name> wrote:
>> Andy,
>>
>> Where did the assertion the second device is a magnetometer come from? Just
>> the data sheet?
> 
> Yep. See chapter 8.2. Isn't enough proof? Or you believe in two
> accelerometers with off-by-one conflicting address on a cheap laptop
> with left unused two magnetometers on the same time?

This is not a cheap device, this has been seen on a Lenovo Yoga 11e,
the yoga's typically have an accelerometer in both the base and the display
and have no use for a magnetometer. Not saying that you're wrong,
but my expectations are different. Anyways we need to find someone to
test this, I asked Jeremy to write a patch for this because we had
Yoga 11e user (Lars Kellogg-Stedman in the CC) asking question and
Jeremy did ask that Lars to test.

It looks like we will need to reach out to Lars and get some testing done
to figure this out one way or the other.

Lars if you're reading this can you please reply. If you've trouble
building your own kernels for testing, would you be willing to install
Fedora so that we can provide test kernels for you?

Regards,

Hans

p.s.

For reference here is the relevant DSDT blurb from the Yoga 11e:

             Device (ACC)
             {
                 Name (_ADR, Zero)  // _ADR: Address
                 Name (_HID, "BOSC0200")  // _HID: Hardware ID
                 Name (_CID, "BOSC0200")  // _CID: Compatible ID
                 Name (_DDN, "Accelerometer")  // _DDN: DOS Device Name
                 Name (_UID, One)  // _UID: Unique ID
                 Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                 {
                     Name (RBUF, ResourceTemplate ()
                     {
                         I2cSerialBusV2 (0x0019, ControllerInitiated, 0x00061A80,
                             AddressingMode7Bit, "\\_SB.PCI0.I2C3",
                             0x00, ResourceConsumer, , Exclusive,
                             )
                         I2cSerialBusV2 (0x0018, ControllerInitiated, 0x00061A80,
                             AddressingMode7Bit, "\\_SB.PCI0.I2C3",
                             0x00, ResourceConsumer, , Exclusive,
                             )
                     })
                     Return (RBUF) /* \_SB_.PCI0.I2C3.ACC_._CRS.RBUF */
                 }





> 
> And we have a driver for magnetometer separately.
> 
> So, it looks like we need to move ACPI ID to a new "kinda I2C mfd" IIO
> driver under drivers/iio/imu/bmc150_i2c.c
> 
> 
>> Steve
>>
>>
>> On Tue, Jan 30, 2018, 12:05 PM Andy Shevchenko <andy.shevchenko@gmail.com>
>> wrote:
>>>
>>> On Tue, Jan 30, 2018 at 6:40 PM, Andy Shevchenko
>>> <andy.shevchenko@gmail.com> wrote:
>>>> On Tue, Jan 30, 2018 at 6:01 PM, Jonathan Cameron
>>>> <Jonathan.Cameron@huawei.com> wrote:
>>>>> On Mon, 29 Jan 2018 16:07:02 +0200
>>>>> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>>>
>>>>>>> But that would take much longer.  Feel free to propose it and a
>>>>>>> patch
>>>>>>> removing the ifdef fun if you like!
>>>>
>>>>>> Where can I see the patch?
>>>>
>>>>> Doh. I clearly forgot to push out.  Should be able to push to
>>>>> iio.git on kernel.org later.
>>>>
>>>> Thanks, I can see it now.
>>>>
>>>> This patch almost wrong. Not by functionality it brings, but by style.
>>>
>>> Oy vey, the second device is *not* accelerometer, it is a magnetometer
>>> [1].
>>>
>>> [1]: https://www.mouser.com/ds/2/783/BST-BMC150-DS000-04-786477.pdf
>>>
>>>> I'll send soon a series of fixes to the driver (compile tested only)
>>>> to provide my view on the matters.
>>>>
>>>> P.S. In the future (I have some kind of deja vu I have told this
>>>> already to someone), please, Cc one or more of Rafael, Mika and/or me
>>>> for ACPI matters.
>>>
>>> --
>>> With Best Regards,
>>> Andy Shevchenko
> 
> 
> 
