Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15813C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7294208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7294208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731938AbeHAWD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 18:03:29 -0400
Received: from www62.your-server.de ([213.133.104.62]:43322 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729647AbeHAWD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 18:03:29 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fkxXK-0006Py-Ju; Wed, 01 Aug 2018 22:15:58 +0200
Received: from [62.203.87.61] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fkxXK-000Nw1-FK; Wed, 01 Aug 2018 22:15:58 +0200
Subject: Re: [PATCH v4 bpf-next 08/14] bpf: introduce the
 bpf_get_local_storage() helper function
To:     Roman Gushchin <guro@fb.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Alexei Starovoitov <ast@kernel.org>
References: <20180727215243.3850-1-guro@fb.com>
 <20180727215243.3850-9-guro@fb.com>
 <ad6c58e3-08a8-aa9c-2d69-528007fe126e@iogearbox.net>
 <20180801002831.GA25953@castle.DHCP.thefacebook.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <82abfd03-1023-e785-a3ba-c63788acc659@iogearbox.net>
Date:   Wed, 1 Aug 2018 22:15:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180801002831.GA25953@castle.DHCP.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24803/Wed Aug  1 18:43:39 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2018 02:28 AM, Roman Gushchin wrote:
> On Wed, Aug 01, 2018 at 12:50:16AM +0200, Daniel Borkmann wrote:
>> On 07/27/2018 11:52 PM, Roman Gushchin wrote:
>> [...]
>>> @@ -2533,6 +2541,16 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
>>>  	}
>>>  
>>>  	regs = cur_regs(env);
>>> +
>>> +	/* check that flags argument in get_local_storage(map, flags) is 0,
>>> +	 * this is required because get_local_storage() can't return an error.
>>> +	 */
>>> +	if (func_id == BPF_FUNC_get_local_storage &&
>>> +	    !tnum_equals_const(regs[BPF_REG_2].var_off, 0)) {
>>> +		verbose(env, "get_local_storage() doesn't support non-zero flags\n");
>>> +		return -EINVAL;
>>> +	}
>>
>> Hmm, this check is actually not correct. You will still be able to pass non-zero
>> values in there. arg2_type from the helper is ARG_ANYTHING, so the register type
>> could for example be one of the pointer types and it will still pass the verifier.
>> The correct way to check would be to use register_is_null().
>>
>>> +
>>>  	/* reset caller saved regs */
>>>  	for (i = 0; i < CALLER_SAVED_REGS; i++) {
>>>  		mark_reg_not_init(env, regs, caller_saved[i]);
> 
> Oh, perfect catch!
> The diff is below. Please, let me know if you prefer me to resend
> the whole patch/patchset.

Yeah, please resend at that point. There are also some other minor things which
would be great if you could roll them in as well in a respin along with this fix
and the uapi helper description adjustment with test case fix:

- patch 1: bpf_map_release_memlock() should also use bpf_uncharge_memlock() directly
- patch 2: cgroup_storage_map_alloc() only checks attr->key_size and attr->value_size
  but what about attr->max_entries and attr->map_flags? Should attr->max_entries be
  forced to 0 and at least attr->map_flags that don't make any sense in this context
  get rejected on map creation?
- patch 9: not all uapi changes were copied over into tools' uapi header

Thanks,
Daniel
