Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE60AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BBA721B68
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="owg2EAXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502919AbfBNT63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:58:29 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57072 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbfBNT62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:58:28 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1EJsITk073232;
        Thu, 14 Feb 2019 19:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=BdK7IaSpJfGdyre7bODL0VtCcEpshJ2Y4O0xLokGeZA=;
 b=owg2EAXP1djY4nOw3m8VNIzE98O8OriShbmSSMKZ1A19elg+OjugPa4ORsAae1iR/QG+
 Oo6TItCage0cFqLHvah7MyhhQEJRLw3heZpg0f9FxV8KjBacCmhDbU4A0xmkJ4AE0tW7
 7J9JF0zShtWDBE+r9ZN2h7CQ6evngnuEYCI2DcA3CDxWWAikNj2v6M/+F1z0RzJ8PftT
 w/OicGnyFF60fSAZPPiq1gNdWsq+Jc80DNuUYrKuzTkrqjKuKEtmKgryWLQec1RjtvWO
 whVfMYxFhwr12ksKkKKbj0LUcJjPeYPtDBVapSvKu0btUzQCxs69XCHlEjHQ3KEkgP2z tg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2qhreea5de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 19:57:36 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1EJvZQN015680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 19:57:35 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1EJvXGY021984;
        Thu, 14 Feb 2019 19:57:33 GMT
Received: from [192.168.1.16] (/24.9.64.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Feb 2019 19:57:33 +0000
Subject: Re: [RFC PATCH v8 13/14] xpfo, mm: Defer TLB flushes for non-current
 CPUs (x86 only)
To:     Dave Hansen <dave.hansen@intel.com>, juergh@gmail.com,
        tycho@tycho.ws, jsteckli@amazon.de, ak@linux.intel.com,
        torvalds@linux-foundation.org, liran.alon@oracle.com,
        keescook@google.com, akpm@linux-foundation.org, mhocko@suse.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jmorris@namei.org,
        konrad.wilk@oracle.com
Cc:     deepa.srinivasan@oracle.com, chris.hyser@oracle.com,
        tyhicks@canonical.com, dwmw@amazon.co.uk,
        andrew.cooper3@citrix.com, jcm@redhat.com,
        boris.ostrovsky@oracle.com, kanth.ghatraju@oracle.com,
        joao.m.martins@oracle.com, jmattson@google.com,
        pradeep.vincent@oracle.com, john.haxby@oracle.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com, hch@lst.de,
        steven.sistare@oracle.com, labbott@redhat.com, luto@kernel.org,
        peterz@infradead.org, kernel-hardening@lists.openwall.com,
        linux-mm@kvack.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1550088114.git.khalid.aziz@oracle.com>
 <98134cb73e911b2f0b59ffb76243a7777963d218.1550088114.git.khalid.aziz@oracle.com>
 <a6510fa8-e96d-677b-78df-da9a19c4089b@intel.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <95fb62d4-1dbc-e420-74c1-ff929c5552e1@oracle.com>
Date:   Thu, 14 Feb 2019 12:57:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <a6510fa8-e96d-677b-78df-da9a19c4089b@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9167 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902140133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/19 10:42 AM, Dave Hansen wrote:
>>  #endif
>> +
>> +	/* If there is a pending TLB flush for this CPU due to XPFO
>> +	 * flush, do it now.
>> +	 */
>=20
> Don't forget CodingStyle in all this, please.

Of course. I will fix that.

>=20
>> +	if (cpumask_test_and_clear_cpu(cpu, &pending_xpfo_flush)) {
>> +		count_vm_tlb_event(NR_TLB_REMOTE_FLUSH_RECEIVED);
>> +		__flush_tlb_all();
>> +	}
>=20
> This seems to exist in parallel with all of the cpu_tlbstate
> infrastructure.  Shouldn't it go in there?

That sounds like a good idea. On the other hand, pending flush needs to
be kept track of entirely within arch/x86/mm/tlb.c and using a local
variable with scope limited to just that file feels like a lighter
weight implementation. I could go either way.

>=20
> Also, if we're doing full flushes like this, it seems a bit wasteful to=

> then go and do later things like invalidate_user_asid() when we *know*
> that the asid would have been flushed by this operation.  I'm pretty
> sure this isn't the only __flush_tlb_all() callsite that does this, so
> it's not really criticism of this patch specifically.  It's more of a
> structural issue.
>=20
>=20

That is a good point. It is not just wasteful, it is bound to have
performance impact even if slight.

>> +void xpfo_flush_tlb_kernel_range(unsigned long start, unsigned long e=
nd)
>> +{
>=20
> This is a bit lightly commented.  Please give this some good
> descriptions about the logic behind the implementation and the tradeoff=
s
> that are in play.
>=20
> This is doing a local flush, but deferring the flushes on all other
> processors, right?  Can you explain the logic behind that in a comment
> here, please?  This also has to be called with preemption disabled, rig=
ht?
>=20
>> +	struct cpumask tmp_mask;
>> +
>> +	/* Balance as user space task's flush, a bit conservative */
>> +	if (end =3D=3D TLB_FLUSH_ALL ||
>> +	    (end - start) > tlb_single_page_flush_ceiling << PAGE_SHIFT) {
>> +		do_flush_tlb_all(NULL);
>> +	} else {
>> +		struct flush_tlb_info info;
>> +
>> +		info.start =3D start;
>> +		info.end =3D end;
>> +		do_kernel_range_flush(&info);
>> +	}
>> +	cpumask_setall(&tmp_mask);
>> +	cpumask_clear_cpu(smp_processor_id(), &tmp_mask);
>> +	cpumask_or(&pending_xpfo_flush, &pending_xpfo_flush, &tmp_mask);
>> +}
>=20
> Fun.  cpumask_setall() is non-atomic while cpumask_clear_cpu() and
> cpumask_or() *are* atomic.  The cpumask_clear_cpu() is operating on
> thread-local storage and doesn't need to be atomic.  Please make it
> __cpumask_clear_cpu().
>=20

I will fix that. Thanks!

--
Khalid

