Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B295C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E26F28032
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JvCFt7eA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E26F28032
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936660AbeF2VU0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 17:20:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34818 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934360AbeF2VUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 17:20:24 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5TLEFZ0048877;
        Fri, 29 Jun 2018 21:20:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=RfDGfnl3W3Ys8sNvt7aW4oVStiCBWU5ZGhw6jP2bn1U=;
 b=JvCFt7eAoYWFJuu4EoyOgP4y8f+qDqOcFsBd1cDZZs2eCqs8iwGerz5bvHblu2docA+y
 PfTxcKZqny9c6vjp5GvIX+/shzGSGihZ6ciLXHDL0XFi8B1Gi40QiffRzARIo6YeS6T2
 /mk7JENokWLhhMkqGWOu0YRNEKNpCZlBlRYdPhEX8J4pU5YjkT2qCAJjwLLLozXsLH2C
 /5ScJ4zB8qodPt4W+wGFvqmsFIq1OALTvksRZp6GWAImPEmNFAZdAh4thhPwMadMZu9L
 yBFhYzEXBi+YUKkILhHE3wsC9LJPGWUbmfljKn/y3Lshh0NxCEhZ4hQbx5j1E3SjlnBR lA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2jukhsr3pg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jun 2018 21:20:19 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5TLKJE7028504
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jun 2018 21:20:19 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5TLKI7W023224;
        Fri, 29 Jun 2018 21:20:18 GMT
Received: from [192.168.1.10] (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Jun 2018 14:20:18 -0700
Subject: Re: [PATCH v6 2/3] drivers core: prepare device_shutdown for
 multi-threading
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev <netdev@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Duyck <alexander.duyck@gmail.com>, tobin@apporbit.com
References: <20180629182541.6735-1-pasha.tatashin@oracle.com>
 <20180629182541.6735-3-pasha.tatashin@oracle.com>
 <CAHp75VdQsrxS5=Jb_+Wfu=JL0-AR1B=p8Jp3psEqH5ApmpewGA@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Message-ID: <fd1641e5-0e75-30a9-a5b7-2a762cefabf1@oracle.com>
Date:   Fri, 29 Jun 2018 17:20:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdQsrxS5=Jb_+Wfu=JL0-AR1B=p8Jp3psEqH5ApmpewGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8939 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=872
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806290225
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/29/2018 04:38 PM, Andy Shevchenko wrote:
> On Fri, Jun 29, 2018 at 9:25 PM, Pavel Tatashin
> <pasha.tatashin@oracle.com> wrote:
>> Do all the necessary refactoring to prepare device_shutdown() logic to
>> be multi-threaded.
>>
>> Which includes:
>> 1. Change the direction of traversing the list instead of going backward,
>> we now go forward.
>> 2. Children are shutdown recursively for each root device from bottom-up.
>> 3. Functions that can be multi-threaded have _task() in their name.
> 
>> +/*
>> + * device_children_count - device children count
>> + * @parent: parent struct device.
>> + *
>> + * Returns number of children for this device or 0 if none.
>> + */
>> +static int device_children_count(struct device *parent)
>> +{
>> +       struct klist_iter i;
>> +       int children = 0;
>> +
>> +       if (!parent->p)
>> +               return 0;
>> +
>> +       klist_iter_init(&parent->p->klist_children, &i);
>> +       while (next_device(&i))
>> +               children++;
>> +       klist_iter_exit(&i);
>> +
>> +       return children;
>> +}
> 
> Looking at another patch in LKML (for gluedir children counting) I
> would suggest to consider to cache children value.
> Would it  make sense?
> 
> (So, basically you would update that value on children registered / removed)
> 

Hi Andy,

Thank you for looking at this patch.

For this particular series, this function is called only once per device during shutdown, when nothing else is running on the machine. So, caching won't really provide us any improvement.

If, in the future this function is going to be called from other sites during run-time of the machine, then yes, that would mean that caching might help.

Thank you,
Pavel
