Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755223AbeCSFvC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 01:51:02 -0400
Received: from ozlabs.org ([103.22.144.67]:47697 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751084AbeCSFvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 01:51:01 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxram@us.ibm.com,
        mingo@kernel.org, akpm@linux-foundation.org, shuah@kernel.org
Subject: Re: [PATCH 1/3] x86, pkeys: do not special case protection key 0
In-Reply-To: <6e0c687d-f465-5433-10be-db04489278a9@intel.com>
References: <20180316214654.895E24EC@viggo.jf.intel.com> <20180316214656.0E059008@viggo.jf.intel.com> <alpine.DEB.2.21.1803171011100.1509@nanos.tec.linutronix.de> <6e0c687d-f465-5433-10be-db04489278a9@intel.com>
Date: Mon, 19 Mar 2018 16:50:56 +1100
Message-ID: <877eq8hav3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <dave.hansen@intel.com> writes:

> On 03/17/2018 02:12 AM, Thomas Gleixner wrote:
>>> This is a bit nicer than what Ram proposed because it is simpler
>>> and removes special-casing for pkey 0.  On the other hand, it does
>>> allow applciations to pkey_free() pkey-0, but that's just a silly
>>> thing to do, so we are not going to protect against it.
>> What's the consequence of that? Application crashing and burning itself or
>> something more subtle?
>
> You would have to:
>
> 	pkey_free(0)
> 	... later
> 	new_key = pkey_alloc();
> 	// now new_key=0
> 	pkey_deny_access(new_key); // or whatever
>
> At which point most apps would probably croak because its stack is
> inaccessible.  The free itself does not make the key inaccessible, *but*
> we could also do that within the existing ABI if we want.  I think I
> called out that behavior as undefined in the manpage.

Allowing key 0 to be freed introduces some pretty weird API IMHO. For
example this part of the manpage:

  An application should not call pkey_free() on any protection key
  which has been assigned to an address range by pkey_mprotect(2)
  and which is still in use. The behavior in this case is undefined
  and may result in an error.

You basically can't avoid hitting undefined behaviour with pkey 0,
because even if you never assigned pkey 0 to an address range, it *is
still in use* - because it's used as the default key for every address
range that doesn't have another key.

So I don't really think it makes sense to allow pkey 0 to be freed. But
I won't die in a ditch over it, I just look forward to a manpage update
that can sensibly describe the semantics.

cheers
