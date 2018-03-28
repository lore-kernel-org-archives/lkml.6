Return-Path: <manojgupta@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1522248474; cv=none;
        d=google.com; s=arc-20160816;
        b=Bk3eak+Q5i4nTPVUDPBKo62QGLzbZJi/f2B6nUc5w6UdTNgySZSdJVm13EJ0wLxhSB
         9UR0/cLFiRqYlmPUxsa/DbSq4J5da+/cQ4lN8/I/TdgxinhbjeuQMwVA+AKpuPl4W24I
         olh+67cfOiPc9kdAhueeyjGpg72lIyQvHY7OrSgugzjw8ECmb2gUv2KB8/6R/XdyWVNv
         O95teujOJAcYAAJ0FppvCvx/poi6qa48d5bvQHF/o5amvJtyhJosyv4TxznmxKupz/1T
         8QcLg3M9m8UQR3GqUZL7ENN8Knhy5VXFiBFj6ifZ1YDbDPrHSW5v8rl4sdZr7bWtrLeT
         N8Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=UW8FXJ/xjWmnl1Ujri99BvnRdLLztdEvi4V8qFOsigY=;
        b=x5qBhNWEwc5vouncA1JPFkfmxV3uHlDKEOariRakQ6+O31oomNR0qs/ay2u9uYEk3B
         6bqL4uG6CfJU2pIiL1VE0of9GDGi5TXQgM2j3PR7V5IW/9X2NapzXG1k1vvWeWlcMxEC
         jsiS7VMWx8+ChBHiOT04GNXUq/Ybaus/7fz9C5kPyraCioBE2Y7/FPK3RaespYXcELP9
         yslscOesanCtO1Zw3CFAJtd7rHVo1HJMe/n7KCG8QnJ8L4aliVYaCH909rz9FXZtV0u2
         e3qy+17JAAqpIK1zB9LT9vP4uetmVdFOb5ndJCKCNisFrX4ermv5vaYFMDGvS2+EaBlx
         XRpQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=PrFirMht;
       spf=pass (google.com: domain of manojgupta@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=manojgupta@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=PrFirMht;
       spf=pass (google.com: domain of manojgupta@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=manojgupta@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx49GaM4RJHHLih9L2tub3AxPgLDD0EkiF66pLgQb9Kv3lrPxd2OL+1cAejtIGECUeg2EnSOZlvFW7CRrl9Mwzuk=
MIME-Version: 1.0
In-Reply-To: <20180328061616.GA8212@kroah.com>
References: <20180327235553.210165-1-mka@chromium.org> <20180328061616.GA8212@kroah.com>
From: Manoj Gupta <manojgupta@chromium.org>
Date: Wed, 28 Mar 2018 07:47:53 -0700
Message-ID: <CAAMbb052mY1TOLzM=8Lpv2gU95X-R40zaMWNZKd1vX-+49R88Q@mail.gmail.com>
Subject: Re: [PATCH] debugfs: Check return value of debugfs_real_fops() for NULL
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthias Kaehlcke <mka@chromium.org>, linux-kernel@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596137136019067169?=
X-GMAIL-MSGID: =?utf-8?q?1596193216892519977?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Please note that there is nothing wrong in the generated code, just
that it confuses objtool.
Clang has simply omitted the statement where NULL is returned since
the pointer was always dereferenced post inlining.

Note that GCC will also remove the NULL pointers if it knows that the
pointer is dereferenced.
Here is an example.

void null_check(int *P) {
  int deref = *P;
  if (P == 0) // GCC won't check the condition.
    return;
  *P = 4;
}

Compiling with gcc -O2 gives:
        movl    $4, (%rdi)
        ret

Thanks,
Manoj

On Tue, Mar 27, 2018 at 11:16 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Mar 27, 2018 at 04:55:53PM -0700, Matthias Kaehlcke wrote:
>> debugfs_real_fops() returns a NULL pointer when it is invoked without a
>> prior call to debugfs_file_get(). In code paths including this call it
>> is not strictly necessary to check the return value of
>> debugfs_real_fops(). However clang inlines debugfs_real_fops(), detects
>> the invalid dereferencing of the NULL pointer and drops the code path.
>
> Wait, what?  Why would it do that, because it thinks dereferencing NULL
> is undefined behaviour and it can just do whatever it wants to?
>
> That feels crazy, as for these calls we "know" it will never be NULL
> because the previous call to debugfs_file_get() will always ensure it
> will be correct.
>
> So this is a case of the compiler trying to be smarter than it really
> is, and getting things totally wrong :(
>
> Has anyone reported this to the clang developers?
>
> Papering over compiler foolishness is not something I like to do in
> kernel code if at all possible...
>
> thanks,
>
> greg k-h
