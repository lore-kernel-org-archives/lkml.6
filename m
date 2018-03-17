Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753909AbeCQTFY (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 15:05:24 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57956 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753847AbeCQTFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 15:05:22 -0400
Date: Sat, 17 Mar 2018 20:05:12 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Dave Hansen <dave.hansen@intel.com>
cc: Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxram@us.ibm.com,
        mpe@ellerman.id.au, mingo@kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org
Subject: Re: [PATCH 1/3] x86, pkeys: do not special case protection key 0
In-Reply-To: <6e0c687d-f465-5433-10be-db04489278a9@intel.com>
Message-ID: <alpine.DEB.2.21.1803172004130.1509@nanos.tec.linutronix.de>
References: <20180316214654.895E24EC@viggo.jf.intel.com> <20180316214656.0E059008@viggo.jf.intel.com> <alpine.DEB.2.21.1803171011100.1509@nanos.tec.linutronix.de> <6e0c687d-f465-5433-10be-db04489278a9@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Mar 2018, Dave Hansen wrote:
> On 03/17/2018 02:12 AM, Thomas Gleixner wrote:
> >> This is a bit nicer than what Ram proposed because it is simpler
> >> and removes special-casing for pkey 0.  On the other hand, it does
> >> allow applciations to pkey_free() pkey-0, but that's just a silly
> >> thing to do, so we are not going to protect against it.
> > What's the consequence of that? Application crashing and burning itself or
> > something more subtle?
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

As long as its documented and the change only allows people to shoot them
more in the foot, we're all good.

Thanks,

	tglx
