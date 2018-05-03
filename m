Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751143AbeECWPD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 18:15:03 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:40436 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbeECWPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 18:15:01 -0400
X-Google-Smtp-Source: AB8JxZpfR7L1OgdpdhpnZq2qvo9WxusrGdf3XmYjCsgnlg06PGFwIMl499hSbrtZvqGPOrX2akcHmg==
Subject: Re: [PATCH] proc: use #pragma once
To: Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc: dsterba@suse.cz, Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
References: <20180423213534.GA9043@avx2>
 <20180424135409.GA22709@infradead.org> <20180425205531.GA9020@avx2>
 <20180426102629.scwtdeijbo3342gp@twin.jikos.cz> <20180426192444.GA4919@avx2>
 <20180501151319.33dcb1d48a8526ed521fae9c@linux-foundation.org>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <85dc7f54-c17f-b49f-df4d-04a339b260d7@rasmusvillemoes.dk>
Date: Fri, 4 May 2018 00:14:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501151319.33dcb1d48a8526ed521fae9c@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-02 00:13, Andrew Morton wrote:
> On Thu, 26 Apr 2018 22:24:44 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
>>> The LOC argument also does not sound very convincing.
>>
>> When was the last time you did -80 kLOC patch for free?
> 
> That would be the way to do it - sell the idea to Linus, send him a
> script to do it then stand back.  The piecemeal approach is ongoing
> pain.
> 

