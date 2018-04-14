Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751321AbeDNQg1 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 12:36:27 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:42090 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751121AbeDNQgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 12:36:25 -0400
X-Google-Smtp-Source: AIpwx49UrubB892FiJ/rRkQLI1bnr68RGCGtBvUUCsc4pjGPYceUicw6MwPYJ+GRmXS5WBt5eNkpBp6YqP2xEmfWjDs=
MIME-Version: 1.0
In-Reply-To: <20180414080206.GV30522@ZenIV.linux.org.uk>
References: <20180413181350.88831-1-khazhy@google.com> <20180413202823.204377-1-khazhy@google.com>
 <20180413141430.2788e2562e3e24bd273fe78b@linux-foundation.org>
 <3362fb2d-85ff-86af-399f-698c986e46cc@suse.com> <20180414080206.GV30522@ZenIV.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 14 Apr 2018 09:36:23 -0700
X-Google-Sender-Auth: WZuCwBVJqjqveHD5VdpUYmBUsjQ
Message-ID: <CA+55aFz4fwzcUWWT78AxK+GeVNVveWPNS+=V+ppb1ksn56TjUA@mail.gmail.com>
Subject: Re: [PATCH] fs/dcache.c: re-add cond_resched() in shrink_dcache_parent()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Nikolay Borisov <nborisov@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>, Jeff Mahoney <jeffm@suse.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Content-Type: multipart/mixed; boundary="001a114461a8e601540569d196ed"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--001a114461a8e601540569d196ed
Content-Type: text/plain; charset="UTF-8"

On Sat, Apr 14, 2018 at 1:02 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> "Bail out" is definitely a bad idea, "sleep"... what on?  Especially
> since there might be several evictions we are overlapping with...

Well, one thing that should be looked at is the return condition from
select_collect() that shrink_dcache_parent() uses.

Because I think that return condition is somewhat insane.

The logic there seems to be:

 - if we have found something, stop walking. Either NOW (if somebody
is waiting) or after you've hit a rename (if nobody is)

Now, this actually makes perfect sense for the whole rename situation:
if there's nobody waiting for us, but we hit a rename, we probably
should stop anyway just to let whoever is doing that rename continue,
and we might as well try to get rid of the dentries we have found so
far.

But it does *not* make sense for the case where we've hit a dentry
that is already on the shrink list. Sure, we'll continue to gather all
the other dentries, but if there is concurrent shrinking, shouldn't we
give up the CPU more eagerly - *particularly* if somebody else is
waiting (it might be the other process that actually gets rid of the
shrinking dentries!)?

So my gut feel is that we should at least try doing something like
this in select_collect():

-       if (!list_empty(&data->dispose))
+       if (data->found)
                ret = need_resched() ? D_WALK_QUIT : D_WALK_NORETRY;

because even if we haven't actually been able to shrink something, if
we hit an already shrinking entry we should probably at least not do
the "retry for rename". And if we actually are going to reschedule, we
might as well start from the beginning.

I realize that *this* thread might not be making any actual progress
(because it didn't find any dentries to shrink), but since it did find
_a_ dentry that is being shrunk, we know the operation itself - on a
bigger scale - is making progress.

Hmm?

Now, this is independent of the fact that we probably do need a
cond_resched() in shrink_dcache_parent(), to actually do the
reschedule if we're not preemptible. The "need_resched()" in
select_collect() is obviously done while holding

HOWEVER. Even in that case, I don't think shrink_dcache_parent() is
the right point. I'd rather just do it differently in
shrink_dentry_list(): do it even for the empty list case by just doing
it at the top of the loop:

 static void shrink_dentry_list(struct list_head *list)
 {
-       while (!list_empty(list)) {
+       while (cond_resched(), !list_empty(list)) {
                struct dentry *dentry, *parent;

-               cond_resched();

so my full patch that I would suggest might be TheRightThing(tm) is
attached (but it should be committed as two patches, since the two
issues are independent - I'm just attaching it as one for testing in
case somebody wants to run some nasty workloads on it)

Comments?

Side note: I think we might want to make that

    while (cond_resched(), <condition>) {
        ....
    }

thing a pattern for doing cond_resched() in loops, instead of having
the cond_resched() inside the loop itself.

It not only handles the "zero iterations" case, it also ends up being
neutral location-waise wrt 'continue' statements, and potentially
generates *better* code.

For example, in this case, doing the cond_resched() at the very top of
the loop means that the loop itself then does that

                dentry = list_entry(list->prev, struct dentry, d_lru);

right after the "list_empty()" test - which means that register
allocation etc might be easier, because it doesn't have a function
call (with associated register clobbers) in between the two accesses
to "list".

And I think that might be a fairly common pattern - the loop
conditional uses the same values as the loop itself then uses.

I don't know. Maybe I'm just making excuses for the somewhat unusual syntax.

Anybody want to test this out?

                   Linus

--001a114461a8e601540569d196ed
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jfzli6370

IGZzL2RjYWNoZS5jIHwgNiArKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvZGNhY2hlLmMgYi9mcy9kY2FjaGUuYwpp
bmRleCA4NmQyZGU2MzQ2MWUuLjc2NTA3MTA5Y2JjZCAxMDA2NDQKLS0tIGEvZnMvZGNhY2hlLmMK
KysrIGIvZnMvZGNhY2hlLmMKQEAgLTEwNDksMTEgKzEwNDksOSBAQCBzdGF0aWMgYm9vbCBzaHJp
bmtfbG9ja19kZW50cnkoc3RydWN0IGRlbnRyeSAqZGVudHJ5KQogCiBzdGF0aWMgdm9pZCBzaHJp
bmtfZGVudHJ5X2xpc3Qoc3RydWN0IGxpc3RfaGVhZCAqbGlzdCkKIHsKLQl3aGlsZSAoIWxpc3Rf
ZW1wdHkobGlzdCkpIHsKKwl3aGlsZSAoY29uZF9yZXNjaGVkKCksICFsaXN0X2VtcHR5KGxpc3Qp
KSB7CiAJCXN0cnVjdCBkZW50cnkgKmRlbnRyeSwgKnBhcmVudDsKIAotCQljb25kX3Jlc2NoZWQo
KTsKLQogCQlkZW50cnkgPSBsaXN0X2VudHJ5KGxpc3QtPnByZXYsIHN0cnVjdCBkZW50cnksIGRf
bHJ1KTsKIAkJc3Bpbl9sb2NrKCZkZW50cnktPmRfbG9jayk7CiAJCXJjdV9yZWFkX2xvY2soKTsK
QEAgLTE0NjIsNyArMTQ2MCw3IEBAIHN0YXRpYyBlbnVtIGRfd2Fsa19yZXQgc2VsZWN0X2NvbGxl
Y3Qodm9pZCAqX2RhdGEsIHN0cnVjdCBkZW50cnkgKmRlbnRyeSkKIAkgKiBlbnN1cmVzIGZvcndh
cmQgcHJvZ3Jlc3MpLiBXZSdsbCBiZSBjb21pbmcgYmFjayB0byBmaW5kCiAJICogdGhlIHJlc3Qu
CiAJICovCi0JaWYgKCFsaXN0X2VtcHR5KCZkYXRhLT5kaXNwb3NlKSkKKwlpZiAoZGF0YS0+Zm91
bmQpCiAJCXJldCA9IG5lZWRfcmVzY2hlZCgpID8gRF9XQUxLX1FVSVQgOiBEX1dBTEtfTk9SRVRS
WTsKIG91dDoKIAlyZXR1cm4gcmV0Owo=
--001a114461a8e601540569d196ed--
