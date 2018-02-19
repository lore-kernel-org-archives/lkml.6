Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752678AbeBSLus (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 06:50:48 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58008 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752563AbeBSLur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 06:50:47 -0500
Cc: Sudeep Holla <sudeep.holla@arm.com>,
        ALKML <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>,
        Roy Franz <roy.franz@cavium.com>,
        Harb Abdulhamid <harba@codeaurora.org>, Nishanth Menon <nm@ti.com>,
        Loc Ho <lho@apm.com>, Alexey Klimov <klimov.linux@gmail.com>,
        Ryan Harkin <Ryan.Harkin@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH v5 11/20] firmware: arm_scmi: add support for polling
 based SCMI transfers
To: Arnd Bergmann <arnd@arndb.de>
References: <1514904162-11201-1-git-send-email-sudeep.holla@arm.com>
 <1514904162-11201-12-git-send-email-sudeep.holla@arm.com>
 <CAK8P3a31CMsLUSm0rsHLdvM4sbjZ6fwocKmA1JiuCtF97vj3PQ@mail.gmail.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <d1acd809-48d0-5889-0eb1-e52b68445dfe@arm.com>
Date: Mon, 19 Feb 2018 11:50:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a31CMsLUSm0rsHLdvM4sbjZ6fwocKmA1JiuCtF97vj3PQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/02/18 11:32, Arnd Bergmann wrote:
> On Tue, Jan 2, 2018 at 3:42 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> 
>> +#define SCMI_MAX_POLLING_TIMEOUT_NS    (100 * NSEC_PER_USEC)
>>  /**
>>   * scmi_do_xfer() - Do one transfer
>>   *
>> @@ -389,14 +406,30 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
> 
>> +       if (xfer->hdr.poll_completion) {
>> +               ktime_t stop, cur;
>> +
>> +               stop = ktime_add_ns(ktime_get(), SCMI_MAX_POLLING_TIMEOUT_NS);
>> +               do {
>> +                       udelay(5);
>> +                       cur = ktime_get();
>> +               } while (!scmi_xfer_poll_done(info, xfer) &&
>> +                        ktime_before(cur, stop));
> 
> The 5 microsecond back-off isn't that much smaller than the 100 microsecond
> timeout, given that udelay() often waits much longer than the specified time.
> 
> How did you come up with those two numbers? Are you sure this is better
> than just using a cpu_relax() instead of the udelay()?
> 

Somehow I assumed that cpu_relax will schedule out and since this is
called in the fast switching path, I can't do that. But now I see that
it's just an hint and so I can use it. Sorry for missing it earlier, you
did point this out in previous version and I retained it based on my
wrong assumption. Thanks.

-- 
Regards,
Sudeep
