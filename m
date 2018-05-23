Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932980AbeEWNTN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 09:19:13 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45365 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932844AbeEWNTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 09:19:11 -0400
X-Google-Smtp-Source: AB8JxZpXqL295Ppp3fHuXGKPFof9CT9BCglW8nPWbUw0akuQ5FDo4qclaDFOvwQtIXxWJg/2j4okCw==
Subject: Re: [PATCH V3] powercap/drivers/idle_injection: Add an idle injection
 framework
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, edubezval@gmail.com, kevin.wangtao@linaro.org,
        leo.yan@linaro.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        daniel.thompson@linaro.org
References: <1526655056-24592-1-git-send-email-daniel.lezcano@linaro.org>
 <20180521103223.asejwsaf7pnrs777@vireshk-i7>
 <7ff0d7d4-be5e-2384-1201-df8616519892@linaro.org>
 <20180523054154.fvhnwgvq34ihivdj@vireshk-i7>
 <61c2b628-6c38-463a-c6b5-5e5b7eeee1ab@linaro.org>
 <20180523095549.mbit5plvqoppnasu@vireshk-i7>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ff76b27a-b286-2e7f-d87e-bc5c9444937b@linaro.org>
Date: Wed, 23 May 2018 15:19:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180523095549.mbit5plvqoppnasu@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2018 11:55, Viresh Kumar wrote:
> On 23-05-18, 10:00, Daniel Lezcano wrote:

[ ... ]

> Maybe I wasn't able to explain the problem I see, but lemme retry
> that. Assume that there is only one use and that id cpu-idle-cooling.
> We are currently running the idle loop with idle duration X and run
> duration Y.
> 
> Now lets say the cooling device gets unregistered itself (maybe module
> removal, etc). And it calls idle_injection_unregister() with a valid
> pointer. Not sure if the thermal framework will call set_cur_state
> anymore. But the problem will remain even if it does that.
> 
> We call idle_injection_stop() from unregister, which will cancel
> hrtimer, set durations as 0 and return. Then we free the iidev. It is
> certainly possible at this point of time that the kthread is still
> running the idle loop which it may have started before unregister was
> called. And so after the idle loop is finished it will try to access
> ii_dev, which is already freed.
> 
> So, idle_injection_stop() needs to guarantee that the kthread and the
> hrtimer are all stopped now and no one is using the ii_dev structure
> anymore.
> 
> Perhaps you need some completion stuff here to give confirmation here,
> etc.

Ok, let me come back with something.

Thanks for reviewing again.

  -- Daniel



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
