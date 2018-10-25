Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAE0C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DCA0207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DCA0207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbeJZHdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 03:33:11 -0400
Received: from www62.your-server.de ([213.133.104.62]:50448 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbeJZHdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 03:33:11 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gFoaG-0000OX-Jl; Fri, 26 Oct 2018 00:58:32 +0200
Received: from [62.203.87.61] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gFoaG-0008Ca-Eb; Fri, 26 Oct 2018 00:58:32 +0200
Subject: Re: [PATCH v2] bpf: btf: Fix a missing-check bug
To:     Martin Lau <kafai@fb.com>, Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, Alexei Starovoitov <ast@kernel.org>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <netdev@vger.kernel.org>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <linux-kernel@vger.kernel.org>
References: <1540386020-30680-1-git-send-email-wang6495@umn.edu>
 <20181024172514.l33dsaqdvs5yewvm@kafai-mbp>
 <20181024182239.lz7uicceihzmxabh@kafai-mbp>
 <20181024203548.glxgu3bqd47minmg@kafai-mbp>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7a5a0bb9-ce61-b9e8-7362-32dac8823700@iogearbox.net>
Date:   Fri, 26 Oct 2018 00:58:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181024203548.glxgu3bqd47minmg@kafai-mbp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25067/Wed Oct 24 23:01:03 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/2018 10:42 PM, Martin Lau wrote:
> On Wed, Oct 24, 2018 at 06:22:46PM +0000, Martin Lau wrote:
>> On Wed, Oct 24, 2018 at 05:26:23PM +0000, Martin Lau wrote:
>>> On Wed, Oct 24, 2018 at 08:00:19AM -0500, Wenwen Wang wrote:
>>>> In btf_parse(), the header of the user-space btf data 'btf_data' is firstly
>>>> parsed and verified through btf_parse_hdr(). In btf_parse_hdr(), the header
>>>> is copied from user-space 'btf_data' to kernel-space 'btf->hdr' and then
>>>> verified. If no error happens during the verification process, the whole
>>>> data of 'btf_data', including the header, is then copied to 'data' in
>>>> btf_parse(). It is obvious that the header is copied twice here. More
>>>> importantly, no check is enforced after the second copy to make sure the
>>>> headers obtained in these two copies are same. Given that 'btf_data'
>>>> resides in the user space, a malicious user can race to modify the header
>>>> between these two copies. By doing so, the user can inject inconsistent
>>>> data, which can cause undefined behavior of the kernel and introduce
>>>> potential security risk.
>> btw, I am working on a patch that copies the btf_data before parsing/verifying
>> the header.  That should avoid this from happening but that will
>> require a bit more code churns for the bpf branch.
>>
> It is what I have in mind:
> 
> It is not a good idea to check the BTF header before copying the
> user btf_data.  The verified header may not be the one actually
> copied to btf->data (e.g. userspace may modify the passed in
> btf_data in between).  Like the one fixed in
> commit 8af03d1ae2e1 ("bpf: btf: Fix a missing check bug").
> 
> This patch copies the user btf_data before parsing/verifying
> the BTF header.
> 
> Fixes: 69b693f0aefa ("bpf: btf: Introduce BPF Type Format (BTF)")
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>

I've added Co-developed-by tag and applied it to bpf tree, thanks everyone!
