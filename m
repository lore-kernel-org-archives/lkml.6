Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B331C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9C524465
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF9C524465
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754296AbeFVPJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:09:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:41579 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754236AbeFVPJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:09:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 08:09:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,257,1526367600"; 
   d="scan'208";a="66382474"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.254.80.177]) ([10.254.80.177])
  by fmsmga001.fm.intel.com with ESMTP; 22 Jun 2018 08:09:21 -0700
Subject: Re: linux-next: manual merge of the tip tree with the vfs tree
To:     Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@ZenIV.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <e6a26908-67b2-e32e-06b5-d2e62acce305@intel.com>
 <20180622115346.1e9cc433@canb.auug.org.au>
 <29411.1529671523@warthog.procyon.org.uk>
 <20180622130600.GY30522@ZenIV.linux.org.uk>
 <alpine.DEB.2.21.1806221537570.2402@nanos.tec.linutronix.de>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <5462d90a-0cac-ca10-1633-275a9836ad41@intel.com>
Date:   Fri, 22 Jun 2018 08:09:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1806221537570.2402@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 6/22/2018 6:39 AM, Thomas Gleixner wrote:
> On Fri, 22 Jun 2018, Al Viro wrote:
>> On Fri, Jun 22, 2018 at 01:45:23PM +0100, David Howells wrote:
>>> Reinette Chatre <reinette.chatre@intel.com> wrote:
>>>
>>>> Thomas and David, please let me know what I can do from my side to help
>>>> with this.
>>>
>>> You could try basing on Al Viro's for-next tree which has the mount API
>>> changes in it.
>>
>> Umm...  That would be a massive headache for everyone involved; the changes
>> in there have very little in common with what you are doing in rdt_mount(),
>> so it might make sense to start with a minimal never-rebased branch that
>> would
>> 	* define rdt_pseudo_lock_init as 0
>> 	* define rdt_pseudo_lock_release as empty
>> 	* do the rdt_mount() part of a3dbd01e6c9d
>> 	* have commit message along the lines of
>> "hooks in rdt_mount() for rdt_pseudo_lock to use
>>
>> Functionally a no-op right now; the only reason for having that
>> as a never-rebased branch to get rdt_pseudo_lock and mount series
>> out of each other's hair"
>>
>> Base that on -rc1, then pull it into your rdt branch and David could pull the
>> same into his.
> 
> Yes, that works.
> 
> Reinette, can you please look into creating that ordering. Then we just zap
> the existing branch and redo it with this scheme.

Will do. How would you prefer to consume this to make the branches
simple to create? Is it ok if I create a new patch series with Al's
suggestion above as the first commit?

The original pseudo-locking patch series consisted out of two sections
with the pseudo-locking specific parts starting in the middle. If I
create a new series with the above change then it will not be cleanly
separate anymore. Is that ok?

Reinette

