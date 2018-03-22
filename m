Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbeCVTep (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 15:34:45 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:60028 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751617AbeCVTeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 15:34:44 -0400
Date: Thu, 22 Mar 2018 15:34:42 -0400 (EDT)
Message-Id: <20180322.153442.967912156804832743.davem@davemloft.net>
To: salil.mehta@huawei.com
Cc: yisen.zhuang@huawei.com, mehta.salil.lnk@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH net-next 0/9] Add support of VF Reset to HNS3 VF driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180322142900.22860-1-salil.mehta@huawei.com>
References: <20180322142900.22860-1-salil.mehta@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Salil Mehta <salil.mehta@huawei.com>
Date: Thu, 22 Mar 2018 14:28:51 +0000

> This patch-set adds the support of VF reset to the existing VF driver.
> VF Reset can be triggered due to TX watchdog firing  as a result of TX
> data-path not working. VF reset could also be a result of some internal
> configuration changes if that requires reset, or as a result of the
> PF/Core/Global/IMP(Integrated Management Processor) reset happened in
> the PF. 
> 
> Summary of Patches:
> * Watchdog timer trigger chnages are present in Patch 1.
> * Reset Service Task and related Event handling is present in Patches {2,3}
> * Changes to send reset request to PF, reset stack and re-initialization
>   of the hclge device is present in Patches {4,5,6}
> * Changes related to ARQ (Asynchronous Receive Queue) and its event handling
>   are present in Patches {7,8}
> * Changes required in PF to handle the VF Reset request and actually perform
>   hardware VF reset is there in Patch 9.
> 
> 
> NOTE: This patch depends upon "[PATCH net-next 00/11] fix some bugs for HNS3 driver"
> 	Link: https://lkml.org/lkml/2018/3/21/72

Series applied, thank you.

Please audit your usage of the various reset state bits.

In most places you do the correct atomic sequence by making use of
test_and_set_bit() and test_and_clear_bit().

But in some cases you do things like:

	if (!test_bit(X) && !test_bit(Y)) {
	...
		set_bit(Y);
	}

which is racy.
