Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417BAC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEFDF20658
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DJbHRRfM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEFDF20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbeHXUQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 16:16:08 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:21003 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbeHXUQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 16:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1535128841; x=1566664841;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=cQuQqjViFuXSc9iTvUaxQj+NrcQcSQ6wwgx7NQPfMKY=;
  b=DJbHRRfMH+Tn27/mNiWPPfo7ufWE+bXftY8/XGOdaj/KsJHEJsMtehgh
   50GLqnMRIkUIKPvUpZPOT+hvCqHr9hZuLy5TeG5y17cfqqOI5UImIUbPO
   rrXuTieWpxmpf2McfiCdu6+eh/yl8khYTZeK/yRlyDmQqBcY90OMp+tul
   g=;
X-IronPort-AV: E=Sophos;i="5.53,283,1531785600"; 
   d="scan'208";a="359035701"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 24 Aug 2018 16:40:40 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w7OGeZuS044719
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 24 Aug 2018 16:40:39 GMT
Received: from EX13D13UWB002.ant.amazon.com (10.43.161.21) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 24 Aug 2018 16:40:38 +0000
Received: from EX13D13UWB002.ant.amazon.com (10.43.161.21) by
 EX13D13UWB002.ant.amazon.com (10.43.161.21) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 24 Aug 2018 16:40:38 +0000
Received: from EX13D13UWB002.ant.amazon.com ([10.43.161.21]) by
 EX13D13UWB002.ant.amazon.com ([10.43.161.21]) with mapi id 15.00.1367.000;
 Fri, 24 Aug 2018 16:40:38 +0000
From:   "van der Linden, Frank" <fllinden@amazon.com>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Anchal Agarwal <anchalag@amzn.com>
CC:     "mlinux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
Thread-Topic: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
Thread-Index: AQHUOvcv6Trip5kavUmHReG3ezAEAw==
Date:   Fri, 24 Aug 2018 16:40:38 +0000
Message-ID: <347a7a07dc5f4122a37afd703ef2a3d0@EX13D13UWB002.ant.amazon.com>
References: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
 <bd84ff08-b75a-0a2f-6b37-07a104452bff@kernel.dk>
 <da9458c632cb4c4695660664bf7c3fb3@EX13D13UWB002.ant.amazon.com>
 <20180823210144.GB5624@kaos-source-ops-60001.pdx1.amazon.com>
 <3eaa20ce-0599-c405-d979-87d91ea331d2@kernel.dk>
 <969389e7-b1bc-0559-6cc9-9461b034a24f@kernel.dk>
 <8af76974-08b2-f4ef-91b9-7bd42291b8d9@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.216]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/18 10:56 PM, jianchao.wang wrote:=0A=
>=0A=
> On 08/24/2018 07:14 AM, Jens Axboe wrote:=0A=
>> On 8/23/18 5:03 PM, Jens Axboe wrote:=0A=
>>>> Hi Jens, This patch looks much cleaner for sure as Frank pointed out=
=0A=
>>>> too. Basically this looks similar to wake_up_nr only making sure that=
=0A=
>>>> those woken up requests won't get reordered. This does solves the=0A=
>>>> thundering herd issue. However, I tested the patch against my=0A=
>>>> application and lock contention numbers rose to around 10 times from=
=0A=
>>>> what I had from your last 3 patches.  Again this did add to drop in=0A=
>>>> of total files read by 0.12% and rate at which they were read by=0A=
>>>> 0.02% but this is not a very significant drop. Is lock contention=0A=
>>>> worth the tradeoff?  I also added missing=0A=
>>>> __set_current_state(TASK_RUNNING) to the patch for testing.=0A=
>>> Can you try this variant? I don't think we need a=0A=
>>> __set_current_state() after io_schedule(), should be fine as-is.=0A=
>>>=0A=
>>> I'm not surprised this will raise contention a bit, since we're now=0A=
>>> waking N tasks potentially, if N can queue. With the initial change,=0A=
>>> we'd always just wake one.  That is arguably incorrect. You say it's=0A=
>>> 10 times higher contention, how does that compare to before your=0A=
>>> patch?=0A=
>>>=0A=
>>> Is it possible to run something that looks like your workload?=0A=
>> Additionally, is the contention you are seeing the wait queue, or the=0A=
>> atomic counter? When you say lock contention, I'm inclined to think it's=
=0A=
>> the rqw->wait.lock.=0A=
>>=0A=
> I guess the increased lock contend is due to:=0A=
> when the wake up is ongoing with wait head lock is held, there is still w=
aiter=0A=
> on wait queue, and __wbt_wait will go to wait and try to require the wait=
 head lock.=0A=
> This is necessary to keep the order on the rqw->wait queue.=0A=
>=0A=
> The attachment does following thing to try to avoid the scenario above.=
=0A=
> "=0A=
> Introduce wait queue rqw->delayed. Try to lock rqw->wait.lock firstly, if=
 fails, add=0A=
> the waiter on rqw->delayed. __wbt_done will pick the waiters on rqw->dela=
yed up and=0A=
> queue them on the tail of rqw->wait before it do wake up operation.=0A=
> "=0A=
>=0A=
Hmm, I am not sure about this one. Sure, it will reduce lock contention=0A=
for the waitq lock, but it also introduces more complexity.=0A=
=0A=
It's expected that there will be more contention if the waitq lock is=0A=
held longer. That's the tradeoff for waking up more throttled tasks and=0A=
making progress faster. Is this added complexity worth the gains? My=0A=
first inclination would be to say no.=0A=
=0A=
If lock contention on a wait queue is an issue, then either the wait=0A=
queue mechanism itself should be improved, or the code that uses the=0A=
wait queue should be fixed. Also, the contention is still a lot lower=0A=
than it used to be.=0A=
=0A=
- Frank=0A=
