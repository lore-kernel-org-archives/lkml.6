Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8B3C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7564E2087D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zuQX3WaE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7564E2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbeJOPwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 11:52:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39238 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbeJOPwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 11:52:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9F849NZ061487;
        Mon, 15 Oct 2018 08:07:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Dg9XB6zUtoe7qqQI02MC6TtsPJn5zwmTVmE0wuD6rbw=;
 b=zuQX3WaERXkNKoWYzl2623IhHTB2GPOXrAD+iNg+9nUBcarI9LMaGqDJcJ9zHTe0N3mh
 B4sBLbEWGrvh4rj04H9SimXtsKMTzpnqNNRT5wYAquLn472V74ysViowRcUP1zYX44QO
 YFZXliHgsXHz3CorJPemRkF6s7yGlPC44Z2xpXkHT3lThJk9Np/s4Lr0tsjiTk8LABV/
 PByDBwR+2fjazJXAtJbSuIQJPh/ZM+5zj8BzuTwXaputCNqv1kX3TGH5DJpQQ/xiRhAS
 hSHWjNFegGS2WcxA0d8+dOnEAlhZMN8X4QIAN/+tGSClOPCCY7Q3Lilc61J3VHeSzI0z Yg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2n39br0ptr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Oct 2018 08:07:35 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9F87Xct032230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Oct 2018 08:07:33 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9F87U3K013570;
        Mon, 15 Oct 2018 08:07:31 GMT
Received: from [10.191.235.38] (/10.191.235.38)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Oct 2018 01:07:30 -0700
From:   Khalid Aziz <khalid.aziz@oracle.com>
Subject: Re: Redoing eXclusive Page Frame Ownership (XPFO) with isolated CPUs
 in mind (for KVM to isolate its guests per CPU)
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
Organization: Oracle Corp
Message-ID: <063f5efc-afb2-471f-eb4b-79bf90db22dd@oracle.com>
Date:   Mon, 15 Oct 2018 02:07:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537800341.9745.20.camel@amazon.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9046 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810150076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/24/2018 08:45 AM, Stecklina, Julian wrote:
> I didn't test the version with TLB flushes, because it's clear that the
> overhead is so bad that no one wants to use this.

I don't think we can ignore the vulnerability caused by not flushing 
stale TLB entries. On a mostly idle system, TLB entries hang around long 
enough to make it fairly easy to exploit this. I was able to use the 
additional test in lkdtm module added by this patch series to 
successfully read pages unmapped from physmap by just waiting for system 
to become idle. A rogue program can simply monitor system load and mount 
its attack using ret2dir exploit when system is mostly idle. This brings 
us back to the prohibitive cost of TLB flushes. If we are unmapping a 
page from physmap every time the page is allocated to userspace, we are 
forced to incur the cost of TLB flushes in some way. Work Tycho was 
doing to implement Dave's suggestion can help here. Once Tycho has 
something working, I can measure overhead on my test machine. Tycho, I 
can help with your implementation if you need.

--
Khalid
