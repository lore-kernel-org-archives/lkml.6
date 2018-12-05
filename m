Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B60C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC4D20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC4D20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cambridgegreys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeLENlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 08:41:20 -0500
Received: from ivanoab6.miniserver.com ([5.153.251.140]:60878 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbeLENlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 08:41:20 -0500
X-Greylist: delayed 1498 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Dec 2018 08:41:19 EST
Received: from [192.168.17.6] (helo=smaug.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1gUX1a-00066a-6V; Wed, 05 Dec 2018 13:15:34 +0000
Received: from wyvern.kot-begemot.co.uk ([192.168.3.72])
        by smaug.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1gUX1U-0007WA-NC; Wed, 05 Dec 2018 13:15:33 +0000
Subject: Re: [RFC v3 01/19] kunit: test: add KUnit test runner core
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     brakmo@fb.com, dri-devel@lists.freedesktop.org,
        Alexander.Levin@microsoft.com, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, robh@kernel.org, frowand.list@gmail.com,
        linux-nvdimm@lists.01.org, richard@nod.at, knut.omang@oracle.com,
        kieran.bingham@ideasonboard.com, joel@jms.id.au, jdike@addtoit.com,
        Tim.Bird@sony.com, keescook@google.com,
        linux-um@lists.infradead.org, rostedt@goodmis.org,
        julia.lawall@lip6.fr, levinsasha928@gmail.com,
        dan.j.williams@intel.com, kunit-dev@googlegroups.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        daniel@ffwll.ch, mpe@ellerman.id.au, joe@perches.com,
        khilman@baylibre.com
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-2-brendanhiggins@google.com>
 <20181130031438.GQ4922@garbanzo.do-not-panic.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
Message-ID: <e2ed9df2-c06b-f0d3-d50a-d03166f586df@cambridgegreys.com>
Date:   Wed, 5 Dec 2018 13:15:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181130031438.GQ4922@garbanzo.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2018 03:14, Luis Chamberlain wrote:
> On Wed, Nov 28, 2018 at 11:36:18AM -0800, Brendan Higgins wrote:
>> +#define module_test(module) \
>> +		static int module_kunit_init##module(void) \
>> +		{ \
>> +			return kunit_run_tests(&module); \
>> +		} \
>> +		late_initcall(module_kunit_init##module)
> Here in lies an assumption that suffices. I'm inclined to believe we
> need new initcall level here so to ensure we *do* run after all the
> respective kernels iniut calls. Otherwise we're left at the whims of
> link order for kunit. For instance if a kunit test relies on frameworks
> which are also late_initcall() we'd have complete incompatibility with
> anything linked *after* kunit.
>
>> diff --git a/kunit/Kconfig b/kunit/Kconfig
>> new file mode 100644
>> index 0000000000000..49b44c4f6630a
>> --- /dev/null
>> +++ b/kunit/Kconfig
>> @@ -0,0 +1,17 @@
>> +#
>> +# KUnit base configuration
>> +#
>> +
>> +menu "KUnit support"
>> +
>> +config KUNIT
>> +	bool "Enable support for unit tests (KUnit)"
>> +	depends on UML
> Consider using:
>
> if UML
>     ...
> endif
>
> That allows the depends to be done once.
>
>> +	help
>> +	  Enables support for kernel unit tests (KUnit), a lightweight unit
>> +	  testing and mocking framework for the Linux kernel. These tests are
>> +	  able to be run locally on a developer's workstation without a VM or
>> +	  special hardware.
>
> Some mention of UML may be good here?
>
>> For more information, please see
>> +	  Documentation/kunit/
>> +
>> +endmenu
> I'm a bit conflicted here. This currently depends on UML but yet you
> noted on RFC v2 that your intention is to liberate kunit from UML and
> ideally allow unit tests to depend only on userspace. I've addressed
> tests using both selftests kernels drivers and also re-written kernel
> APIs to userspace to test there. I think we may need to live with both.
>
> Then for the UML stuff, I think if we *really* accept that UML will
> always be a viable option we should probably consider now throwing these
> things under drivers/platform/uml/. This follows the pattern of arch
> specific drivers. Whether or not we end up with a complete userspace

UML platform drivers predate that and are under arch/um/drivers/

We should either keep to current convention or consider relocating the 
existing ones - having things spread in different places around the tree 
is not good in the long run (UML already has a few of those under the 
x86 tree, let's not increase the number).

> component independent of UML may implicate having a shared component
> somewhere else.
>
> Likewise, I realize the goal is to *avoid* using a virtual machine for
> these tests, but would it in any way make sense to share kunit to be
> supported for other architectures to allow easier-to-write tests as
> well?
>
>    Luis
>
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661

