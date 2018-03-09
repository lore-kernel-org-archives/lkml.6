Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520620986; cv=none;
        d=google.com; s=arc-20160816;
        b=F0lziMoqHN44wBaP0gJxBi50nb+pdiIAHTSeotHVB/bttWDr42ijuV2xmXWk4iW0ZZ
         MhqMPjxV+C6tslh0mvbX87aCXq5MuurnLKdkjppavqmVsrePL4uaqMbcf8R6sArOua1H
         Ph8NlU9jlZOldcCQxDFlZ9mxbQW82v1rGMg2HxzaWpdEzbvw6faKDCEG9EQBXH1WhKbe
         yRsx21lPPGkVDa6UVI5A5060JWX/dWxZzGuGrWipt01SKSkYnvX4yZ/CqkWhjuAMWkal
         iw6tvrLDMdIhd62anF5kdSKRho0C09C3DD06Sr/MgKayHO8+9DeUmdmnn1L7kIIR8unO
         Rblw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=xjrTs4iSBRjgG1Ez9nuS2pSYpJUTcS5o/rgA1tdfouk=;
        b=awOMFqOkDHDV8DlwwJLlpumhEZQU14moJnIY5Nd+Xg73MpcmWoDd9zgb6K3uOpKJVR
         KwwqJNIu3zRe4Ncb0vvkCOElsvy9lXbt/6bMpJ+e9MV6EE9P1qcsorB6GHAa7HKYrPfn
         1iQM2pYu/28TmL8yo37gjmptela8acscMXaeP5br0aboCq2Md72Rm9lNvTkBlHhlwPL0
         gMNss+RvLnTij8wL00ltRbq4TkSKKajH0tpkcrnoqguhQ1UooCQq8rSYmMd2iCWbbFHs
         jWF+7iW2QAcTBK51OQECa0Lo4II/4f6eEOlXIVjQuD87kXYf1r7fhKd1ZgzWOwe4mHGD
         YYOg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=jUAHfpEl;
       dkim=pass header.i=@chromium.org header.s=google header.b=cyjFUSm4;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=jUAHfpEl;
       dkim=pass header.i=@chromium.org header.s=google header.b=cyjFUSm4;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELv1ocvx/XkrqWYkbUyJRZggFeAjEuovuDS4xl6okIhmWMi91epAsG97cRkqDosN3Dq9IalRvwL/S335pu+2Kzw=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180309.133509.1275903267249306409.davem@davemloft.net>
References: <C94A45E9-54A0-446D-86D6-82D06E2A35CD@amacapital.net>
 <87478c51-59a7-f6ac-1fb2-f3ca2dcf658b@fb.com> <CA+55aFwfcXzD+pzjN=vTcvscpK97pSztUZ2JK7pABs+rMtM7BQ@mail.gmail.com>
 <20180309.133509.1275903267249306409.davem@davemloft.net>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 9 Mar 2018 10:43:04 -0800
X-Google-Sender-Auth: a2OfxbmnYYGnj1GF7Z6dblf5GUE
Message-ID: <CAGXu5jJcuSojm_KN5+JQ3fV6J09V6dmNB6haqu11xkXTq=nxog@mail.gmail.com>
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf binaries
To: David Miller <davem@davemloft.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexei Starovoitov <ast@fb.com>,
	Andy Lutomirski <luto@amacapital.net>, Alexei Starovoitov <ast@kernel.org>, Djalal Harouni <tixxdz@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Daniel Borkmann <daniel@iogearbox.net>,
	Greg KH <gregkh@linuxfoundation.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>,
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	kernel-team <kernel-team@fb.com>, Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594150201283124044?=
X-GMAIL-MSGID: =?utf-8?q?1594486671645339211?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 9, 2018 at 10:35 AM, David Miller <davem@davemloft.net> wrote:
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Fri, 9 Mar 2018 10:17:42 -0800
>
>>  - use deny_write_access() to make sure that we don't have active
>> writers and cannot get them during the execve.
>
> I agree that this is necessary for image validation purposes.

Module loading (via kernel_read_file()) already uses
deny_write_access(), and so does do_open_execat(). As long as module
loading doesn't call allow_write_access() before the execve() has
started in the new implementation, I think we'd be covered here.

-Kees

-- 
Kees Cook
Pixel Security
