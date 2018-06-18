Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC075C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E8D208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E8D208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755000AbeFRGqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 02:46:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:43837 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754904AbeFRGqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 02:46:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 774E0AF7B;
        Mon, 18 Jun 2018 06:46:13 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Jun 2018 16:46:04 +1000
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH resend*3] VFS: simplify seq_file iteration code and interface
In-Reply-To: <874lintqa6.fsf@notabene.neil.brown.name>
References: <87vacsrt0r.fsf@notabene.neil.brown.name> <87fu3dihtf.fsf@notabene.neil.brown.name> <874lintqa6.fsf@notabene.neil.brown.name>
Message-ID: <87y3fcegnn.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


The documentation for seq_file suggests that it is necessary to be
able to move the iterator to a given offset, however that is not the
case.  If the iterator is stored in the private data and is stable
from one read() syscall to the next, it is only necessary to support
first/next interactions.  Implementing this in a client is a little
clumsy.
=2D if ->start() is given a pos of zero, it should go to start of
  sequence.
=2D if ->start() is given the name pos that was given to the most recent
  next() or start(), it should restore the iterator to state just
  before that last call
=2D if ->start is given another number, it should set the iterator one
  beyond the start just before the last ->start or ->next call.


Also, the documentation says that the implementation can interpret the
pos however it likes (other than zero meaning start), but seq_file
increments the pos sometimes which does impose on the implementation.

This patch simplifies the interface for first/next iteration and
simplifies the code, while maintaining complete backward
compatability.  Now:

=2D if ->start() is given a pos of zero, it should return an iterator
  placed at the start of the sequence
=2D if ->start() is given a non-zero pos, it should return the iterator
  in the same state it was after the last ->start or ->next.

This is particularly useful for interators which walk the multiple
chains in a hash table, e.g. using rhashtable_walk*. See
fs/gfs2/glock.c and drivers/staging/lustre/lustre/llite/vvp_dev.c

A large part of achieving this is to *always* call ->next after ->show
has successfully stored all of an entry in the buffer.  Never just
increment the index instead.
Also:
 - always pass &m->index to ->start() and ->next(), never a temp
   variable
 - don't clear ->from when ->count is zero, as ->from is dead when
    ->count is zero.


Some ->next functions do not increment *pos when they return NULL.
To maintain compatability with this, we still need to increment
m->index in one place, if ->next didn't increment it.
Note that such ->next functions are buggy and should be fixed.
A simple demonstration is
   dd if=3D/proc/swaps bs=3D1000 skip=3D1
Choose any block size larger than the size of /proc/swaps.
This will always show the whole last line of /proc/swaps.

This patch doesn't work around buggy next() functions for this case.

Acked-by: Jonathan Corbet <corbet@lwn.net> (For the docs part)
Signed-off-by: NeilBrown <neilb@suse.com>
=2D--

