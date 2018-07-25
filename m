Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19E3C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9568C20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9568C20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbeGYUaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 16:30:30 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:38950 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729417AbeGYUaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 16:30:30 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fiPHq-0002S6-LI; Wed, 25 Jul 2018 13:17:26 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fiPHp-000098-H1; Wed, 25 Jul 2018 13:17:26 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     David Ahern <dsahern@gmail.com>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        nikita.leshchenko@oracle.com,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Alexander Aring <alex.aring@gmail.com>,
        linux-wpan@vger.kernel.org,
        NetFilter <netfilter-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1a3f59a9-0ba5-c83f-16a6-f9550a84f693@gmail.com>
        <CAM_iQpWabZorkMNswyfHyS4KT=f_bgMtK8K35=84uah6Kfqxew@mail.gmail.com>
        <1a27e301-3275-b349-a2f8-afdfdc02f04f@gmail.com>
        <20180718.125938.2271502580775162784.davem@davemloft.net>
        <28c30574-391c-b4bd-c337-51d3040d901a@gmail.com>
        <CAM_iQpW4-JkZY7jXx0Q1b907hQ85UOL1eXv2YHwSukb5L=apUg@mail.gmail.com>
        <5021d874-8e99-6eba-f24b-4257c62d4457@gmail.com>
        <CAM_iQpUc-H2kZCBevePs6g-8qKyJkUhdd1ZDSQgYsCG0ChfC2w@mail.gmail.com>
        <87muufze8w.fsf@xmission.com>
        <4b03b5f6-87ce-9ff2-7c14-598beebd8fb8@gmail.com>
        <87zhyfw70m.fsf@xmission.com>
        <dacc9322-fd5a-dfeb-e4f1-7a288fb79886@gmail.com>
Date:   Wed, 25 Jul 2018 14:17:21 -0500
In-Reply-To: <dacc9322-fd5a-dfeb-e4f1-7a288fb79886@gmail.com> (David Ahern's
        message of "Wed, 25 Jul 2018 12:13:30 -0600")
Message-ID: <87o9evt9a6.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fiPHp-000098-H1;;;mid=<87o9evt9a6.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/R2zkNmVwQ6kjKZbQSiFAEYhKimhriGiQ=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH RFC/RFT net-next 00/17] net: Convert neighbor tables to per-namespace
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Ahern <dsahern@gmail.com> writes:

> On 7/25/18 11:38 AM, Eric W. Biederman wrote:
>> 
>> Absolutely NOT.  Global thresholds are exactly correct given the fact
>> you are running on a single kernel.
>> 
>> Memory is not free (Even though we are swimming in enough of it memory
>> rarely matters).  One of the few remaining challenges is for containers
>> is finding was to limit resources in such a way that one application
>> does not mess things up for another container during ordinary usage.
>> 
>> It looks like the neighbour tables absolutely are that kind of problem,
>> because the artificial limits are too strict.   Completely giving up on
>> limits does not seem right approach either.  We need to fix the limits
>> we have (perhaps making them go away entirely), not just apply a
>> band-aid.  Let's get to the bottom of this and make the system better.
>
> Eric: yes, they all share the global resource of memory and there should
> be limits on how many entries a remote entity can create.
>
> Network namespaces can provide a separation such that one namespace does
> not disrupt networking in another. It is absolutely appropriate to do
> so. Your rigid stance is inconsistent given the basic meaning of a
> network namespace and the parallels to this same problem -- bridges,
> vxlans, and ip fragments. Only neighbor tables are not per-device or per
> namespace; your insistence on global limits is missing the mark and wrong.

That is not what I said.  Let me rephrase and see if you understand.

The problem appears to be of lots of devices.  Fundamentally if you use
lots of network devices today unless you adjust gc_thresh3 you will run
out of neighbour table entries.

The problem has a bigger scope than what you are looking at.

If you fix the core problem you won't see the problem in the context
of network namespaces either.

Default limits should be something that will never be hit unless
something goes crazy.  We are hitting them.  Therefore by definition
there is a bug in these limits.


And yes there is absolutely a place for global limits on things like
inodes, file descriptors etc, that does not care about which part of the
kernel you are in.  However hitting those limits in normal operation is
a bug.

We have ourselves a bug.

Eric

p.s. I wrote the definition of network namespaces and it absolutely does
have room for global limits.   One of the things Linus has periodically
yelled at me about is that there are not enough of them.


