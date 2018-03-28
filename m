Return-Path: <jpoimboe@redhat.com>
X-Google-Smtp-Source: AIpwx49KzRAqH/sF9CsDD9pRemPgY5NsQRe5Kt/a6h0zGbExjiOhTOl1P3f4+hVRk7PQRknZDNw+
ARC-Seal: i=1; a=rsa-sha256; t=1522251295; cv=none;
        d=google.com; s=arc-20160816;
        b=Gc9zTeGYxFyEFILexhiC6qKjQo8cygCQsCZDH1KiCVeBXgkm+AcgX4ol5wJcyvyGQB
         WD8ceFduiZbTP9MyJUQiV/dy9zqJNgXaPcONKim/TQL3KIft7CTXUfkCVPNbuuJhGRzm
         Y3Wg5gCSwjQMQKGvDD4FEjw+sbjVj3zZMWHUIAvOSI7W8XqysTE071TXJWwJttpbdklW
         lhFVn4sXOQt9ZljmLIDpQM0NGdh8nhtM95Ryn1aWiNofSldWcqWQ531RgPeXQNmWHqeW
         VjRMJ7kieX02/8u2jTS7Rfa8+jBFlEON6EUxwiw/vx5nYZaRfVAET0qMCqN6ymzw06DM
         OSxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Yw5SHNm1AfsRVywfcH+6AkzPi5VQx/NIwbsf1rEaxZM=;
        b=lkl2EAbeK6l7qXlVrlERPv8DAJILz3gSBpswUj+8hIwaJ3sf5M7okotYO658AF/Ldr
         sQwHTL6k9CaFSAKocDX4HpeSF748dhqwGbD2MQqssbw68CdU4msFMVsxwi2Qs1gneRTJ
         zDsOrRzR5t++t3CJvvUi6hhhIdZRWqwO2gAcstNT9TeO4dTmyt66fPYdTINHrmr2VNpO
         FKkewq6AVYPvoFIY+LfjAJWKTbfNu+Darv9XNZ0W/Ne0hXkZgF6k2kfAAJQQVT+YRpLs
         a+shxSa8mqmAjAkXsTjFxf2YV3vL7bLKw4ibllsXGPXBhkdB+X7KhukKPruAZkg1LLQK
         7dow==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Wed, 28 Mar 2018 10:34:54 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Manoj Gupta <manojgupta@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthias Kaehlcke <mka@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs: Check return value of debugfs_real_fops() for
 NULL
Message-ID: <20180328153454.ejpn2ayppkk3escc@treble>
References: <20180327235553.210165-1-mka@chromium.org>
 <20180328061616.GA8212@kroah.com>
 <CAAMbb052mY1TOLzM=8Lpv2gU95X-R40zaMWNZKd1vX-+49R88Q@mail.gmail.com>
 <20180328153051.jlyqpz7dxcuxgawc@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180328153051.jlyqpz7dxcuxgawc@treble>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596137136019067169?=
X-GMAIL-MSGID: =?utf-8?q?1596196174926837122?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 10:30:51AM -0500, Josh Poimboeuf wrote:
> On Wed, Mar 28, 2018 at 07:47:53AM -0700, Manoj Gupta wrote:
> > Please note that there is nothing wrong in the generated code, just
> > that it confuses objtool.
> > Clang has simply omitted the statement where NULL is returned since
> > the pointer was always dereferenced post inlining.
> 
> ... but returning NULL would be far more sane than falling through to
> the next function.

Or, as the case may be, oopsing at the point of failure.


> > Note that GCC will also remove the NULL pointers if it knows that the
> > pointer is dereferenced.
> > Here is an example.
> > 
> > void null_check(int *P) {
> >   int deref = *P;
> >   if (P == 0) // GCC won't check the condition.
> >     return;
> >   *P = 4;
> > }
> > 
> > Compiling with gcc -O2 gives:
> >         movl    $4, (%rdi)
> >         ret
> 
> This is why we use -fno-delete-null-pointer-checks.

-- 
Josh
