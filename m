Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751795AbeBBAZe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 19:25:34 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:38153 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751736AbeBBAZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 19:25:27 -0500
X-Google-Smtp-Source: AH8x226mLG3u3DI5FiJKyhx5+PWWH7HioCqL0qw+MBDTL58P56CZcKG0lsT+H7xeolvgbb3tYKKFEw==
Reply-To: minyard@acm.org
Subject: Re: [PATCH arm/aspeed/ast2500 v3 1/2] ipmi: add a KCS IPMI BMC driver
To: "Wang, Haiyue" <haiyue.wang@linux.intel.com>, minyard@acm.org,
        joel@jms.id.au, openbmc@lists.ozlabs.org,
        openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: andriy.shevchenko@intel.com
References: <1517474936-15308-1-git-send-email-haiyue.wang@linux.intel.com>
 <66b3a8f8-b477-6ada-5ced-944a5b67edd3@acm.org>
 <062c4b58-960a-5023-be75-9b7cd1163783@linux.intel.com>
From: Corey Minyard <tcminyard@gmail.com>
Message-ID: <af22ee18-3b8c-0c47-72bc-053d2b7e738e@gmail.com>
Date: Thu, 1 Feb 2018 18:25:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <062c4b58-960a-5023-be75-9b7cd1163783@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2018 05:56 PM, Wang, Haiyue wrote:
>
>
> On 2018-02-02 04:32, Corey Minyard wrote:
>>> +static void kcs_bmc_handle_cmd(struct kcs_bmc *kcs_bmc)
>>> +{
>>> +    u8 cmd;
>>> +
>>> +    set_state(kcs_bmc, WRITE_STATE);
>>> +    write_data(kcs_bmc, KCS_ZERO_DATA);
>>> +
>>> +    cmd = read_data(kcs_bmc);
>>> +    switch (cmd) {
>>> +    case KCS_CMD_WRITE_START:
>>> +        if (kcs_bmc->phase != KCS_PHASE_IDLE &&
>>> +            kcs_bmc->phase != KCS_PHASE_ERROR) {
>>> +            kcs_force_abort(kcs_bmc);
>>> +            break;
>>> +        }
>>> +
>>
>> The spec says you can do a write start basically any time and the 
>> state machine starts over. I know I kind of went back and forth on 
>> this in my previous email, but what you had before is correct, I think.
>>
> So change it to the bellowing code is OK now? :-)
>
> +    case KCS_CMD_WRITE_START:
> +        kcs_bmc->data_in_avail = false;
> +        kcs_bmc->data_in_idx   = 0;
> +        kcs_bmc->phase         = KCS_PHASE_WRITE;
> +        kcs_bmc->error         = KCS_NO_ERROR;
> +        break;
>
Yes, that should be good.  Sorry about the confusion.
