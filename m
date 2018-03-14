Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932945AbeCNATM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 20:19:12 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:43821 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932634AbeCNATK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 20:19:10 -0400
X-Google-Smtp-Source: AG47ELunjrLzDJr+yf2tN0vsbRD57Kq8f+C/dhQAZucZ+Xnk/hqdcf3KXQAkBOCbb7MNKzeFbTNgAzH/v7dPmcyfVYM=
MIME-Version: 1.0
In-Reply-To: <1520980163.2049.54.camel@perches.com>
References: <20180312233952.niz2cuz7psv4fe2s@gmail.com> <20180313140037.7717460162192c99775b135e@linux-foundation.org>
 <CANiq72nKXXV7SDTmCwvizWA3ubdczNZV8qT2-PoGAQnDfX9qtg@mail.gmail.com> <1520980163.2049.54.camel@perches.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 14 Mar 2018 01:18:49 +0100
Message-ID: <CANiq72k=sw=Cxoes9tCNnVp0LweXRN5U+RuXU56QvO__HHQ1ZA@mail.gmail.com>
Subject: Re: [PATCH] clang-format: add configuration file
To: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, Robo Bot <apw@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 11:29 PM, Joe Perches <joe@perches.com> wrote:
> On Tue, 2018-03-13 at 22:52 +0100, Miguel Ojeda wrote:
>> On Tue, Mar 13, 2018 at 10:00 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
>> > On Tue, 13 Mar 2018 00:39:52 +0100 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
>> > > --- a/Documentation/process/4.Coding.rst
>> > > +++ b/Documentation/process/4.Coding.rst
>> > > @@ -58,6 +58,12 @@ can never be transgressed.  If there is a good reason to go against the
>> > >  style (a line which becomes far less readable if split to fit within the
>> > >  80-column limit, for example), just do it.
>> > >
>> > > +Note that you can use the clang-format tool to help you with these rules
>> > > +and to quickly re-format parts of your code automatically. It is specially
>> > > +useful for new files/code and to spot coding style mistakes. It is also
>> > > +useful to sort #includes, to align variables or comments, to reflow text
>> > > +and other similar tasks.
>> >
>> > It would be rather helpful to tell people how to invoke clang-format.
>
> clang-format has its drawbacks but at least it is
> likely to be improved more in the future.
>
> That is a lot better than Lindent/indent.
>
> Some not kernel-style compliant oddities:
>
> o placements of braces for definitions is like:
> static const struct pci_device_id e100_id_table[]
>        = { INTEL_8255X_ETHERNET_DEVICE(0x1029, 0),
> o alignment of block #defines

You mean a series of one-line #defines (i.e. the body) or a multiline
#define (i.e. the backspaces)? For the former, indeed, it is what I
saw. It seems that clang-format treats it one by one, and it honors
the column width limitation (so if it does not fit in one line, it
will move it to the next). However, if it fits, it will leave it in
the same line without aligning the bodies of the other #defines.

> o alignment of function arguments

For function signatures in general, I am unsure what options to
apply... I have seen in many places the "indent until the ( in the
previous line", then again, I have seen the "1 tab indentation" style
as well. I have also seen the GNU style (I mean leaving the return
type and other specifiers in the previous line) is also present when
it does not fit in one line. The coding style guide says:

"Statements longer than 80 columns will be broken into sensible chunks, unless
exceeding 80 columns significantly increases readability and does not hide
information. Descendants are always substantially shorter than the parent and
are placed substantially to the right. The same applies to function headers
with a long argument list. However, never break user-visible strings such as
printk messages, because that breaks the ability to grep for them.
"

> o logical tests continuations moved to BOL not EOL

Changed for v2. It does not seem to say anything in the coding style
guide, but you are completely right, it is the prevalent style.

> o misalignment of per-line comments
> o location of struct/union/enum braces

Oops -- fixed.

>
> etc...
>
> After applying Miguel's patch, try it with something like:
>
> $ git ls-files -- "drivers/net/ethernet/intel/*.[ch]" | \
>   while read file ; do clang-format -i $file ; done
>
> and look at the diff (I used clang-format-5.0.0-3)

Thanks a lot for the list/review! It was very useful.

Since we seem to agree on having this, I will send a v2 after I try a
few experiments to try to reduce more the produced diffs, explain
things better in Documentation/, add more comments in the config file
and send a v2.

Cheers,
Miguel
