Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D615C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0629220811
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FMewaJuu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0629220811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390168AbeKQDbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 22:31:46 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:33052 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbeKQDbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 22:31:46 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAGHE10a021480;
        Fri, 16 Nov 2018 17:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=3U1bYNGqhawLSrOj7zZRGxZdoq1JJhJWNWfpqUIYAyA=;
 b=FMewaJuu3WQV2DXmHbMHFNXgddgz5pMczPCncgQaqJuathNhIKW803AFPbr54mlHaOdV
 scvpnUsy1p5LGGtkJ2UZjmhAXsCLP12dvIcS/YwE/ZIhFtDQjdteFK9Tr6gbf0rGFKS+
 GEsPsw3yxlDYB7XUt098TzZWNQA2my4/Z1NrE6+J64+B443k7YQxmITiVpbG3EhFcMsH
 LFhlcU2Y2PAX3o4QhRABvUfOyeg9+UtXZUo6k/AzP0uI+tm+SGT4oFSPYqv5ronjnewC
 F+/mkMTx3rmJewdvKhXug139pl0Jz+4zpJY8P9BXGMI3t39THU84cySFG/Jwl4k1kSgw DQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2nr7csge9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Nov 2018 17:17:39 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAGHHYKw007033
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Nov 2018 17:17:34 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAGHHUo3019023;
        Fri, 16 Nov 2018 17:17:31 GMT
Received: from [10.159.250.128] (/10.159.250.128)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 16 Nov 2018 09:17:30 -0800
Subject: Re: [PATCH v7 0/7] KVM: x86: Allow Qemu/KVM to use PVH entry point
To:     Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, jgross@suse.com
Cc:     boris.ostrovsky@oracle.com, bp@suse.de,
        dave.hansen@linux.intel.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, hpa@zytor.com, jpoimboe@redhat.com,
        kirill.shutemov@linux.intel.com, linus.walleij@linaro.org,
        luto@kernel.org, mchehab@kernel.org, mingo@redhat.com,
        rdunlap@infradead.org, tglx@linutronix.de, thomas.lendacky@amd.com,
        hch@infradead.org, roger.pau@citrix.com, rkrcmar@redhat.com,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        George Kennedy <george.kennedy@oracle.com>,
        Maran Wilson <maran.wilson@oracle.com>
References: <1523920175-27287-1-git-send-email-maran.wilson@oracle.com>
 <9aeeaf85-6ecf-c1e2-640a-657f5bb0f8ef@redhat.com>
From:   Maran Wilson <maran.wilson@oracle.com>
Organization: Oracle Corporation
Message-ID: <bf0112de-8ceb-d1e4-d787-bf6bde7a1f14@oracle.com>
Date:   Fri, 16 Nov 2018 09:17:27 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9aeeaf85-6ecf-c1e2-640a-657f5bb0f8ef@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9079 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811160153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/2018 2:46 AM, Paolo Bonzini wrote:
> On 17/04/18 01:09, Maran Wilson wrote:
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
> Hi Maran, what happened to this series (and to the QEMU work)?

Hi Paolo,

Thank you for the reminder. Sorry, I have been wanting to continue this 
work for a while now, but our team has been pulled in other directions 
and this one ended up getting temporarily pushed down the priority stack.

Let me discuss with my management and get back to you. I do want (and 
intend) to support and push this over the finish line.

In the meantime, if there are any folks out there with a specific 
business need for getting this done sooner rather than later and are 
able to invest a bit of time to collaborate on the remaining Qemu work, 
please feel free to ping me offline. We have some preliminary Qemu 
patches, but there is some additional work needed before they are ready 
wider review.

Thanks,
-Maran

