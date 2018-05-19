Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750813AbeESENK (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 00:13:10 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:39143 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbeESENI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 00:13:08 -0400
X-Google-Smtp-Source: AB8JxZqhz/E3hM7vIk+AWEcqmrtQumldM2GvE+zRNn8DV/Uxxc9JjaLQD+dt/YNRShuJfRUlGKipiW1/5dyYRcymCSk=
MIME-Version: 1.0
References: <cover.thread-4f3684.your-ad-here.call-01526696764-ext-9375@work.hours>
 <patch-1.thread-4f3684.git-4f3684ca2aad.your-ad-here.call-01526696764-ext-9375@work.hours>
 <CA+55aFxJb9P2TMCc2Pao-uXcVACK-CTBHmzObAQu=rvs87itvw@mail.gmail.com>
 <CA+55aFwxEiiAC+dMMVqQ4igqb7rmn23Bq=BM8fqU=MFRWF1JSw@mail.gmail.com> <20180519034338.GV30522@ZenIV.linux.org.uk>
In-Reply-To: <20180519034338.GV30522@ZenIV.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 18 May 2018 21:12:56 -0700
Message-ID: <CA+55aFyHLFnGv8yFJs7-vGVe6tDeDAbSJ6=09iTqsegRZN_nGw@mail.gmail.com>
Subject: Re: [PATCH] procfs: fix mmap() for /proc/vmcore
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: gor@linux.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Content-Type: multipart/mixed; boundary="00000000000028fee3056c87497b"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000028fee3056c87497b
Content-Type: text/plain; charset="UTF-8"

On Fri, May 18, 2018 at 8:43 PM Al Viro <viro@zeniv.linux.org.uk> wrote:

> Not quite.  The things like
>          if (unlikely(*ppos >= inode->i_sb->s_maxbytes))
>                  return 0;
>          iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
> protect most of the regular files (see mm/filemap.c).  And for devices
(which is
> where the majority of crap ->read()/->write() is) it's obviously not
applicable -
> ->s_maxbytes of *what*?

Yeah that "s_maxbytes of what" is I think the real issue. We should never
have made s_maxbytes be super-block specific: we should have made it be
per-inode, and then have inode_init_always() initialize it using something
like the file_mmap_size_max() logic.

(So we'd still have a "sb_maxbytes" that filesystems would fill in, but it
would only be used as a "fill in inode value for regular files for this
superblock").

Then we could actually protect read/write properly, because many of the
nasty bugs have been in character device drivers.

Oh well. It would still be a good thing to do some day, I suspect, but it's
clearly not the case now, and so s_maxbytes actually has much less coverage
than I was hoping for.

(And thus also the problems with /proc/vmcore - it never saw s_maxbytes
limits before).

Oh, well. The lack of any meaningful s_maxbytes coverage for proc obviously
means that my objections against Vasily's patch are mostly invalid. Even if
/proc does use "generic_file_llseek()" a lot and that should limit things
to 4G offsets, you can just use pread64/pwrite64 to see if you can screw up
the offset.

I'd still prefer to limit the damage to just "vmcore".

Something like the below COMPLETELY UNTESTED patch? Vasily?

             Linus

--00000000000028fee3056c87497b
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jhcvm91p0>
X-Attachment-Id: f_jhcvm91p0

IGZzL3Byb2Mvdm1jb3JlLmMgfCA4ICsrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvZnMvcHJvYy92bWNvcmUuYyBiL2ZzL3Byb2Mvdm1jb3JlLmMK
aW5kZXggYTQ1ZjBhZjIyYTYwLi44MzI3OGM1NDcxMjcgMTAwNjQ0Ci0tLSBhL2ZzL3Byb2Mvdm1j
b3JlLmMKKysrIGIvZnMvcHJvYy92bWNvcmUuYwpAQCAtNDkxLDcgKzQ5MSwxNSBAQCBzdGF0aWMg
aW50IG1tYXBfdm1jb3JlKHN0cnVjdCBmaWxlICpmaWxlLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3Qg
KnZtYSkKIH0KICNlbmRpZgogCisvKiBNYXJrIHZtY29yZSBhcyBiZWluZyBhYmxlIGFuZCB3aWxs
aW5nIHRvIGRvIDY0LWJpdCBtbWFwcyAqLworc3RhdGljIGludCB2bWNvcmVfb3BlbihzdHJ1Y3Qg
aW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmlsZSkKK3sKKwlmaWxlLT5mX21vZGUgfD0gRk1P
REVfVU5TSUdORURfT0ZGU0VUOworCXJldHVybiAwOworfQorCiBzdGF0aWMgY29uc3Qgc3RydWN0
IGZpbGVfb3BlcmF0aW9ucyBwcm9jX3ZtY29yZV9vcGVyYXRpb25zID0geworCS5vcGVuCQk9IHZt
Y29yZV9vcGVuLAogCS5yZWFkCQk9IHJlYWRfdm1jb3JlLAogCS5sbHNlZWsJCT0gZGVmYXVsdF9s
bHNlZWssCiAJLm1tYXAJCT0gbW1hcF92bWNvcmUsCg==
--00000000000028fee3056c87497b--
