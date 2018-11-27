Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6697EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE0121104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yKcfz9O6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE0121104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbeK1Azv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 19:55:51 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33616 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbeK1Azv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 19:55:51 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wARDsGTW117051;
        Tue, 27 Nov 2018 13:57:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=SPm5YuydnMTbWDhJz/E0WzSa57EM3Q3tTuRQZSB9gRw=;
 b=yKcfz9O6p690KrDwe8Qb1Gp0P9dZvI/IwWx3wO+89JmeIR/fZF63Rlo8GdNQnEPuoEdw
 OXTORwmeNDlEcf/OYLBjj3F1LnBZqHGl4fxwi9/X9NJRy5zD8X0Cm66tRG1UvtUvAfnj
 cUWpiB+iQ6IwjkrmGYFzAxPqkEQPeGDHJLdkk08+igNDtp5ONpz8CVDL+5Dkzsn95qEt
 vPfWjW/a0wTayOC8lO6lDwjRyI1nVRTZY2Z4ARjJJ/q69qSY3f1hsltHsV3WPJgghYBm
 KmOF+wfW6q45uKL0IflRuVKnePQ4flVJTvpKA9gdDdO19+1XYXWWcMnY7xN5WstwGH4w +Q== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2nxy9r41vu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Nov 2018 13:57:30 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wARDvTJx025095
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Nov 2018 13:57:29 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wARDvS17028719;
        Tue, 27 Nov 2018 13:57:28 GMT
Received: from dhcp-burlington7-2nd-B-east-10-152-55-162.usdhcp.oraclecorp.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Nov 2018 05:57:28 -0800
Subject: Re: [PATCH] xen/x86: add diagnostic printout to xen_mc_flush() in
 case of error
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, x86@kernel.org
Cc:     sstabellini@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de
References: <20181123162451.3351-1-jgross@suse.com>
 <0727da38-bfe8-f484-6b06-7205c1d953c1@oracle.com>
 <04dc8206-d7ad-9438-2f68-c25bf5a10b96@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <a379cd7c-2da3-930f-606f-9d567db77c51@oracle.com>
Date:   Tue, 27 Nov 2018 08:57:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <04dc8206-d7ad-9438-2f68-c25bf5a10b96@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9089 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811270120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/18 2:46 AM, Juergen Gross wrote:
> On 26/11/2018 21:11, Boris Ostrovsky wrote:
>> On 11/23/18 11:24 AM, Juergen Gross wrote:
>>> Failure of an element of a Xen multicall is signalled via a WARN()
>>> only unless the kernel is compiled with MC_DEBUG. It is impossible to
>> s/unless/if
>>
>>
>>> know which element failed and why it did so.
>>>
>>> Change that by printing the related information even without MC_DEBUG,
>>> even if maybe in some limited form (e.g. without information which
>>> caller produced the failing element).
>>>
>>> Move the printing out of the switch statement in order to have the
>>> same information for a single call.
>>>
>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>> ---
>>>  arch/x86/xen/multicalls.c | 35 ++++++++++++++++++++---------------
>>>  1 file changed, 20 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/arch/x86/xen/multicalls.c b/arch/x86/xen/multicalls.c
>>> index 2bce7958ce8b..0766a08bdf45 100644
>>> --- a/arch/x86/xen/multicalls.c
>>> +++ b/arch/x86/xen/multicalls.c
>>> @@ -69,6 +69,11 @@ void xen_mc_flush(void)
>>>  
>>>  	trace_xen_mc_flush(b->mcidx, b->argidx, b->cbidx);
>>>  
>>> +#if MC_DEBUG
>>> +	memcpy(b->debug, b->entries,
>>> +	       b->mcidx * sizeof(struct multicall_entry));
>>> +#endif
>>> +
>>>  	switch (b->mcidx) {
>>>  	case 0:
>>>  		/* no-op */
>>> @@ -87,32 +92,34 @@ void xen_mc_flush(void)
>>>  		break;
>>>  
>>>  	default:
>>> -#if MC_DEBUG
>>> -		memcpy(b->debug, b->entries,
>>> -		       b->mcidx * sizeof(struct multicall_entry));
>>> -#endif
>>> -
>>>  		if (HYPERVISOR_multicall(b->entries, b->mcidx) != 0)
>>>  			BUG();
>>>  		for (i = 0; i < b->mcidx; i++)
>>>  			if (b->entries[i].result < 0)
>>>  				ret++;
>>> +	}
>>>  
>>> +	if (WARN_ON(ret)) {
>>> +		pr_err("%d of %d multicall(s) failed: cpu %d\n",
>>> +		       ret, b->mcidx, smp_processor_id());
>>> +		for (i = 0; i < b->mcidx; i++) {
>>> +			if (b->entries[i].result < 0) {
>>>  #if MC_DEBUG
>>> -		if (ret) {
>>> -			printk(KERN_ERR "%d multicall(s) failed: cpu %d\n",
>>> -			       ret, smp_processor_id());
>>> -			dump_stack();
>>> -			for (i = 0; i < b->mcidx; i++) {
>>> -				printk(KERN_DEBUG "  call %2d/%d: op=%lu arg=[%lx] result=%ld\t%pF\n",
>>> -				       i+1, b->mcidx,
>>> +				pr_err("  call %2d: op=%lu arg=[%lx] result=%ld\t%pF\n",
>>> +				       i + 1,
>>>  				       b->debug[i].op,
>>>  				       b->debug[i].args[0],
>>>  				       b->entries[i].result,
>>>  				       b->caller[i]);
>>> +#else
>>> +				pr_err("  call %2d: op=%lu arg=[%lx] result=%ld\n",
>>> +				       i + 1,
>>> +				       b->entries[i].op,
>>> +				       b->entries[i].args[0],
>>> +				       b->entries[i].result);
>>> +#endif
>> Doesn't (non-debug) hypervisor corrupt op and args?
> No. Only debug hypervisor does so.
>
> See my patch (and rather lengthy discussion) on xen-devel:
>
> https://lists.xen.org/archives/html/xen-devel/2018-11/msg02714.html

Yes, I saw that later, after I responded to the patch.


>
>> (Also, we don't really need to print anything when b->entries[i].result
>> == 0)
> Right. Did you miss the:

I did.

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

(with commit message fixed)



>
> +			if (b->entries[i].result < 0) {
>
> above?
>
>
> Juergen

