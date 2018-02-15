Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AH8x224IVZiLTRKD+P76X3YMgKXtZ5mBB/zPkEuMtvv6/NnrwT652tqlVb5xmA0uxTwuvYVOglu+
ARC-Seal: i=1; a=rsa-sha256; t=1518706399; cv=none;
        d=google.com; s=arc-20160816;
        b=dGdpOJq6mCUQEiUCsj4l9lZftHN+7rEXuDNV+/26E10rRY6LX1ittWQUjhuk4RYfzr
         +GsuBxgR31P5TK+Ujt+eX2w62qhfUaxJoPkZWJlT90NpZN7EqP5kKgy2sdc4duGXrav+
         ev3SRhvMQFKlfepwiPdvr+8sTmkvR9i0I3Ocaw2ZZX4nhPQvjEMi2fGHEYCCKBis7kGc
         Ikpq0DL97p2D5KBjyNsvU8BkM/6cBuFqZS0UEp/HHwbUjXVVyNfzOhLyIQtR5wqxoJob
         9xvPU7mV89FGKX+3h44Cs+5moODCG9uzGNBxrH51OG2szDNgyJXYwal+xwQf1W4nDLQb
         Y2ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=QA/Fek0Kb/xxmcSVDvWJqHvhrINp/p7yu08DvOsNvCA=;
        b=t2NA8A4fVS+BU7q3dL7IkvBrJAv74+RRpFk2e6Wwkbah5z8yB8q+/kWoyI0PUFzUeL
         aNPD4AL4SIW3OMSR6/bz9AtSi6YHToiNH9smgX9nCcf36qDJL5NTyWWZkpiN6FGJN3vm
         upGVPgV6m8sJic5bCKnBhtYtodRB+nH9QoCXUCimdf0BTiAXp9nAcXUYmD+8rGrdskln
         nky07Upy6HNQRTVMVzPllRao2rUDePMQZIvDk0v9IEj2uAg1CN9bji02vqIJkrlxp3Zs
         TT2p1NEX95YrKw0lYBrc9UI0QeTkoEUgK64dxr5ZCRmyP8HcFUs2lKi6NexFGTCrSbSs
         IfyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 146.0.238.70 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 146.0.238.70 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Date: Thu, 15 Feb 2018 15:53:14 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Dan Williams <dan.j.williams@intel.com>
cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
    LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
    Linus Torvalds <torvalds@linux-foundation.org>,
    David Woodhouse <dwmw@amazon.co.uk>, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] posix-timers: Protect posix clock array access against
 speculation
In-Reply-To: <CAPcyv4i-bULZp1WTUgUVtdEY5i_fTGkFWKBsVLDu6dsuxUwoug@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1802151550330.1296@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1802151424490.1296@nanos.tec.linutronix.de> <45f8dece-e235-0831-4fe5-89ee7d27b959@prevas.dk> <CAPcyv4i-bULZp1WTUgUVtdEY5i_fTGkFWKBsVLDu6dsuxUwoug@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592473683460033132?=
X-GMAIL-MSGID: =?utf-8?q?1592479082052142673?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 15 Feb 2018, Dan Williams wrote:
> On Thu, Feb 15, 2018 at 6:05 AM, Rasmus Villemoes
> <rasmus.villemoes@prevas.dk> wrote:
> > (2) The line "if (id >= ARRAY_SIZE(posix_clocks) || !posix_clocks[id])"
> > still seems to allow speculatively accessing posix_clocks[id]. Is that
> > ok, and even if so, wouldn't it be cleaner to elide the
> > !posix_clocks[id] check and just return the NULL safely fetched from the
> > array in the following line?
> 
> Right, this looks broken. I would expect:

Indeed. Missed that.

>         if (id >= ARRAY_SIZE(posix_clocks))
>                 return NULL;
>         idx = array_index_nospec(idx, ARRAY_SIZE(posix_clocks));
>         if (!posix_clocks[idx])
>                 return NULL;
>         return posix_clocks[idx];

The !posix_clocks[idx] check is pointless and always was.

	if (id >= ARRAY_SIZE(posix_clocks))
		return NULL;

	idx = array_index_nospec(idx, ARRAY_SIZE(posix_clocks));
	return posix_clocks[idx];

is sufficient. It returns NULL for !posix_clocks[idx] anyway.

Thanks,

	tglx
