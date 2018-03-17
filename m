Return-Path: <kernel-hardening-return-12682-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtchZHYf0EtZE2kVjwgqOmdzJD+9eWMVYd13jm6F8Bpv2zAV2aed1G51Agl84OII+Ba45Ks
ARC-Seal: i=1; a=rsa-sha256; t=1521267969; cv=none;
        d=google.com; s=arc-20160816;
        b=vxwZujlHS9JvxnOsf5Pl1+z+1aXqUGnLoYY8pTeLvo4T9xEuFrkz9Sal20+aAagawn
         gpyDbvInmhNwXq+cyg2kvhyrhvmNihhrQbgvvybpfYupSdO1IhhVf76/foJsj5ObDzso
         z6nR3EMPoxAjlpFRlbGaeNe51g7fzJcvjOK7ZopMfRxLoek4OoMupPDXOlmUCuUpjD5m
         2YnXuhPIaPoYvWkbAQnmZEgjh0GtOyvgjq/9Vo/MmL6PJ0hjC4M/7enstIv3K2PrWU64
         BoDARLBp8dOu2Rl9p0uDa3ls4VWvC6iU/jqWxT/LEtHOj2vG9TsheZ5YbXoAvj9qubys
         hYeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=/R8lO9VI1yBZyj+6cyvsfzFPNuGXDIzOgoLv2RiSqbs=;
        b=T99XGw8UEeQuDHwV87Wouu+idspuuiHS2vXxLYLBJFakrC3PPtqxSI4mqQisfCIAT3
         B9zGZ2F7O5EAenI5ajksS/32WwFG1uxEKE8zCxhnqiRb8lFAFYEw774EO+rK1wSU2OH3
         dm/dJpWj9eKiGdgteyrP4l4N6IyzbgL8Np3uFSL0F4YCJO6B4lCMMP6o6SuUsB5H3lfW
         pQlwF+g6Cx38ea7wFfU75UbmQUzZ6hyOplcnIFLPZPkfnlvWyU/gahVAfOCAK3UBaitB
         oUcZl/75+0310Nt0Ftbn0gBkUxMpOM7Vfqb1c3BtgeGmZXzobWaosIw713V/vPfsRDvA
         TnkQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=XA+Re8Il;
       dkim=pass header.i=@chromium.org header.s=google header.b=hh4geemo;
       spf=pass (google.com: domain of kernel-hardening-return-12682-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12682-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=XA+Re8Il;
       dkim=pass header.i=@chromium.org header.s=google header.b=hh4geemo;
       spf=pass (google.com: domain of kernel-hardening-return-12682-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12682-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180316155950.35fda7c63ec59277ba504201@linux-foundation.org>
References: <20180315225919.GA43806@beast> <20180316155950.35fda7c63ec59277ba504201@linux-foundation.org>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 16 Mar 2018 23:25:43 -0700
X-Google-Sender-Auth: -y-rOyMfWTC3iGwA-HqDwEYBofc
Message-ID: <CAGXu5jLAqki8oE7AF9BEwLxKzpTOOPsT1imjdSAG_U44uGXJdQ@mail.gmail.com>
Subject: Re: [PATCH v2] rslib: Remove VLAs by setting upper bound on nroots
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Segher Boessenkool <segher@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595046396754035881?=
X-GMAIL-MSGID: =?utf-8?q?1595165082892522390?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 3:59 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Thu, 15 Mar 2018 15:59:19 -0700 Kees Cook <keescook@chromium.org> wrote:
>
>> Avoid stack VLAs[1] by always allocating the upper bound of stack space
>> needed. The existing users of rslib appear to max out at 24 roots[2],
>> so use that as the upper bound until we have a reason to change it.
>>
>> Alternative considered: make init_rs() a true caller-instance and
>> pre-allocate the workspaces. This would possibly need locking and
>> a refactoring of the returned structure.
>>
>> Using kmalloc in this path doesn't look great, especially since at
>> least one caller (pstore) is sensitive to allocations during rslib
>> usage (it expects to run it during an Oops, for example).
>
> Oh.
>
> Could we allocate the storage during init_rs(), attach it to `struct
> rs_control'?

No, because they're modified during decode, and struct rs_control is
shared between users. :(

Doing those changes is possible, but it requires a rather extensive
analysis of callers, etc.

Hence, the 24 ultimately.

-Kees

-- 
Kees Cook
Pixel Security