FWIW, it's not just removing some identifiers from cpp's hash tables, it
also reduces I/O: Due to our header mess, we have some cyclic includes,
e.g mm.h -> memremap.h -> mm.h. While parsing mm.h, cpp sees the #define
_LINUX_MM_H, then goes parsing memremap.h, but since it hasn't reached
the end of mm.h yet (seeing that there's nothing but comments outside
the #ifndef/#endif pair), it hasn't had a chance to set the internal
flag for mm.h, so it goes slurping in mm.h again. Obviously, the
definedness of _LINUX_MM_H at that point means it "only" has to parse
those 87K for comments and matching up #ifs, #ifdefs,#endifs etc. With
#pragma once, the flag gets set for mm.h immediately, so the #include
from memremap.h is entirely ignored. This can easily be verified with
strace. And mm.h is not the only header getting read twice.

I had some "extract the include guard" line noise lying around, so I
hacked up the below if someone wants to play some more with this. A few
not-very-careful kbuild timings didn't show anything significant, but
both the before and after times were way too noisy, and I only patched
include/linux/*.h.

Anyway, the first order of business is to figure out which ones to leave
alone. We have a bunch of #ifndef THAT_ONE #error "don't include
$this_one directly". The brute-force way is to simply record all macros
which are checked for definedness at least twice.

git grep -h -E '^\s*#\s*if(.*defined\s*\(|n?def)\s*[A-Za-z0-9_]+' | grep
-o -E '[A-Za-z_][A-Za-z_0-9]*' | sort | uniq --repeated > multest.txt

But there's also stuff like arch/x86/boot/compressed/kaslr.c that plays
games with pre-defining _EXPORT_H to avoid parsing export.h when it
inevitably gets included. Oh well, just add the list of macros that have
at least two definitions.

git grep -h -E '^\s*#\s*define\s+[A-Za-z0-9_]+' | grep -o -E
'^\s*#\s*define\s+[A-Za-z0-9_]+' | grep -oE '[A-Za-z0-9_]+' | sort |
uniq --repeated > muldef.txt

With those, one can just do

cat muldef.txt multest.txt | scripts/replace_ig.pl ...

This ends up detecting a lot of copy-pasting (e.g.
__LINUX_MFD_MAX8998_H), as well as lots of headers that for no obvious
reason do not have an include guard. Oh, and once.h has a redundant \.

Rasmus

wear sunglasses...

=== scripts/replace_ig.pl ===

#!/usr/bin/perl

use strict;
use warnings;
use File::Slurp;

my %preserve;

sub strip_comments {
    my $txt = shift;

    # Line continuations are handled before comment stripping, so
    # <slash> <backslash> <newline> <star> actually starts a comment,
    # and a // comment can swallow the following line. Let's just
    # assume nobody has modified the #if control flow using such dirty
    # tricks when we do a more naive line-by-line parsing below to
    # actually remove the include guard deffery.
    $txt =~ s/\\\n//g;

    # http://stackoverflow.com/a/911583/722859
    $txt =~ s{
		 /\*         ##  Start of /* ... */ comment
		 [^*]*\*+    ##  Non-* followed by 1-or-more *'s
		 (?:
		     [^/*][^*]*\*+
		 )*          ##  0-or-more things which don't start with /
		 ##    but do end with '*'
		 /           ##  End of /* ... */ comment

	     |
		 //     ## Start of // comment
		 [^\n]* ## Anything which is not a newline
		 (?=\n) ## End of // comment; use look-ahead to avoid consuming the
newline

	     |         ##     OR  various things which aren't comments:

		 (
		     "           ##  Start of " ... " string
		     (?:
			 \\.           ##  Escaped char
		     |               ##    OR
			 [^"\\]        ##  Non "\
		     )*
		     "           ##  End of " ... " string

		 |         ##     OR

		     '           ##  Start of ' ... ' string
		     (
			 \\.           ##  Escaped char
		     |               ##    OR
			 [^'\\]        ##  Non '\
		     )*
		     '           ##  End of ' ... ' string

		 |         ##     OR

		     .           ##  Anything other char
		     [^/"'\\]*   ##  Chars which doesn't start a comment, string or escape
		 )
	 }{defined $1 ? $1 : " "}gxse;

    return $txt;
}

sub include_guard {
    my $txt = shift;
    my @lines = (split /^/, $txt);
    my $i = 0;
    my $level = 1;
    my $name;

   # The first non-empty line must be an #ifndef or an #if !defined().
    ++$i while ($i < @lines && $lines[$i] =~ m/^\s*$/);
    goto not_found if ($i == @lines);
    goto not_found
	if (!($lines[$i] =~
m/^\s*#\s*ifndef\s+(?<name>[A-Za-z_][A-Za-z_0-9]*)\s*$/) &&
	    !($lines[$i] =~
m/^\s*#\s*if\s+!\s*defined\s*\(\s*(?<name>[A-Za-z_][A-Za-z_0-9]*)\s*\)\s*$/));
    $name = $+{name};

    # The next non-empty line must be a #define of that macro.
    1 while (++$i < @lines && $lines[$i] =~ m/^\s*$/);
    goto not_found if ($i == @lines);
    goto not_found if !($lines[$i] =~ m/^\s*#\s*define\s+\b$name\b/);

    # Now track #ifs and #endifs. #elifs and #elses don't change the level.
    while (++$i < @lines && $level > 0) {
	if ($lines[$i] =~ m/^\s*#\s*(?:if|ifdef|ifndef)\b/) {
	    $level++;
	} elsif ($lines[$i] =~ m/^\s*#\s*endif\b/) {
	    $level--;
	}
    }
    goto not_found if ($level > 0); # issue a warning?
    # Check that the rest of the file consists of empty lines.
    ++$i while ($i < @lines && $lines[$i] =~ m/^\s*$/);
    goto not_found if ($i < @lines);
    return $name;

 not_found:
    return undef;
}

sub do_file {
    my $fn = shift;
    my $src = read_file($fn);
    my $ig = include_guard(strip_comments($src));
    if (not defined $ig) {
	printf STDERR "%s: no include guard\n", $fn;
	return;
    }
    if (exists $preserve{$ig}) {
	printf STDERR "%s: include guard %s exempted\n", $fn, $ig;
	return;
    }

    # OK, the entire text should match this horrible regexp.
    if ($src =~ m{
  (.*?) # arbitrary stuff before #ifndef
  (^\s*\#\s*if(?:\s*!\s*defined\s*\(\s*$ig\s*\)|ndef\s*$ig) .*? \n #
  (?:^\s*\n)*
   ^\s*\#\s*define\s*$ig .*? \n) # 2/3 of include guard
  (.*(?=^\s*\#\s*endif)) # body of file
  (^\s*\#\s*endif .*? \n) # last 1/3
  (.*) # rest of file (trailing comments)
	}smx) {
	my $pre = $1;
	my $define = $2;
	my $body = $3;
	my $endif = $4;
	my $post = $5;
	$body =~ s/\n[ \t]*\n$/\n/g;
	$src = $pre . "#pragma once\n";
	$src .= $body . $post;
    } else {
	printf STDERR "%s: has include guard %s, but I failed to replace it
with #pragma once\n",
	$fn, $ig;
	return;
    }
    write_file($fn, $src);
}

while (<STDIN>) {
    chomp;
    $preserve{$_} = 1;
}

for (@ARGV) {
    do_file($_);
}
