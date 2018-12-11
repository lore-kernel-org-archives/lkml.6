Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B6FC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D0520870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 19:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VRpjDVVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D0520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbeLKTa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:30:29 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59124 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbeLKTa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 14:30:28 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBBJTDT2114721;
        Tue, 11 Dec 2018 19:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=tSuTGJwc5JcHn5S/sk2zNgsblWiGAiGQQ+g85SpyUrU=;
 b=VRpjDVVXWIhleb2/P8GhS0N0WFbwJODkaqK/p8G2zO93o4l9hv+k87NsW4xfuobxbdeP
 2xLQBeBz9cbS2qMx1rgitKz4m8pa+ldmK/cCfmNQxZDCS6ka0yKH6GWogRLxujbtvL//
 qYt0p60CcSBlyaAC7Q3jYDdhv4BpVoq+Xm/kSqTP8U4K7gugSRJTm5Ya+Xe5o/jjQs0F
 jUG8JADsWUuG1svguu8KDtEYjE4kFXakDr6Y9e6khgKMwLseI8U6EruTFY8SQYEckiA8
 s5LVZ5KXc1dhZMTI6YHkkOwzuYyEOAtOJy9FJZjb3XMv73zqQzZ3Fser1iCZxuGeeu7+ tA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2p85cu5x97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Dec 2018 19:29:30 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBBJTPOk022010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Dec 2018 19:29:25 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBBJTNrA016477;
        Tue, 11 Dec 2018 19:29:23 GMT
Received: from [10.141.197.71] (/10.141.197.71)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Dec 2018 11:29:22 -0800
Subject: Re: [PATCH v9 0/7] KVM: x86: Allow Qemu/KVM to use PVH entry point
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, jgross@suse.com, boris.ostrovsky@oracle.com,
        bp@suse.de, dave.hansen@linux.intel.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, hpa@zytor.com, jpoimboe@redhat.com,
        kirill.shutemov@linux.intel.com, luto@kernel.org,
        mchehab@kernel.org, mingo@redhat.com, rdunlap@infradead.org,
        tglx@linutronix.de, thomas.lendacky@amd.com, hch@infradead.org,
        roger.pau@citrix.com, rkrcmar@redhat.com
References: <1544468734-32763-1-git-send-email-maran.wilson@oracle.com>
 <20181211131825.GD27375@zn.tnic>
From:   Maran Wilson <maran.wilson@oracle.com>
Organization: Oracle Corporation
Message-ID: <5fc083d4-1dbd-f2f9-3059-0e3e8dda9b25@oracle.com>
Date:   Tue, 11 Dec 2018 11:29:21 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181211131825.GD27375@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9104 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812110173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2018 5:18 AM, Borislav Petkov wrote:
> On Mon, Dec 10, 2018 at 11:05:34AM -0800, Maran Wilson wrote:
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
> How would I do that, practically?
>
> Looking at those here:
>
>>   * Qemu and qboot RFC patches have been posted to show one example of how
>>     this functionality can be used. Some preliminary numbers are available
>>     in those cover letters showing the KVM guest boot time improvement.
>>        Qemu:
>>        http://lists.nongnu.org/archive/html/qemu-devel/2018-12/msg00957.html
>>        qboot:
>>        http://lists.nongnu.org/archive/html/qemu-devel/2018-12/msg00953.html
> I might still need to do some dancing to get stuff going.

Is your question about what options you need to provide to Qemu? Or is 
your question about the SW implementation choices?

Assuming the former... once you have compiled all 3 new binaries 
(kernel, Qemu, and qboot) then you simply invoke qemu the same way you 
normally invoke qemu with qboot + kernel binary, except you provide the 
vmlinux (uncompressed) kernel binary when specifying the "-kernel" 
parameter. Qemu/qboot will automatically detect that you have provided 
an ELF binary, find the PVH ELF note to locate the entry point, and 
proceed to boot the kernel via that method. On the other hand, if you 
leave all the Qemu options as-is, but simply provide the bzImage 
(compressed) kernel binary from the same build, Qemu/qboot will boot the 
way it has always done and not look for PVH.

To make it more concrete, here's an example of how I had been invoking 
PVH boot recently:

    x86_64-softmmu/qemu-system-x86_64 \
      -name testvm01 \
      -machine q35,accel=kvm,nvdimm \
      -cpu host \
      -m 1024,maxmem=20G,slots=2 \
      -smp 1 \
      -nodefaults \
      -kernel binaries/vmlinux \
      -object 
memory-backend-file,id=mem0,share,mem-path=binaries/containers.img,size=235929600 
\
      -device nvdimm,memdev=mem0,id=nv0 \
      -append 'console=ttyS0,115200,8n1 root=/dev/pmem0p1 panic=1 rw 
init=/usr/lib/systemd/systemd rootfstype=ext4' \
      -bios binaries/bios.bin \
      -serial mon:stdio

Thanks,
-Maran



> Thx.
>

