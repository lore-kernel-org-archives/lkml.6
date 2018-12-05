Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2127BC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A922020850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="aTEVAZ0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A922020850
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbeLEQiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:38:18 -0500
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:44144 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727103AbeLEQiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:38:18 -0500
Received: from pps.filterd (m0050096.ppops.net [127.0.0.1])
        by m0050096.ppops.net-00190b01. (8.16.0.27/8.16.0.27) with SMTP id wB5GWQn6005805;
        Wed, 5 Dec 2018 16:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=yShLBhmDkxNJ3mJq7Za1DUZIzBCcKF1x6p77GV3w9zk=;
 b=aTEVAZ0S1LIpuVZFxApuIHsVpmFqzUFsYP8O+6b8JrQjXMGk5Y/gMDWSbxzEXWjDsDJs
 xLYQ+Iaea5zc2Qmmu8aVdBDB6kax9lxs0m09b3WG2VcMSXyx5mPSGXlSyJGsbI3x3pic
 ay1g8Hhcstu/bCeHDlukGDRw/bKtziV0H2C09GyVGlgW3h2IfW/TnaBwUPvDSKTAvK5U
 Z3UqoJaHZrSF1v+PNXQGBCHNLi5SOWv+gjGWwk1V5CYq8dikPZwwXu8p38Nog6LCzE+I
 2v101wcPgVAL/GoR8fRQD4ulPMYn7X8U2Id0QKzRryfLHOAsZknFDszMdW5t0Br1WM5e 4A== 
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19])
        by m0050096.ppops.net-00190b01. with ESMTP id 2p6hn0r5uu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Dec 2018 16:38:10 +0000
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
        by prod-mail-ppoint2.akamai.com (8.16.0.21/8.16.0.21) with SMTP id wB5GWE4t027564;
        Wed, 5 Dec 2018 11:38:10 -0500
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
        by prod-mail-ppoint2.akamai.com with ESMTP id 2p3pgyghcy-1;
        Wed, 05 Dec 2018 11:38:10 -0500
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay10.akamai.com (Postfix) with ESMTP id EE6FD2099F;
        Wed,  5 Dec 2018 16:38:09 +0000 (GMT)
Subject: Re: [RFC PATCH 1/1] epoll: use rwlock in order to reduce
 ep_poll_callback() contention
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181203110237.14787-1-rpenyaev@suse.de>
 <45bce871-edfd-c402-acde-2e57e80cc522@akamai.com>
 <38cc83144a2ec332dead4e21214ea068@suse.de>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <b8c6ef78-f0ea-2bc5-566a-9482061fffb2@akamai.com>
Date:   Wed, 5 Dec 2018 11:38:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <38cc83144a2ec332dead4e21214ea068@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-05_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812050147
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-05_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1812050147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/5/18 6:16 AM, Roman Penyaev wrote:
> On 2018-12-04 18:23, Jason Baron wrote:
>> On 12/3/18 6:02 AM, Roman Penyaev wrote:
> 
> [...]
> 
>>>
>>>      ep_set_busy_poll_napi_id(epi);
>>>
>>> @@ -1156,8 +1187,8 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
>>>       */
>>>      if (unlikely(ep->ovflist != EP_UNACTIVE_PTR)) {
>>>          if (epi->next == EP_UNACTIVE_PTR) {
>>> -            epi->next = ep->ovflist;
>>> -            ep->ovflist = epi;
>>> +            /* Atomically exchange tail */
>>> +            epi->next = xchg(&ep->ovflist, epi);
>>
>> This also relies on the fact that the same epi can't be added to the
>> list in parallel, because the wait queue doing the wakeup will have the
>> wait_queue_head lock. That was a little confusing for me b/c we only had
>> the read_lock() above.
> 
> Yes, that is indeed not obvious path, but wq is locked by wake_up_*_poll()
> call or caller of wake_up_locked_poll() has to be sure wq.lock is taken.
> 
> I'll add an explicit comment here, thanks for pointing out.
> 
>>
>>>              if (epi->ws) {
>>>                  /*
>>>                   * Activate ep->ws since epi->ws may get
>>> @@ -1172,7 +1203,7 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
>>>
>>>      /* If this file is already in the ready list we exit soon */
>>>      if (!ep_is_linked(epi)) {
>>> -        list_add_tail(&epi->rdllink, &ep->rdllist);
>>> +        list_add_tail_lockless(&epi->rdllink, &ep->rdllist);
>>>          ep_pm_stay_awake_rcu(epi);
>>>      }
>>
>> same for this.
> 
> ... and an explicit comment here.
> 
>>
>>>
>>> @@ -1197,13 +1228,13 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
>>>                  break;
>>>              }
>>>          }
>>> -        wake_up_locked(&ep->wq);
>>> +        wake_up(&ep->wq);
>>
>> why the switch here to the locked() variant? Shouldn't the 'reader'
>> side, in this case which takes the rwlock for write see all updates in a
>> coherent state at this point?
> 
> lockdep inside __wake_up_common expects wq_head->lock is taken, and
> seems this is not a good idea to leave wq naked on wake up path,
> when several CPUs can enter wake function.  Although default_wake_function
> is protected by spinlock inside try_to_wake_up(), but for example
> autoremove_wake_function() can't be called concurrently for the same wq
> (it removes wq entry from the list).  Also in case of bookmarks
> __wake_up_common adds an entry to the list, thus can't be called without
> any locks.
> 
> I understand you concern and you are right saying that read side sees
> wq entries as stable, but that will work only if __wake_up_common does
> not modify anything, that is seems true now, but of course it is
> too scary to rely on that in the future.

I think it might be interesting for, at least testing, to see if not grabbing
wq.lock improves your benchmarks any further? fwiw, epoll only recently started
grabbing wq.lock bc lockdep required it.

Thanks,

-Jason
