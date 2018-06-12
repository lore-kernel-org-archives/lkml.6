Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 95DBEC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4884A2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4884A2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934171AbeFLOIz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:08:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14034 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933295AbeFLOIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:08:51 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5CDwjGn002659
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 10:08:51 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jjervucqh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 10:08:50 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Tue, 12 Jun 2018 15:08:49 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Jun 2018 15:08:45 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5CE8hCH30539862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Jun 2018 14:08:43 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6AC7511C05C;
        Tue, 12 Jun 2018 14:59:19 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B964A11C050;
        Tue, 12 Jun 2018 14:59:18 +0100 (BST)
Received: from oc3836556865.ibm.com (unknown [9.152.224.108])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Jun 2018 14:59:18 +0100 (BST)
Subject: Re: [PATCH RFC 2/2] vfio-ccw: support for halt/clear subchannel
To:     pmorel@linux.ibm.com, Cornelia Huck <cohuck@redhat.com>
Cc:     Dong Jia Shi <bjsdjshi@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20180509154822.23510-1-cohuck@redhat.com>
 <20180509154822.23510-3-cohuck@redhat.com>
 <c18f9b9f-da00-1a0b-8ef0-7ac223c73d1a@linux.ibm.com>
 <20180515181006.0cb1dfc2.cohuck@redhat.com>
 <a5d08fb7-d9c1-b230-fe0c-acebbda2ba65@linux.ibm.com>
 <20180522145208.310143ea.cohuck@redhat.com>
 <4e4001cc-540e-0f2b-bbd1-1f82ca594bb3@linux.ibm.com>
 <20180605151449.22aafbfc.cohuck@redhat.com>
 <e73038ff-fb2d-5865-8b84-e775990f3983@linux.ibm.com>
 <20180606142131.74ea2eb7.cohuck@redhat.com>
 <5b77ec9c-41b8-2e32-ce79-d9005b93fdd0@linux.ibm.com>
 <20180607115442.6a779ed9.cohuck@redhat.com>
 <86d57698-3ea7-a390-2217-07c6d41ca9ed@linux.ibm.com>
 <20180608142022.7dd6a658.cohuck@redhat.com>
 <d68340a2-bb1b-cef9-e394-f0d55983c0bb@linux.ibm.com>
 <20180608164514.2e8248f4.cohuck@redhat.com>
 <99ca65a2-ee33-6353-b6b7-aa4c07a34e2a@linux.ibm.com>
 <20180612115900.4aa319d1.cohuck@redhat.com>
 <d5416c61-252a-5bb8-aebe-46d883e5822e@linux.ibm.com>
From:   Halil Pasic <pasic@linux.ibm.com>
Date:   Tue, 12 Jun 2018 16:08:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <d5416c61-252a-5bb8-aebe-46d883e5822e@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18061214-0016-0000-0000-000001DAEE8C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061214-0017-0000-0000-0000322E22E6
Message-Id: <e4fc9a67-f3df-c040-8188-37eb3091db1a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-12_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=963 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806120160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/12/2018 03:56 PM, Pierre Morel wrote:
>> So, what are you proposing? Being more specific and stating that the
>> scsw is not necessarily a real scsw, but merely a vehicle for sending a
>> command? Or keeping it as it is now for ssch, and adding a second
>> interface for hsch/csch (and maybe rsch, msch, ...)?
>>
> 
> 
> I said no radical surgery, but after thinking more about it...
> I am not sure.
> 
> Let's explain this:
> 
> I see 2 ways to proceed but my favorite is definitively to introduce versioning.
> 
> 
> Way 1)
> 
> This was the way I first thought about.
> We keep the existing IO Regionand structures, and are more
> specific by stating that the io_region is a command region during write
> entry and a status region during interrupt handling:
> This allow us to use the 3 bits of the FCTL field of the SCSW to pass
> commands to the kernel and stay backward compatible.
> The FCTL field has 3 bits => we can have 8 commands.
> 
> PRO: small change
> 
> CONTRA: This is still confusing, we do not really solve this
>          unclarity problem since QEMU view / documentation and
>          Linux view / documentation differ or we update QEMU.
>          Moreover this does not allow for long term extensions
>          and/or re-design.
> 
> 

I'm not really in favor of way 1. Conie's point with RSCH is a good one.
And IMHO it speaks for a new interface for commands. Squeezing the RSCH
command into the SCSW does not seem to be a good idea. Considering your
proposal with the 3 bits, we could do something like: if in FCTL the
start and the clear and the halt bits are set then we postulate that is
request for a resume. But that would be quite confusing, and we would end
up re-defining the semantic of the scsw_area -- in respect to what is
documented Documentation/s390/vfio-ccw.txt, and also what is intuitive
based on the uapi header.

> 
> Way 2)
> 
> We use the device VFIO versioning using the capability chain to advertise
> a new interface.
> 
> This the preferred way, it is sane, allows for the userland backward
> compatibility and allows to have a new command interface, extensible
> for future use.
> 
> In this case we can extend the interface to be any kind we want
> in a next version, pwrite with new io_region, mmap on new
> IO regions, status region...
> 
> PRO: Extensible and also goes in the VFIO INFO extension direction
>       proposed by Alex
> 


Sounds much better. I imagine the coexistence of old and new like this.
Both the old and the new QEMU would supply the the SCSW area with the old
documented semantics -- the SCSW of the virtual subchannel. But with the
new version an explicit command would be supplied via the command region
(also for  SSCH). Maybe the SCSW can still end up being useful for
something in the kernel module too (maybe there are some  optimization
that can be done based on the QEMU SCSW).


> CONTRA: I see none outer more work to do (but is it a problem?)
> 
> 
The problem I see is that designing a good interface usually hard.
I could help with review, but I don't have the resources to commit
to more than that.

> ====================
> 
> Extra argumentation for versioning support
> 
> 
> Suppose a future implementation with 4 mapped regions like
> the following:
> 
> - A Status region (RO updated as result of command and IRQ)
> 
> - A command region (WO where the user send its commands)
>    userland write here to trigger IO (quite as currently)
> 
> - A CCW program region (RW where the CCW chain is handled)
>    most handling done from userspace, last translations in kernel,
>    double buffering...
> 
> - A performance / measurement / statistics region (RO)
>    This is updated asynchronously by hardware and/or driver
> 
> This is purely theoretical and we do not need to do all at once
> but if we want to extend the implementation without problems
> and continue backward compatibility the versioning and capability
> handling is a must.

I'm not sure about this.


Regards,
Halil
[..]

