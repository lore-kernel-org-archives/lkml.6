Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631D4C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08718216C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l4tbA9iU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08718216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbeHURYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 13:24:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47212 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbeHURYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 13:24:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7LDxJg2021449;
        Tue, 21 Aug 2018 14:02:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=eS/jbnoiStp6z91Q35PdP9FPUYjBnHPylDqiZ9YmGcE=;
 b=l4tbA9iU3WMQzcTk4oV1wIwTxjfZcl84f1HLB6B7I7LFj/K+Ck94IfVivWLT9usgCJOO
 Jk8xs7GAO0rnNih5PJlHEkX5+Ddr6mj6kizN/tQj9VILVlUc1Bk2u/Wjc77iLNvd2LlV
 tK8hulHJn3KRthIbR5QzKb1nHAiZbRV2ajbJ32KtjRxEkYJ8oZghdLR82gb8WWsipOmH
 fK3vADpPRBsIeOuthtFx9Pwng3nt+xRcUQoTXL43kdfc/iSubHiabB+dkwGQx6ouW+Vs
 ug8yGug77sRCQIgJpijwN2xgYUnlIiu9jIDiVmD7POwocAwKK/R1E+D6iNmZqk4QE0gw AA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2kxc3qmm1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Aug 2018 14:02:07 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7LE26hD030546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Aug 2018 14:02:06 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7LE24T4027816;
        Tue, 21 Aug 2018 14:02:04 GMT
Received: from lirans-mbp.ravello.local (/213.57.127.2)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Aug 2018 07:02:03 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: Redoing eXclusive Page Frame Ownership (XPFO) with isolated CPUs
 in mind (for KVM to isolate its guests per CPU)
From:   Liran Alon <liran.alon@oracle.com>
In-Reply-To: <1534845423.10027.44.camel@infradead.org>
Date:   Tue, 21 Aug 2018 17:01:57 +0300
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        juerg.haefliger@hpe.com, deepa.srinivasan@oracle.com,
        Jim Mattson <jmattson@google.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-mm <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        joao.m.martins@oracle.com, pradeep.vincent@oracle.com,
        Andi Kleen <ak@linux.intel.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        kanth.ghatraju@oracle.com, Kees Cook <keescook@google.com>,
        jsteckli@os.inf.tu-dresden.de,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        chris.hyser@oracle.com, Tyler Hicks <tyhicks@canonical.com>,
        John Haxby <john.haxby@oracle.com>,
        Jon Masters <jcm@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <ED24D811-C740-417F-A443-B7A249F4FF4C@oracle.com>
References: <20180820212556.GC2230@char.us.oracle.com>
 <CA+55aFxZCyVZc4ZpRyZ3uDyakRSOG_=2XvnwMo4oejpsieF9=A@mail.gmail.com>
 <1534801939.10027.24.camel@amazon.co.uk>
 <CA+55aFxyUdhYjnQdnmWAt8tTwn4HQ1xz3SAMZJiawkLpMiJ_+w@mail.gmail.com>
 <1534845423.10027.44.camel@infradead.org>
To:     David Woodhouse <dwmw2@infradead.org>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8991 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808210147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 21 Aug 2018, at 12:57, David Woodhouse <dwmw2@infradead.org> wrote:
>=20
> Another alternative... I'm told POWER8 does an interesting thing with
> hyperthreading and gang scheduling for KVM. The host kernel doesn't
> actually *see* the hyperthreads at all, and KVM just launches the full
> set of siblings when it enters a guest, and gathers them again when =
any
> of them exits. That's definitely worth investigating as an option for
> x86, too.

I actually think that such scheduling mechanism which prevents leaking =
cache entries to sibling hyperthreads should co-exist together with the =
KVM address space isolation to fully mitigate L1TF and other similar =
vulnerabilities. The address space isolation should prevent VMExit =
handlers code gadgets from loading arbitrary host memory to the cache. =
Once VMExit code path switches to full host address space, then we =
should also make sure that no other sibling hyprethread is running in =
the guest.

Focusing on the scheduling mechanism, we must make sure that when a =
logical processor runs guest code, all siblings logical processors must =
run code which do not populate L1D cache with information unrelated to =
this VM. This includes forbidding one logical processor to run guest =
code while sibling is running a host task such as a NIC interrupt =
handler.
Thus, when a vCPU thread exits the guest into the host and VMExit =
handler reaches code flow which could populate L1D cache with this =
information, we should force an exit from the guest of the siblings =
logical processors, such that they will be allowed to resume only on a =
core which we can promise that the L1D cache is free from information =
unrelated to this VM.

At first, I have created a patch series which attempts to implement such =
mechanism in KVM. However, it became clear to me that this may need to =
be implemented in the scheduler itself. This is because:
1. It is difficult to handle all new scheduling contrains only in KVM.
2. This mechanism should be relevant for any Type-2 hypervisor which =
runs inside Linux besides KVM (Such as VMware Workstation or =
VirtualBox).
3. This mechanism could also be used to prevent future =
=E2=80=9Ccore-cache-leaking=E2=80=9D vulnerabilities to be exploited =
between processes of different security domains which run as siblings on =
the same core.

The main idea is a mechanism which is very similar to Microsoft's "core =
scheduler" which they implemented to mitigate this vulnerability. The =
mechanism should work as follows:
1. Each CPU core will now be tagged with a "security domain id".
2. The scheduler will provide a mechanism to tag a task with a security =
domain id.
3. Tasks will inherit their security domain id from their parent task.
    3.1. First task in system will have security domain id of 0. Thus, =
if nothing special is done, all tasks will be assigned with security =
domain id of 0.
4. Tasks will be able to allocate a new security domain id from the =
scheduler and assign it to another task dynamically.
5. Linux scheduler will prevent scheduling tasks on a core with a =
different security domain id:
    5.0. CPU core security domain id will be set to the security domain =
id of the tasks which currently run on it.
    5.1. The scheduler will attempt to first schedule a task on a core =
with required security domain id if such exists.
    5.2. Otherwise, will need to decide if it wishes to kick all tasks =
running on some core to run the task with a different security domain id =
on that core.

The above mechanism can be used to mitigate the L1TF HT variant by just =
assigning vCPU tasks with a security domain id which is unique per VM =
and also different than the security domain id of the host which is 0.

I would be glad to hear feedback on the above suggestion.
If this should better be discussed on a separate email thread, please =
say so and I will open a new thread.

Thanks,
-Liran


