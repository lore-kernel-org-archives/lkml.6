Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750944AbeC0ELu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 00:11:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:56632 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750800AbeC0ELt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 00:11:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,366,1517904000";
   d="scan'208";a="186266653"
Subject: Re: [PATCH 1/9] x86, pkeys: do not special case protection key 0
To: Ram Pai <linuxram@us.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20180323180903.33B17168@viggo.jf.intel.com>
 <20180323180905.B40984E6@viggo.jf.intel.com>
 <20180327022718.GD5743@ram.oc3035372033.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, tglx@linutronix.de,
        mpe@ellerman.id.au, mingo@kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <0f990ce6-0eac-bd77-18d8-e2e3fdd5fb43@intel.com>
Date: Mon, 26 Mar 2018 21:11:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327022718.GD5743@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/26/2018 07:27 PM, Ram Pai wrote:
>> This is a bit nicer than what Ram proposed because it is simpler
>> and removes special-casing for pkey 0.  On the other hand, it does
>> allow applciations to pkey_free() pkey-0, but that's just a silly
>> thing to do, so we are not going to protect against it.
> The more I think about this, the more I feel we are opening up a can
> of worms.  I am ok with a bad application, shooting itself in its feet.
> But I am worried about all the bug reports and support requests we
> will encounter when applications inadvertently shoot themselves 
> and blame it on the kernel.
> 
> a warning in dmesg logs indicating a free-of-pkey-0 can help deflect
> the blame from the kernel.

I think it's OK to leave it.  A legit, very careful app could decide not
to use pkey 0.  It might even be fun to write that in the selftests for
sheer entertainment value.

Although, it _could_ be a bit more debuggable than it is now.  A
tracepoint that dumps out the pkey that got faulted on along with the
PKRU value at fault time might be nice to have.  That's mildly difficult
to do from outside the app.
