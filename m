Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7381AC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A36F2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lW40+lCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A36F2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeJXT2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:28:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53552 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeJXT2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:28:40 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9OAxJfA180011;
        Wed, 24 Oct 2018 11:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=bX6RUfphyqHyZeURl0BA8FLGlS+eCWKi3wRWc0blAHc=;
 b=lW40+lCjvRV8Hnj+nmlkirIbCjelkz8hEpmzPkzs4KI8rOzlxgTZzfHBlC/nx/M+Bao8
 0+g1whrfUQhco91143l8IV7yLhC5HuF5yqvmrPgi3jDq/fZRxGl3z0s2zozkxQ46twxW
 uNzQWbcEWyNdl6D8xN3e12VTO2NFUjthvy8kYkUoaNhUQ4bVtbZcpMqQPVooR1y2+rWI
 Ms6PRntW17yd+bnaFegSu1l5DOENS35RuGuyAtfJQMDx9VUqrWwzwwP8TyY4fEgSmdCA
 9KbXdyui+yu1YrtdLkGAsGOG2Y9pooj6TUzgXD5lNju4FznE1/etwpGvPFVu9Q+xud5r TA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2n7vaq2ssu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Oct 2018 11:00:25 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9OB0Np5006816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Oct 2018 11:00:24 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9OB0GQ7016489;
        Wed, 24 Oct 2018 11:00:22 GMT
Received: from [192.168.15.133] (/47.8.173.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Oct 2018 04:00:16 -0700
Subject: Re: Redoing eXclusive Page Frame Ownership (XPFO) with isolated CPUs
 in mind (for KVM to isolate its guests per CPU)
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     "Stecklina, Julian" <jsteckli@amazon.de>
Cc:     "juerg.haefliger@hpe.com" <juerg.haefliger@hpe.com>,
        "deepa.srinivasan@oracle.com" <deepa.srinivasan@oracle.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "pradeep.vincent@oracle.com" <pradeep.vincent@oracle.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kanth.ghatraju@oracle.com" <kanth.ghatraju@oracle.com>,
        "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
        "liran.alon@oracle.com" <liran.alon@oracle.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "keescook@google.com" <keescook@google.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "chris.hyser@oracle.com" <chris.hyser@oracle.com>,
        "tyhicks@canonical.com" <tyhicks@canonical.com>,
        "john.haxby@oracle.com" <john.haxby@oracle.com>,
        "jcm@redhat.com" <jcm@redhat.com>
References: <CA+55aFxyUdhYjnQdnmWAt8tTwn4HQ1xz3SAMZJiawkLpMiJ_+w@mail.gmail.com>
 <ciirm8a7p3alos.fsf@u54ee758033e858cfa736.ant.amazon.com>
 <CA+55aFzHj_GNZWG4K2oDu4DPP9sZdTZ9PY7sBxGB6WoN9g8d=A@mail.gmail.com>
 <ciirm8zhwyiqh4.fsf@u54ee758033e858cfa736.ant.amazon.com>
 <ciirm8efdy916l.fsf@u54ee758033e858cfa736.ant.amazon.com>
 <5efc291c-b0ed-577e-02d1-285d080c293d@oracle.com>
 <ciirm8va743105.fsf@u54ee758033e858cfa736.ant.amazon.com>
 <7221975d-6b67-effa-2747-06c22c041e78@oracle.com>
 <1537800341.9745.20.camel@amazon.de>
 <063f5efc-afb2-471f-eb4b-79bf90db22dd@oracle.com>
Organization: Oracle Corp
Message-ID: <6cc985bb-6aed-4fb7-0ef2-43aad2717095@oracle.com>
Date:   Wed, 24 Oct 2018 16:30:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <063f5efc-afb2-471f-eb4b-79bf90db22dd@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9055 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=984
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810240099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/2018 01:37 PM, Khalid Aziz wrote:
> On 09/24/2018 08:45 AM, Stecklina, Julian wrote:
>> I didn't test the version with TLB flushes, because it's clear that the
>> overhead is so bad that no one wants to use this.
> 
> I don't think we can ignore the vulnerability caused by not flushing 
> stale TLB entries. On a mostly idle system, TLB entries hang around long 
> enough to make it fairly easy to exploit this. I was able to use the 
> additional test in lkdtm module added by this patch series to 
> successfully read pages unmapped from physmap by just waiting for system 
> to become idle. A rogue program can simply monitor system load and mount 
> its attack using ret2dir exploit when system is mostly idle. This brings 
> us back to the prohibitive cost of TLB flushes. If we are unmapping a 
> page from physmap every time the page is allocated to userspace, we are 
> forced to incur the cost of TLB flushes in some way. Work Tycho was 
> doing to implement Dave's suggestion can help here. Once Tycho has 
> something working, I can measure overhead on my test machine. Tycho, I 
> can help with your implementation if you need.

I looked at Tycho's last patch with batch update from 
<https://lkml.org/lkml/2017/11/9/951>. I ported it on top of Julian's 
patches and got it working well enough to gather performance numbers. 
Here is what I see for system times on a machine with dual Xeon E5-2630 
and 256GB of memory when running "make -j30 all" on 4.18.6 kernel 
(percentages are relative to base 4.19-rc8 kernel without xpfo):


Base 4.19-rc8				913.84s
4.19-rc8 + xpfo, no TLB flush		1027.985s (+12.5%)
4.19-rc8 + batch update, no TLB flush	970.39s (+6.2%)
4.19-rc8 + xpfo, TLB flush		8458.449s (+825.6%)
4.19-rc8 + batch update, TLB flush	4665.659s (+410.6%)

Batch update is significant improvement but we are starting so far 
behind baseline, it is still a huge slow down.

--
Khalid

