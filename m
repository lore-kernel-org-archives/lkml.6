Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05214C46471
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED4B216FC
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED4B216FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbeHHDOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 23:14:37 -0400
Received: from mout.gmx.net ([212.227.17.22]:58445 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbeHHDOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 23:14:37 -0400
Received: from [192.168.166.33] ([220.112.58.66]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MbKXI-1fWlpk2G8a-00Ij2V; Wed, 08
 Aug 2018 02:57:21 +0200
Subject: Re: [PATCH] mm: adjust max read count in generic_file_buffered_read()
To:     Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>
Cc:     mgorman@techsingularity.net, jlayton@redhat.com,
        ak@linux.intel.com, mawilcox@microsoft.com,
        tim.c.chen@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@ZenIV.linux.org.uk>
References: <20180719081726.3341-1-cgxu519@gmx.com>
 <20180719085812.sjup2odrjyuigt3l@quack2.suse.cz>
 <20180720161429.d63dccb9f66799dc0ff74dba@linux-foundation.org>
 <20180806102203.hmobd26cujmlfcsw@quack2.suse.cz>
 <20180806155927.4740babd057df9d5078281b1@linux-foundation.org>
 <20180807135453.nhatdtw25wa6dtzm@quack2.suse.cz>
From:   cgxu519 <cgxu519@gmx.com>
Message-ID: <7be05929-a5d0-e0b0-9d48-705c3840ee95@gmx.com>
Date:   Wed, 8 Aug 2018 08:57:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180807135453.nhatdtw25wa6dtzm@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:KprWOjprukJ9xYrLt70aBvXZHgIj1uMM8Z0sooyGO/lsVzu8m7F
 XP8un3wCvPV6ecrXZCfPlN/MYfGKxM7avgqsFQ0aLIsDGTUTSxjayeRGGv9UTHPEUvpBsLu
 76AtQseMVNTZmY+22lNp00Gw4tsKEw14gNX2HgLm0Bvw+Q5jZZ2LHV8/7q/9vYcXhZcL3gB
 8QUFBz1hIQeT1RQEplwjQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/iAyW/47XHs=:68UQ1bCXvrmsQGLcSouIWq
 Y6xUv/eqHu7+/c4X605edi3/NrpvqKC+TyXjG+ZQzVgpRy+M00H97imUKzftB6h8nCjxreOT6
 NhxkDnGK6Cw/gUKb6RhFulp7kuu2s2DuLiK/lR3p/yrpKl2PCRQ9sGWEAeVRdRmm4YfNQ7mDa
 tycNVfRww854h3pCcDKzRfTfotqjtN9hU74E2/llssyAvltkxYEvyhaT20UF/PFQDaPh7Y2rl
 kjkjTXNZCteGucdXbcXDHltgg04OJdyiZp2YBsKamBKoAC3eaHLrNmFtqZIh1GJb0qymu+FzY
 Insl/wpT+0Jmd9y0aidtU1p0kZoXZqW5ubnw3vU7jZC7gc+9VsmKUeHXXtRKu4eRE/8KW0zBc
 Zz9rB1NwhRUZdWCqPUGyYIV7me5Nlr0P6IAvFV7UvuBAHSy/tyBQ98ymXxNm+Lfk1fTjp9tO9
 ofLpOWHXz9/+lCf6W3Nfp7r3eq437RlfpPGbtUok+qiSSfxGuEuP2BZdnsPPHQJUmzAjz9QrL
 s3zSfxHRUEB2eKN+bj5E6wsIpRKafLUDvrM5bGEQgxo9v5KV6F3QZrRceJPSVol58gViV83zP
 AoGprDvw32ewgus5fmRGU0Slq50Uuv855bDXGruD+IxWSqVy//McR+VtsQGuRVRDvgD0xtpMx
 pThcch/jXavZ7UGcHMhgKt/swXRwxCLrg6lA2I3IWW0wkJ6jrwneCn/rykCJLTBEMv8BlWSec
 8ggt2XqSm7pRb3vnWaNEEWjLrQkEFHDHE63GcW0OYw6qddr22AQagJ6mdsIzGorfF0SxxMI+/
 DO1uQB2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/07/2018 09:54 PM, Jan Kara wrote:
> On Mon 06-08-18 15:59:27, Andrew Morton wrote:
>> On Mon, 6 Aug 2018 12:22:03 +0200 Jan Kara <jack@suse.cz> wrote:
>>
>>> On Fri 20-07-18 16:14:29, Andrew Morton wrote:
>>>> On Thu, 19 Jul 2018 10:58:12 +0200 Jan Kara <jack@suse.cz> wrote:
>>>>
>>>>> On Thu 19-07-18 16:17:26, Chengguang Xu wrote:
>>>>>> When we try to truncate read count in generic_file_buffered_read(),
>>>>>> should deliver (sb->s_maxbytes - offset) as maximum count not
>>>>>> sb->s_maxbytes itself.
>>>>>>
>>>>>> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
>>>>> Looks good to me. You can add:
>>>>>
>>>>> Reviewed-by: Jan Kara <jack@suse.cz>
>>>> Yup.
>>>>
>>>> What are the runtime effects of this bug?
>>> Good question. I think ->readpage() could be called for index beyond
>>> maximum file size supported by the filesystem leading to weird filesystem
>>> behavior due to overflows in internal calculations.
>>>
>> Sure.  But is it possible for userspace to trigger this behaviour?
>> Possibly all callers have already sanitized the arguments by this stage
>> in which case the statement is arguably redundant.
> So I don't think there's any sanitization going on before
> generic_file_buffered_read(). E.g. I don't see any s_maxbytes check on
> ksys_read() -> vfs_read() -> __vfs_read() -> new_sync_read() ->
> call_read_iter() -> generic_file_read_iter() ->
> generic_file_buffered_read() path... However now thinking about this again:
> We are guaranteed i_size is within s_maxbytes (places modifying i_size
> are checking for this) and generic_file_buffered_read() stops when it
> should read beyond i_size. So in the end I don't think there's any breakage
> possible and the patch is not necessary?
>
I think most of time i_size is within s_maxbytes in local filesystem,
but consider network filesystem, write big file in 64bit client and
read in 32bit client, in this case maybe generic_file_buffered_read()
can read more than s_maxbytes, right?


Thanks,
Chengguang
