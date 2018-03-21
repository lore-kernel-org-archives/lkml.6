Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751595AbeCUJiO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 05:38:14 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55944 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbeCUJiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 05:38:12 -0400
Subject: Re: [PATCH v3 6/6] platform/chrome: mfd/cros_ec_dev: Add sysfs entry
 to set keyboard wake lid angle
To: Gwendal Grignou <gwendal@chromium.org>
Cc: Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>, kernel@collabora.com,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>
References: <20180320155125.3046-1-enric.balletbo@collabora.com>
 <20180320155125.3046-7-enric.balletbo@collabora.com>
 <CAMHSBOV1ioE6hNtgTmvJKQ1mGBarbLsY_PmQhg1hAdqT8bdbZg@mail.gmail.com>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <92c295fb-344a-87a0-49dc-58f1e6f93d6a@collabora.com>
Date: Wed, 21 Mar 2018 10:38:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAMHSBOV1ioE6hNtgTmvJKQ1mGBarbLsY_PmQhg1hAdqT8bdbZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20/03/18 19:53, Gwendal Grignou wrote:
> On Tue, Mar 20, 2018 at 8:51 AM, Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
>> From: Gwendal Grignou <gwendal@chromium.org>
>>
>> This adds a sysfs attribute (/sys/class/chromeos/cros_ec/kb_wake_angle)
>> used to set and get the keyboard wake lid angle. This attribute is
>> present only if 2 accelerometers are controlled by the EC.
>>
>> This patch also moves the cros_ec features check before the device is
>> added so the features map obtained from the EC is ready on time.
>>
>> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> ---
>>
>> Changes in v3:
>> - [6/6] Add Reviewed-by Andy Shevchenko
>> - [6/6] Fix the code that has_kb_wake_angle in cros_ec_sensors_register().
>>
>> Changes in v2:
>> - [6/6] Use DEVICE_ATTR_RW variant.
>> - [6/6] Use one line when fits in 80 characters.
>> - [6/6] Use the previous defined to_cros_ec_dev
>>
>>  drivers/mfd/cros_ec_dev.c               | 29 +++++-------
>>  drivers/platform/chrome/cros_ec_sysfs.c | 81 +++++++++++++++++++++++++++++++++
>>  include/linux/mfd/cros_ec.h             |  2 +
>>  3 files changed, 95 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
>> index e4fafdd96e5e..ceaff1cf2f65 100644
>> --- a/drivers/mfd/cros_ec_dev.c
>> +++ b/drivers/mfd/cros_ec_dev.c
>> @@ -305,7 +305,7 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
>>
>>         resp = (struct ec_response_motion_sense *)msg->data;
>>         sensor_num = resp->dump.sensor_count;
>> -       /* Allocate 2 extra sensors in case lid angle or FIFO are needed */
>> +       /* Allocate 1 extra sensors in FIFO are needed */
>>         sensor_cells = kzalloc(sizeof(struct mfd_cell) * (sensor_num + 2),
> Should be +1 instead of +2 to match the comment.

Oh, right, my bad. Guess makes sense send a v4 with that fixed. I'll wait one
day for if there is something else and send a v4.

Regards,
  Enric

>>                                GFP_KERNEL);
>>         if (sensor_cells == NULL)
>> @@ -362,16 +362,10 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
>>                 sensor_type[resp->info.type]++;
>>                 id++;
>>         }
>> -       if (sensor_type[MOTIONSENSE_TYPE_ACCEL] >= 2) {
>> -               sensor_platforms[id].sensor_num = sensor_num;
>>
>> -               sensor_cells[id].name = "cros-ec-angle";
>> -               sensor_cells[id].id = 0;
>> -               sensor_cells[id].platform_data = &sensor_platforms[id];
>> -               sensor_cells[id].pdata_size =
>> -                       sizeof(struct cros_ec_sensor_platform);
>> -               id++;
>> -       }
>> +       if (sensor_type[MOTIONSENSE_TYPE_ACCEL] >= 2)
>> +               ec->has_kb_wake_angle = true;
>> +
>>         if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
>>                 sensor_cells[id].name = "cros-ec-ring";
>>                 id++;
>> @@ -424,6 +418,14 @@ static int ec_device_probe(struct platform_device *pdev)
>>                 goto failed;
>>         }
>>
>> +       /* check whether this EC is a sensor hub. */
>> +       if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
>> +               cros_ec_sensors_register(ec);
>> +
>> +       /* Take control of the lightbar from the EC. */
>> +       lb_manual_suspend_ctrl(ec, 1);
>> +
>> +       /* We can now add the sysfs class, we know which parameter to show */
>>         retval = cdev_device_add(&ec->cdev, &ec->class_dev);
>>         if (retval) {
>>                 dev_err(dev, "cdev_device_add failed => %d\n", retval);
>> @@ -433,13 +435,6 @@ static int ec_device_probe(struct platform_device *pdev)
>>         if (cros_ec_debugfs_init(ec))
>>                 dev_warn(dev, "failed to create debugfs directory\n");
>>
>> -       /* check whether this EC is a sensor hub. */
>> -       if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
>> -               cros_ec_sensors_register(ec);
>> -
>> -       /* Take control of the lightbar from the EC. */
>> -       lb_manual_suspend_ctrl(ec, 1);
>> -
>>         return 0;
>>
>>  failed:
>> diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
>> index 78ae0d3760e4..5a6db3fe213a 100644
>> --- a/drivers/platform/chrome/cros_ec_sysfs.c
>> +++ b/drivers/platform/chrome/cros_ec_sysfs.c
>> @@ -258,21 +258,102 @@ static ssize_t flashinfo_show(struct device *dev,
>>         return ret;
>>  }
>>
>> +/* Keyboard wake angle control */
>> +static ssize_t kb_wake_angle_show(struct device *dev,
>> +                                 struct device_attribute *attr, char *buf)
>> +{
>> +       struct cros_ec_dev *ec = to_cros_ec_dev(dev);
>> +       struct ec_response_motion_sense *resp;
>> +       struct ec_params_motion_sense *param;
>> +       struct cros_ec_command *msg;
>> +       int ret;
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
>> +
>> +       ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
>> +       if (ret < 0)
>> +               goto exit;
>> +
>> +       resp = (struct ec_response_motion_sense *)msg->data;
>> +       ret = scnprintf(buf, PAGE_SIZE, "%d\n", resp->kb_wake_angle.ret);
>> +exit:
>> +       kfree(msg);
>> +       return ret;
>> +}
>> +
>> +static ssize_t kb_wake_angle_store(struct device *dev,
>> +                                  struct device_attribute *attr,
>> +                                  const char *buf, size_t count)
>> +{
>> +       struct cros_ec_dev *ec = to_cros_ec_dev(dev);
>> +       struct ec_params_motion_sense *param;
>> +       struct cros_ec_command *msg;
>> +       u16 angle;
>> +       int ret;
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
>> +
>> +       ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
>> +       kfree(msg);
>> +       if (ret < 0)
>> +               return ret;
>> +       return count;
>> +}
>> +
>>  /* Module initialization */
>>
>>  static DEVICE_ATTR_RW(reboot);
>>  static DEVICE_ATTR_RO(version);
>>  static DEVICE_ATTR_RO(flashinfo);
>> +static DEVICE_ATTR_RW(kb_wake_angle);
>>
>>  static struct attribute *__ec_attrs[] = {
>> +       &dev_attr_kb_wake_angle.attr,
>>         &dev_attr_reboot.attr,
>>         &dev_attr_version.attr,
>>         &dev_attr_flashinfo.attr,
>>         NULL,
>>  };
>>
>> +static umode_t cros_ec_ctrl_visible(struct kobject *kobj,
>> +                                   struct attribute *a, int n)
>> +{
>> +       struct device *dev = container_of(kobj, struct device, kobj);
>> +       struct cros_ec_dev *ec = to_cros_ec_dev(dev);
>> +
>> +       if (a == &dev_attr_kb_wake_angle.attr && !ec->has_kb_wake_angle)
>> +               return 0;
>> +
>> +       return a->mode;
>> +}
>> +
>>  struct attribute_group cros_ec_attr_group = {
>>         .attrs = __ec_attrs,
>> +       .is_visible = cros_ec_ctrl_visible,
>>  };
>>  EXPORT_SYMBOL(cros_ec_attr_group);
>>
>> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
>> index c61535979b8f..2d4e23c9ea0a 100644
>> --- a/include/linux/mfd/cros_ec.h
>> +++ b/include/linux/mfd/cros_ec.h
>> @@ -183,6 +183,7 @@ struct cros_ec_debugfs;
>>   * @ec_dev: cros_ec_device structure to talk to the physical device
>>   * @dev: pointer to the platform device
>>   * @debug_info: cros_ec_debugfs structure for debugging information
>> + * @has_kb_wake_angle: true if at least 2 accelerometer are connected to the EC.
>>   * @cmd_offset: offset to apply for each command.
>>   */
>>  struct cros_ec_dev {
>> @@ -191,6 +192,7 @@ struct cros_ec_dev {
>>         struct cros_ec_device *ec_dev;
>>         struct device *dev;
>>         struct cros_ec_debugfs *debug_info;
>> +       bool has_kb_wake_angle;
>>         u16 cmd_offset;
>>         u32 features[2];
>>  };
>> --
>> 2.16.2
>>
> <div class="gmail_extra"><br><div class="gmail_quote">On Tue, Mar 20,
> 2018 at 8:51 AM, Enric Balletbo i Serra <span dir="ltr">&lt;<a
> href="mailto:enric.balletbo@collabora.com"
> target="_blank">enric.balletbo@collabora.com</a>&gt;</span>
> wrote:<br><blockquote class="gmail_quote" style="margin:0 0 0
> .8ex;border-left:1px #ccc solid;padding-left:1ex">From: Gwendal
> Grignou &lt;<a href="mailto:gwendal@chromium.org">gwendal@chromium.org</a>&gt;<br>
> <br>
> This adds a sysfs attribute (/sys/class/chromeos/cros_ec/<wbr>kb_wake_angle)<br>
> used to set and get the keyboard wake lid angle. This attribute is<br>
> present only if 2 accelerometers are controlled by the EC.<br>
> <br>
> This patch also moves the cros_ec features check before the device is<br>
> added so the features map obtained from the EC is ready on time.<br>
> <br>
> Signed-off-by: Gwendal Grignou &lt;<a
> href="mailto:gwendal@chromium.org">gwendal@chromium.org</a>&gt;<br>
> Signed-off-by: Enric Balletbo i Serra &lt;<a
> href="mailto:enric.balletbo@collabora.com">enric.balletbo@collabora.com</a>&gt;<br>
> Reviewed-by: Andy Shevchenko &lt;<a
> href="mailto:andy.shevchenko@gmail.com">andy.shevchenko@gmail.com</a>&gt;<br>
> ---<br>
> <br>
> Changes in v3:<br>
> - [6/6] Add Reviewed-by Andy Shevchenko<br>
> - [6/6] Fix the code that has_kb_wake_angle in cros_ec_sensors_register().<br>
> <br>
> Changes in v2:<br>
> - [6/6] Use DEVICE_ATTR_RW variant.<br>
> - [6/6] Use one line when fits in 80 characters.<br>
> - [6/6] Use the previous defined to_cros_ec_dev<br>
> <br>
> &nbsp;drivers/mfd/cros_ec_dev.c&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
> &nbsp; &nbsp; &nbsp;| 29 +++++-------<br>
> &nbsp;drivers/platform/chrome/cros_<wbr>ec_sysfs.c | 81
> ++++++++++++++++++++++++++++++<wbr>+++<br>
> &nbsp;include/linux/mfd/cros_ec.h&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
> &nbsp; &nbsp;|&nbsp; 2 +<br>
> &nbsp;3 files changed, 95 insertions(+), 17 deletions(-)<br>
> <br>
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c<br>
> index e4fafdd96e5e..ceaff1cf2f65 100644<br>
> --- a/drivers/mfd/cros_ec_dev.c<br>
> +++ b/drivers/mfd/cros_ec_dev.c<br>
> @@ -305,7 +305,7 @@ static void cros_ec_sensors_register(<wbr>struct
> cros_ec_dev *ec)<br>
> <br>
> &nbsp; &nbsp; &nbsp; &nbsp; resp = (struct ec_response_motion_sense
> *)msg-&gt;data;<br>
> &nbsp; &nbsp; &nbsp; &nbsp; sensor_num = resp-&gt;dump.sensor_count;<br>
> -&nbsp; &nbsp; &nbsp; &nbsp;/* Allocate 2 extra sensors in case lid
> angle or FIFO are needed */<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;/* Allocate 1 extra sensors in FIFO are
> needed */<br>
> &nbsp; &nbsp; &nbsp; &nbsp; sensor_cells = kzalloc(sizeof(struct
> mfd_cell) * (sensor_num + 2),<br>
> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;GFP_KERNEL);<br>
> &nbsp; &nbsp; &nbsp; &nbsp; if (sensor_cells == NULL)<br>
> @@ -362,16 +362,10 @@ static void cros_ec_sensors_register(<wbr>struct
> cros_ec_dev *ec)<br>
> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
> sensor_type[resp-&gt;info.type]++<wbr>;<br>
> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; id++;<br>
> &nbsp; &nbsp; &nbsp; &nbsp; }<br>
> -&nbsp; &nbsp; &nbsp; &nbsp;if
> (sensor_type[MOTIONSENSE_TYPE_<wbr>ACCEL] &gt;= 2) {<br>
> -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
> &nbsp;sensor_platforms[id].sensor_<wbr>num = sensor_num;<br>
> <br>
> -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
> &nbsp;sensor_cells[id].name = "cros-ec-angle";<br>
> -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
> &nbsp;sensor_cells[id].id = 0;<br>
> -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
> &nbsp;sensor_cells[id].platform_data = &amp;sensor_platforms[id];<br>
> -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
> &nbsp;sensor_cells[id].pdata_size =<br>
> -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
> &nbsp; &nbsp;sizeof(struct cros_ec_sensor_platform);<br>
> -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;id++;<br>
> -&nbsp; &nbsp; &nbsp; &nbsp;}<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;if
> (sensor_type[MOTIONSENSE_TYPE_<wbr>ACCEL] &gt;= 2)<br>
> +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
> &nbsp;ec-&gt;has_kb_wake_angle = true;<br>
> +<br>
> &nbsp; &nbsp; &nbsp; &nbsp; if (cros_ec_check_features(ec,
> EC_FEATURE_MOTION_SENSE_FIFO)) {<br>
> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
> sensor_cells[id].name = "cros-ec-ring";<br>
> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; id++;<br>
> @@ -424,6 +418,14 @@ static int ec_device_probe(struct platform_device
> *pdev)<br>
> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; goto failed;<br>
> &nbsp; &nbsp; &nbsp; &nbsp; }<br>
> <br>
> +&nbsp; &nbsp; &nbsp; &nbsp;/* check whether this EC is a sensor hub. */<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;if (cros_ec_check_features(ec,
> EC_FEATURE_MOTION_SENSE))<br>
> +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
> &nbsp;cros_ec_sensors_register(ec);<br>
> +<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;/* Take control of the lightbar from the EC. */<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;lb_manual_suspend_ctrl(ec, 1);<br>
> +<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;/* We can now add the sysfs class, we know
> which parameter to show */<br>
> &nbsp; &nbsp; &nbsp; &nbsp; retval = cdev_device_add(&amp;ec-&gt;cdev,
> &amp;ec-&gt;class_dev);<br>
> &nbsp; &nbsp; &nbsp; &nbsp; if (retval) {<br>
> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; dev_err(dev,
> "cdev_device_add failed =&gt; %d\n", retval);<br>
> @@ -433,13 +435,6 @@ static int ec_device_probe(struct platform_device
> *pdev)<br>
> &nbsp; &nbsp; &nbsp; &nbsp; if (cros_ec_debugfs_init(ec))<br>
> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; dev_warn(dev,
> "failed to create debugfs directory\n");<br>
> <br>
> -&nbsp; &nbsp; &nbsp; &nbsp;/* check whether this EC is a sensor hub. */<br>
> -&nbsp; &nbsp; &nbsp; &nbsp;if (cros_ec_check_features(ec,
> EC_FEATURE_MOTION_SENSE))<br>
> -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
> &nbsp;cros_ec_sensors_register(ec);<br>
> -<br>
> -&nbsp; &nbsp; &nbsp; &nbsp;/* Take control of the lightbar from the EC. */<br>
> -&nbsp; &nbsp; &nbsp; &nbsp;lb_manual_suspend_ctrl(ec, 1);<br>
> -<br>
> &nbsp; &nbsp; &nbsp; &nbsp; return 0;<br>
> <br>
> &nbsp;failed:<br>
> diff --git a/drivers/platform/chrome/<wbr>cros_ec_sysfs.c
> b/drivers/platform/chrome/<wbr>cros_ec_sysfs.c<br>
> index 78ae0d3760e4..5a6db3fe213a 100644<br>
> --- a/drivers/platform/chrome/<wbr>cros_ec_sysfs.c<br>
> +++ b/drivers/platform/chrome/<wbr>cros_ec_sysfs.c<br>
> @@ -258,21 +258,102 @@ static ssize_t flashinfo_show(struct device *dev,<br>
> &nbsp; &nbsp; &nbsp; &nbsp; return ret;<br>
> &nbsp;}<br>
> <br>
> +/* Keyboard wake angle control */<br>
> +static ssize_t kb_wake_angle_show(struct device *dev,<br>
> +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct
> device_attribute *attr, char *buf)<br>
> +{<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;struct cros_ec_dev *ec = to_cros_ec_dev(dev);<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;struct ec_response_motion_sense *resp;<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;struct ec_params_motion_sense *param;<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;struct cros_ec_command *msg;<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;int ret;<br>
> +<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;msg = kmalloc(sizeof(*msg) +
> EC_HOST_PARAM_SIZE, GFP_KERNEL);<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;if (!msg)<br>
> +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return -ENOMEM;<br>
> +<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;param = (struct ec_params_motion_sense
> *)msg-&gt;data;<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;msg-&gt;command = EC_CMD_MOTION_SENSE_CMD
> + ec-&gt;cmd_offset;<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;msg-&gt;version = 2;<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;param-&gt;cmd = MOTIONSENSE_CMD_KB_WAKE_ANGLE;<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;param-&gt;kb_wake_angle.data =
> EC_MOTION_SENSE_NO_VALUE;<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;msg-&gt;outsize = sizeof(*param);<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;msg-&gt;insize = sizeof(*resp);<br>
> +<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;ret =
> cros_ec_cmd_xfer_status(ec-&gt;<wbr>ec_dev, msg);<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;if (ret &lt; 0)<br>
> +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;goto exit;<br>
> +<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;resp = (struct ec_response_motion_sense
> *)msg-&gt;data;<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;ret = scnprintf(buf, PAGE_SIZE, "%d\n",
> resp-&gt;kb_wake_angle.ret);<br>
> +exit:<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;kfree(msg);<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;return ret;<br>
> +}<br>
> +<br>
> +static ssize_t kb_wake_angle_store(struct device *dev,<br>
> +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; struct
> device_attribute *attr,<br>
> +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; const char *buf,
> size_t count)<br>
> +{<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;struct cros_ec_dev *ec = to_cros_ec_dev(dev);<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;struct ec_params_motion_sense *param;<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;struct cros_ec_command *msg;<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;u16 angle;<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;int ret;<br>
> +<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;ret = kstrtou16(buf, 0, &amp;angle);<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;if (ret)<br>
> +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return ret;<br>
> +<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;msg = kmalloc(sizeof(*msg) +
> EC_HOST_PARAM_SIZE, GFP_KERNEL);<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;if (!msg)<br>
> +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return -ENOMEM;<br>
> +<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;param = (struct ec_params_motion_sense
> *)msg-&gt;data;<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;msg-&gt;command = EC_CMD_MOTION_SENSE_CMD
> + ec-&gt;cmd_offset;<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;msg-&gt;version = 2;<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;param-&gt;cmd = MOTIONSENSE_CMD_KB_WAKE_ANGLE;<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;param-&gt;kb_wake_angle.data = angle;<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;msg-&gt;outsize = sizeof(*param);<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;msg-&gt;insize = sizeof(struct
> ec_response_motion_sense);<br>
> +<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;ret =
> cros_ec_cmd_xfer_status(ec-&gt;<wbr>ec_dev, msg);<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;kfree(msg);<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;if (ret &lt; 0)<br>
> +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return ret;<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;return count;<br>
> +}<br>
> +<br>
> &nbsp;/* Module initialization */<br>
> <br>
> &nbsp;static DEVICE_ATTR_RW(reboot);<br>
> &nbsp;static DEVICE_ATTR_RO(version);<br>
> &nbsp;static DEVICE_ATTR_RO(flashinfo);<br>
> +static DEVICE_ATTR_RW(kb_wake_angle);<br>
> <br>
> &nbsp;static struct attribute *__ec_attrs[] = {<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;&amp;dev_attr_kb_wake_angle.attr,<br>
> &nbsp; &nbsp; &nbsp; &nbsp; &amp;dev_attr_reboot.attr,<br>
> &nbsp; &nbsp; &nbsp; &nbsp; &amp;dev_attr_version.attr,<br>
> &nbsp; &nbsp; &nbsp; &nbsp; &amp;dev_attr_flashinfo.attr,<br>
> &nbsp; &nbsp; &nbsp; &nbsp; NULL,<br>
> &nbsp;};<br>
> <br>
> +static umode_t cros_ec_ctrl_visible(struct kobject *kobj,<br>
> +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct
> attribute *a, int n)<br>
> +{<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;struct device *dev = container_of(kobj,
> struct device, kobj);<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;struct cros_ec_dev *ec = to_cros_ec_dev(dev);<br>
> +<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;if (a == &amp;dev_attr_kb_wake_angle.attr
> &amp;&amp; !ec-&gt;has_kb_wake_angle)<br>
> +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return 0;<br>
> +<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;return a-&gt;mode;<br>
> +}<br>
> +<br>
> &nbsp;struct attribute_group cros_ec_attr_group = {<br>
> &nbsp; &nbsp; &nbsp; &nbsp; .attrs = __ec_attrs,<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;.is_visible = cros_ec_ctrl_visible,<br>
> &nbsp;};<br>
> &nbsp;EXPORT_SYMBOL(cros_ec_attr_<wbr>group);<br>
> <br>
> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h<br>
> index c61535979b8f..2d4e23c9ea0a 100644<br>
> --- a/include/linux/mfd/cros_ec.h<br>
> +++ b/include/linux/mfd/cros_ec.h<br>
> @@ -183,6 +183,7 @@ struct cros_ec_debugfs;<br>
> &nbsp; * @ec_dev: cros_ec_device structure to talk to the physical device<br>
> &nbsp; * @dev: pointer to the platform device<br>
> &nbsp; * @debug_info: cros_ec_debugfs structure for debugging information<br>
> + * @has_kb_wake_angle: true if at least 2 accelerometer are connected
> to the EC.<br>
> &nbsp; * @cmd_offset: offset to apply for each command.<br>
> &nbsp; */<br>
> &nbsp;struct cros_ec_dev {<br>
> @@ -191,6 +192,7 @@ struct cros_ec_dev {<br>
> &nbsp; &nbsp; &nbsp; &nbsp; struct cros_ec_device *ec_dev;<br>
> &nbsp; &nbsp; &nbsp; &nbsp; struct device *dev;<br>
> &nbsp; &nbsp; &nbsp; &nbsp; struct cros_ec_debugfs *debug_info;<br>
> +&nbsp; &nbsp; &nbsp; &nbsp;bool has_kb_wake_angle;<br>
> &nbsp; &nbsp; &nbsp; &nbsp; u16 cmd_offset;<br>
> &nbsp; &nbsp; &nbsp; &nbsp; u32 features[2];<br>
> &nbsp;};<br>
> <span class="HOEnZb"><font color="#888888">--<br>
> 2.16.2<br>
> <br>
> </font></span></blockquote></div><br></div>
> 