Still hoping someone might apply this, or at least review it,
or maybe just tell me how insane it is - anything but silence :-(

NeilBrown


 Documentation/filesystems/seq_file.txt | 63 ++++++++++++++++++++++--------=
----
 fs/seq_file.c                          | 53 +++++++++++-----------------
 2 files changed, 62 insertions(+), 54 deletions(-)

diff --git a/Documentation/filesystems/seq_file.txt b/Documentation/filesys=
tems/seq_file.txt
index 9de4303201e1..d412b236a9d6 100644
=2D-- a/Documentation/filesystems/seq_file.txt
+++ b/Documentation/filesystems/seq_file.txt
@@ -66,23 +66,39 @@ kernel 3.10. Current versions require the following upd=
ate
=20
 The iterator interface
=20
=2DModules implementing a virtual file with seq_file must implement a simple
=2Diterator object that allows stepping through the data of interest.
=2DIterators must be able to move to a specific position - like the file th=
ey
=2Dimplement - but the interpretation of that position is up to the iterator
=2Ditself. A seq_file implementation that is formatting firewall rules, for
=2Dexample, could interpret position N as the Nth rule in the chain.
=2DPositioning can thus be done in whatever way makes the most sense for the
=2Dgenerator of the data, which need not be aware of how a position transla=
tes
=2Dto an offset in the virtual file. The one obvious exception is that a
=2Dposition of zero should indicate the beginning of the file.
+Modules implementing a virtual file with seq_file must implement an
+iterator object that allows stepping through the data of interest
+during a "session" (roughly one read() system call).  If the iterator
+is able to move to a specific position - like the file they implement,
+though with freedom to map the position number to a sequence location
+in whatever way is convenient - the iterator need only exist
+transiently during a session.  If the iterator cannot easily find a
+numerical position but works well with a first/next interface, the
+iterator can be stored in the private data area and continue from one
+session to the next.
+
+A seq_file implementation that is formatting firewall rules from a
+table, for example, could provide a simple iterator that interprets
+position N as the Nth rule in the chain.  A seq_file implementation
+that presents the content of a, potentially volatile, linked list
+might record a pointer into that list, providing that can be done
+without risk of the current location being removed.
+
+Positioning can thus be done in whatever way makes the most sense for
+the generator of the data, which need not be aware of how a position
+translates to an offset in the virtual file. The one obvious exception
+is that a position of zero should indicate the beginning of the file.
=20
 The /proc/sequence iterator just uses the count of the next number it
 will output as its position.
=20
=2DFour functions must be implemented to make the iterator work. The first,
=2Dcalled start() takes a position as an argument and returns an iterator
=2Dwhich will start reading at that position. For our simple sequence examp=
le,
+Four functions must be implemented to make the iterator work. The
+first, called start(), starts a session and takes a position as an
+argument, returning an iterator which will start reading at that
+position.  The pos passed to start() will always be either zero, or
+the most recent pos used in the previous session.
+
+For our simple sequence example,
 the start() function looks like:
=20
 	static void *ct_seq_start(struct seq_file *s, loff_t *pos)
@@ -101,11 +117,12 @@ implementations; in most cases the start() function s=
hould check for a
 "past end of file" condition and return NULL if need be.
=20
 For more complicated applications, the private field of the seq_file
=2Dstructure can be used. There is also a special value which can be return=
ed
=2Dby the start() function called SEQ_START_TOKEN; it can be used if you wi=
sh
=2Dto instruct your show() function (described below) to print a header at =
the
=2Dtop of the output. SEQ_START_TOKEN should only be used if the offset is
=2Dzero, however.
+structure can be used to hold state from session to session.  There is
+also a special value which can be returned by the start() function
+called SEQ_START_TOKEN; it can be used if you wish to instruct your
+show() function (described below) to print a header at the top of the
+output. SEQ_START_TOKEN should only be used if the offset is zero,
+however.
=20
 The next function to implement is called, amazingly, next(); its job is to
 move the iterator forward to the next position in the sequence.  The
@@ -121,9 +138,13 @@ complete. Here's the example version:
 	        return spos;
 	}
