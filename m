Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C307C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C160920839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C160920839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbeILBDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:03:11 -0400
Received: from 13.mo5.mail-out.ovh.net ([87.98.182.191]:44539 "EHLO
        13.mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeILBDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:03:11 -0400
X-Greylist: delayed 4216 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Sep 2018 21:03:10 EDT
Received: from player716.ha.ovh.net (unknown [10.109.160.232])
        by mo5.mail-out.ovh.net (Postfix) with ESMTP id D03981EAAAF
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 20:45:34 +0200 (CEST)
Received: from zorba.kaod.org (LFbn-1-10605-110.w90-89.abo.wanadoo.fr [90.89.196.110])
        (Authenticated sender: postmaster@kaod.org)
        by player716.ha.ovh.net (Postfix) with ESMTPSA id B640F56008E;
        Tue, 11 Sep 2018 20:45:23 +0200 (CEST)
Subject: Re: [PATCH i2c-next v6] i2c: aspeed: Handle master/slave combined irq
 events properly
To:     Guenter Roeck <linux@roeck-us.net>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     linux-aspeed@lists.ozlabs.org,
        James Feist <james.feist@linux.intel.com>,
        openbmc@lists.ozlabs.org,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
References: <20180823225731.19063-1-jae.hyun.yoo@linux.intel.com>
 <20180911183734.GA21976@roeck-us.net>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e16aadd4-09ee-19bf-f7ea-10dc1e491112@kaod.org>
Date:   Tue, 11 Sep 2018 20:45:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180911183734.GA21976@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 958703773954706420
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtjedrjedvgddufedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2018 08:37 PM, Guenter Roeck wrote:
> Hi,
> 
> On Thu, Aug 23, 2018 at 03:57:31PM -0700, Jae Hyun Yoo wrote:
>> In most of cases, interrupt bits are set one by one but there are
>> also a lot of other cases that Aspeed I2C IP sends multiple
>> interrupt bits with combining master and slave events using a
>> single interrupt call. It happens much more in multi-master
>> environment than single-master. For an example, when master is
>> waiting for a NORMAL_STOP interrupt in its MASTER_STOP state,
>> SLAVE_MATCH and RX_DONE interrupts could come along with the
>> NORMAL_STOP in case of an another master immediately sends data
>> just after acquiring the bus. In this case, the NORMAL_STOP
>> interrupt should be handled by master_irq and the SLAVE_MATCH and
>> RX_DONE interrupts should be handled by slave_irq. This commit
>> modifies irq hadling logic to handle the master/slave combined
>> events properly.
>>
>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> 
> This patch causes a boot stall when booting witherspoon-bmc with
> qemu v3.0, and all i2c device probes fail with error -110 (timeout).
> Bisect log is attached for reference.
> 
> With the same kernel configuration (aspeed_g5_defconfig),
> ast2500-evb and romulus-bmc are still able to boot.
> palmetto-bmc with aspeed_g4_defconfig also appears to work.
> 
> Is this a problem with qemu ? Should I drop the qemu test
> for witherspoon-bmc starting with the next kernel release ?

The QEMU model for the Aspeed I2C controller does not support 
slave mode or DMA registers. That might be the issue. 

I will check what this patch does when I have sometime. 

Thanks, 


C.
