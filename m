Return-Path: <kernel-hardening-return-12839-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48b8CLy6Xj5BrEgC3QPoSHCdR+FqkyFC/1uDKVCi2fPZX402+JVeo2+zRCeCPxIKVc5gjKS
ARC-Seal: i=1; a=rsa-sha256; t=1522490155; cv=none;
        d=google.com; s=arc-20160816;
        b=PWXJocvLhBCDZErnieFhg9Pcc5BgyHwJtWijj8q4WKKxFD5c/I9Kc7zuOLCnP6MtqY
         Z0NJqmjK0eIBi/G8ymKrOd/oj4Ht8+FzJj4apJRnWPkiRUjfV2HMrXj31RD3drDYsu04
         SRjihEP1OlAoBMDW68bQtuWbZpbME7btPPb4RYWoUvIpjpJzk8fZh49nHnm4bJLhUDTR
         qVxgn6k+/mCaoh8TUOpQYmRkweCW3jc/owy8fdjazpG9RNS4U95ztrjFjThNVD+Mw5Ss
         ebGcx+ECIncSMryb8jZjOlU8IkUgZJQhP40wOhWp5EITD7n+2cZtwvJnKDZuFMP56PUq
         lMNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=qOxDnbEh+GHuLyGHkuBxehME8P0P+D+AoXzMgIPkYrY=;
        b=jBRLMNJeOQ7NNuEA2G05jLBJtfZzpSWxS75/wd/HpPbvTMkEmYoDjJTPJS0ML36oRh
         IhCvFeGXzB2nTzxERFWq/48WdKVdxsj/fPy2bKsrz8q93MhUwi+RNJxzwv5AfSCUFDaE
         6upqiBdgCE2Znzjb19v05mUFnhU+NHHn9T0zkWP0wCBDcXZXF56jXPv8SS6LHtoag5wz
         5Rg5dQnJb3HbHlv9knrVc7JjqbxEPmEQkZt14SYK/grdefE/jmlcXUurpgVR7X/e9+bP
         6xyTmA+inMwtKwXXSVj1kNVkukOYMwYatdvjG1RHrP72YAwZE85fDmgok+GtMlGWX032
         53cw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bWOj/JAE;
       spf=pass (google.com: domain of kernel-hardening-return-12839-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12839-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bWOj/JAE;
       spf=pass (google.com: domain of kernel-hardening-return-12839-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12839-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <20180330103411.5ed25f43@gandalf.local.home>
References: <1522399988-8815-1-git-send-email-s.mesoraca16@gmail.com> <20180330103411.5ed25f43@gandalf.local.home>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Sat, 31 Mar 2018 11:55:16 +0200
Message-ID: <CAJHCu1+9NJ0onfjETfwn+XSL_d1Zxo0P=5RpWUkxnXO597BA5g@mail.gmail.com>
Subject: Re: [v2] ftrace: drop a VLA in module_exists()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, Ingo Molnar <mingo@redhat.com>,
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596352124099470452?=
X-GMAIL-MSGID: =?utf-8?q?1596446637168252176?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-30 16:34 GMT+02:00 Steven Rostedt <rostedt@goodmis.org>:
> On Fri, 30 Mar 2018 10:53:08 +0200
> Salvatore Mesoraca <s.mesoraca16@gmail.com> wrote:
>
> Couple of things. First, "PATCH" was dropped from the subject. If my
> inbox was busy today, I probably would have missed this email.

Aargh, I'm sorry for this, I didn't notice it.

>> Avoid a VLA[1] by using a real constant expression instead of a variable.
>> The compiler should be able to optimize the original code and avoid using
>> an actual VLA. Anyway this change is useful because it will avoid a false
>> positive with -Wvla, it might also help the compiler generating better
>> code.
>>
>> [1] https://lkml.org/lkml/2018/3/7/621
>
> Second, do not use lkml.org, use http://lkml.kernel.org/r/<messageid>
>
> Search for "Link:" tags in git log to see examples.

Thank you for the suggestion.

> Other than that, the patch looks fine to me and I can pull it for the
> next merge window.

Thank you very much,

Salvatore
