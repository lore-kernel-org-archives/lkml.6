Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933367AbeBMDRK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 22:17:10 -0500
Received: from ozlabs.org ([103.22.144.67]:47085 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933293AbeBMDRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 22:17:09 -0500
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
        hbabu@us.ibm.com, linuxppc-dev@ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] powerpc/vas: Fix cleanup when VAS is not configured
In-Reply-To: <20180212202510.GB28183@us.ibm.com>
References: <1518234567-24869-1-git-send-email-sukadev@linux.vnet.ibm.com> <1518234567-24869-2-git-send-email-sukadev@linux.vnet.ibm.com> <87d11awzkp.fsf@concordia.ellerman.id.au> <20180212202510.GB28183@us.ibm.com>
Date: Tue, 13 Feb 2018 14:17:07 +1100
Message-ID: <87tvulvarw.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:

> Michael Ellerman [mpe@ellerman.id.au] wrote:
>> Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:
>> 
>> > When VAS is not configured in the system, make sure to remove
>> > the VAS debugfs directory and unregister the platform driver.
>> >
>> > Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
>> ...
>> > diff --git a/arch/powerpc/platforms/powernv/vas.c b/arch/powerpc/platforms/powernv/vas.c
>> > index aebbe95..f83e27d8 100644
>> > --- a/arch/powerpc/platforms/powernv/vas.c
>> > +++ b/arch/powerpc/platforms/powernv/vas.c
>> > @@ -169,8 +169,11 @@ static int __init vas_init(void)
>> >  		found++;
>> >  	}
>> >  
>> > -	if (!found)
>> > +	if (!found) {
>> > +		platform_driver_unregister(&vas_driver);
>> > +		vas_cleanup_dbgdir();
>> >  		return -ENODEV;
>> > +	}
>> 
>> The better patch would be to move the call to vas_init_dbgdir() down
>> here, where we know we have successfully registered the driver.
>
> Well, when VAS is configured, init_vas_instance() expects the top level
> "vas" debugfs dir to already be setup.

OK.

> We could have each init_vas_instance() assume it is the first and
> unconditionally call vas_init_dbgdir(). vas_init_dbgdir() could make
> sure to initialize only once.

Yeah that looks like a good solution.

cheers
