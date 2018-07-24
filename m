Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D9CC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE3520856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE3520856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388498AbeGXMGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:06:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59774 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388291AbeGXMGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:06:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B224E406E974;
        Tue, 24 Jul 2018 11:01:01 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 231C42156897;
        Tue, 24 Jul 2018 11:00:59 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Yidong Ren <Yidong.Ren@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        "devel\@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Madhan Sivakumar <madhans@microsoft.com>
Subject: Re: [PATCH v3] hv_netvsc: Add per-cpu ethtool stats for netvsc
References: <20180613193608.444-1-yidren@linuxonhyperv.com>
        <20180724012622.26873-1-yidren@linuxonhyperv.com>
        <SN6PR2101MB11359728E41C4B2AB8E7736D84550@SN6PR2101MB1135.namprd21.prod.outlook.com>
Date:   Tue, 24 Jul 2018 13:00:59 +0200
In-Reply-To: <SN6PR2101MB11359728E41C4B2AB8E7736D84550@SN6PR2101MB1135.namprd21.prod.outlook.com>
        (Yidong Ren's message of "Tue, 24 Jul 2018 01:42:06 +0000")
Message-ID: <87k1pkrj84.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 24 Jul 2018 11:01:01 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 24 Jul 2018 11:01:01 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yidong Ren <Yidong.Ren@microsoft.com> writes:

>> From: Yidong Ren <yidren@linuxonhyperv.com>
>> Sent: Monday, July 23, 2018 6:26 PM
>> +	pcpu_sum = kvmalloc(sizeof(struct netvsc_ethtool_pcpu_stats) *
>> +			num_present_cpus(), GFP_KERNEL);
>
> Since there is no plan for CPU hotplug in Hyper-V in short term, it is fine 
> to use num_present_cpus for now. We can move to debugfs later if necessary.

While you do for_each_present_cpu() in netvsc_get_ethtool_stats(),
netvsc_get_pcpu_stats() does for_each_possible_cpu(). This looks
inconsistent.

The allocation you're doing here is short-lived so I would suggest you
use possible_cpus everywhere. Even knowing there's no CPU hotplug on
Hyper-V at this moment, it can appear later and we'll get a hard-to-find
issue. Moreover, we may consider using netvsc driver on e.g. KVM with
Hyper-V enlightenments and KVM has CPU hotplug already.

-- 
  Vitaly
