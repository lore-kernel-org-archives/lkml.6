Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94657C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA952084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JUq1+tar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA952084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbeLLSK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:10:28 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50782 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbeLLSK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:10:26 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBCI43S2169015;
        Wed, 12 Dec 2018 18:09:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Oy2mXvVS78Jpkc8RrYEt586hwUSTj6D5lbxVuVd3cyk=;
 b=JUq1+tarofyY+YfRHZ6IsIJRQ9dT0K3CvT42bam4TWGgF+N0pp9YVXiM+pCOr4NRDrIr
 Q1Q+q1hYrZXxb5M1dzK62+e4ZZCk7jidWYYjGCG8nOqjA5nuRZcjp22WnXWbNeYaT1VV
 RhbMayWsZTzi52Z5ZN7eRxHudEoIRIEy93U+/5enMloKYrWvKPoUGWQ0AY4Q977GAMh2
 RunA3R8gSXgFHCzRDlK9ciFbjuodB3kUavTJENUJMVHEHRg5Y8DQ0FRVMbWRDerlHppc
 PRBTx4yxmHapa6CsNSjBjSzMUNof+56EMjgMnT3ahME3phw03WIUN2RM6YagHpc/1A8m Ew== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2pb3n71gqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Dec 2018 18:09:47 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBCI9ktp018075
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Dec 2018 18:09:46 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBCI9ieV030826;
        Wed, 12 Dec 2018 18:09:44 GMT
Received: from [10.141.199.39] (/10.141.199.39)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Dec 2018 10:09:43 -0800
Subject: Re: [PATCH v8 0/7] KVM: x86: Allow Qemu/KVM to use PVH entry point
To:     Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, jgross@suse.com
Cc:     boris.ostrovsky@oracle.com, bp@suse.de,
        dave.hansen@linux.intel.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, hpa@zytor.com, jpoimboe@redhat.com,
        kirill.shutemov@linux.intel.com, luto@kernel.org,
        mchehab@kernel.org, mingo@redhat.com, rdunlap@infradead.org,
        tglx@linutronix.de, thomas.lendacky@amd.com, hch@infradead.org,
        roger.pau@citrix.com, rkrcmar@redhat.com,
        Maran Wilson <maran.wilson@oracle.com>
References: <1544076152-21637-1-git-send-email-maran.wilson@oracle.com>
 <e8ed34e7-f82a-2314-9919-185d48510715@redhat.com>
From:   Maran Wilson <maran.wilson@oracle.com>
Organization: Oracle Corporation
Message-ID: <faae2cec-1ff2-74eb-69c8-b75f64cfca3a@oracle.com>
Date:   Wed, 12 Dec 2018 10:09:38 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <e8ed34e7-f82a-2314-9919-185d48510715@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9105 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812120155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/2018 1:21 PM, Paolo Bonzini wrote:
> On 06/12/18 07:02, Maran Wilson wrote:
>> For certain applications it is desirable to rapidly boot a KVM virtual
>> machine. In cases where legacy hardware and software support within the
>> guest is not needed, Qemu should be able to boot directly into the
>> uncompressed Linux kernel binary without the need to run firmware.
>>
>> There already exists an ABI to allow this for Xen PVH guests and the ABI
>> is supported by Linux and FreeBSD:
>>
>>     https://xenbits.xen.org/docs/unstable/misc/pvh.html
>>
>> This patch series would enable Qemu to use that same entry point for
>> booting KVM guests.
> Thanks!  I should be able to post a Tested-by next Monday.  Boris, are
> you going to pick it up for 4.21?

Hi Paolo,

Are you still planning on running some testing of your own for these 
patches? Should Boris wait to hear from you before moving forward?

Thanks,
-Maran

> Paolo

