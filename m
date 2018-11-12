Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C745C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 21:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2CF22504
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 21:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pv0qLTaz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2CF22504
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbeKMHf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 02:35:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:47428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730550AbeKMHf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 02:35:27 -0500
Received: from localhost (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EE9E224E0;
        Mon, 12 Nov 2018 21:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542058824;
        bh=kG74ufKBA645TcZAZg/B2Jz2IvA1Q87K4dMGB78zIHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pv0qLTazdIzkpNEqK8yD9sDreqCXpBMlCCrhT3ESHeKxf1GR24dFk0K2uo9VRFVFa
         ZSKoRUvzbv04lp+/2tZ326iMIx2+huo1TeLF4zisngDcqdiIU0qqRk0Ambun3m7e1m
         Bf1LKyWA6C0qN1j9YjImD1/aH/RaRwrsjR8NfyyQ=
Date:   Mon, 12 Nov 2018 16:40:23 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        dipankar <dipankar@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        fweisbec <fweisbec@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH tip/core/rcu 0/41] More RCU flavor consolidation cleanup
 for v4.21/v5.0
Message-ID: <20181112214023.GA64029@sasha-vm>
References: <20181111194104.GA4787@linux.ibm.com>
 <2113574714.3779.1542031670315.JavaMail.zimbra@efficios.com>
 <20181112160137.GI4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181112160137.GI4170@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 08:01:37AM -0800, Paul E. McKenney wrote:
>On Mon, Nov 12, 2018 at 09:07:50AM -0500, Mathieu Desnoyers wrote:
>> ----- On Nov 11, 2018, at 2:41 PM, paulmck paulmck@linux.ibm.com wrote:
>>
>> > Hello!
>> >
>> > This series does additional cleanup for the RCU flavor consolidation,
>> > focusing primarily on uses of old API members, for example, so that
>> > call_rcu_bh() becomes call_rcu().  There are also a few straggling
>> > internal-to-RCU cleanups.
>> >
>> > 1.	Remove unused rcu_state externs, courtesy of Joel Fernandes.
>> >
>> > 2.	Fix rcu_{node,data} comments about gp_seq_needed, courtesy of
>> >	Joel Fernandes.
>> >
>> > 3.	Eliminate synchronize_rcu_mult() and its sole caller.
>> >
>> > 4.	Consolidate the RCU update functions invoked by sync.c.
>> >
>> > 5-41.	Replace old flavorful RCU API calls with the corresponding
>> >	vanilla calls.
>>
>> Hi Paul,
>>
>> Just a heads up: we might want to spell out warnings in very big letters
>> for anyone trying to backport code using RCU from post-4.21 kernels
>> back to older kernels. I fear that newer code will build just fine
>> on older kernels, but will spectacularly fail in hard-to-debug ways at
>> runtime.
>>
>> Renaming synchronize_rcu() and call_rcu() to something that did not
>> exist in prior kernels would prevent that. It may not be as pretty
>> though.
>
>From v4.20 rather than v4.21, but yes.  Would it make sense to have Sasha
>automatically flag -stable candidates going back past that boundary that
>contain call_rcu(), synchronize_rcu(), etc.?  Adding Sasha on CC, and
>I might be able to touch base with him this week.

We had a similar issue recently with a vfs change
(https://patchwork.kernel.org/patch/10604339/) leading to potentially
the same results as described above, we took it as is to avoid these
issues in the future, though this is a much smaller change than what's
proposed here.

We can look into an good way to solve this. While I can alert on
post-4.20 stable tagged patches that touch rcu, do you really want to be
dealing with this for the next 10+ years? It'll also means each of those
patches will need a manual backport.

Let's talk at Plumbers :)

--
Thanks,
Sasha
