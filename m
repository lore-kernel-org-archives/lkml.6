Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751725AbeBAX5H (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 18:57:07 -0500
Received: from mga01.intel.com ([192.55.52.88]:54194 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751544AbeBAX46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 18:56:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,444,1511856000";
   d="scan'208";a="200690310"
Subject: Re: [PATCH arm/aspeed/ast2500 v3 1/2] ipmi: add a KCS IPMI BMC driver
To: minyard@acm.org, joel@jms.id.au, openbmc@lists.ozlabs.org,
        openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: andriy.shevchenko@intel.com
References: <1517474936-15308-1-git-send-email-haiyue.wang@linux.intel.com>
 <66b3a8f8-b477-6ada-5ced-944a5b67edd3@acm.org>
From: "Wang, Haiyue" <haiyue.wang@linux.intel.com>
Message-ID: <062c4b58-960a-5023-be75-9b7cd1163783@linux.intel.com>
Date: Fri, 2 Feb 2018 07:56:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <66b3a8f8-b477-6ada-5ced-944a5b67edd3@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-02-02 04:32, Corey Minyard wrote:
>> +static void kcs_bmc_handle_cmd(struct kcs_bmc *kcs_bmc)
>> +{
>> +    u8 cmd;
>> +
>> +    set_state(kcs_bmc, WRITE_STATE);
>> +    write_data(kcs_bmc, KCS_ZERO_DATA);
>> +
>> +    cmd = read_data(kcs_bmc);
>> +    switch (cmd) {
>> +    case KCS_CMD_WRITE_START:
>> +        if (kcs_bmc->phase != KCS_PHASE_IDLE &&
>> +            kcs_bmc->phase != KCS_PHASE_ERROR) {
>> +            kcs_force_abort(kcs_bmc);
>> +            break;
>> +        }
>> +
>
> The spec says you can do a write start basically any time and the 
> state machine starts over. I know I kind of went back and forth on 
> this in my previous email, but what you had before is correct, I think.
>
So change it to the bellowing code is OK now? :-)

+	case KCS_CMD_WRITE_START:
+		kcs_bmc->data_in_avail = false;
+		kcs_bmc->data_in_idx   = 0;
+		kcs_bmc->phase         = KCS_PHASE_WRITE;
+		kcs_bmc->error         = KCS_NO_ERROR;
+		break;

> -corey 