=20
=2DThe stop() function is called when iteration is complete; its job, of
=2Dcourse, is to clean up. If dynamic memory is allocated for the iterator,
=2Dstop() is the place to free it.
+The stop() function closes a session; its job, of course, is to clean
+up. If dynamic memory is allocated for the iterator, stop() is the
+place to free it; if a lock was taken by start(), stop() must release
+that lock.  The value that *pos was set to by the last next() call
+before stop() is remembered, and used for the first start() call of
+the next session unless lseek() has been called on the file; in that
+case next start() will be asked to start at position zero.
=20
 	static void ct_seq_stop(struct seq_file *s, void *v)
 	{
diff --git a/fs/seq_file.c b/fs/seq_file.c
index 4cc090b50cc5..fd82585ab50f 100644
=2D-- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -90,23 +90,22 @@ EXPORT_SYMBOL(seq_open);
=20
 static int traverse(struct seq_file *m, loff_t offset)
 {
=2D	loff_t pos =3D 0, index;
+	loff_t pos =3D 0;
 	int error =3D 0;
 	void *p;
=20
 	m->version =3D 0;
=2D	index =3D 0;
+	m->index =3D 0;
 	m->count =3D m->from =3D 0;
=2D	if (!offset) {
=2D		m->index =3D index;
+	if (!offset)
 		return 0;
=2D	}
+
 	if (!m->buf) {
 		m->buf =3D seq_buf_alloc(m->size =3D PAGE_SIZE);
 		if (!m->buf)
 			return -ENOMEM;
 	}
=2D	p =3D m->op->start(m, &index);
+	p =3D m->op->start(m, &m->index);
 	while (p) {
 		error =3D PTR_ERR(p);
 		if (IS_ERR(p))
@@ -123,20 +122,15 @@ static int traverse(struct seq_file *m, loff_t offset)
 		if (pos + m->count > offset) {
 			m->from =3D offset - pos;
 			m->count -=3D m->from;
=2D			m->index =3D index;
 			break;
 		}
 		pos +=3D m->count;
 		m->count =3D 0;
=2D		if (pos =3D=3D offset) {
=2D			index++;
=2D			m->index =3D index;
+		p =3D m->op->next(m, p, &m->index);
+		if (pos =3D=3D offset)
 			break;
=2D		}
=2D		p =3D m->op->next(m, p, &index);
 	}
 	m->op->stop(m, p);
=2D	m->index =3D index;
 	return error;
=20
 Eoverflow:
@@ -160,7 +154,6 @@ ssize_t seq_read(struct file *file, char __user *buf, s=
ize_t size, loff_t *ppos)
 {
 	struct seq_file *m =3D file->private_data;
 	size_t copied =3D 0;
=2D	loff_t pos;
 	size_t n;
 	void *p;
 	int err =3D 0;
@@ -223,16 +216,11 @@ ssize_t seq_read(struct file *file, char __user *buf,=
 size_t size, loff_t *ppos)
 		size -=3D n;
 		buf +=3D n;
 		copied +=3D n;
=2D		if (!m->count) {
=2D			m->from =3D 0;
=2D			m->index++;
=2D		}
 		if (!size)
 			goto Done;
 	}
 	/* we need at least one record in buffer */
=2D	pos =3D m->index;
=2D	p =3D m->op->start(m, &pos);
+	p =3D m->op->start(m, &m->index);
 	while (1) {
 		err =3D PTR_ERR(p);
 		if (!p || IS_ERR(p))
@@ -243,8 +231,7 @@ ssize_t seq_read(struct file *file, char __user *buf, s=
ize_t size, loff_t *ppos)
 		if (unlikely(err))
 			m->count =3D 0;
 		if (unlikely(!m->count)) {
=2D			p =3D m->op->next(m, p, &pos);
=2D			m->index =3D pos;
+			p =3D m->op->next(m, p, &m->index);
 			continue;
 		}
 		if (m->count < m->size)
@@ -256,29 +243,33 @@ ssize_t seq_read(struct file *file, char __user *buf,=
 size_t size, loff_t *ppos)
 		if (!m->buf)
 			goto Enomem;
 		m->version =3D 0;
=2D		pos =3D m->index;
=2D		p =3D m->op->start(m, &pos);
+		p =3D m->op->start(m, &m->index);
 	}
 	m->op->stop(m, p);
 	m->count =3D 0;
 	goto Done;
 Fill:
 	/* they want more? let's try to get some more */
=2D	while (m->count < size) {
+	while (1) {
 		size_t offs =3D m->count;
=2D		loff_t next =3D pos;
=2D		p =3D m->op->next(m, p, &next);
+		loff_t pos =3D m->index;
+
+		p =3D m->op->next(m, p, &m->index);
+		if (pos =3D=3D m->index)
+			/* Buggy ->next function */
+			m->index++;
 		if (!p || IS_ERR(p)) {
 			err =3D PTR_ERR(p);
 			break;
 		}
+		if (m->count >=3D size)
+			break;
 		err =3D m->op->show(m, p);
 		if (seq_has_overflowed(m) || err) {
 			m->count =3D offs;
 			if (likely(err <=3D 0))
 				break;
 		}
=2D		pos =3D next;
 	}
 	m->op->stop(m, p);
 	n =3D min(m->count, size);
@@ -287,11 +278,7 @@ ssize_t seq_read(struct file *file, char __user *buf, =
size_t size, loff_t *ppos)
 		goto Efault;
 	copied +=3D n;
 	m->count -=3D n;
=2D	if (m->count)
=2D		m->from =3D n;
=2D	else
=2D		pos++;
=2D	m->index =3D pos;
+	m->from =3D n;
 Done:
 	if (!copied)
 		copied =3D err;
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsnVSwACgkQOeye3VZi
gblhvQ//VA7o7gc58OfB/fQmINAlSInLUQbkSDo5lSTNBkyJJGwFNAko3daSATpA
Qn8n7scLFOyyOhBv5+4/J4RNcXv9aPkRRlyo5i7/tRRKBGHgwZWDi1l3iJf7jucv
/RycDYOmzfAy6162mrqmELR9AiljiBJdSTGvxg5csYgD73N3KuoOOkW9IlXbaU85
e5iS0THMAd2rNRozWKOVk7RkDx5VEtTBDj9q8qfcAnW/RoKGkri5GBFdlGfo3EeO
NRV/jKHH0VSlRu93v7GOZh5aCZ66xyWF2tHvB13i7dL61T6ggExUoTzWBrc9nJRE
lNgpsNLZs7AZfegMmS5efey6V5dIxzTt47Nb1XLEpThHTsdkwCsvSkx0O+8/Casz
XVds8PdVlQRw4tuTndd/xuVxBsSCkIy7CMfZVDaMIfr4InFE6fmny7AvzNZYNDsu
zR589VwJiotZlJqOPt6th3s2VAJVI8q22V5uM3+lDdClyMr9MGsmyJU9oULpHif6
jCQ/lf8oNJnOLrGu6aO/2abJKlnPG1I/rL0Arv+KWfp+vpQ1OX7XXiZL3q/iS+ob
tHzffulerolVjIMyg37R+nWLmoiPjxEKNWcy+ypC31ni7HKTHUVgsOviMJ4+Ybcc
deCg2aot2I1IafjZLDUSTdqgFfjUiCkK6OkzdnnZC6KZR1yadpI=
=GqP+
-----END PGP SIGNATURE-----
--=-=-=--
