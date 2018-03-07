Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754287AbeCGKua (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 05:50:30 -0500
Received: from regular1.263xmail.com ([211.150.99.132]:47973 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751224AbeCGKu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 05:50:28 -0500
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: broonie@kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <fe41a5bcd602a5542f5ccedb997240c0>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Message-ID: <5A9FC3E0.5020600@rock-chips.com>
Date: Wed, 07 Mar 2018 18:50:08 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To: Mark Brown <broonie@kernel.org>
CC: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 1/3] mfd: syscon: Set name of regmap_config
References: <20180306110403.14438-1-jeffy.chen@rock-chips.com> <5A9EAC92.4050702@rock-chips.com> <20180307102006.GA7290@sirena.org.uk>
In-Reply-To: <20180307102006.GA7290@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 03/07/2018 06:20 PM, Mark Brown wrote:
> On Tue, Mar 06, 2018 at 10:58:26PM +0800, JeffyChen wrote:
>
>> even this is already fixed by a430ab205d29 ("regmap: debugfs: Disambiguate
>> dummy debugfs file name")
>
>> but maybe we can still have this for a better debugfs name?
>
> That's why the facility is there.
>
> Please don't top post, reply in line with needed context.  This allows
> readers to readily follow the flow of conversation and understand what
> you are talking about and also helps ensure that everything in the
> discussion is being addressed.
>
ok, sorry for that :)

recently we are now allowing to register debugfs for syscon regmap, then 
i hit a lot of:
(NULL device *): Failed to create debugfs directory

so i sent this patch to fix that by using the of_node name to create 
debugfs.

but later i found we have:
commit a430ab205d29e7d1537b220fcf989b8080d8267f
Author: Fabio Estevam <fabio.estevam@nxp.com>
Date:   Mon Mar 5 15:52:09 2018 -0300

     regmap: debugfs: Disambiguate dummy debugfs file name

which would fix that in another way by naming dummy0, dummy1, dummy2.

even if the issue is fixed, i wonder could we still have this patch to 
make it more readable:

+++ b/drivers/mfd/syscon.c
@@ -109,6 +109,7 @@ static struct syscon *of_syscon_register(struct 
device_node *np)
         syscon_config.reg_stride = reg_io_width;
         syscon_config.val_bits = reg_io_width * 8;
         syscon_config.max_register = resource_size(&res) - reg_io_width;
+       syscon_config.name = of_node_full_name(np);




and i've sent 2 more patches to fix the memleak there:
https://patchwork.kernel.org/patch/10261409
https://patchwork.kernel.org/patch/10261411

and sorry again, i forgot to add a cover letter, and i should CC you the 
whole series.
