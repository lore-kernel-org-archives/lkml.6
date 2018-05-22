Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751673AbeEVSdr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 14:33:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39034 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751469AbeEVSdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 14:33:44 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 22 May 2018 11:33:43 -0700
From: rishabhb@codeaurora.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm@lists.infradead.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, evgreen@chromium.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 2/2] drivers: soc: Add LLCC driver
In-Reply-To: <CAHp75VdO7+u-PQ+RBH71sxHHG0WkAyEVxv0BNPaycbcRnrZang@mail.gmail.com>
References: <1526492623-20527-1-git-send-email-rishabhb@codeaurora.org>
 <1526492623-20527-3-git-send-email-rishabhb@codeaurora.org>
 <CAHp75VdO7+u-PQ+RBH71sxHHG0WkAyEVxv0BNPaycbcRnrZang@mail.gmail.com>
Message-ID: <f1970a64be17267e0f044242dc0764d6@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-18 14:01, Andy Shevchenko wrote:
> On Wed, May 16, 2018 at 8:43 PM, Rishabh Bhatnagar
> <rishabhb@codeaurora.org> wrote:
>> LLCC (Last Level Cache Controller) provides additional cache memory
>> in the system. LLCC is partitioned into multiple slices and each
>> slice gets its own priority, size, ID and other config parameters.
>> LLCC driver programs these parameters for each slice. Clients that
>> are assigned to use LLCC need to get information such size & ID of the
>> slice they get and activate or deactivate the slice as needed. LLCC 
>> driver
>> provides API for the clients to perform these operations.
> 
>> +static const struct of_device_id sdm845_qcom_llcc_of_match[] = {
>> +       { .compatible = "qcom,sdm845-llcc", },
> 
>> +       { },
> 
> Slightly better w/o comma
Changed
> 
>> +};
> 
>> +static struct platform_driver sdm845_qcom_llcc_driver = {
>> +       .driver = {
>> +               .name = "sdm845-llcc",
> 
>> +               .owner = THIS_MODULE,
> 
> No need. See below.
> 
>> +               .of_match_table = sdm845_qcom_llcc_of_match,
>> +       },
>> +       .probe = sdm845_qcom_llcc_probe,
>> +};
> 
>> +
>> +static int __init sdm845_init_qcom_llcc_init(void)
>> +{
>> +       return platform_driver_register(&sdm845_qcom_llcc_driver);
>> +}
>> +module_init(sdm845_init_qcom_llcc_init);
>> +
>> +static void __exit sdm845_exit_qcom_llcc_exit(void)
>> +{
>> +       platform_driver_unregister(&sdm845_qcom_llcc_driver);
>> +}
>> +module_exit(sdm845_exit_qcom_llcc_exit);
> 
> Why not to use module_platform_driver() macro?
Done
> 
>> +#define ACTIVATE                      0x1
>> +#define DEACTIVATE                    0x2
>> +#define ACT_CTRL_OPCODE_ACTIVATE      0x1
>> +#define ACT_CTRL_OPCODE_DEACTIVATE    0x2
>> +#define ACT_CTRL_ACT_TRIG             0x1
> 
> Are these bits? Perhaps BIT() ?
> 
isn't it just better to use fixed size as u suggest in the next comment?

