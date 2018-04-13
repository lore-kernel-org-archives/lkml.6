Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753250AbeDMHcH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 03:32:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51676 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeDMHcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 03:32:05 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3F6EC60BFA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=gkohli@codeaurora.org
To: tj@kernel.org, nborisov@suse.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
From: "Kohli, Gaurav" <gkohli@codeaurora.org>
Subject: Query:Regarding percpu_counter debug object destroy
Message-ID: <0754201b-2051-3f1c-7a09-ed1be96a0260@codeaurora.org>
Date: Fri, 13 Apr 2018 13:02:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,

I have checked below code and it seems we are calling debug_object_free twice, ideally we should deactivate and later we
have to destroy.

1st call -> percpu_counter_destroy->debug_percpu_counter_deactivate -> debug_object_free
2nd call ->
debug_object_free



static bool percpu_counter_fixup_free(void *addr, enum debug_obj_state state)
{
         struct percpu_counter *fbc = addr;

         switch (state) {
         case ODEBUG_STATE_ACTIVE:
                 percpu_counter_destroy(fbc);  -> first call
                 debug_object_free(fbc, &percpu_counter_debug_descr); 2nd call
                 return true;
         default:
                 return false;
         }
}


We are seeing one issue, where one list contain garbage data in obj_hash, just before element of that is percpu_counter but
still not sure as it is very difficult to reproduce.

Can some one please review above code or can we remove one instance of debug_object_free from above code.

Regards
Gaurav

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