>
> Paolo
>
>> Changes from v6:
>>
>>   * Addressed issues caught by the kbuild test robot:
>>      - Restored an #include line that had been dropped by mistake (patch 4)
>>      - Removed a pair of #include lines that were no longer needed in a
>>        common code file and causing problems for certain 32-bit configs
>>        (patchs 4 and 7)
>>
>> Changes from v5:
>>
>>   * The interface changes to the x86/HVM start info layout have
>>     now been accepted into the Xen tree.
>>   * Rebase and merge upstream PVH file changes.
>>   * (Patch 6) Synced up to the final version of the header file that was
>>               acked and pulled into the Xen tree.
>>   * (Patch 1) Fixed typo and removed redundant "def_bool n" line.
>>
>> Changes from v4:
>>
>> Note: I've withheld Juergen's earlier "Reviewed-by" tags from patches
>> 1 and 7 since there were minor changes (mostly just addition of
>> CONFIG_KVM_GUEST_PVH as requested) that came afterwards.
>>
>>   * Changed subject prefix from RFC to PATCH
>>   * Added CONFIG_KVM_GUEST_PVH as suggested
>>   * Relocated the PVH common files to
>>     arch/x86/platform/pvh/{enlighten.c,head.S}
>>   * Realized I also needed to move the objtool override for those files
>>   * Updated a few code comments per reviewer feedback
>>   * Sent out a patch of the hvm_start_info struct changes against the Xen
>>     tree since that is the canonical copy of the header. Discussions on
>>     that thread have resulted in some (non-functional) updates to
>>     start_info.h (patch 6/7) and those changes are reflected here as well
>>     in order to keep the files in sync. The header file has since been
>>     ack'ed for the Xen tree by Jan Beulich.
>>
>> Changes from v3:
>>
>>   * Implemented Juergen's suggestion for refactoring and moving the PVH
>>     code so that CONFIG_XEN is no longer required for booting KVM guests
>>     via the PVH entry point.
>>     Functionally, nothing has changed from V3 really, but the patches
>>     look completely different now because of all the code movement and
>>     refactoring. Some of these patches can be combined, but I've left
>>     them very small in some cases to make the refactoring and code
>>     movement easier to review.
>>     My approach for refactoring has been to create a PVH entry layer that
>>     still has understanding and knowledge about Xen vs non-Xen guest types
>>     so that it can make run time decisions to handle either case, as
>>     opposed to going all the way and re-writing it to be a completely
>>     hypervisor agnostic and architecturally pure layer that is separate
>>     from guest type details. The latter seemed a bit overkill in this
>>     situation. And I've handled the complexity of having to support
>>     Qemu/KVM boot of kernels compiled with or without CONFIG_XEN via a
>>     pair of xen specific __weak routines that can be overridden in kernels
>>     that support Xen guests. Importantly, the __weak routines are for
>>     xen specific code only (not generic "guest type" specific code) so
>>     there is no clashing between xen version of the strong routine and,
>>     say, a KVM version of the same routine. But I'm sure there are many
>>     ways to skin this cat, so I'm open to alternate suggestions if there
>>     is a compelling reason for not using __weak in this situation.
>>
>> Changes from v2:
>>
>>   * All structures (including memory map table entries) are padded and
>>     aligned to an 8 byte boundary.
>>
>>   * Removed the "packed" attributes and made changes to comments as
>>     suggested by Jan.
>>
>> Changes from v1:
>>
>>   * Adopted Paolo's suggestion for defining a v2 PVH ABI that includes the
>>     e820 map instead of using the second module entry to pass the table.
>>
>>   * Cleaned things up a bit to reduce the number of xen vs non-xen special
>>     cases.
>>
>>
>> Maran Wilson (7):
>>    xen/pvh: Split CONFIG_XEN_PVH into CONFIG_PVH and CONFIG_XEN_PVH
>>    xen/pvh: Move PVH entry code out of Xen specific tree
>>    xen/pvh: Create a new file for Xen specific PVH code
>>    xen/pvh: Move Xen specific PVH VM initialization out of common file
>>    xen/pvh: Move Xen code for getting mem map via hcall out of common
>>      file
>>    xen/pvh: Add memory map pointer to hvm_start_info struct
>>    KVM: x86: Allow Qemu/KVM to use PVH entry point
>>
>>   MAINTAINERS                                     |   1 +
>>   arch/x86/Kbuild                                 |   2 +
>>   arch/x86/Kconfig                                |  14 +++
>>   arch/x86/kernel/head_64.S                       |   2 +-
>>   arch/x86/platform/pvh/Makefile                  |   5 +
>>   arch/x86/platform/pvh/enlighten.c               | 136 ++++++++++++++++++++++++
>>   arch/x86/{xen/xen-pvh.S => platform/pvh/head.S} |   0
>>   arch/x86/xen/Kconfig                            |   3 +-
>>   arch/x86/xen/Makefile                           |   2 -
>>   arch/x86/xen/enlighten_pvh.c                    |  93 +++-------------
>>   include/xen/interface/hvm/start_info.h          |  63 ++++++++++-
>>   11 files changed, 240 insertions(+), 81 deletions(-)
>>   create mode 100644 arch/x86/platform/pvh/Makefile
>>   create mode 100644 arch/x86/platform/pvh/enlighten.c
>>   rename arch/x86/{xen/xen-pvh.S => platform/pvh/head.S} (100%)
>>

