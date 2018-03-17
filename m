Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753370AbeCQQBW (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 12:01:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:39557 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751618AbeCQQBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 12:01:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,321,1517904000";
   d="scan'208";a="42915861"
Subject: Re: [PATCH 1/3] x86, pkeys: do not special case protection key 0
To: Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20180316214654.895E24EC@viggo.jf.intel.com>
 <20180316214656.0E059008@viggo.jf.intel.com>
 <alpine.DEB.2.21.1803171011100.1509@nanos.tec.linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxram@us.ibm.com,
        mpe@ellerman.id.au, mingo@kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <6e0c687d-f465-5433-10be-db04489278a9@intel.com>
Date: Sat, 17 Mar 2018 09:01:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1803171011100.1509@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/17/2018 02:12 AM, Thomas Gleixner wrote:
>> This is a bit nicer than what Ram proposed because it is simpler
>> and removes special-casing for pkey 0.  On the other hand, it does
>> allow applciations to pkey_free() pkey-0, but that's just a silly
>> thing to do, so we are not going to protect against it.
> What's the consequence of that? Application crashing and burning itself or
> something more subtle?

You would have to:

	pkey_free(0)
	... later
	new_key = pkey_alloc();
	// now new_key=0
	pkey_deny_access(new_key); // or whatever

At which point most apps would probably croak because its stack is
inaccessible.  The free itself does not make the key inaccessible, *but*
we could also do that within the existing ABI if we want.  I think I
called out that behavior as undefined in the manpage.
