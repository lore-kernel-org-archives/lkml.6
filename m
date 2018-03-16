Return-Path: <kernel-hardening-return-12679-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvzJkEevcq1tOaCwxKdMeia6qNPgpj6XdiIYYWkSaFtT8TkStbIOdE5jug/KF/umtwXoqCZ
ARC-Seal: i=1; a=rsa-sha256; t=1521241212; cv=none;
        d=google.com; s=arc-20160816;
        b=FO+xjD2wmPW23Da9A+6/8eUlCLCRg4nPhzUWjp0K62t7C+FrEPE083rqNGxyzZjtzK
         yd9ji8nIKhhvsM54so+OXq7GVv1xAHyDmJlfzUqyOUWRPTnT8Av58X+DhNU5SzIR/9PL
         Z73VtwNYVlNDtZhwXy4HdMZGQaOp+XSN85fciRHwPIEx4tPhPz6hX0G2WiojPpFj04sY
         OiuibEmwH9OTXKZgvM3d28zYQNGXxcEn4AqLsVXI4Ml0vjue8z3pGWvPnvHIrG7UJKAn
         tBe1pxX4dWzSNsU/yHwdYvxhLExhOjAUETgsFOxDcT06YM7rFM6OYZdaVt1PZ3ykhsb4
         79Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=7EdCfuKrvl/cbkMKWBj/ulhq3y1X4ywiYhjpTRZLXUo=;
        b=jbKBhuMNzOxvJq3r9fVlIXhhbHRlMluCTgDyHHk9gFGtVU8I+pUXMhPUKmRd2v5Ruj
         ZJI/xhMXdNCHHK17Cy2ydjZ/RIUoucSkfeTVRI2DFLU7uFtHY6oCQT3KoyTDxfPmXr1D
         tMW4FPWH6cNmWputq3CD/BPX3/2PeiapPNkb5+Ob6zGoKVw+K82V0znS/0vrb7GsQuSL
         FMFw2qcJu5k9/glTO1+e/3P+QX9b8A8ror1GOvVR/C3Q+FeKrijLRITP5OmJI7zSkGMw
         wrifkTB5wld9so2z1JZfbUl2nS27onkMGyHHBnzuN3i93K1uEPcVw/aTCaFtRsg+sQW3
         1NEg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12679-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12679-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12679-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12679-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Fri, 16 Mar 2018 15:59:50 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Segher Boessenkool
 <segher@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>,
 kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v2] rslib: Remove VLAs by setting upper bound on nroots
Message-Id: <20180316155950.35fda7c63ec59277ba504201@linux-foundation.org>
In-Reply-To: <20180315225919.GA43806@beast>
References: <20180315225919.GA43806@beast>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595046396754035881?=
X-GMAIL-MSGID: =?utf-8?q?1595137025458580633?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 15 Mar 2018 15:59:19 -0700 Kees Cook <keescook@chromium.org> wrote:

> Avoid stack VLAs[1] by always allocating the upper bound of stack space
> needed. The existing users of rslib appear to max out at 24 roots[2],
> so use that as the upper bound until we have a reason to change it.
> 
> Alternative considered: make init_rs() a true caller-instance and
> pre-allocate the workspaces. This would possibly need locking and
> a refactoring of the returned structure.
> 
> Using kmalloc in this path doesn't look great, especially since at
> least one caller (pstore) is sensitive to allocations during rslib
> usage (it expects to run it during an Oops, for example).

Oh.

Could we allocate the storage during init_rs(), attach it to `struct
rs_control'?  
