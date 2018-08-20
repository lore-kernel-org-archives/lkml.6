Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1598CC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4EF120C01
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XTHvaRtV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4EF120C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbeHUAny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 20:43:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47534 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeHUAny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 20:43:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7KLO0LD042833;
        Mon, 20 Aug 2018 21:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=92DS7IVfrqhrKgQqQXDTE2nTprc0i3J+m5MoQhxoIy4=;
 b=XTHvaRtVQf/y8DJvZYx7ENw/2RLmCJaXkT2E1TQm81Jyed53kZXC4aoyN58obHMLNnDY
 HuXjRVsLH7nRg3L5nmG/tVFZC9jDPX+FrwmAH4zZgZEDIl7F9o9Rszbt3A+OGG7r5lGH
 ZF8vEDdHS0B+gySqG7ZpeZJNeS4dMJ2puaTo1suAOybfy23750M4Cim1p0mzyYev8ljN
 VPlvIMWm5Zr3+RCDmxYhL470y+e7mNXQTXH97TAhkLlOwAnP3gB/TaCkN/7hvD76zeGU
 X4tkVgjfUuEP2OnNSY6fOHTVWUHxnDNgpbOa4OastBIL99/Zu+m3r5SDKb2liXlsYrwk kg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2kxc3qgvs7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Aug 2018 21:26:01 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7KLPxUA003535
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Aug 2018 21:26:00 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7KLPwiZ014182;
        Mon, 20 Aug 2018 21:25:58 GMT
Received: from char.us.oracle.com (/10.152.35.101)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Aug 2018 14:25:58 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 665FA6A010B; Mon, 20 Aug 2018 17:25:56 -0400 (EDT)
Date:   Mon, 20 Aug 2018 17:25:56 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     kernel-hardening@lists.openwall.com,
        Liran Alon <liran.alon@oracle.com>,
        Deepa Srinivasan <deepa.srinivasan@oracle.com>,
        linux-mm@kvack.org, juerg.haefliger@hpe.com,
        khalid.aziz@oracle.com, chris.hyser@oracle.com,
        tyhicks@canonical.com, dwmw@amazon.co.uk, keescook@google.com,
        andrew.cooper3@citrix.com, jcm@redhat.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Kanth <kanth.ghatraju@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>, jmattson@google.com,
        pradeep.vincent@oracle.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ak@linux.intel.com, john.haxby@oracle.com,
        jsteckli@os.inf.tu-dresden.de
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Redoing eXclusive Page Frame Ownership (XPFO) with isolated CPUs in
 mind (for KVM to isolate its guests per CPU)
Message-ID: <20180820212556.GC2230@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8991 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808200216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

See eXclusive Page Frame Ownership (https://lwn.net/Articles/700606/) which was posted
way back in in 2016..

In the last couple of months there has been a slew of CPU issues that have complicated
a lot of things. The latest - L1TF - is still fresh in folks's mind and it is
especially acute to virtualization workloads.

As such a bunch of various folks from different cloud companies (CCed) are looking
at a way to make Linux kernel be more resistant to hardware having these sort of 
bugs.

In particular we are looking at a way to "remove as many mappings from the global
kernel address space as possible. Specifically, while being in the
context of process A, memory of process B should not be visible in the
kernel." (email from Julian Stecklina). That is the high-level view and 
how this could get done, well, that is why posting this on
LKML/linux-hardening/kvm-devel/linux-mm to start the discussion.

Usually I would start with a draft of RFC patches so folks can rip it apart, but
thanks to other people (Juerg thank you!) it already exists:

(see https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1222756.html)

The idea would be to extend this to:

 1) Only do it for processes that run under CPUS which are in isolcpus list.

 2) Expand this to be a per-cpu page tables. That is each CPU has its own unique
    set of pagetables - naturally _START_KERNEL -> __end would be mapped but the
    rest would not.

Thoughts? Is this possible? Crazy? Better ideas?
