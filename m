Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7FEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC872133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbfB0OWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:22:10 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47452 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730104AbfB0OWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:22:09 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id E25E927EC3E
Subject: Re: [PATCH] cros_ec: instantiate properly Intel ISH MCU device
To:     Jett Rink <jettrink@chromium.org>,
        Guenter Roeck <groeck@google.com>
Cc:     Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@google.com>,
        andriy.shevchenko@intel.com
References: <1550999629-31791-1-git-send-email-rushikesh.s.kadam@intel.com>
 <CABXOdTdprS1OL534XQq8yHTFDzXdWWODq3VGrSEHYe2wmV5zfg@mail.gmail.com>
 <CAK+PMK67rWZarOV31n=yYbRMq3wo9vDyMTQ93PFZ7PRUMS66Ng@mail.gmail.com>
 <CABXOdTdbev2nKNjocqxOyPcGOU8zbWpQ7uALWZdEHL0CXkYDgA@mail.gmail.com>
 <CAK+PMK5U4YRtJNUbsQu3ARJFxwai7W=DjPfjuX_AZMFcUZ-c_A@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <39dc9be2-808e-4800-b4bb-605d5bf94e12@collabora.com>
Date:   Wed, 27 Feb 2019 15:22:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAK+PMK5U4YRtJNUbsQu3ARJFxwai7W=DjPfjuX_AZMFcUZ-c_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26/2/19 18:21, Jett Rink wrote:
> We are specifically wanting userspace applications to not worry/confuse cros_ish
> with a normal cros_ec. Adding an attribute instead of changing the path would
> make it easy for userspace application to forget to check properly before
> accessing the ish as an EC when it shouldn't.
> 
> On Mon, Feb 25, 2019 at 4:37 PM Guenter Roeck <groeck@google.com
> <mailto:groeck@google.com>> wrote:
> 
>     On Mon, Feb 25, 2019 at 3:22 PM Jett Rink <jettrink@chromium.org
>     <mailto:jettrink@chromium.org>> wrote:
> 
>         A cros_ec and cros_ish device could both be present on the same system.
>         We want to change the device path to ensure that drivers/code further up
>         the stack does not get confuse the ISH with as an EC.
> 
>         The ISH device can export a similar sysfs interface as they both use the
>         same command interface for communication (although they will use
>         different transport layers). The common cros code will detect certain
>         EC_FEATURES and enable the correct subsystem based on the level of
>         functionality the device supports. In the case of the ISH, the sensor
>         subsystem will be enabled.
> 
>     Seems to me it would make more sense to handle that difference with a sysfs
>     attribute (instead of forcing each userspace application to support multiple
>     sysfs paths).
> 

Is still unclear to me what's that ISH device, so I'd appreciate if you can give
some more background. Trying to understand the topology, makes sense that block
diagram to you?


       ---------------------------
      |  User Space Applications  |
       ---------------------------

----------------IIO ABI----------------

       -----------------------------
      |  CrOS EC IIO Sensor Drivers |
       -----------------------------

       --------------------------
      |  CrOS EC over ISH Driver |
       --------------------------

---------------- OS ------------------

       --------------------------
      |     CrOS EC Firmware     |
       --------------------------

       --------------------------
      | ISH Hardware/Firmware    |
       --------------------------

So I'm right assuming that this CrOS EC will implement only the sensor features?

And then, the system will have another CrOS EC implementing other features like
RTC, USBPD-charger, etc?

Apart from the sensors features, will the CrOS EC ISH implement other features?

I'm a bit worried about the increasing way to use a particular name for
different CrOS EC, actually we have only cros_ec and cros_pd. But in the
chromeos kernels there is /dev/cros_fp, /dev/cros_tp, /dev/cros_ish,
/dev/cros_scp and who knows how many more in the future. So I'm wondering if
wouldn't be better use standard names, i.e /dev/cros_ec0, /dev/cros_ec1, etc. as
userspace, for those cases, should be able to query the EC_FEATURE_ISH/FP/TP/SCP
and know against which EC the device is attached.

Cheers,
Enric