>> +#define ACT_CTRL_OPCODE_SHIFT         0x1
>> +#define ATTR1_PROBE_TARGET_WAYS_SHIFT 0x2
>> +#define ATTR1_FIXED_SIZE_SHIFT        0x3
>> +#define ATTR1_PRIORITY_SHIFT          0x4
>> +#define ATTR1_MAX_CAP_SHIFT           0x10
> 
> Better to use fixed size pattern, i.e. 0x01, 0x02, 0x03, 0x04, 0x10.
> 
>> +#define ATTR0_RES_WAYS_MASK           0x00000fff
>> +#define ATTR0_BONUS_WAYS_MASK         0x0fff0000
> 
> GENMASK()
Done
> 
>> +#define LLCC_LB_CNT_MASK               0xf0000000
> 
> Ditto.
> 
>> +#define MAX_CAP_TO_BYTES(n) (n * 1024)
> 
> (n * SZ_1K) ?
Done
> 
>> +#define LLCC_TRP_ACT_CTRLn(n) (n * 0x1000)
> 
> SZ_4K ?
> 
>> +#define LLCC_TRP_STATUSn(n)   (4 + n * 0x1000)
> 
> Ditto.
> 
>> +struct llcc_slice_desc *llcc_slice_getd(u32 uid)
>> +{
>> +       const struct llcc_slice_config *cfg;
>> +       struct llcc_slice_desc *desc;
>> +       u32 sz, count = 0;
>> +
>> +       cfg = drv_data->cfg;
>> +       sz = drv_data->cfg_size;
>> +
> 
>> +       while (cfg && count < sz) {
>> +               if (cfg->usecase_id == uid)
>> +                       break;
>> +               cfg++;
>> +               count++;
>> +       }
>> +       if (cfg == NULL || count == sz)
>> +               return ERR_PTR(-ENODEV);
> 
> if (!cfg)
>           return ERR_PTR(-ENODEV);
> 
> while (cfg->... != uid) {
>   cfg++;
>   count++;
> }
> 
> if (count == sz)
>  return ...
> 
> Though I would rather put it to for () loop.
> 
In each while loop iteration the cfg pointer needs to be checked for
NULL. What if the usecase id never matches the uid passed by client
and we keep iterating. At some point it will crash.

>> +static int llcc_update_act_ctrl(u32 sid,
>> +                               u32 act_ctrl_reg_val, u32 status)
>> +{
>> +       u32 act_ctrl_reg;
>> +       u32 status_reg;
>> +       u32 slice_status;
> 
>> +       int ret = 0;
> 
> Useless assignment. Check entire patch series for a such.
Checked and  removed these.
> 
>> +       ret = regmap_read_poll_timeout(drv_data->regmap, status_reg,
>> +       slice_status, !(slice_status & status), 0, 
>> LLCC_STATUS_READ_DELAY);
> 
> Wrong indentation.
Corrected
> 
>> +       return ret;
>> +}
> 
>> +       ret = llcc_update_act_ctrl(desc->slice_id, act_ctrl_val,
>> +                                 DEACTIVATE);
> 
> Perhaps one line (~83 characters here is OK) ?
The checkpatch script complains about such lines.
> 
>> +       ret = llcc_update_act_ctrl(desc->slice_id, act_ctrl_val,
>> +                                 ACTIVATE);
> 
> Ditto.
> 
>> +               attr1_cfg = bcast_off +
>> +                               
>> LLCC_TRP_ATTR1_CFGn(llcc_table[i].slice_id);
>> +               attr0_cfg = bcast_off +
>> +                               
>> LLCC_TRP_ATTR0_CFGn(llcc_table[i].slice_id);
> 
> Ditto.
> 
>> +               attr1_val |= llcc_table[i].probe_target_ways <<
>> +                               ATTR1_PROBE_TARGET_WAYS_SHIFT;
>> +               attr1_val |= llcc_table[i].fixed_size <<
>> +                               ATTR1_FIXED_SIZE_SHIFT;
>> +               attr1_val |= llcc_table[i].priority << 
>> ATTR1_PRIORITY_SHIFT;
> 
> foo |=
>   bar << SHIFT;
> 
> would look slightly better.
> 
>> +int qcom_llcc_probe(struct platform_device *pdev,
>> +                     const struct llcc_slice_config *llcc_cfg, u32 
>> sz)
>> +{
> 
>> +       drv_data->offsets = devm_kzalloc(dev, num_banks * sizeof(u32),
>> +                                                       GFP_KERNEL);
>> +       if (!drv_data->offsets)
>> +               return -ENOMEM;
> 
> devm_kcalloc() ?
changed
>> +
>> +       for (i = 0; i < num_banks; i++)
>> +               drv_data->offsets[i] = (i * BANK_OFFSET_STRIDE);
> 
> Pointless parens.
Removed
> 
>> +       drv_data->bitmap = devm_kcalloc(dev,
>> +       BITS_TO_LONGS(drv_data->max_slices), sizeof(unsigned long),
>> +                                               GFP_KERNEL);
>> +       if (!drv_data->bitmap)
>> +               return -ENOMEM;
> 
> Perhaps at some point someone will add
> bitmap_alloc()
> devm_bitmap_alloc()
> 
>> +       bitmap_zero(drv_data->bitmap, drv_data->max_slices);
> 
> Pointless
Removed
