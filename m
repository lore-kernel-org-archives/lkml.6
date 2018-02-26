Return-Path: <mpe@ellerman.id.au>
X-Google-Smtp-Source: AH8x227svnMAajUbwcd02yXEZvTAReCYfNF6D22zFmkDr7OjINRoDBSMlpMsHGZ17G70LEzezy8A
ARC-Seal: i=1; a=rsa-sha256; t=1519624455; cv=none;
        d=google.com; s=arc-20160816;
        b=cK4cucshcrqkBgtF7zccjP4WvyWx9jvQWa6cgh1XqMfVsY5eqsU5a2BUsTKeGBo4T+
         ITnK6BuiJV1EFXFy0qGYrh+Khk/doJO0hGvJK2lKZWOp1GiU/9R+sRnA0sf29FZKf/ad
         8kz2pZXH4aUJrFLXb2hXqDUQIn0vYTIkEaabr7z6id8Rgu2XsQTUZOriHaQaM89Fvihj
         +LNFVVpwTZJO4cHah4xIU342p+aUcsItVZ+rd4mtxLr30ESban248AocxcnWVEJoPDnz
         HdkiGmAIPEB8bIzzM1aOyLCPJmtlBCD2v3ncM6e7XMwopyEZL9xI6R3p56OoBXfuS9DE
         c5SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:arc-authentication-results;
        bh=JfULOX94W2DEhFM8cLhPcykJr/R6HZupD4HPyBqDusM=;
        b=RoZH34RMTJV7BU9kl3KBoJJ4TtJL9kPHs1lsgmJU8cRmMxNn8CGDBOO3dSWr0HvOVl
         XgQAHahqt59xtr0Fojtz/XdL1rr1VXvzRq5SeUDE/IkBQ7Lk3srpPPMXbgNJimBTwhxp
         jPHHfbtX1hPfVCiq+gN4rEiHqacVV9XNAD7jesy6rjdpgHpTIkx7Tr5Ko6C2bf6UAPxU
         9C6qPtrhUYZgK9W+jULQo5P03sP/YpcTH3cTzhj8cB/dfUjTuN57uJuVqmteBQZw7/Yi
         Txer3/Nm6vBCLp1cb8ubMQv8T140PoXEg1QYTN7LgLTjyLurvP/aQYnLw6x0ZksfY6EV
         sjWw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2401:3900:2:1::2 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2401:3900:2:1::2 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org, davem@davemloft.net, dave.hansen@linux.intel.com
Cc: Khalid Aziz <khalid.aziz@oracle.com>, bsingharora@gmail.com, nborisov@suse.com, aarcange@redhat.com, anthony.yznaga@oracle.com, mgorman@suse.de, linuxram@us.ibm.com, kirill.shutemov@linux.intel.com, dan.j.williams@intel.com, jack@suse.cz, ross.zwisler@linux.intel.com, gregkh@linuxfoundation.org, tglx@linutronix.de, mhocko@suse.com, n-horiguchi@ah.jp.nec.com, jglisse@redhat.com, henry.willard@oracle.com, aneesh.kumar@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>
Subject: Re: [PATCH v12 07/11] mm: Add address parameter to arch_validate_prot()
In-Reply-To: <349751cbd54fda6f4a223f941aa71bbfe7be77ce.1519227112.git.khalid.aziz@oracle.com>
References: <cover.1519227112.git.khalid.aziz@oracle.com> <349751cbd54fda6f4a223f941aa71bbfe7be77ce.1519227112.git.khalid.aziz@oracle.com>
Date: Mon, 26 Feb 2018 16:54:12 +1100
Message-ID: <87d10s9tyz.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593031745545119756?=
X-GMAIL-MSGID: =?utf-8?q?1593441733241343687?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Khalid Aziz <khalid.aziz@oracle.com> writes:

> A protection flag may not be valid across entire address space and
> hence arch_validate_prot() might need the address a protection bit is
> being set on to ensure it is a valid protection flag. For example, sparc
> processors support memory corruption detection (as part of ADI feature)
> flag on memory addresses mapped on to physical RAM but not on PFN mapped
> pages or addresses mapped on to devices. This patch adds address to the
> parameters being passed to arch_validate_prot() so protection bits can
> be validated in the relevant context.
>
> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
> Cc: Khalid Aziz <khalid@gonehiking.org>
> Reviewed-by: Anthony Yznaga <anthony.yznaga@oracle.com>
> ---
> v8:
> 	- Added addr parameter to powerpc arch_validate_prot() (suggested
> 	  by Michael Ellerman)
> v9:
> 	- new patch
>
>  arch/powerpc/include/asm/mman.h | 4 ++--
>  arch/powerpc/kernel/syscalls.c  | 2 +-

These changes look fine to me:

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
