Return-Path: <kernel-hardening-return-12793-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/QpwiEzYavuvMmQlhCqPVmD10ICP/DMts6zsIaifbb/LpFI+wn4n9HxnXW5aQQg3wGTdiT
ARC-Seal: i=1; a=rsa-sha256; t=1522233550; cv=none;
        d=google.com; s=arc-20160816;
        b=gdnOLI9TCVAU5nRrfwtnZvBj9jW/Pf1NueHVaQiGYB0vBXjvWKpz8evCuZzMt1DCyZ
         naT8o1CrFV9zvaaZUty4Y8GGspQS+e1Q2EicPiF3JWttvhbiS1NaPZc8VaSVpIR0+fs2
         5URS3b5uX/WDxZHp5IZxBXAs6bZCdbGUG1bHNcfLTYkPiJxSuUQSczIaAJQ8lFRQZonS
         Id/IFnKty/MTQM9tXB6agNd5sXdoFnJ4QVxrTOxh8PR0A3sESSvGaAbDWoz/ekfFQXoT
         iCi2mZG2eKrKrfLTOVACi1qHYPKoUNyn4pPHxMLACjSE/K5AmbXMY+OeVvZ4M5rawb4e
         zTXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=gNJJg74xXurTPcEtX2bGQFm/VUyKCjG4FnTSblEF/nw=;
        b=s4pBn5dyx1EwO4zunkeRRS7pi/z2tClrqP8OQLg++galtfe8ScDTv4ljZJH+VJjNo0
         3r/XniFBXpRK6eLMc6HElFB6DeImqMCx1vAgY8n8dtZ8BxeFqHkbut0tZ+RZ0gZYj73+
         72c++09zkTSsaNwW58dBbXGCT0N7MLBWoUUkI1zx2d2zZki76eWPL8SgtLOjmTAdDtBu
         dFLZYX04mszgaxTVVnYIt64MdWtZ/E45gsnMNpd4GynOnA0WjQ/2DHfB1QdR5VxUxLda
         CjDhkJ4wFm+MtMOeas2Pdfep5Sg4jmA2xECGbzYiEnPWV3vCVZ6oOn3Tzdu91CDPHo5u
         t6WQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=jcCKPrJC;
       spf=pass (google.com: domain of kernel-hardening-return-12793-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12793-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=jcCKPrJC;
       spf=pass (google.com: domain of kernel-hardening-return-12793-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12793-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJ=46_1DiWg=0aKzOo1+kxL9vemLFi11brn-+iY6cgZMw@mail.gmail.com>
References: <1520970663-19633-1-git-send-email-s.mesoraca16@gmail.com> <CAGXu5jJ=46_1DiWg=0aKzOo1+kxL9vemLFi11brn-+iY6cgZMw@mail.gmail.com>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Wed, 28 Mar 2018 12:38:32 +0200
Message-ID: <CAJHCu1JFfKEiRFs6rz3W=B3z1GM09E9K7Oja2i9iK3GHqLpDuw@mail.gmail.com>
Subject: Re: [PATCH] ftrace: drop a VLA in module_exists()
To: Kees Cook <keescook@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, Ingo Molnar <mingo@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594853368165293411?=
X-GMAIL-MSGID: =?utf-8?q?1596177567556022166?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-27 1:16 GMT+02:00 Kees Cook <keescook@chromium.org>:
> On Tue, Mar 13, 2018 at 12:51 PM, Salvatore Mesoraca
> <s.mesoraca16@gmail.com> wrote:
>> Avoid a VLA[1] by using a real constant expression instead of a variable.
>> The compiler should be able to optimize the original code and avoid using
>> an actual VLA. Anyway this change is useful because it will avoid a false
>> positive with -Wvla, it might also help the compiler generating better
>> code.
>>
>> [1] https://lkml.org/lkml/2018/3/7/621
>>
>> Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
>> ---
>>  kernel/trace/ftrace.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>> index eac9ce2..adebb92 100644
>> --- a/kernel/trace/ftrace.c
>> +++ b/kernel/trace/ftrace.c
>> @@ -3902,14 +3902,13 @@ static bool module_exists(const char *module)
>>  {
>>         /* All modules have the symbol __this_module */
>>         const char this_mod[] = "__this_module";
>> -       const int modname_size = MAX_PARAM_PREFIX_LEN + sizeof(this_mod) + 1;
>> -       char modname[modname_size + 1];
>> +       char modname[MAX_PARAM_PREFIX_LEN + sizeof(this_mod) + 1];
>
> Actually, I think this needs to be "+ 2" (":" and NULL).

Ah, right! I'll fix it ASAP :)

>
>>         unsigned long val;
>>         int n;
>>
>> -       n = snprintf(modname, modname_size + 1, "%s:%s", module, this_mod);
>> +       n = snprintf(modname, sizeof(modname), "%s:%s", module, this_mod);
>>
>> -       if (n > modname_size)
>> +       if (n > sizeof(modname) - 1)
>>                 return false;
>>
>>         val = module_kallsyms_lookup_name(modname);
>
> Otherwise, looks good!

Thank you!

Salvatore
