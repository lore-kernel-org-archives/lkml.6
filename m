Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6E4C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 03:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78EB720852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 03:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78EB720852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbeGYFIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 01:08:41 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58812 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726773AbeGYFIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 01:08:40 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8FB647DEC78D5;
        Wed, 25 Jul 2018 11:58:53 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.382.0; Wed, 25 Jul 2018
 11:58:53 +0800
Subject: Re: [PATCH] fs/9p/xattr.c: catch the error of p9_client_clunk when
 setting xattr failed
To:     Dominique Martinet <asmadeus@codewreck.org>
References: <5B57EACC.2060900@huawei.com> <20180725033200.GA29865@nautica>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Eric Van Hensbergen" <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        "Latchesar Ionkov" <lucho@ionkov.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <v9fs-developer@lists.sourceforge.net>, <groug@kaod.org>
From:   piaojun <piaojun@huawei.com>
Message-ID: <5B57F564.9070604@huawei.com>
Date:   Wed, 25 Jul 2018 11:58:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20180725033200.GA29865@nautica>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dominique,

On 2018/7/25 11:32, Dominique Martinet wrote:
> piaojun wrote on Wed, Jul 25, 2018:
>> In my testing, v9fs_fid_xattr_set will return successfully even if the
>> backend ext4 filesystem has no space to store xattr key-value. That will
>> cause inconsistent behavior between front end and back end. The reason is
>> that lsetxattr will be triggered by p9_client_clunk, and unfortunately we
>> did not catch the error. This patch will catch the error to notify upper
>> caller.
>>
>> p9_client_clunk (in 9p)
>>   p9_client_rpc(clnt, P9_TCLUNK, "d", fid->fid);
>>     v9fs_clunk (in qemu)
>>       put_fid
>>         free_fid
>>           v9fs_xattr_fid_clunk
>>             v9fs_co_lsetxattr
>>               s->ops->lsetxattr
>>                 ext4_xattr_user_set (in host ext4 filesystem)
>>
>> Signed-off-by: Jun Piao <piaojun@huawei.com>
> 
> Good catch!
> 
> LGTM on its own but see comment below for further error checking.
> Please let me know if you want to do this in a v2 or submit a separate
> patch altogether, I can pick this one up as it is.
> 
>> ---
>>  fs/9p/xattr.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
>> index f329eee..352abc3 100644
>> --- a/fs/9p/xattr.c
>> +++ b/fs/9p/xattr.c
>> @@ -105,7 +105,7 @@ int v9fs_fid_xattr_set(struct p9_fid *fid, const char *name,
>>  {
>>  	struct kvec kvec = {.iov_base = (void *)value, .iov_len = value_len};
>>  	struct iov_iter from;
>> -	int retval;
>> +	int retval, err;
>>
>>  	iov_iter_kvec(&from, WRITE | ITER_KVEC, &kvec, 1, value_len);
>>
>> @@ -126,7 +126,9 @@ int v9fs_fid_xattr_set(struct p9_fid *fid, const char *name,
>>  			 retval);
>>  	else
>>  		p9_client_write(fid, 0, &from, &retval);
> 
> I'm not sure what to do about this but it's also possible for
> p9_client_write to not write the full length without setting and error.
> 
> We should probably compare the return value of p9_client_write and
> value_len to detect short writes and return an error in this case.
> 
It looks like we could identify short writes error from the *err. If no
error case breaks the while loop, the total equal to the whole data len.

Thanks,
Jun

>> -	p9_client_clunk(fid);
>> +	err = p9_client_clunk(fid);
>> +	if (!retval && err)
>> +		retval = err;
>>  	return retval;
>>  }
>>
>> -- 
> .
> 
