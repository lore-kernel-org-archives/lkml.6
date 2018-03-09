Return-Path: <mail@maciej.szmigiero.name>
X-Google-Smtp-Source: AG47ELtHMEmCvGAdlBvTLqy3OIscuCgTFGLnkBEnje6Jpbw++Gto5pb4Sk4edYaL7ASpHVt8CNdB
ARC-Seal: i=1; a=rsa-sha256; t=1520601174; cv=none;
        d=google.com; s=arc-20160816;
        b=TP3P5CFiOHbm00LyniN9Df8peTnaDHNmqzsmYNgwlzPqkWE8Udrmb1kAOIWLpJoJXq
         kJJS84P8cGpIqCvtuyWx/JspOQHQVZD1T179jjoX6hWGLOg7d0WbCJ+Am0ng77ddTeyI
         BFRlxM/j6C40JgaovdHmWivgr7twFx1kVRkbj+jVRMSMw8SZ5mjk+fI+GKaktCNjeDqp
         M/XvwleHjUkqn1jVO/zIiOAqH3Fjn1WBapbO2OvnU9QHqJZBeMkrK43chQnmF5Rhykei
         OlZy6wErTidSXI92gaUocWkphstJvnk28aDtVxEteM2MJGpP2wrqeZt4d5FOs4neJLrQ
         YDPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:disposition-notification-to:message-id:from
         :references:cc:to:subject:arc-authentication-results;
        bh=M1WDdDSNyMl2z018euZTI7LoQBzUeCUCody940BhgZg=;
        b=kkc5LXQogRVYh6YacWvuNogcEPannEYksZ4IJfmuHnDgcLDYlJ1SGEQwoEl5JTStVU
         zkanIWeI2yhnbAezulTbdqVyy64Z/cYCWIp1nvf8QDUBdTzWrDElJsuLveFFlRSP3cmQ
         PEuV5h0/zeFJlTwZZ4pRgNuuAIz5RDRJbfhqBSfbHc0QBQGN6r50YTQgN95RbyB4UjT9
         lAVu6laUDAipJaXnBwpz1VvOvyfkLUuGiLsfUHczNEcf5BOeD85R87sjHRN9fvVoKBfW
         7ja5QT6zTZqmZS6bi1OkX9Ilmu9aigJ/IZmm7bh/xUER3+msFZ9a+SQXPwy+9OqVP5Qb
         Lv2A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 37.28.154.113 is neither permitted nor denied by best guess record for domain of mail@maciej.szmigiero.name) smtp.mailfrom=mail@maciej.szmigiero.name
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 37.28.154.113 is neither permitted nor denied by best guess record for domain of mail@maciej.szmigiero.name) smtp.mailfrom=mail@maciej.szmigiero.name
Subject: Re: x86/retpoline: Fill RSB on context switch for affected CPUs
To: "Woodhouse, David" <dwmw@amazon.co.uk>
Cc: Andi Kleen <ak@linux.intel.com>, Paul Turner <pjt@google.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linux-foundation.org>,
 Tim Chen <tim.c.chen@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>,
 tglx@linutronix.de, Kees Cook <keescook@google.com>,
 Rik van Riel <riel@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@amacapital.net>, Jiri Kosina <jikos@kernel.org>,
 gnomes@lxorguk.ukuu.org.uk, x86@kernel.org, thomas.lendacky@amd.com,
 Josh Poimboeuf <jpoimboe@redhat.com>
References: <1515779365-9032-1-git-send-email-dwmw@amazon.co.uk>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <f2faf9ff-8955-d8b5-c521-91b9c273128b@maciej.szmigiero.name>
Date: Fri, 9 Mar 2018 14:12:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1515779365-9032-1-git-send-email-dwmw@amazon.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1589409875989472083?=
X-GMAIL-MSGID: =?utf-8?q?1594465896930748766?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 12.01.2018 18:49, Woodhouse, David wrote:
> When we context switch from a shallow call stack to a deeper one, as we
> 'ret' up the deeper side we may encounter RSB entries (predictions for
> where the 'ret' goes to) which were populated in userspace. This is
> problematic if we have neither SMEP nor KPTI (the latter of which marks
> userspace pages as NX for the kernel), as malicious code in userspace
> may then be executed speculatively. So overwrite the CPU's return
> prediction stack with calls which are predicted to return to an infinite
> loop, to "capture" speculation if this happens. This is required both
> for retpoline, and also in conjunction with IBRS for !SMEP && !KPTI.
> 
> On Skylake+ the problem is slightly different, and an *underflow* of the
> RSB may cause errant branch predictions to occur. So there it's not so
> much overwrite, as *filling* the RSB to attempt to prevent it getting
> empty. This is only a partial solution for Skylake+ since there are many
> other conditions which may result in the RSB becoming empty. The full
> solution on Skylake+ is to use IBRS, which will prevent the problem even
> when the RSB becomes empty. With IBRS, the RSB-stuffing will not be
> required on context switch.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Acked-by: Arjan van de Ven <arjan@linux.intel.com>
> ---
(..)
> @@ -213,6 +230,23 @@ static void __init spectre_v2_select_mitigation(void)
>  
>  	spectre_v2_enabled = mode;
>  	pr_info("%s\n", spectre_v2_strings[mode]);
> +
> +	/*
> +	 * If we don't have SMEP or KPTI, then we run the risk of hitting
> +	 * userspace addresses in the RSB after a context switch from a
> +	 * shallow call stack to a deeper one. We must must fill the entire
> +	 * RSB to avoid that, even when using IBRS.
> +	 *
> +	 * Skylake era CPUs have a separate issue with *underflow* of the
> +	 * RSB, when they will predict 'ret' targets from the generic BTB.
> +	 * IBRS makes that safe, but we need to fill the RSB on context
> +	 * switch if we're using retpoline.
> +	 */
> +	if ((!boot_cpu_has(X86_FEATURE_PTI) &&
> +	     !boot_cpu_has(X86_FEATURE_SMEP)) || is_skylake_era()) {
> +		setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
> +		pr_info("Filling RSB on context switch\n");
> +	}

Shouldn't the RSB filling on context switch also be done on non-IBPB
CPUs to protect (retpolined) user space tasks from other user space
tasks?

We already issue a IBPB when switching to high-value user space tasks
to protect them from other user space tasks.

Thanks,
Maciej
