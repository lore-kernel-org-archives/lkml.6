Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE74C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 17:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8242561D
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 17:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8242561D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751380AbeF3RRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 13:17:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33698 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751246AbeF3RRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 13:17:03 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5UHF0fx121130
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 13:17:03 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jx6chmxe1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 13:17:03 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 30 Jun 2018 13:17:01 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 30 Jun 2018 13:16:59 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5UHGwEF9699772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 30 Jun 2018 17:16:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E8C7B2064;
        Sat, 30 Jun 2018 13:16:46 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2878B205F;
        Sat, 30 Jun 2018 13:16:45 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.206.224])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 30 Jun 2018 13:16:45 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id AEDD516C3F1E; Sat, 30 Jun 2018 10:19:07 -0700 (PDT)
Date:   Sat, 30 Jun 2018 10:19:07 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,oom: Bring OOM notifier callbacks to outside of OOM
 killer.
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180621073142.GA10465@dhcp22.suse.cz>
 <2d8c3056-1bc2-9a32-d745-ab328fd587a1@i-love.sakura.ne.jp>
 <20180626170345.GA3593@linux.vnet.ibm.com>
 <20180627072207.GB32348@dhcp22.suse.cz>
 <20180627143125.GW3593@linux.vnet.ibm.com>
 <20180628113942.GD32348@dhcp22.suse.cz>
 <20180628213105.GP3593@linux.vnet.ibm.com>
 <20180629090419.GD13860@dhcp22.suse.cz>
 <20180629125218.GX3593@linux.vnet.ibm.com>
 <bf76c93d-37d6-5f1e-4e5a-122089997fd9@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf76c93d-37d6-5f1e-4e5a-122089997fd9@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18063017-0072-0000-0000-0000037799F6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009284; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01054591; UDB=6.00540822; IPR=6.00832513;
 MB=3.00021942; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-30 17:17:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18063017-0073-0000-0000-0000488B0A2E
Message-Id: <20180630171907.GA3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-30_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=885 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806300203
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 11:35:48PM +0900, Tetsuo Handa wrote:
> On 2018/06/29 21:52, Paul E. McKenney wrote:
> > The effect of RCU's current OOM code is to speed up callback invocation
> > by at most a few seconds (assuming no stalled CPUs, in which case
> > it is not possible to speed up callback invocation).
> > 
> > Given that, I should just remove RCU's OOM code entirely?
> 
> out_of_memory() will start selecting an OOM victim without calling
> get_page_from_freelist() since rcu_oom_notify() does not set non-zero
> value to "freed" field.
> 
> I think that rcu_oom_notify() needs to wait for completion of callback
> invocations (possibly with timeout in case there are stalling CPUs) and
> set non-zero value to "freed" field if pending callbacks did release memory.

Waiting for the callbacks is easy.  Timeouts would be a bit harder, but
still doable.  I have no idea how to tell which callbacks freed memory
and how much -- all RCU does is invoke a function, and that function
can do whatever its developer wants.

> However, what will be difficult to tell is whether invocation of pending callbacks
> did release memory. Lack of last second get_page_from_freelist() call after
> blocking_notifier_call_chain(&oom_notify_list, 0, &freed) forces rcu_oom_notify()
> to set appropriate value (i.e. zero or non-zero) to "freed" field.
> 
> We have tried to move really last second get_page_from_freelist() call to inside
> out_of_memory() after blocking_notifier_call_chain(&oom_notify_list, 0, &freed).
> But that proposal was not accepted...
> 
> We could move blocking_notifier_call_chain(&oom_notify_list, 0, &freed) to
> before last second get_page_from_freelist() call (and this is what this patch
> is trying to do) which would allow rcu_oom_notify() to always return 0...
> or update rcu_oom_notify() to use shrinker API...

Would it be possible to tell RCU that memory was starting to get tight
with one call, and then tell it that things are OK with another call?
That would make much more sense from an RCU perspective.

							Thanx, Paul

