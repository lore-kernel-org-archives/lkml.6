Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759560AbeD1HPn (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 03:15:43 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35586 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753174AbeD1HPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 03:15:42 -0400
X-Google-Smtp-Source: AB8JxZqIar+ld/Vz2UJg0P0QyFZ42fxePlb5VsGaGDTixoaATO9UoeDi1Sx7590APqlCrFdxpduXgA==
Date: Sat, 28 Apr 2018 09:15:38 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxram@us.ibm.com,
        tglx@linutronix.de, dave.hansen@intel.com, mpe@ellerman.id.au,
        akpm@linux-foundation.org, shuah@kernel.org, shakeelb@google.com
Subject: Re: [PATCH 0/9] [v3] x86, pkeys: two protection keys bug fixes
Message-ID: <20180428071538.3whanph7r6v56h2a@gmail.com>
References: <20180427174527.0031016C@viggo.jf.intel.com>
 <20180428070553.yjlt22sb6ntcaqnc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180428070553.yjlt22sb6ntcaqnc@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> After I got the GDB backtraces I tried to clean up leftover tasks, but the main 
> thread would not go away:
> 
>  4006 pts/0    00:00:00 protection_keys <defunct>
> 
> neither SIGCONT nor SIGKILL appears to help:

Just seconds after I sent this I found out that this was user error: I forgot 
about a gdb session I still had running, which understandably blocked the task 
from being cleaned up. Once I exited GDB it all got cleaned up properly.

The hang problem is still there, if I run a script like this:

 while :; do date; echo -n "32-bit: "; ./protection_keys_32 >/dev/null; date; echo -n "64-bit: "; ./protection_keys_64 >/dev/null; done

then within a minute one of the testcases hangs reliably.

Out of 4 attempts so far one hang was in the 32-bit testcase, 3 hangs were in the 
64-bit testcase - so 64-bit appears to trigger it more frequently.

Thanks,

	Ingo
