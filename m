Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753193AbeCMVwl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 17:52:41 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36738 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753080AbeCMVwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 17:52:39 -0400
X-Google-Smtp-Source: AG47ELtIhfcK1D8MN+PVAenfjUQKHLgue0ANKMvCiu5Nk52v/13pnKCfJCigBRL1ouNofijzUSf8ZVj0HXDDdvyud4c=
MIME-Version: 1.0
In-Reply-To: <20180313140037.7717460162192c99775b135e@linux-foundation.org>
References: <20180312233952.niz2cuz7psv4fe2s@gmail.com> <20180313140037.7717460162192c99775b135e@linux-foundation.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 13 Mar 2018 22:52:17 +0100
Message-ID: <CANiq72nKXXV7SDTmCwvizWA3ubdczNZV8qT2-PoGAQnDfX9qtg@mail.gmail.com>
Subject: Re: [PATCH] clang-format: add configuration file
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, Robo Bot <apw@canonical.com>,
        Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 10:00 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Tue, 13 Mar 2018 00:39:52 +0100 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
>
>> --- a/Documentation/process/4.Coding.rst
>> +++ b/Documentation/process/4.Coding.rst
>> @@ -58,6 +58,12 @@ can never be transgressed.  If there is a good reason to go against the
>>  style (a line which becomes far less readable if split to fit within the
>>  80-column limit, for example), just do it.
>>
>> +Note that you can use the clang-format tool to help you with these rules
>> +and to quickly re-format parts of your code automatically. It is specially
>> +useful for new files/code and to spot coding style mistakes. It is also
>> +useful to sort #includes, to align variables or comments, to reflow text
>> +and other similar tasks.
>
> It would be rather helpful to tell people how to invoke clang-format.
> Is it just "clang-format foo.c" or what?
>

Indeed! I will add more information. Here is some more we can put (I
will properly rewrite it, but you can see it as a draft and as the
answer to your question! :-)

You can call "clang-format foo.c" and it will output to the standard
output the formatted file (using the configuration file automatically
if it is any of the parents, a la git). The -i does the replacements
inline. However, for the kernel, it is best to use it with one of the
editor integrations: the issue is that clang-format does not format
everything perfectly as we want for the kernel [*], so it is best used
to either 1) format portions of files or 2) check patches.

  - For formatting portions of files, you just select inside your text
editor something and press your favorite key binding to re-format it
(clang-format has some parameters that the editor passes when invoking
it). Since it is very fast, it works very well. Integrations with vim
and emacs come with the tool; for most other popular editors, you can
usually find a plugin or similar in the manager of such editor.

  - For checking patches, since it comes with support to read unified
diffs, it is very easy to use it for patches and for commits. What you
will see is both things that could be improved because there was a
typo/mistake by the patch author, and things that you should ignore
because clang-format does not format those cases -- it is very easy to
know which are which if you use the tool a few times, specially if you
are looking at the difference with git diff.

When I was testing clang-format to come with the configuration, I was
running the tool against full files, and while there were many cases
that have to be ignored, like [*], it is also very easy to see some
mistakes in the code. If it gets popular, I am sure people will come
up with ready-to-be-used scripts/hooks and things like that, but for
the moment I thought the best was to at least have the basic
configuration in and iterate from there. At least there is *one*
person (what an audience! :-) using it currently, since if you grep
for "clang-format" you will see one staging driver with one comment in
the code to turn off the formatting in a block. I also thought that
the sooner we define how we will use it (e.g. whether we allow those
"don't-format-this" marks, the name for those marks -- it is
configurable, etc.), the best.

[*] For instance, it does not support alignment of one-line #defines
-- but it aligns multiline #defines quite well, though. So you won't
run it for full files typically, but for groups of things. Another
simple case where it is best for selections and not for full files (at
least existing files) is the sorting of #includes i.e. It is great if
you use it when selecting a bunch of them that you know will look
better if sorted, but probably you don't want to sort ALL of them
(even if it respects the grouping, which it does); expect if you are
writing a new file.

Cheers,
Miguel
