Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53639C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1770C2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lBkQ0KwE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfBUAaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 19:30:15 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:34834 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfBUAaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 19:30:15 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1L0Smcl102165;
        Thu, 21 Feb 2019 00:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=1xLGvszPYPyOSKoIYzMs5Zwpc4JSnGc/udVZjL/KiJI=;
 b=lBkQ0KwENN2nISYDlRdgwXi3hmpUfyd9zJamhRac0NCZNu5z7Kq2/My8HTFHhuakPILK
 T7j2lfLhmp5dhd6RnMX7uyX9pDg3UaB1OfTr32iKjUHJYAiH7JM4doVBYYMT9DECswRM
 53H19rY6m5TRTUeY+3cHUL5sFPEQeaUyyXllPE7MbSoXeuvGOFCV9t8SGm6UXnV0tIHc
 wDFd9iP2i62eLRU4wNZ3l38N1mFGHAegLjKpF+H1UV1v3rZSAmjMPod7C8l9F/ND4dU1
 54f/mp5QRcncS1J5spbJ4uQvU/L0y162IOLAyJWGjam8nykrMpHqWBqO8rkyqH8nUI6t gg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2qp81ed64y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 00:28:52 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1L0Skhk028166
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 00:28:47 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1L0SjIh029159;
        Thu, 21 Feb 2019 00:28:45 GMT
Received: from [10.156.74.184] (/10.156.74.184)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 16:28:45 -0800
Subject: Re: [PATCH RFC 00/39] x86/KVM: Xen HVM guest support
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
 <35051310-c497-8ad5-4434-1b8426a317d2@redhat.com>
From:   Ankur Arora <ankur.a.arora@oracle.com>
Message-ID: <6bc9183d-82db-f4d8-9dc1-e14dea3e354e@oracle.com>
Date:   Wed, 20 Feb 2019 16:29:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <35051310-c497-8ad5-4434-1b8426a317d2@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902210003
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/19 1:09 PM, Paolo Bonzini wrote:
> On 20/02/19 21:15, Joao Martins wrote:
>>   2. PV Driver support (patches 17 - 39)
>>
>>   We start by redirecting hypercalls from the backend to routines
>>   which emulate the behaviour that PV backends expect i.e. grant
>>   table and interdomain events. Next, we add support for late
>>   initialization of xenbus, followed by implementing
>>   frontend/backend communication mechanisms (i.e. grant tables and
>>   interdomain event channels). Finally, introduce xen-shim.ko,
>>   which will setup a limited Xen environment. This uses the added
>>   functionality of Xen specific shared memory (grant tables) and
>>   notifications (event channels).
> 
> I am a bit worried by the last patches, they seem really brittle and
> prone to breakage.  I don't know Xen well enough to understand if the
> lack of support for GNTMAP_host_map is fixable, but if not, you have to
> define a completely different hypercall.
I assume you are aware of most of this, but just in case, here's the
flow when a backend driver wants to map a grant-reference in the
host: it allocates an empty struct page (via ballooning) and does a
map_grant_ref(GNTMAP_host_map) hypercall. In response, Xen validates the
grant-reference and maps it onto the address associated with the struct
page.
After this, from the POV of the underlying network/block drivers, these
struct pages can be used as just regular pages.

To support this in a KVM environment, where AFAICS no remapping of pages
is possible, the idea was to make minimal changes to the backend drivers
such that map_grant_ref() could just return the PFN from which the
backend could derive the struct page.

To ensure that backends -- when running in this environment -- have been
modified to deal with these new semantics, our map_grant_ref()
implementation explicitly disallows the GNTMAP_host_map flag.

Now if I'm reading you right, you would prefer something more
straightforward -- perhaps similar semantics but a new flag that
makes this behaviour explicit?

> 
> Of course, tests are missing.  You should use the
> tools/testing/selftests/kvm/ framework, and ideally each patch should
> come with coverage for the newly-added code.
Agreed.

Thanks
Ankur

> 
> Thanks,
> 
> Paolo
> 
