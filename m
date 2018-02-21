Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936167AbeBUQiz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:38:55 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55512 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932674AbeBUQix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:38:53 -0500
Subject: Re: [PATCH 3/3] platform/chrome: mfd/cros_ec_dev: Add sysfs entry to
 set keyboard wake lid angle
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@collabora.com, groeck@chromium.org, gwendal@chromium.org
References: <20180221145033.13781-1-enric.balletbo@collabora.com>
 <CAHp75Vf3fKen1mHGrKK0NjaCoiNwS_x91+5cfv4RPqSKAfTSQQ@mail.gmail.com>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <ddd2fd38-8128-ceec-a3c2-04a76110933d@collabora.com>
Date: Wed, 21 Feb 2018 17:38:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vf3fKen1mHGrKK0NjaCoiNwS_x91+5cfv4RPqSKAfTSQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 21/02/18 16:16, Andy Shevchenko wrote:
> On Wed, Feb 21, 2018 at 4:50 PM, Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
>> From: Gwendal Grignou <gwendal@chromium.org>
>>
>> This adds a sysfs attribute (/sys/class/chromeos/cros_ec/kb_wake_angle)
>> used to set and get the keyboard wake lid angle. This attribute is
>> present only if 2 accelerometers are controlled by the EC.
>>
>> This patch also moves the cros_ec features check before the device is
>> added so the features map obtained from the EC is ready on time.
> 
>> +/* Keyboard wake angle control */
>> +static ssize_t show_kb_wake_angle(struct device *dev,
>> +                                 struct device_attribute *attr, char *buf)
>> +{
>> +       struct ec_response_motion_sense *resp;
>> +       struct ec_params_motion_sense *param;
>> +       struct cros_ec_command *msg;
>> +       int ret;
> 
>> +       struct cros_ec_dev *ec = container_of(
>> +                       dev, struct cros_ec_dev, class_dev);
> 
> First of all, do not split lines like this.
> Second, consider just to add a preparatory patch which introduces
> 
> #define to_cros_ec_dev(dev)  container_of(dev, struct cros_ec_dev, class_dev)
> 
> and use it here.
> 
>> +
>> +       msg = kmalloc(sizeof(*msg) + EC_HOST_PARAM_SIZE, GFP_KERNEL);
>> +       if (!msg)
>> +               return -ENOMEM;
>> +
>> +       param = (struct ec_params_motion_sense *)msg->data;
>> +       msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
>> +       msg->version = 2;
>> +       param->cmd = MOTIONSENSE_CMD_KB_WAKE_ANGLE;
>> +       param->kb_wake_angle.data = EC_MOTION_SENSE_NO_VALUE;
>> +       msg->outsize = sizeof(*param);
>> +       msg->insize = sizeof(*resp);
>> +       ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
>> +       if (ret < 0)
>> +               goto exit;
>> +       resp = (struct ec_response_motion_sense *)msg->data;
> 
>> +       ret = scnprintf(buf, PAGE_SIZE, "%d\n",
>> +                       resp->kb_wake_angle.ret);
> 
> Looks like one line.
> 
>> +exit:
>> +       kfree(msg);
>> +       return ret;
>> +}
>> +
>> +static ssize_t store_kb_wake_angle(struct device *dev,
>> +                                  struct device_attribute *attr,
>> +                                  const char *buf, size_t count)
>> +{
>> +       struct ec_params_motion_sense *param;
>> +       struct cros_ec_command *msg;
>> +       int ret;
>> +       struct cros_ec_dev *ec = container_of(
>> +                       dev, struct cros_ec_dev, class_dev);
>> +       u16 angle;
>> +
>> +       ret = kstrtou16(buf, 0, &angle);
>> +       if (ret)
>> +               return ret;
>> +
>> +       msg = kmalloc(sizeof(*msg) + EC_HOST_PARAM_SIZE, GFP_KERNEL);
>> +       if (!msg)
>> +               return -ENOMEM;
>> +
>> +       param = (struct ec_params_motion_sense *)msg->data;
>> +       msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
>> +       msg->version = 2;
>> +       param->cmd = MOTIONSENSE_CMD_KB_WAKE_ANGLE;
>> +       param->kb_wake_angle.data = angle;
>> +       msg->outsize = sizeof(*param);
>> +       msg->insize = sizeof(struct ec_response_motion_sense);
>> +       ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
>> +       kfree(msg);
>> +       if (ret < 0)
>> +               return ret;
>> +       return count;
>> +}
>> +
>>  /* Module initialization */
>>
>>  static DEVICE_ATTR(reboot, S_IWUSR | S_IRUGO, show_ec_reboot, store_ec_reboot);
>>  static DEVICE_ATTR(version, S_IRUGO, show_ec_version, NULL);
>>  static DEVICE_ATTR(flashinfo, S_IRUGO, show_ec_flashinfo, NULL);
>> +static DEVICE_ATTR(kb_wake_angle, S_IWUSR | S_IRUGO, show_kb_wake_angle,
>> +                  store_kb_wake_angle);
> 
> Consider to switch to
> 
> DEVICE_ATTR_RO()
> DEVICE_ATTR_RW()
> 

I'll send a second version soon, thanks for the review.

Regards,
 Enric
