Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217ADC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A0A2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 09:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A0A2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeJXRoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:44:07 -0400
Received: from www62.your-server.de ([213.133.104.62]:35458 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbeJXRoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 13:44:02 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gFFHM-0004QM-US; Wed, 24 Oct 2018 11:16:40 +0200
Received: from [62.203.87.61] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gFFHM-000PG9-Ka; Wed, 24 Oct 2018 11:16:40 +0200
Subject: Re: [PATCH] bpf: btf: Fix a missing-check bug
To:     Y Song <ys114321@gmail.com>, wang6495@umn.edu
Cc:     kjlu@umn.edu, Alexei Starovoitov <ast@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1539988191-13973-1-git-send-email-wang6495@umn.edu>
 <CAH3MdRV2qLj_3KHFYmCKYHMx2wZk_4mQrdvRJe+znXr3Astm8g@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ff23c4af-9e31-8a79-9c37-95766bff7619@iogearbox.net>
Date:   Wed, 24 Oct 2018 11:16:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAH3MdRV2qLj_3KHFYmCKYHMx2wZk_4mQrdvRJe+znXr3Astm8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25065/Wed Oct 24 06:59:08 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wenwen,

On 10/22/2018 05:57 PM, Y Song wrote:
> On Fri, Oct 19, 2018 at 3:30 PM Wenwen Wang <wang6495@umn.edu> wrote:
>>
>> In btf_parse(), the header of the user-space btf data 'btf_data' is firstly
>> parsed and verified through btf_parse_hdr(). In btf_parse_hdr(), the header
>> is copied from user-space 'btf_data' to kernel-space 'btf->hdr' and then
>> verified. If no error happens during the verification process, the whole
>> data of 'btf_data', including the header, is then copied to 'data' in
>> btf_parse(). It is obvious that the header is copied twice here. More
>> importantly, no check is enforced after the second copy to make sure the
>> headers obtained in these two copies are same. Given that 'btf_data'
>> resides in the user space, a malicious user can race to modify the header
>> between these two copies. By doing so, the user can inject inconsistent
>> data, which can cause undefined behavior of the kernel and introduce
>> potential security risk.
>>
>> To avoid the above issue, this patch rewrites the header after the second
>> copy, using 'btf->hdr', which is obtained in the first copy.
>>
>> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
>> ---
>>  kernel/bpf/btf.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 138f030..2a85f91 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -2202,6 +2202,9 @@ static struct btf *btf_parse(void __user *btf_data, u32 btf_data_size,
>>                 goto errout;
>>         }
>>
>> +       memcpy(data, &btf->hdr,
>> +               min_t(u32, btf->hdr.hdr_len, sizeof(btf->hdr)));
> 
> Could you restructure the code to memcpy the header followed by copying
> the rest of btf_data with copy_from_user? This way, each byte is only
> copied once.
> Could you add some comments right before memcpy so later people will know
> why we implement this way?

Thanks for the fix! Agree with Yonghong that we should rework this a bit, so
please respin a v2 with the feedback addressed, thanks.

>> +
>>         err = btf_parse_str_sec(env);
>>         if (err)
>>                 goto errout;
>> --
>> 2.7.4
>>