>     Guenter
>      
> 
>         -Jett
> 
>         On Sun, Feb 24, 2019 at 4:03 PM Guenter Roeck <groeck@google.com
>         <mailto:groeck@google.com>> wrote:
> 
>             On Sun, Feb 24, 2019 at 1:14 AM Rushikesh S Kadam
>             <rushikesh.s.kadam@intel.com <mailto:rushikesh.s.kadam@intel.com>>
>             wrote:
> 
>                 Intel Integrated Sensor Hub (ISH) is also a MCU running EC
>                 having feature bit EC_FEATURE_ISH. Instantiate it as a special
>                 CrOS EC device with device name 'cros_ish'.
> 
> 
>             The type of MCU doesn't really have to be reflected in the sysfs
>             directory path. cros_ec uses different
>             MCUs over time.
> 
>             Will the new path exist in parallel with cros_ec (in other words,
>             will there also be a stand-alone EC in the same system) ? Does it
>             have different or the same sysfs attributes as cros_ec ?
> 
>             Also,, what is the impact on userspace ?
> 
>             Thanks,
>             Guenter
> 
>                 Signed-off-by: Rushikesh S Kadam <rushikesh.s.kadam@intel.com
>                 <mailto:rushikesh.s.kadam@intel.com>>
>                 ---
>                  drivers/mfd/cros_ec_dev.c            | 10 ++++++++++
>                  include/linux/mfd/cros_ec.h          |  1 +
>                  include/linux/mfd/cros_ec_commands.h |  2 ++
>                  3 files changed, 13 insertions(+)
> 
>                 diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
>                 index 2d0fee4..be499b8 100644
>                 --- a/drivers/mfd/cros_ec_dev.c
>                 +++ b/drivers/mfd/cros_ec_dev.c
>                 @@ -414,6 +414,16 @@ static int ec_device_probe(struct
>                 platform_device *pdev)
>                         device_initialize(&ec->class_dev);
>                         cdev_init(&ec->cdev, &fops);
> 
>                 +       /* check whether this is actually a Intel ISH rather
>                 than an EC */
>                 +       if (cros_ec_check_features(ec, EC_FEATURE_ISH)) {
>                 +               dev_info(dev, "Intel ISH MCU detected.\n");
>                 +               /*
>                 +                * Help userspace differentiating ECs from ISH MCU,
>                 +                * regardless of the probing order.
>                 +                */
>                 +               ec_platform->ec_name = CROS_EC_DEV_ISH_NAME;
>                 +       }
>                 +
>                         /*
>                          * Add the class device
>                          * Link to the character device for creating the /dev entry
>                 diff --git a/include/linux/mfd/cros_ec.h
>                 b/include/linux/mfd/cros_ec.h
>                 index de8b588..00c5765 100644
>                 --- a/include/linux/mfd/cros_ec.h
>                 +++ b/include/linux/mfd/cros_ec.h
>                 @@ -24,6 +24,7 @@
> 
>                  #define CROS_EC_DEV_NAME "cros_ec"
>                  #define CROS_EC_DEV_PD_NAME "cros_pd"
>                 +#define CROS_EC_DEV_ISH_NAME "cros_ish"
> 
>                  /*
>                   * The EC is unresponsive for a time after a reboot command.  Add a
>                 diff --git a/include/linux/mfd/cros_ec_commands.h
>                 b/include/linux/mfd/cros_ec_commands.h
>                 index fc91082..9276c3c 100644
>                 --- a/include/linux/mfd/cros_ec_commands.h
>                 +++ b/include/linux/mfd/cros_ec_commands.h
>                 @@ -856,6 +856,8 @@ enum ec_feature_code {
>                         EC_FEATURE_RTC = 27,
>                         /* EC supports CEC commands */
>                         EC_FEATURE_CEC = 35,
>                 +       /* The MCU is an Intel Integrated Sensor Hub */
>                 +       EC_FEATURE_ISH = 40,
>                  };
> 
>                  #define EC_FEATURE_MASK_0(event_code) (1UL << (event_code % 32))
>                 -- 
>                 1.9.1
> 
