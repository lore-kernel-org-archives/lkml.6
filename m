Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526042183; cv=none;
        d=google.com; s=arc-20160816;
        b=geYxPnDrZPejLLS/zqrVzGw3esxB9P/2g+NKul76c7nrIAPZS59L95YlN7O04RdHvD
         iQWXXOy+4JREMdfFQ/qcKykbDFOQNFsai+5vyGzMI7xWUck7/iCzxoLIk3ewvxWOfaqx
         7/AUMZyFBvkgBtjtCe26QJDeGcgGf1LRp1UOB6pFwtm+IXFBvXECfjtlVTbVg9LYPeoW
         7bLLQnS303wEl76CTie8VhdeP85J1HokFuSuqqtbKIqUugUNspJ2Gg2qUzoA7Vhv37UH
         q9NxrSfzJVso31Bqq/WgwqLDY+WKJwWVO1MHVi7mi8v3r8Dc0kq1lfxZHlS/I5Jro5pu
         t35A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=nukVuubG0PtvETsOeOCDB8+hK3wKQhWo+f6+7KQfU24=;
        b=qgtRrE0lMu9z5CrD7MqkKGuvEAQsLc2tCPWm4Buf4rUk31CumRsZ/BaMijoh97hdIh
         X/WR/+m3rJhrQ77CKm2SFW8s4Kf05fqXbXQOIu9JSagwf++Zrzgxz+CDeg/iFxRIuWwD
         LCQNQViWEOqTFBt7k0Ygxer+z2Jk4hgLtl/0U+OaYDeEpGWlngf7sw3o+jGHM6RgVM0R
         mQnNFsi5INK6FFd7g4HmLtyjeWWKEuWksXiO0yovD1uODALfYiMWS2TNuYGiZDtnncv2
         BEOMCmIJqKuoZdMAzeWLwjwq3Esuf3zbmryMmzuoa+JC7X7rNwaN9MwZsuw0bUoj+7YM
         +8sw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=JRRUs0Ay;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=JRRUs0Ay;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AB8JxZqPPwr2n8Jby83evYFjEIEBVlfFFH98d8EVRx37cXxoeKOoq6bO8MXFcyU14bya2kmpX+T5mekM+UTWuqyimsg=
MIME-Version: 1.0
In-Reply-To: <20180508151137.zguepljs3pa7xv5g@armageddon.cambridge.arm.com>
References: <cover.1524077494.git.andreyknvl@google.com> <0db34d04fa16be162336106e3b4a94f3dacc0af4.1524077494.git.andreyknvl@google.com>
 <20180426174714.4jtb72q56w3xonsa@armageddon.cambridge.arm.com>
 <CAAeHK+zY8p9E4FZa7mbdgR=wR0u-RDS552dn=h9fKRC-ArYLdw@mail.gmail.com>
 <20180502153645.fui4ju3scsze3zkq@black.fi.intel.com> <CAAeHK+yTbmZfkeNbqbo+J90zsjsM99rwnYBGfQBxphHMMfgD7A@mail.gmail.com>
 <20180508151137.zguepljs3pa7xv5g@armageddon.cambridge.arm.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Fri, 11 May 2018 14:36:22 +0200
Message-ID: <CAAeHK+yR9=SYEBg-Pvi+x3qSqQSG1u+79pk5vQvOcsp+o=zkxw@mail.gmail.com>
Subject: Re: [PATCH 4/6] mm, arm64: untag user addresses in mm/gup.c
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>,
	Kate Stewart <kstewart@linuxfoundation.org>, linux-doc@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>, Linux Memory Management List <linux-mm@kvack.org>, Ingo Molnar <mingo@kernel.org>,
	Jacob Bramley <Jacob.Bramley@arm.com>, Jonathan Corbet <corbet@lwn.net>,
	Dmitry Vyukov <dvyukov@google.com>, Bart Van Assche <bart.vanassche@wdc.com>,
	Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Evgeniy Stepanov <eugenis@google.com>,
	Kees Cook <keescook@chromium.org>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
	Lee Smith <Lee.Smith@arm.com>, Dan Williams <dan.j.williams@intel.com>,
	Robin Murphy <robin.murphy@arm.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Kostya Serebryany <kcc@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>, James Morse <james.morse@arm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
	Philippe Ombredanne <pombredanne@nexb.com>, Andrew Morton <akpm@linux-foundation.org>,
	Zi Yan <zi.yan@cs.rutgers.edu>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598111199483906995?=
X-GMAIL-MSGID: =?utf-8?q?1600171208495161809?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 8, 2018 at 5:11 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Wed, May 02, 2018 at 07:25:17PM +0200, Andrey Konovalov wrote:
>> On Wed, May 2, 2018 at 5:36 PM, Kirill A. Shutemov
>> <kirill.shutemov@linux.intel.com> wrote:
>> > On Wed, May 02, 2018 at 02:38:42PM +0000, Andrey Konovalov wrote:
>> >> > Does having a tagged address here makes any difference? I couldn't hit a
>> >> > failure with my simple tests (LD_PRELOAD a library that randomly adds
>> >> > tags to pointers returned by malloc).
>> >>
>> >> I think you're right, follow_page_mask is only called from
>> >> __get_user_pages, which already untagged the address. I'll remove
>> >> untagging here.
>> >
>> > It also called from follow_page(). Have you covered all its callers?
>>
>> Oh, missed that, will take a look.
>>
>> Thinking about that, would it make sense to add untagging to find_vma
>> (and others) instead of trying to cover all find_vma callers?
>
> I don't think adding the untagging to find_vma() is sufficient. In many
> cases the caller does a subsequent check like 'start < vma->vm_start'
> (see sys_msync() as an example, there are a few others as well).

OK.

> What I
> did in my tests was a WARN_ON_ONCE() in find_vma() if the address is
> tagged.

So this is similar to what I did.

Do you think trying to find "all places where we cast out __user" with
static analysis as Kirill suggested is something I should pursue? Or
is this patchset is good as is as the first approximation, since we
can fix more things where untagging is needed as we discover them one
by one?
