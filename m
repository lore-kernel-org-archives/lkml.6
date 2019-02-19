Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8D6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7398E20838
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbfBSHMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:12:15 -0500
Received: from mx.socionext.com ([202.248.49.38]:33038 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfBSHMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:12:14 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 19 Feb 2019 16:12:13 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 54F256117D;
        Tue, 19 Feb 2019 16:12:13 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Tue, 19 Feb 2019 16:12:13 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id D3E8A4039E;
        Tue, 19 Feb 2019 16:12:12 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
        by yuzu.css.socionext.com (Postfix) with ESMTP id C169C121B6C;
        Tue, 19 Feb 2019 16:12:12 +0900 (JST)
Subject: Re: [PATCH v2 04/15] ARM: milbeaut: Add basic support for Milbeaut
 m10v SoC
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
References: <1549628778-30785-1-git-send-email-sugaya.taichi@socionext.com>
 <CAK8P3a026P7tZpJ7gsZbf_MnJJ0eVv60ggGXYndX9kCDLpNy4Q@mail.gmail.com>
From:   "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <7266af3b-aeec-4c29-c96e-ee0d21d3e867@socionext.com>
Date:   Tue, 19 Feb 2019 16:12:11 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a026P7tZpJ7gsZbf_MnJJ0eVv60ggGXYndX9kCDLpNy4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for your comments.

On 2019/02/18 21:15, Arnd Bergmann wrote:
> On Fri, Feb 8, 2019 at 1:26 PM Sugaya Taichi
> <sugaya.taichi@socionext.com> wrote:
> 
>> +static int m10v_pm_enter(suspend_state_t state)
>> +{
>> +       switch (state) {
>> +       case PM_SUSPEND_STANDBY:
>> +               pr_err("STANDBY\n");
>> +               asm("wfi");
>> +               break;
>> +       case PM_SUSPEND_MEM:
>> +               pr_err("SUSPEND\n");
>> +               cpu_pm_enter();
>> +               cpu_suspend(0, m10v_die);
>> +               cpu_pm_exit();
>> +               break;
>> +       }
>> +       return 0;
>> +}
> 
> It looks like you left the pr_err() messages from bringup, they should probably
> be removed now.
> 

OK. remove the pr_err()s.


>> +static int __init m10v_pm_init(void)
>> +{
>> +       suspend_set_ops(&m10v_pm_ops);
>> +
>> +       return 0;
>> +}
>> +late_initcall(m10v_pm_init);
> 
> This requires a check to ensure you are actually on the right platform,
> otherwise you break suspend/resume in a multiplatform kernel running
> on anything other than milbeaut.
>

OK.
I think the solution is adding a "if statement with mlbeaut compatible" 
above suspend_set_ops(&m10v_pm_ops).

Thanks,
Sugaya Taichi


>         Arnd
> 

