Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbeBWJEY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 04:04:24 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35636 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751383AbeBWJEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 04:04:23 -0500
Subject: Re: [PATCH 5/6] mfd: cros_ec_dev: Check communication with ec at
 resume
To: Gwendal Grignou <gwendal@google.com>
Cc: Gwendal Grignou <gwendal@chromium.org>,
        Lee Jones <lee.jones@linaro.org>, Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>, kernel@collabora.com
References: <20180219224111.21601-1-enric.balletbo@collabora.com>
 <CAMHSBOVwqgTn5KAgq8Ueqh-QDMU+bfDAzQLSEk5-6pb58L8X9g@mail.gmail.com>
 <42a823e5-ba12-2060-a2bd-44027261e26f@collabora.com>
 <CAMHSBOXBu7pRmifePJ82cj3MorRXXGqfdDSCrDJ7qwJ8YBarrA@mail.gmail.com>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <4a79fc19-f76a-3f53-56fa-03e33d984e2b@collabora.com>
Date: Fri, 23 Feb 2018 10:04:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAMHSBOXBu7pRmifePJ82cj3MorRXXGqfdDSCrDJ7qwJ8YBarrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gwendal,

On 23/02/18 10:01, Gwendal Grignou wrote:
> On Thu, Feb 22, 2018 at 1:41 AM, Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
>> Hi Gwendal,
>>
>> On 22/02/18 03:20, Gwendal Grignou wrote:
>>> On Mon, Feb 19, 2018 at 2:41 PM, Enric Balletbo i Serra
>>> <enric.balletbo@collabora.com> wrote:
>>>> From: Gwendal Grignou <gwendal@chromium.org>
>>> This patch is not needed anymore. It was added to
>>>>
>>>> Send dummy command to EC at resume time, wait for status.
>>>> If EC loses that command and return a status for the
>>>> pre-suspend command, we will not interpret that status as an
>>>> answer for an important command.
>>>>
>>>> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
>>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>> Hold on for this commit. We have only used it in 3.14 kernels. It
>>> looks like the issue has been addressed by a more elegant solution at
>>> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/0225a9de5971b99770344c04e0eba5b35ca68f71
>>
>> Just to make sure.
>>
>> I don't see this patch reverted in current chromeos-4.4, seems that both are
>> applied. The patch is still there [1]. So, to double check, can I remove this
>> patch from this series and add only the one that moves the system sleep pm ops
>> to late?
> You're right, it is still in chromeos-4.4. If it is still really
> needed, we will apply it later.
> Thanks,
> 
Sounds good, I'll resend another version removing this patch and adding the
other. Let's leave this patch in standby.

 Enric


> Gwendal.
>>
>> [1]
>> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.4/drivers/platform/chrome/cros_ec_dev.c#782
>>
>>>> ---
>>>>  drivers/mfd/cros_ec_dev.c | 10 ++++++++++
>>>>  1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
>>>> index fc98e0564061..c901839317ae 100644
>>>> --- a/drivers/mfd/cros_ec_dev.c
>>>> +++ b/drivers/mfd/cros_ec_dev.c
>>>> @@ -553,6 +553,16 @@ static __maybe_unused int ec_device_suspend(struct device *dev)
>>>>  static __maybe_unused int ec_device_resume(struct device *dev)
>>>>  {
>>>>         struct cros_ec_dev *ec = dev_get_drvdata(dev);
>>>> +       char msg[sizeof(struct ec_response_get_version) +
>>>> +                sizeof(CROS_EC_DEV_VERSION)];
>>>> +       int ret;
>>>> +
>>>> +       /* Be sure the communication with the EC is reestablished */
>>>> +       ret = ec_get_version(ec, msg, sizeof(msg));
>>>> +       if (ret < 0) {
>>>> +               dev_err(ec->ec_dev->dev, "No EC response at resume: %d\n", ret);
>>>> +               return 0;
>>> Besides, that looks wrong, we should try to resume the lightbar.
>>>> +       }
>>>>
>>>>         lb_resume(ec);
>>>>
>>>> --
>>>> 2.16.1
>>>>
>>
>> Thanks,
>>   Enric
> 
