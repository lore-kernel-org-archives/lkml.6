Return-Path: <kernel-hardening-return-12662-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELviU0geqfMgHlOw7A8GE6toXYk3xVPLyArMh99eu5n1JuAZgdHp9ifVBsrUbzS4bYHM/Jfd
ARC-Seal: i=1; a=rsa-sha256; t=1521200904; cv=none;
        d=google.com; s=arc-20160816;
        b=yQUsxU2ilS3Wjx6c4dfCeVkd5HClUCaD0SCtw+UHPiVktwpqOlXTqq7FyXxmeVwjVH
         tNASwZb2xa8Ddlznu0m6uiaywDXz8xzLNPWY7q5E53PlYPRsIP/RnH4qtKd3igy8g1Ms
         I9UeiKRIccT4NCCbzfMz+9SuhkQp2RwgAGOeQlmnwJoI84+S20tONiKImdM0z6hEnkkQ
         4EVAPUdA2zjSx8x+51RtQOI+OSjZR2eYpYI1GgFG3L1207RZ6ASmcd+bcMm6yqlX7Mxq
         HgTLS6tCZMYs7vHHqS9et6UzMIBvSj8Wqlv8VZx0TN2v30pISv7Y3hXRL8t50XiZw09I
         Zsiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=765LG/Pp4ssaIhjFliEu+yaepDFDN9/4UIh1XPMQX7U=;
        b=tRqsb6Zdbj6rrW3JwR7xNlqgvt1+R3FT/OOQi642htD3GCGbYn4QevKipZIBjmGlLA
         kzvQZxXlS8AeVo+w6r7YFa8WYAibeEbbQqKCS4mZdIhRaJyem2aawRPfA4Wpm4fQjAtw
         sLqTDKh4RzKQiPC1CkfS7G4zwI6se2J4gzgBQS3GEd7sXcKrKwbn6gRjB7wK5LTt1dfo
         WwSKt1iOw2x/bNfyxEcZfLuKT/YzSNWVmDPJSSTOb4t8XKINwhJ/BEHy9+8HKx1IAkzQ
         3+KitF97hdhkABFFuhqqEhk5l1PQs6WxSAvlwa16Nztf8BiNuZuCnOoPKvh9u5w7aMDB
         6h4g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12662-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12662-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12662-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12662-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH v5 0/2] Remove false-positive VLAs when using max()
To: Kees Cook <keescook@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Randy Dunlap <rdunlap@infradead.org>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Ingo Molnar <mingo@kernel.org>, David Laight <David.Laight@aculab.com>,
 Ian Abbott <abbotti@mev.co.uk>, linux-input@vger.kernel.org,
 linux-btrfs@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
References: <1521174359-46392-1-git-send-email-keescook@chromium.org>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <ab2933a2-ca7b-eb3b-744d-bc037b1be688@redhat.com>
Date: Fri, 16 Mar 2018 12:47:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521174359-46392-1-git-send-email-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595034368078500739?=
X-GMAIL-MSGID: =?utf-8?q?1595094758961318146?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/16/2018 05:25 AM, Kees Cook wrote:
> In the effort to remove all VLAs from the kernel[1], it is desirable to
> build with -Wvla. However, this warning is overly pessimistic, in that
> it is only happy with stack array sizes that are declared as constant
> expressions, and not constant values. One case of this is the evaluation
> of the max() macro which, due to its construction, ends up converting
> constant expression arguments into a constant value result. Attempts
> to adjust the behavior of max() ran afoul of version-dependent compiler
> behavior[2].

I find this commit message confusing.  VLAs have precisely defined 
semantics which differ from other arrays, and these differences can be 
observable (maybe not in the kernel, but certainly for userspace), so 
the compiler has to treat a VLA as such even if the length is a constant 
known at compile time.  (The original intent of the warning probably was 
a portability check anyway.)

If you want to catch stack frames which have unbounded size, 
-Werror=stack-usage=1000 or -Werror=vla-larger-than=1000 (with the 
constant adjusted as needed) might be the better approach.

Thanks,
Florian
