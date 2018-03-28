Return-Path: <jpoimboe@redhat.com>
X-Google-Smtp-Source: AIpwx49TGB9PVXOWPk7YPjMFefZWclOmsh8MqBd6mJl7IFCn1JfSp6KuHB6vr/k9ejKs7BSFAm02
ARC-Seal: i=1; a=rsa-sha256; t=1522251053; cv=none;
        d=google.com; s=arc-20160816;
        b=hd5GLG10QC6SMlW0EBLITimaJJGB1wREamuJb4tSQS/1HvMy5bvw+2SZ7krVzF1pQg
         Zg2lt9L3ib/cit7hnSExNtf1mWuTWDyRrbv7XPnCgnlxAbEa8KYBNFvf+DrwACwnsFuC
         nfzySCC6ru/hXMJQwiPQ6Iav5HMwKMJlyR3Q/nXwzVSRGTSojr1hv6Tfwt1SDhPKA+Fu
         qYTFYTtdVPuT0E4tHBWnGQkhZjU7khhRPpV33Q88vSfmP9RbbAX+ihLi+g9+4WpCemVq
         BBnYefpqxNkvoU1RwYaHCTo6DwtWSSVhgiYfEcTp7SyhU3Wr8VPiMG5SppIWWvAAwo7v
         QbLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=W4TOTjI4E+Cl/56v+VTCME9tId1YKSLbGOlMs1hNMYo=;
        b=Jq06Dgf9odoUFHA9TRXGdl023764sGnn8tguj8cf0MnVfWmCTeSF4bACbroIVzSAcr
         D3AeCPh27XhA9nYTVz7u01UQJXpxmf6U0kf0S/sXhZhX0WiY37VNbxPNFMF2uWWwORd+
         1SuDxSybK7rLuPkgzDmLrJLt63ouQzXChullMzwb81Y5Ee4n8wHpI5i44hXOqKo9uAJi
         qse+I1NWTH7hjZAOOIV3DbUlrkJbxoJtzQ8b5ezbD2nPhmUCfoQlW52HuHOvIJ7WmQi6
         dcZnNm7avYgJREBrP8j8u0b58ZBCymFFn0Q7FM/pgqj0r0LOFke8uNnbDZlW5nGqMHLK
         4Org==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Wed, 28 Mar 2018 10:30:51 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Manoj Gupta <manojgupta@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthias Kaehlcke <mka@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs: Check return value of debugfs_real_fops() for
 NULL
Message-ID: <20180328153051.jlyqpz7dxcuxgawc@treble>
References: <20180327235553.210165-1-mka@chromium.org>
 <20180328061616.GA8212@kroah.com>
 <CAAMbb052mY1TOLzM=8Lpv2gU95X-R40zaMWNZKd1vX-+49R88Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAMbb052mY1TOLzM=8Lpv2gU95X-R40zaMWNZKd1vX-+49R88Q@mail.gmail.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596137136019067169?=
X-GMAIL-MSGID: =?utf-8?q?1596195920301435768?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 07:47:53AM -0700, Manoj Gupta wrote:
> Please note that there is nothing wrong in the generated code, just
> that it confuses objtool.
> Clang has simply omitted the statement where NULL is returned since
> the pointer was always dereferenced post inlining.

... but returning NULL would be far more sane than falling through to
the next function.

> Note that GCC will also remove the NULL pointers if it knows that the
> pointer is dereferenced.
> Here is an example.
> 
> void null_check(int *P) {
>   int deref = *P;
>   if (P == 0) // GCC won't check the condition.
>     return;
>   *P = 4;
> }
> 
> Compiling with gcc -O2 gives:
>         movl    $4, (%rdi)
>         ret

This is why we use -fno-delete-null-pointer-checks.

-- 
Josh
