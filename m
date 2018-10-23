Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD47C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B9420824
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CV5ze7/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6B9420824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbeJXENY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 00:13:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725740AbeJXENY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 00:13:24 -0400
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C863B20671;
        Tue, 23 Oct 2018 19:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540324113;
        bh=+GZ7dmsYDNS1RXziMK2uPb0GmUtrniDrYvCjC+m9WFs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CV5ze7/JREUyg8FFRo116jRZKvxTlOOVQhpvsqxTv4JUeJ1CnpfygH4l7dbaTsnVl
         eyVjSST45CGcIhAn5SwgP6/A0ArAQypdEFESW3Ud2Jxw7VnLo6im2lbeWKuV1E5cwu
         2Nf3tVLy/biIOnGtheu/eFZ3ZjI5dCgIJUwbaQQk=
Subject: Re: [RFC PATCH 0/2] improve vmalloc allocation
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>,
        maco@android.com, Shuah Khan <shuah@kernel.org>
References: <20181019173538.590-1-urezki@gmail.com>
 <20181022125142.GD18839@dhcp22.suse.cz>
 <20181022165253.uphv3xzqivh44o3d@pc636>
 <20181023072306.GN18839@dhcp22.suse.cz>
 <dd0c3528-9c01-12bc-3400-ca88060cb7cf@kernel.org>
 <20181023152640.GD20085@bombadil.infradead.org>
 <20181023170532.GW18839@dhcp22.suse.cz>
 <98842edb-d462-96b1-311f-27c6ebfc108a@kernel.org>
 <20181023193044.GA139403@joelaf.mtv.corp.google.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <024af44a-77e1-1c61-c9b2-64ffbe4f7c49@kernel.org>
Date:   Tue, 23 Oct 2018 13:48:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181023193044.GA139403@joelaf.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/2018 01:30 PM, Joel Fernandes wrote:
> On Tue, Oct 23, 2018 at 11:13:36AM -0600, Shuah Khan wrote:
>> On 10/23/2018 11:05 AM, Michal Hocko wrote:
>>> On Tue 23-10-18 08:26:40, Matthew Wilcox wrote:
>>>> On Tue, Oct 23, 2018 at 09:02:56AM -0600, Shuah Khan wrote:
>>> [...]
>>>>> The way it can be handled is by adding a test module under lib. test_kmod,
>>>>> test_sysctl, test_user_copy etc.
>>>>
>>>> The problem is that said module can only invoke functions which are
>>>> exported using EXPORT_SYMBOL.  And there's a cost to exporting them,
>>>> which I don't think we're willing to pay, purely to get test coverage.
>>>
>>> Yes, I think we do not want to export internal functionality which might
>>> be still interesting for the testing coverage. Maybe we want something
>>> like EXPORT_SYMBOL_KSELFTEST which would allow to link within the
>>> kselftest machinery but it wouldn't allow the same for general modules
>>> and will not give any API promisses.
>>>
>>
>> I like this proposal. I think we will open up lot of test opportunities with
>> this approach.
>>
>> Maybe we can use this stress test as a pilot and see where it takes us.
> 
> I am a bit worried that such an EXPORT_SYMBOL_KSELFTEST mechanism can be abused by
> out-of-tree module writers to call internal functionality.

That is  valid concern to consider before we go forward with the proposal.

We could wrap EXPORT_SYMBOL_KSELFTEST this in an existing debug option. This could
be fine grained for each sub-system for its debug option. We do have a few of these
now

# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_BT_SELFTEST is not set
# CONFIG_DRM_DEBUG_SELFTEST is not set
# CONFIG_CHASH_SELFTEST is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_RANDOM32_SELFTEST is not set
# CONFIG_GLOB_SELFTEST is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_X86_DECODER_SELFTEST is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set

thanks,
-- Shuah



