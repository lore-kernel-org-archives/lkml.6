Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60DEFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BB220853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="4USV956P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73BB220853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbeINWXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:23:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43206 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbeINWXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:23:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8EH4NKN059416;
        Fri, 14 Sep 2018 17:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=pGxRt0ER/Y461WOoR10RP+CxMr5JnDyPwp78bs+aAKk=;
 b=4USV956PhLH1nHLsXogahZAip9u7pGO2+FzxaPcbwVzqtpO3qlNaWt4eEBoSrOzFBXI/
 5EwuXlB+0+ZI+HRbpx3LrvvwhLH9HbIxm4B58J7OeUaYb8X4LIoJjlbMZz4deQktru/F
 6oQlPbQondNJ2CYpWu1lLUa0RPUl6TmM39Uw7goTdFm6hvrRSxKsvJh0zFP3ESxiKbwL
 HSlK6uDrWPc0CvhrvnFlRmj3fbO967+MuV2iQQ4lmissjDkcNdt6ILcKxSjYmePaQlY0
 isQ4FN4F9FPI402Oz6ejD3rd9pIcVGc5bONMBZYNBbxPL1l4xEs8eA7Oq1p6PqcZEPo8 Vw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2mc5uu09mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 17:07:04 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8EH6vom021291
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 17:06:57 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8EH6tBU032596;
        Fri, 14 Sep 2018 17:06:56 GMT
Received: from [192.168.1.44] (/24.9.64.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Sep 2018 10:06:55 -0700
Subject: Re: Redoing eXclusive Page Frame Ownership (XPFO) with isolated CPUs
 in mind (for KVM to isolate its guests per CPU)
To:     Julian Stecklina <jsteckli@amazon.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        juerg.haefliger@hpe.com, deepa.srinivasan@oracle.com,
        Jim Mattson <jmattson@google.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-mm <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        joao.m.martins@oracle.com, pradeep.vincent@oracle.com,
        Andi Kleen <ak@linux.intel.com>, kanth.ghatraju@oracle.com,
        Liran Alon <liran.alon@oracle.com>,
        Kees Cook <keescook@google.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        chris.hyser@oracle.com, Tyler Hicks <tyhicks@canonical.com>,
        John Haxby <john.haxby@oracle.com>,
        Jon Masters <jcm@redhat.com>
References: <CA+55aFxyUdhYjnQdnmWAt8tTwn4HQ1xz3SAMZJiawkLpMiJ_+w@mail.gmail.com>
 <ciirm8a7p3alos.fsf@u54ee758033e858cfa736.ant.amazon.com>
 <CA+55aFzHj_GNZWG4K2oDu4DPP9sZdTZ9PY7sBxGB6WoN9g8d=A@mail.gmail.com>
 <ciirm8zhwyiqh4.fsf@u54ee758033e858cfa736.ant.amazon.com>
 <ciirm8efdy916l.fsf@u54ee758033e858cfa736.ant.amazon.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <5efc291c-b0ed-577e-02d1-285d080c293d@oracle.com>
Date:   Fri, 14 Sep 2018 11:06:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ciirm8efdy916l.fsf@u54ee758033e858cfa736.ant.amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9016 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809140174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2018 09:37 AM, Julian Stecklina wrote:
> Julian Stecklina <jsteckli@amazon.de> writes:
> 
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>>
>>> On Fri, Aug 31, 2018 at 12:45 AM Julian Stecklina <jsteckli@amazon.de> wrote:
>>>>
>>>> I've been spending some cycles on the XPFO patch set this week. For the
>>>> patch set as it was posted for v4.13, the performance overhead of
>>>> compiling a Linux kernel is ~40% on x86_64[1]. The overhead comes almost
>>>> completely from TLB flushing. If we can live with stale TLB entries
>>>> allowing temporary access (which I think is reasonable), we can remove
>>>> all TLB flushing (on x86). This reduces the overhead to 2-3% for
>>>> kernel compile.
>>>
>>> I have to say, even 2-3% for a kernel compile sounds absolutely horrendous.
>>
>> Well, it's at least in a range where it doesn't look hopeless.
>>
>>> Kernel bullds are 90% user space at least for me, so a 2-3% slowdown
>>> from a kernel is not some small unnoticeable thing.
>>
>> The overhead seems to come from the hooks that XPFO adds to
>> alloc/free_pages. These hooks add a couple of atomic operations per
>> allocated (4K) page for book keeping. Some of these atomic ops are only
>> for debugging and could be removed. There is also some opportunity to
>> streamline the per-page space overhead of XPFO.
> 
> I've updated my XPFO branch[1] to make some of the debugging optional
> and also integrated the XPFO bookkeeping with struct page, instead of
> requiring CONFIG_PAGE_EXTENSION, which removes some checks in the hot
> path. These changes push the overhead down to somewhere between 1.5 and
> 2% for my quad core box in kernel compile. This is close to the
> measurement noise, so I take suggestions for a better benchmark here.
> 
> Of course, if you hit contention on the xpfo spinlock then performance
> will suffer. I guess this is what happened on Khalid's large box.
> 
> I'll try to remove the spinlocks and add fixup code to the pagefault
> handler to see whether this improves the situation on large boxes. This
> might turn out to be ugly, though.
> 

Hi Julian,

I ran tests with your updated code and gathered lock statistics. Change in system time for "make -j60" was in the noise margin (It actually went up by about 2%). There is some contention on xpfo_lock. Average wait time does not look high compared to other locks. Max hold time looks a little long. From /proc/lock_stat:

              &(&page->xpfo_lock)->rlock:         29698          29897           0.06         134.39       15345.58           0.51      422474670      960222532           0.05       30362.05   195807002.62           0.20

Nevertheless even a smaller average wait time can add up.

--
Khalid



