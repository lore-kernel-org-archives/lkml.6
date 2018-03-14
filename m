Return-Path: <kernel-hardening-return-12613-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuPS2zQBESACElHcPbldxAwq52TeaFvZMtgFlTLqwxF69nLPtugQFAYEcVtfRrBI2LSinu7
ARC-Seal: i=1; a=rsa-sha256; t=1521050100; cv=none;
        d=google.com; s=arc-20160816;
        b=sT378CTlNUpWRyb0RAe/BpFuX9JIxiTKY/hoJNB5lJelnPh7c3kvt0KOtl3TFvQsuJ
         bkZGX+s/bIfyC9IbNHCvBoCyo7xe+BStJNuXdkqZiKQVwe3X2ECqfA3/IAYPGE16sN70
         Tr6w4IyWmtE+U+FUoUW+4qzOFXBZ1E93wRfVHg7wM4dk+mF+CnF8T6ERu27oKZrQyvo/
         onbKGK+L8/FU+n9Yx5o9pxClQATzrUcisRXhe7aH0K8SSf0hSsfghR+y5kMu3TiBwp57
         pSSFQ+3PuuBzmwo0yewHfqjzPPNCNdvdmIxS0cUxv9/7eEDybBKt+li3t4lnYTJrkcjR
         fnSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:delivered-to
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=fBb/kMZ0ZtzmvWGUuFFUcCh5xHovYnYn9j7YI1rbQpE=;
        b=WeWRChvE1dhU5oGvWyvO3jgaNVSzh3+dHfoHaDSplJVj8mchFMoQe9PuppKiFMOfgg
         +CBaGK0c8ogo0N2XlqdQ3n/PeBaVF5kaMcNKxFdXnZuGBT3Nji1vuG86nx1X4sgJcHvK
         J1lQC9o+Ec4Dni3idF5nevAeCBtzb0T+QsCwvmxZdbwNb+sGJYfknEOnv+sLp+4abx4q
         XyLW2jD8gwYHzdnNW/+G4Ywe6EXbvkXNNzSknshF8kW+n3kh6Mh1SCKYKFioHXEho2/Q
         w0CEfmaMU+DTL/2K9W1/vhoRVuxbZcQCFxCzeha7IdTLlgV0wusL1FWfUQ/PsN6DDYae
         0G5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12613-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12613-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12613-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12613-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 14 Mar 2018 16:42:48 +0100
From: David Sterba <dsterba@suse.cz>
To: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
	linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Josef Bacik <jbacik@fb.com>,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] Btrfs: drop a VLA in btrfs_check_super_csum()
Message-ID: <20180314154248.GL32007@twin.jikos.cz>
Mail-Followup-To: dsterba@suse.cz,
	Salvatore Mesoraca <s.mesoraca16@gmail.com>,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
	linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Josef Bacik <jbacik@fb.com>,
	Kees Cook <keescook@chromium.org>
References: <1520970622-19535-1-git-send-email-s.mesoraca16@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520970622-19535-1-git-send-email-s.mesoraca16@gmail.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594853328339341486?=
X-GMAIL-MSGID: =?utf-8?q?1594936630069700772?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 08:50:22PM +0100, Salvatore Mesoraca wrote:
> Avoid a VLA[1] by using a real constant expression instead of a variable.
> The compiler should be able to optimize the original code and avoid using
> an actual VLA. Anyway this change is useful because it will avoid a false
> positive with -Wvla, it might also help the compiler generating better
> code.
> 
> [1] https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>

We already have a patch for that from a few days ago, but thanks anyway.

https://patchwork.kernel.org/patch/10277901/
