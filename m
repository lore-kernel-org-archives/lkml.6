Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519062268; cv=none;
        d=google.com; s=arc-20160816;
        b=mCPT1gIXeZUdcPZwR/ot4353PRNwvHcrV4tRHX4zzLJNsnHKsLr/QO3UU5swR9WO2i
         2qdgwbafZK2/98WwC7tuBxlGgm2znbpw91ZhJUsbksNSQhFFrAke4N13kNMMyghNwhEc
         UvYpYH02PQC2o3zqSvCvR2x/acXW3dxEvnmYtuj4e8QdWitG3cBkaYi7M3DLXpLjiBUT
         zY3mO0MdkANgcOYNSGqeeuyI0VYq+Z+6i1mAyYaQFPA7gnRnvGUrvpv6qFDwpD+tYlsP
         nWi5pMi2+fMzqhpMBLsnkJ1lSh3jO0/89C3w4giWLMosA6jZ8FjSRhveGJlit4ifrcwF
         3k8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=goZO8zOSfL4zsbl+jU/gJFZNdnJLSzlijW0hKE6tW9s=;
        b=Ksu62KwZ8oIpnUog3f50D77+i2AEhuThdZLXxQAia7BI6BfHjAEWUd5t46b9cSw82U
         DFQkDbSyxDAIkoV33jveGSFMGWM9RvEKaOxn2PSp7mRVQDxnS2Mzs0IbURcxbBv13xin
         TkdJrmHRdtdAy0G+fU8ZdzEvqPZrV0Y6aR/uGuLsrjrsPyK1Ani7sQMcQro+ZYc7EhgX
         /hZO0g2748bRKShahcxPMpuSftJKLDD6royv9b4WIo5mhlHp1pMRby9IEglL/GnYO2vl
         yrj7H39xsOHzRV8PxU912Rj1Bt2H9hUq9GKYYblLGByRgkLu2jIpGh1Yb1yfAm/etr2Q
         V5dA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lNwgslu1;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lNwgslu1;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AH8x227TgbFDYYLBDxWog+/gNA6VzrWtKR2uhsDJeIufeIEzoUIICBscg6AADMqP3NZw/5VK1rAi2bRwCSzgwNbUy4M=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180219044845.7cnqpgyiinn6hkyb@huvuddator>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
 <1518806331-7101-12-git-send-email-yamada.masahiro@socionext.com>
 <CA+55aFwQLrrBeXZXK_qUXiGVFNv3qPJS4tNKFacuk0Y0WgZjCA@mail.gmail.com> <20180219044845.7cnqpgyiinn6hkyb@huvuddator>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 19 Feb 2018 09:44:28 -0800
X-Google-Sender-Auth: e1mrKvabN4MwqGju5ZNeS9-zIgA
Message-ID: <CA+55aFwiRzpSRW8xhoMs9cbFFXZGmEyyVa4a7aeZzQGYuO211w@mail.gmail.com>
Subject: Re: [PATCH 11/23] kconfig: add 'shell-stdout' function
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <keescook@chromium.org>, Randy Dunlap <rdunlap@infradead.org>,
	Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583935341216706?=
X-GMAIL-MSGID: =?utf-8?q?1592852238022444365?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 18, 2018 at 8:48 PM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
> On Fri, Feb 16, 2018 at 11:17:52AM -0800, Linus Torvalds wrote:
>>
>> Can we *please* make "shell-stdout" go away, and make this just be "shell"?
>>
>> The rule would be very simple:
>>
>>  - if the result of the shell command is a failure, the result is 'n'
>>
>>  - otherwise, the result is the first line of stdout
>>
>>  - if the result is empty, we replace it with 'y'.
>
> Could there be cases where you'd legitimately want to put empty output
> from a command in a string (that would be common enough to matter)?
> That'd get messier with the above rule, as it never generates an empty
> string as output.

Hmm. Maybe. Something like "LOCALVERSION_AUTO" might want that where
you add a version string if something is true, and maybe you'd use a
shell script for it and generate it at Kconfig time.

I'm not seeing anything like that right now, but I could imagine it in
theory, so your worry is valid.

> Would you still be as opposed (or more opposed...) to having two
> functions if they were called something like 'success' and 'stdout'
> instead?

Maybe the naming is indeed what annoyed me the most.

I do like your "success"/"stdout" more than "shell"/"shell-stdout",
because with that naming I don't get the feeling that one should
subsume the other.

          Linus
