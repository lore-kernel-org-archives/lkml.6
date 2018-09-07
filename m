Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866A8C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF2920844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H6Dsll6j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF2920844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbeIHCNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:13:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42832 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbeIHCNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:13:49 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w87LIgTO041626;
        Fri, 7 Sep 2018 21:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ELuhaeRrH1vi0zwKqxYfMNq5b292N1qzRMsQ/4Wy+Ig=;
 b=H6Dsll6jgPhQZndHt84H4g+l6Sv4tfCHbIbbUaBmAciFf5aI8vyDUJQuEWJ7QUrxZp4u
 A29mSG1Rohtqs4e9BIH48Qk9R9ybSx5PwKOzx5Cdw8UzOZ36S8smU5p2QhVhh+lzOGp1
 LiiNK+n5Pm/tB6zQZ0OMi5BBgsAjJllpePxwF5JVxxi/Wkaop42YtMt8n3qnb2/oZSoq
 DdgQpcvSG7cJxtdIgp0kU6H144ClvbjZCzqmg1dRtJ7v3I9GkfWzgOGZQDzaV7jE4mCc
 q+1x3ar3DHwfmJ1oX3H6whcFxfeScJi7Cq4uu8AE/N27ur834SRRs/cL70Lya9HkiEvJ Ng== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2m7kdr4pq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Sep 2018 21:30:17 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w87LUFBS032468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Sep 2018 21:30:15 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w87LUD7s029850;
        Fri, 7 Sep 2018 21:30:13 GMT
Received: from [192.168.1.16] (/24.9.64.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Sep 2018 14:30:12 -0700
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
References: <ciirm8a7p3alos.fsf@u54ee758033e858cfa736.ant.amazon.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <80a75259-e38b-be94-dc4a-827eddfae931@oracle.com>
Date:   Fri, 7 Sep 2018 15:30:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ciirm8a7p3alos.fsf@u54ee758033e858cfa736.ant.amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9009 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809070210
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/2018 10:00 AM, Julian Stecklina wrote:
> Hey everyone,
> 
> On Mon, 20 Aug 2018 15:27 Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> On Mon, Aug 20, 2018 at 3:02 PM Woodhouse, David <dwmw@amazon.co.uk> wrote:
>>>
>>> It's the *kernel* we don't want being able to access those pages,
>>> because of the multitude of unfixable cache load gadgets.
>>
>> Ahh.
>>
>> I guess the proof is in the pudding. Did somebody try to forward-port
>> that patch set and see what the performance is like?
> 
> I've been spending some cycles on the XPFO patch set this week. For the
> patch set as it was posted for v4.13, the performance overhead of
> compiling a Linux kernel is ~40% on x86_64[1]. The overhead comes almost
> completely from TLB flushing. If we can live with stale TLB entries
> allowing temporary access (which I think is reasonable), we can remove
> all TLB flushing (on x86). This reduces the overhead to 2-3% for
> kernel compile.
> 
> There were no problems in forward-porting the patch set to master.
> You can find the result here, including a patch makes the TLB flushing
> configurable:
> http://git.infradead.org/users/jsteckli/linux-xpfo.git/shortlog/refs/heads/xpfo-master
> 
> It survived some casual stress-ng runs. I can rerun the benchmarks on
> this version, but I doubt there is any change.
> 
>> It used to be just 500 LOC. Was that because they took horrible
>> shortcuts?
> 
> The patch is still fairly small. As for the horrible shortcuts, I let
> others comment on that.


Looks like the performance impact can be whole lot worse. On my test 
system with 2 Xeon Platinum 8160 (HT enabled) CPUs and 768 GB of memory, 
I am seeing very high penalty with XPFO when building 4.18.6 kernel 
sources with "make -j60":

              No XPFO patch   XPFO patch(No TLB flush)  XPFO(TLB Flush)
sys time      52m 54.036s       55m 47.897s              434m 8.645s

That is ~8% worse with TLB flush disabled and ~720% worse with TLB flush 
enabled. This test was with kernel sources being compiled on an ext4 
filesystem. XPFO seems to affect ext2 even more. With ext2 filesystem, 
impact was ~18.6% and ~900%.

--
Khalid


