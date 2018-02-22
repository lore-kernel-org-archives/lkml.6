Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932161AbeBVL4Z (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 06:56:25 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:46843 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753649AbeBVL4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 06:56:23 -0500
X-Google-Smtp-Source: AH8x22713UMIjwtf24X/16ryltHbbDFvzP+leghMXPa0eNG2wzHW0/R7DtfL4a0E03JMI1pZEyayvkNzJHs494LxV/k=
MIME-Version: 1.0
In-Reply-To: <201802220830.S3PHpwWI%fengguang.wu@intel.com>
References: <20180221144909.13461-3-enric.balletbo@collabora.com> <201802220830.S3PHpwWI%fengguang.wu@intel.com>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Thu, 22 Feb 2018 12:56:22 +0100
Message-ID: <CAFqH_508wFpG8QRTrYKddiO9Cs0-oPSagGS6hkjvzQuQzROUxQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] platform/chrome: cros_ec_debugfs: Add PD port info to debugfs
To: kbuild test robot <lkp@intel.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        kbuild-all@01.org, Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Shawn Nematbakhsh <shawnn@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

2018-02-22 1:25 GMT+01:00 kbuild test robot <lkp@intel.com>:
> Hi Shawn,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on ljones-mfd/for-mfd-next]
> [also build test ERROR on v4.16-rc2 next-20180221]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Enric-Balletbo-i-Serra/platform-chrome-cros_ec-debugfs-and-sysfs-updates/20180222-074242
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
> config: i386-randconfig-s0-201807 (attached as .config)
> compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386
>
> All errors (new ones prefixed by >>):
>
>    drivers/platform/chrome/cros_ec_debugfs.c: In function 'cros_ec_pdinfo_read':
>>> drivers/platform/chrome/cros_ec_debugfs.c:221:16: error: 'EC_USB_PD_MAX_PORTS' undeclared (first use in this function)
>      char read_buf[EC_USB_PD_MAX_PORTS * 40], *p = read_buf;
>                    ^~~~~~~~~~~~~~~~~~~
>    drivers/platform/chrome/cros_ec_debugfs.c:221:16: note: each undeclared identifier is reported only once for each function it appears in
>    drivers/platform/chrome/cros_ec_debugfs.c:221:7: warning: unused variable 'read_buf' [-Wunused-variable]
>      char read_buf[EC_USB_PD_MAX_PORTS * 40], *p = read_buf;
>           ^~~~~~~~
>    drivers/platform/chrome/cros_ec_debugfs.c:269:1: warning: control reaches end of non-void function [-Wreturn-type]
>     }
>     ^
>
> vim +/EC_USB_PD_MAX_PORTS +221 drivers/platform/chrome/cros_ec_debugfs.c
>
>    215
>    216  static ssize_t cros_ec_pdinfo_read(struct file *file,
>    217                                     char __user *user_buf,
>    218                                     size_t count,
>    219                                     loff_t *ppos)
>    220  {
>  > 221          char read_buf[EC_USB_PD_MAX_PORTS * 40], *p = read_buf;
>    222          struct cros_ec_debugfs *debug_info = file->private_data;
>    223          struct cros_ec_device *ec_dev = debug_info->ec->ec_dev;
>    224
>    225          struct {
>    226                  struct cros_ec_command msg;
>    227                  union {
>    228                          struct ec_response_usb_pd_control_v1 resp;
>    229                          struct ec_params_usb_pd_control params;
>    230                  };
>    231          } __packed ec_buf;
>    232
>    233          struct cros_ec_command *msg;
>    234          struct ec_response_usb_pd_control_v1 *resp;
>    235          struct ec_params_usb_pd_control *params;
>    236
>    237          int i;
>    238
>    239          msg = &ec_buf.msg;
>    240          params = (struct ec_params_usb_pd_control *)msg->data;
>    241          resp = (struct ec_response_usb_pd_control_v1 *)msg->data;
>    242
>    243          msg->command = EC_CMD_USB_PD_CONTROL;
>    244          msg->version = 1;
>    245          msg->insize = sizeof(*resp);
>    246          msg->outsize = sizeof(*params);
>    247
>    248          /*
>    249           * Read status from all PD ports until failure, typically caused
>    250           * by attempting to read status on a port that doesn't exist.
>    251           */
>    252          for (i = 0; i < EC_USB_PD_MAX_PORTS; ++i) {
>    253                  params->port = i;
>    254                  params->role = 0;
>    255                  params->mux = 0;
>    256                  params->swap = 0;
>    257
>    258                  if (cros_ec_cmd_xfer_status(ec_dev, msg) < 0)
>    259                          break;
>    260
>    261                  p += scnprintf(p, sizeof(read_buf) + read_buf - p,
>    262                          "p%d: %s en:%.2x role:%.2x pol:%.2x\n",
>    263                          i, resp->state, resp->enabled, resp->role,
>    264                          resp->polarity);
>    265          }
>    266
>    267          return simple_read_from_buffer(user_buf, count, ppos,
>    268                                         read_buf, p - read_buf);
>    269  }
>    270
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

Looks like I missed to add a dependency on this patch [1] here. I
think that the series that contains the dependency is farther to be
accepted than these. So maybe what we could do is include the missing
dependency here. What would you prefer, I send a new version with the
missing patch included or you just pick the patch from the other
series? The patch was already acked by you.

Thanks,
  Enric

[1] https://lkml.org/lkml/2018/1/23/217
