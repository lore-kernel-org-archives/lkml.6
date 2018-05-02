Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525271392; cv=none;
        d=google.com; s=arc-20160816;
        b=GOt4kePYaCTjKvUpUW3MaVQwoVXo0gOfJbx0YbNVGIS8vvwxwvQfR07Tpo/QBAuUuZ
         Gyd0BL7hcnzL0Eb4QGS1kkGyB3iGfFBn3/Rqs4bFsjBgJILReVPKt1BFxUjkejSIEIbK
         15TxRl0v775deYN2jKGBpxJB4sJlsUBnftAMngeZ2CFZSSK/UL2LBYaFW4WCYcG+TIvw
         MHsTMSvH1Y/h/to4o0rM9DH2E/21M6w4vM1AYUw6fCQ9ETq11A+MTZO7IIaGFMDvuD8S
         3qgJ5BJo5ChQnvVRs6pGXNYh5n625YZmI0HgGOox3Thxd6GpPbs5optJOSNKIRsu2cnl
         +GqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=E/LLJKBeqZFD2sKZPFk32FqNdxYR7HYo66wdTxHwid4=;
        b=M4Cu3BDJSYg7HEULKjk9flrtkLNABgJLpTnwiUIcEm2v21m8+pwsdD5Kxjd56JH480
         RWib7pIfncDxjoKZapSKOK/eO+F5xdCxl5+1mzzH13YXFuvXWhkddZrFCep3WCVqfaz9
         VtJeIBk4nbZd7wDjX9bF/kwMlERxDbFRDtap4UyzYS/basrI7YvDesu7oftvjTxc/UIR
         /qQW8w/mUySBa8tILbqGnVo3yIHxOsHrPNyqcAEHQ5ykNXDII6r7Qftn5FZs4uL5KJM6
         UZvX8gnYw2g/uvhfvhmSSnlCn5tgosSPGhbqrlEQiycR7rdxsqrPT1a+WDRSQUhPksmq
         IGkg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=kfAVgNIy;
       dkim=pass header.i=@chromium.org header.s=google header.b=edplCefn;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=kfAVgNIy;
       dkim=pass header.i=@chromium.org header.s=google header.b=edplCefn;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AB8JxZreuzmT1g/WFeD3nIm6N21HtSV4oVxuLIOKL2LGNw2Q02vQjllclOk+NIgBStW2yBF8oIFxRGRf1D0e6MMrvuc=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <8d3e702b-470a-542e-4e0d-6a3c58419f0f@linux.ibm.com>
References: <20180427123547.15727-1-tmricht@linux.ibm.com> <20180427134936.GA31171@kroah.com>
 <CAGXu5j+LK8-g9bg+RNn+-v1LpRC32sTCAUNZr1v0HXquiG9fQw@mail.gmail.com> <8d3e702b-470a-542e-4e0d-6a3c58419f0f@linux.ibm.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 2 May 2018 07:29:51 -0700
X-Google-Sender-Auth: vb0hv48PPx4t7jJVN5EkkPQTFXM
Message-ID: <CAGXu5j+Fr+=bdWMwkLh2jP2EA4JejTyxqXbr+L99Y7jrDV1X3w@mail.gmail.com>
Subject: Re: [PATCH v2] inode: debugfs_create_dir uses mode permission from parent
To: Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, brueckner@linux.vnet.ibm.com,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598885939373348657?=
X-GMAIL-MSGID: =?utf-8?q?1599362975938475491?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 2, 2018 at 12:16 AM, Thomas-Mich Richter
<tmricht@linux.ibm.com> wrote:
> On 04/27/2018 04:58 PM, Kees Cook wrote:
>> On Fri, Apr 27, 2018 at 6:49 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
>>> I'm going to add Kees and the kernel-hardning list here, as I'd like
>>> their opinions for the patch below.
>>>
>>> Kees, do you have any problems with this patch?  I know you worked on
>>> making debugfs more "secure" from non-root users, this should still keep
>>> the intial mount permissions all fine, right?  Anything I'm not
>>> considering here?
>>
>> This appears correct to me. I'd like to see some stronger rationale
>> for why this is needed, just so I have a "design" to compare the
>> implementation against. :)
>>
>> Normally, the top-level directory permissions should block all the
>> subdirectories too. The only time I think of this being needed is if
>> someone is explicitly bind-mounting a subdirectory to another location
>> (e.g. Chrome OS does this for the i915 subdirectory). In that case,
>> I'd expect them to tweak permissions too. Thomas, what's your
>> use-case?
>>
>> -Kees
>>
>
> There is no 'real use case'. I wrote the patch because of discussions
> regarding file permissions for files located deeply in the
> directory tree, for example
>
>   -r--r--r-- 1 root root 0 Apr 27 14:23 /sys/kernel/debug/kprobes/blacklist
>
> which gives the impression it is world readable.
> This happened to me in recent discussions when I wrote patches to fix some
> of the address randomized output of /sys files which broke the perf tool.
>
> During discussion people often forgot that the root /sys/kernel/debug is rwx for
> root only and blocks non root access to subdirectories and files. They simply
> looked at the file permissions.

Okay, sounds good. "Make permissions less surprising" is a perfectly
good reason to make the change. :)

> I have not thought about the bind-mount case nor did I test this scenario.

I think this case is fine too. Anyone doing this is likely doing some
pretty special things with permissions already.

So, FWIW:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
